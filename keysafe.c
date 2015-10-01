#include <stdio.h>
#include <bcm2835.h>

#include "servo.h"
#define PIN RPI_GPIO_P1_12
//And it is controlled by PWM channel 0
#define PWM_CHANNEL 0
//This controls the max range of the PWM signal
#define RANGE 1024

int main(int argc, char **argv) {
    
    puts("Init");
    
    if (!bcm2835_init())
    {
        return 1;
    }
    
    // Set the output pin to Alt Fun 5, to allow PWM channel 0 to be output there
    bcm2835_gpio_fsel(PIN, BCM2835_GPIO_FSEL_ALT5);
    // Clock divider is set to 16.
    // With a divider of 16 and a RANGE of 1024, in MARKSPACE mode,
    // the pulse repetition frequency will be
    // 1.2MHz/1024 = 1171.875Hz, suitable for driving a DC motor with PWM
    bcm2835_pwm_set_clock(BCM2835_PWM_CLOCK_DIVIDER_16);
    bcm2835_pwm_set_mode(PWM_CHANNEL, 1, 1);
    bcm2835_pwm_set_range(PWM_CHANNEL, RANGE);

    init = 1;
    
    if(atoi(argv[1])==1)
    {
        puts("Open");
        doorOpen();
    }

    else
    {
        puts("Close");
        doorClose();
    }
    return 0;
}
