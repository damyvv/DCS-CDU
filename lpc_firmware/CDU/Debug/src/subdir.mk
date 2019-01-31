################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/cr_cpp_config.cpp \
../src/cr_startup_lpc13xx.cpp \
../src/lcd.cpp \
../src/main.cpp \
../src/spi.cpp 

C_SRCS += \
../src/crp.c \
../src/sysinit.c \
../src/usb.c 

OBJS += \
./src/cr_cpp_config.o \
./src/cr_startup_lpc13xx.o \
./src/crp.o \
./src/lcd.o \
./src/main.o \
./src/spi.o \
./src/sysinit.o \
./src/usb.o 

CPP_DEPS += \
./src/cr_cpp_config.d \
./src/cr_startup_lpc13xx.d \
./src/lcd.d \
./src/main.d \
./src/spi.d 

C_DEPS += \
./src/crp.d \
./src/sysinit.d \
./src/usb.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C++ Compiler'
	arm-none-eabi-c++ -std=gnu++11 -D__NEWLIB__ -DDEBUG -D__CODE_RED -DDONT_ENABLE_SWVTRACECLK -DCORE_M3 -D__USE_LPCOPEN -DNO_BOARD_LIB -DCPP_USE_HEAP -D__LPC13XX__ -I"C:\Users\Damy\Desktop\cdu\lpc_firmware\lpc_chip_13xx\inc" -O0 -fno-common -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -fno-rtti -fno-exceptions -mcpu=cortex-m3 -mthumb -D__NEWLIB__ -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -std=gnu11 -DDEBUG -D__CODE_RED -DDONT_ENABLE_SWVTRACECLK -DCORE_M3 -D__USE_LPCOPEN -DNO_BOARD_LIB -DCPP_USE_HEAP -D__LPC13XX__ -D__NEWLIB__ -I"C:\Users\Damy\Desktop\cdu\lpc_firmware\lpc_chip_13xx\inc" -O0 -fno-common -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -mcpu=cortex-m3 -mthumb -D__NEWLIB__ -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


