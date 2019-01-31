/*
 * usb.c
 *
 *  Created on: 15 mrt. 2018
 *  Author: Damy
 */

#include "usb.h"

#include "chip.h"

ROM ** LPC_ROM = (ROM**) 0x1fff1ff8;

static USB_DEV_INFO DeviceInfo;
static HID_DEVICE_INFO HidDevInfo;

/* USB String Descriptor (optional) */
const uint8_t USB_StringDescriptor[] = {
  /* Index 0x00: LANGID Codes */
  0x04,                              /* bLength */
  0x03,        /* bDescriptorType */
  ((0x1FC9) & 0xFF),(((0x1FC9) >> 8) & 0xFF), /* US English */    /* wLANGID */
  /* Index 0x04: Manufacturer */
  0x1C,                              /* bLength */
  0x03,        /* bDescriptorType */
  'D',0,
  '.',0,
  ' ',0,
  'V',0,
  'A',0,
  'L',0,
  'E',0,
  'N',0,
  'B',0,
  'E',0,
  'R',0,
  'G',0,
  ' ',0,
  /* Index 0x20: Product */
  0x28,                              /* bLength */
  0x03,        /* bDescriptorType */
  'D',0,
  'C',0,
  'S',0,
  ' ',0,
  'A',0,
  '-',0,
  '1',0,
  '0',0,
  'C',0,
  ' ',0,
  'C',0,
  'D',0,
  'U',0,
  ' ',0,
  'D',0,
  'I',0,
  'S',0,
  'P',0,
  '.',0,
  /* Index 0x48: Serial Number */
  0x1A,                              /* bLength */
  0x03,        /* bDescriptorType */
  'F',0,
  'F',0,
  'F',0,
  'F',0,
  'F',0,
  'F',0,
  'F',0,
  'F',0,
  'F',0,
  'F',0,
  'F',0,
  'F',0,
  /* Index 0x62: Interface 0, Alternate Setting 0 */
  0x0E,                              /* bLength */
  0x03,        /* bDescriptorType */
  'H',0,
  'I',0,
  'D',0,
  ' ',0,
  ' ',0,
  ' ',0,
};

void USB_Init(USB_InReportHandler inReport, USB_OutReportHandler outReport) {
    HidDevInfo.idVendor = VENDOR_ID;
    HidDevInfo.idProduct = PRODUCT_ID;
    HidDevInfo.bcdDevice = DRIVER_VER;
    HidDevInfo.StrDescPtr = (uint32_t)&USB_StringDescriptor[0];
    HidDevInfo.InReportCount = REP_IN_SIZE;
    HidDevInfo.OutReportCount = REP_OUT_SIZE;
    HidDevInfo.SampleInterval = REP_INTERVAL;
    HidDevInfo.InReport = inReport;
    HidDevInfo.OutReport = outReport;
    
    DeviceInfo.DevType = 0x03;
    DeviceInfo.DevDetailPtr = (uint32_t) &HidDevInfo;
    
    LPC_SYSCTL->SYSAHBCLKCTRL |= (EN_TIMER32_1 | EN_IOCON | EN_USBREG);
    
    (*LPC_ROM)->pUSBD->init_clk_pins();
    
    for(int i = 0; i < 500000; i++)
    {
    	__asm__("nop");
    }
    
    (*LPC_ROM)->pUSBD->init(&DeviceInfo);
    
    for(int i = 0; i < 1000000; i++)
    {
    	__asm__("nop");
    }
    
    (*LPC_ROM)->pUSBD->connect(TRUE);
}
