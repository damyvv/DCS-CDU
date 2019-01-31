/*
 * spi.cpp
 *
 *  Created on: 27 jan. 2018
 *  Author: Damy
 */

#include "spi.h"

#define LPC_SSP LPC_SSP0


SPI::SPI() {
	m_SSPFormat.frameFormat = SSP_FRAMEFORMAT_SPI;
	m_SSPFormat.bits = SSP_BITS_8;
	m_SSPFormat.clockMode = SSP_CLOCK_MODE0;
	
	initSPI();
	setBitrate(SPI_DEFAULT_BITRATE);
}
SPI& SPI::getInstance()
{
	static SPI instance;
	return instance;
}

void SPI::initSPI() const {
    Chip_GPIO_Init(LPC_GPIO_PORT);
	Chip_GPIO_SetPinDIROutput(LPC_GPIO_PORT, 0, 2);
	Chip_GPIO_SetPinOutHigh(LPC_GPIO_PORT, 0, 2); // CE
	
	Chip_IOCON_PinLocSel(LPC_IOCON, IOCON_SCKLOC_PIO2_11);
	Chip_IOCON_PinMux(LPC_IOCON, IOCON_PIO2_11, IOCON_MODE_INACT, IOCON_FUNC1); // SCK
	Chip_IOCON_PinMux(LPC_IOCON, IOCON_PIO0_9, IOCON_MODE_INACT, IOCON_FUNC1); // MOSI
	Chip_IOCON_PinMux(LPC_IOCON, IOCON_PIO0_8, IOCON_MODE_INACT, IOCON_FUNC1); // MISO

	Chip_SSP_Init(LPC_SSP);
	Chip_SSP_SetFormat(LPC_SSP, m_SSPFormat.bits, m_SSPFormat.frameFormat, m_SSPFormat.clockMode);
	Chip_SSP_Enable(LPC_SSP);
}

void SPI::write(void* data, uint32_t size) const {
	__disable_irq();
	chipEnable();
	((uint8_t*) data)[0] |= 0x80; // Set write flag
	Chip_SSP_WriteFrames_Blocking(LPC_SSP, (uint8_t*) data, size);
	chipDisable();
	__enable_irq();
}

void SPI::read(void* dst) const {
	__disable_irq();
	chipEnable();
	uint8_t dummy = 0;
	Chip_SSP_WriteFrames_Blocking(LPC_SSP, &dummy, 1);
	Chip_SSP_ReadFrames_Blocking(LPC_SSP, (uint8_t*) dst, 9);
	chipDisable();
	__enable_irq();
}

void SPI::setBitrate(uint32_t bitrate) {
	m_Bitrate = bitrate;
	Chip_SSP_SetBitRate(LPC_SSP, bitrate);
}
	
void SPI::chipEnable() const {
	Chip_GPIO_SetPinOutLow(LPC_GPIO_PORT, 0, 2);
}

void SPI::chipDisable() const {
	Chip_GPIO_SetPinOutHigh(LPC_GPIO_PORT, 0, 2);
}
