/*
 * spi.h
 *
 *  Created on: 27 jan. 2018
 *  Author: Damy van Valenberg
 */

#ifndef SPI_H_
#define SPI_H_

#define SPI_DEFAULT_BITRATE 100000

#include "chip.h"

class SPI {
private:
	uint32_t m_Bitrate;
	SSP_ConfigFormat m_SSPFormat;
public:
	SPI(SPI const&) = delete;
	void operator=(SPI const&) = delete;
	
	static SPI& getInstance();
	
	void write(void* data, uint32_t size) const;
	void read(void* dst) const;
	
	void setBitrate(uint32_t bitrate);
	inline int getBitrate() const { return m_Bitrate; }
	
private:
	SPI();
	
	void chipEnable() const;
	void chipDisable() const;
	void initSPI() const;
};


#endif /* SPI_H_ */
