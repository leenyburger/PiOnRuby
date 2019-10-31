require 'rpi_gpio'

RPi::GPIO.set_numbering :board

RPi::GPIO.setup 18, :as => :input, :pull => :up

farts = ['ben-fart.wav', 'ca-fart.wav', 'marc-fart.wav']

while true do
  sleep(2)  
  if RPi::GPIO.low? 18
    funny_sound = farts.sample
    system("aplay #{funny_sound}")
  end
end

RPi::GPIO.reset