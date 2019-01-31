/*
 * lcd.cpp
 *
 *  Created on: 28 jan. 2018
 *  Author: Damy van Valenberg
 */

#include "lcd.h"
#include "spi.h"

#include <string.h>

void LCD::clearSreen() {
	for (int y = 0; y < LCD_Y_COUNT; y++) {
		for (int x = 0; x < LCD_X_COUNT; x++) {
			writeChar(x, y, 0);
		}
	}
}

void LCD::writeChar(uint8_t posX, uint8_t posY, uint8_t val) {
	SPI& spi = SPI::getInstance();
	charBuffer = { posY, posX, val };
	spi.write(&charBuffer, sizeof(LCD_BUFF_T));
}

void LCD::writeString(uint8_t offsetX, uint8_t offsetY, const char* str, bool wrap) {
	if (offsetX >= LCD_X_COUNT || offsetY >= LCD_Y_COUNT) return;
	uint16_t len = strlen(str);
	uint16_t i = 0;
	uint8_t posX = offsetX;
	uint8_t posY = offsetY;
	while (i < len) {
		if (posX >= LCD_X_COUNT) {
			if (!wrap) return;
			posY++;
			posX = offsetX;
			if (posY >= LCD_Y_COUNT) return;
		}
		
		char c = str[i++];
		if (c >= '0' && c <= '9') c += 1 - '0';
		else if (c >= 'a' && c <= 'z') c += 11 - 'a';
		else if (c >= 'A' && c <= 'Z') c += 11 - 'A';
		else if (c == '\n') { posY++; posX = offsetX; continue; }
		else c = 0;
		
		writeChar(posX++, posY, c);
	}
}
