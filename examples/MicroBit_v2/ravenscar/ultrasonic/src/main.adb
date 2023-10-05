with Ultrasonic;-- use Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
use MicroBit;

procedure Main is
   package UltraFront is new Ultrasonic;
   package UltraRight is new Ultrasonic;
   package UltraLeft is new Ultrasonic;

   DistanceFront : UltraFront.Distance_cm := 0;
   DistanceLeft : UltraLeft.Distance_cm := 0;
   DistanceRight : UltraRight.Distance_cm := 0;
begin
    UltraFront.Setup(12,0); -- trigger is MB pin 12, echo is MB pin 0
                            -- implementation quirk: due to sensitive timing (microseconds), the implementation is really low level. Even an if statement takes too long.
                            -- you can't use pins 6,16,20 for they are on another port address.
                            -- if you want to use these pins change line 35 and 43 (trigger pin) from ultrasonic.adb and/or line 50 and line 55 (echo pin).
                            -- The only change is GPIO_Periph to GPIO_Periph1 to change the correct port address for these 3 pins.
   UltraRight.Setup(13,1);
   UltraLeft.Setup(8,2);
   loop
      -- Put_Line("HELLO");
      DistanceFront := UltraFront.Read;
      DistanceRight := UltraRight.Read;
      DistanceLeft := UltraLeft.Read;

      Put_Line ("Read Front" & UltraFront.Distance_cm'Image(DistanceFront)); -- a console line delay the loop significantly
      Put_Line ("Read Left" & UltraLeft.Distance_cm'Image(DistanceLeft));
      Put_Line ("Read Right" & UltraRight.Distance_cm'Image(DistanceRight));
      delay(1.0);
   end loop;

end Main;



