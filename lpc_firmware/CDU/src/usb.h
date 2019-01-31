/*
 * rom.h
 *
 *  Created on: 15 mrt. 2018
 *  Author: Damy
 */

#pragma once

#ifndef USB_H_
#define USB_H_

#include <stdint.h>

#include <chip.h>

#define     EN_TIMER32_1    (1<<10)
#define     EN_IOCON        (1<<16)
#define     EN_USBREG       (1<<14)

#define VENDOR_ID 		0x1FC9
#define PRODUCT_ID 		0x0085
#define DRIVER_VER 		0x0100

#define REP_IN_SIZE		0x09
#define REP_OUT_SIZE	0x3E
#define REP_INTERVAL	0x08

#if defined (__cplusplus)
extern "C" {
#endif

typedef void (*USB_InReportHandler)(uint8_t src[], uint32_t length);
typedef void (*USB_OutReportHandler)(uint8_t src[], uint32_t length);

typedef struct _HID_DEVICE_INFO {
	uint16_t idVendor;
	uint16_t idProduct;
	uint16_t bcdDevice;
	uint32_t StrDescPtr;
	uint8_t InReportCount;
	uint8_t OutReportCount;
	uint8_t SampleInterval;
	USB_InReportHandler InReport;
	USB_OutReportHandler OutReport;
} HID_DEVICE_INFO;

typedef struct _USB_DEVICE_INFO {
	uint16_t DevType;
	uint32_t DevDetailPtr;
} USB_DEV_INFO;

typedef struct _USBD {
	void (*init_clk_pins)(void);
	void (*isr)(void);
	void (*init)( USB_DEV_INFO * DevInfoPtr );
	void (*connect)(uint32_t con);
} USBD;

typedef struct _ROM {
	const USBD * pUSBD;
} ROM;

extern ROM ** LPC_ROM;

extern const uint8_t USB_StringDescriptor[];

void USB_Init(USB_InReportHandler inReport, USB_OutReportHandler outReport);

#if defined (__cplusplus)
}
#endif

#endif /* USB_H_ */
