/*
 * base16.h
 *
 *  Created on: 28 jan. 2018
 *  Author: Damy
 */

#ifndef BASE16_H_
#define BASE16_H_

#include <stdint.h>
#include <malloc.h>

/*
 * str needs to be a null terminated string
 */
inline uint8_t* base16_decode(const char* str, size_t* size) {
	*size = 0;
	size_t len = strlen(str);
	if (len & 1) return nullptr;
	uint8_t* byteArray = (uint8_t*) malloc(len / 2);
	uint8_t upByte, loByte;
	for (size_t i = 0; i < len / 2; i++) {
		upByte = str[i*2];
		loByte = str[i*2 + 1];
		if (upByte >= '0' && upByte <= '9') upByte -= '0';
		else if (upByte >= 'A' && upByte <= 'F') upByte += 10 - 'A';
		else {
			free(byteArray);
			return nullptr;
		}
		if (loByte >= '0' && loByte <= '9') loByte -= '0';
		else if (loByte >= 'A' && loByte <= 'F') loByte += 10 - 'A';
		else {
			free(byteArray);
			return nullptr;
		}
		byteArray[i] = (upByte << 4) | loByte;
	}
	*size = len / 2;
	return byteArray;
}


#endif /* BASE16_H_ */
