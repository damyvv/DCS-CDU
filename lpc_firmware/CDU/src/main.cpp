/*
===============================================================================
 Name        : main.c
 Author      : Damy van Valenberg
===============================================================================
*/

#include "chip.h"
#include "usb.h"
#include "lcd.h"
#include "spi.h"

#include <cr_section_macros.h>

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#define PACKET_STRING_SIZE 60

#define USB_ISP_PORT	0
#define USB_ISP_PIN		3

#define IAP_LOCATION 0x1fff1ff1

unsigned int command[5];
unsigned int result[4];

typedef void (*IAP)(unsigned int [],unsigned int[]);
IAP iap_entry = (IAP) IAP_LOCATION;

const char* author = "     A10C CDU\n    CREATED BY\nDAMY VAN VALENBERG";

bool packetReady = false;

char* screenStr;
uint8_t inRep[9];

void GetInReport(uint8_t dst[], uint32_t length) {
	memcpy(dst, inRep, MIN(9, length));
}

void SetOutReport(uint8_t src[], uint32_t length) {
	if (length != REP_OUT_SIZE) return;
	if (src[PACKET_STRING_SIZE] > 3 || src[PACKET_STRING_SIZE + 1] != 0xFE) return;
	
	uint16_t offset = src[PACKET_STRING_SIZE] * PACKET_STRING_SIZE;
	memcpy(screenStr + offset, src, PACKET_STRING_SIZE);
	
	if (src[PACKET_STRING_SIZE] == 3) {
		packetReady = true;
	}
}

int main(void) {
    SystemCoreClockUpdate();
    
	Chip_Clock_EnablePeriphClock(SYSCTL_CLOCK_IOCON);
    
	Chip_GPIO_Init(LPC_GPIO_PORT);
	Chip_GPIO_SetPinDIROutput(LPC_GPIO_PORT, USB_ISP_PORT, USB_ISP_PIN);
	if (Chip_GPIO_GetPinState(LPC_GPIO_PORT, USB_ISP_PORT, USB_ISP_PIN) == 1) {
		command[0] = 57;
		iap_entry(command, result);
	}
    
    screenStr = (char*) malloc(240);

    USB_Init(GetInReport, SetOutReport);

    Chip_TIMER_Init(LPC_TIMER32_0);
    Chip_TIMER_PrescaleSet(LPC_TIMER32_0, 72000);
    Chip_TIMER_Enable(LPC_TIMER32_0);
    
    Chip_TIMER_Init(LPC_TIMER16_0);
    Chip_TIMER_PrescaleSet(LPC_TIMER16_0, 72);
    Chip_TIMER_SetMatch(LPC_TIMER16_0, 0, 1000);
    Chip_TIMER_MatchEnableInt(LPC_TIMER16_0, 0);
    Chip_TIMER_ResetOnMatchEnable(LPC_TIMER16_0, 0);
    Chip_TIMER_Enable(LPC_TIMER16_0);
    
    NVIC_EnableIRQ(TIMER_16_0_IRQn);

    Chip_GPIO_Init(LPC_GPIO_PORT);
    Chip_GPIO_SetPinDIROutput(LPC_GPIO_PORT, 3, 2);
	Chip_GPIO_SetPinOutLow(LPC_GPIO_PORT, 3, 2);
	
	SPI& spi = SPI::getInstance();
	spi.setBitrate(18000000);
	
	LCD lcd;
	lcd.clearSreen();
	lcd.writeString(3, 3, author);
    
    bool timeout = true;
	
    while(1) {
    	uint32_t current = Chip_TIMER_ReadCount(LPC_TIMER32_0);
    	if (current > 1000 && timeout == false) {
    		timeout = true;
    		lcd.clearSreen();
    		lcd.writeString(3, 3, author);
    		Chip_GPIO_SetPinOutLow(LPC_GPIO_PORT, 3, 2);
    	}

		Chip_GPIO_SetPinState(LPC_GPIO_PORT, 3, 2, inRep[6] & 0x40);
    	
    	if (packetReady) {
    		packetReady = false;
    		Chip_GPIO_SetPinToggle(LPC_GPIO_PORT, 3, 2);
    		for (int y = 0; y < 10; y++) {
    			for (int x = 0; x < 24; x++) {
    	    		lcd.writeChar(x, y, screenStr[y*24 + x]);
    			}
    		}
    		Chip_TIMER_Reset(LPC_TIMER32_0);
    		timeout = false;
    	}
    }
    return 0 ;
}

#if defined (__cplusplus)
extern "C" {
#endif

void USB_IRQHandler(void)
{
	(*LPC_ROM)->pUSBD->isr();
}

void TIMER16_0_IRQHandler(void)
{
	Chip_TIMER_ClearMatch(LPC_TIMER16_0, 0);
	SPI& spi = SPI::getInstance();
	spi.read(inRep);
}

#if defined (__cplusplus)
}
#endif
