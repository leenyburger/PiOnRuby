class Robot

  require 'rpi_gpio'
  attr_reader :control_pin, :control_pin_2


  def initialize
    RPi::GPIO.set_numbering :board

    @control_pin = [7, 11, 13, 15]
    @control_pin_2 = [29,31, 33, 37]
    for pin in control_pin
      RPi::GPIO.setup pin, :as => :output, :initialize => :low
    end

    for pin in control_pin_2
      RPi::GPIO.setup pin, :as => :output, :initialize => :low
    end
  end

  def set_pin(pin, value)
    if value == 0 
      RPi::GPIO.set_low(pin)
    else 
      RPi::GPIO.set_high(pin)
    end
  end

  def seq 
    [ [1,0,0,0],
      [1,1,0,0],
      [0,1,0,0],
      [0,1,1,0],
      [0,0,1,0],
      [0,0,1,1],
      [0,0,0,1],
      [1,0,0,1]
   ]  
  end
  def go_forward  
    for i in 0..511
      for halfstep in 0..7
        for pin in 0..3
          set_pin(control_pin[pin], seq[halfstep][pin])
          set_pin(control_pin_2[pin], seq[halfstep][pin])
        end
      sleep(0.001)
      end
    end
  end

  def turn_right
    for i in 0..511
      for halfstep in 0..7
        for pin in 0..3
          set_pin(control_pin_2[pin], seq[halfstep][pin])
        end
      sleep(0.001)
      end
    end
  end

   def turn_left
    for i in 0..511
      for halfstep in 0..7
        for pin in 0..3
          set_pin(control_pin[pin], seq[halfstep][pin])
        end
      sleep(0.001)
      end
    end
    end
    

  RPi::GPIO.clean_up
end
