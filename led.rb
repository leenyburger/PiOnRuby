require 'rpi_gpio'

RPi::GPIO.set_numbering :board

led = RPi::GPIO.setup 12, :as => :output, :initialize => :low

5.times do
  RPi::GPIO.set_high 12
  sleep(1)
  RPi::GPIO.set_low 12
  sleep(1)
end

RPi::GPIO.reset