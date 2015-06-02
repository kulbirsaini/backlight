## Backlight

A simple bash script to control backlight (keyboard/screen) wherever not supported out of the box. Lookup the device directory modify the script as per your system. The diretory is generally located in `/sys/class/leds/` or `/sys/class/backlight/`.


## Usage

```bash
# Must be executed as super/root user
# To turn off backlight
$ ./backlight.sh 0

# To set backlight brightness to 10
$ ./backlight.sh 10
```
