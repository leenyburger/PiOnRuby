require 'rpi_gpio'

RPi::GPIO.set_numbering :board

ControlPin = [7, 11, 13, 15]
ControlPin_2 = [29,31, 33, 37]

for pin in ControlPin
  RPi::GPIO.setup pin, :as => :output, :initialize => :low
end

for pin in ControlPin_2
	RPi::GPIO.setup pin, :as => :output, :initialize => :low
end

def set_pin(pin, value)
  if value == 0 
    RPi::GPIO.set_low(pin)
  else 
    RPi::GPIO.set_high(pin)
  end
end

  seq = [ [1,0,0,0],
          [1,1,0,0],
          [0,1,0,0],
          [0,1,1,0],
	  [0,0,1,0],
	  [0,0,1,1],
          [0,0,0,1],
          [1,0,0,1]
	]    
for i in 0..511
  for halfstep in 0..7
    for pin in 0..3
      set_pin(ControlPin[pin], seq[halfstep][pin])
      set_pin(ControlPin_2[pin], seq[halfstep][pin])
    end
  sleep(0.001)
  end
end


RPi::GPIO.clean_up
