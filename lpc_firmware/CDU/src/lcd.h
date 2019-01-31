/*
 * lcd.h
 *
 *  Created on: 28 jan. 2018
 *  Author: Damy van Valenberg
 */

#ifndef LCD_H_
#define LCD_H_

#define LCD_X_COUNT 24
#define LCD_Y_COUNT 10

#include <stdint.h>

class LCD {
public:
	struct LCD_BUFF_T {
		uint8_t y;
		uint8_t x;
		uint8_t val;
	} __attribute__((packed));
private:
	LCD_BUFF_T charBuffer;
public:
	
	LCD() {}
	~LCD() {}
	
	void clearSreen();
	void writeChar(uint8_t posX, uint8_t posY, uint8_t val);
	void writeString(uint8_t poxX, uint8_t posY, const char* str, bool wrap = false);
};



#endif /* LCD_H_ */
