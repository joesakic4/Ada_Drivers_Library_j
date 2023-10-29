<<<<<<< HEAD
with Ultrasonic;-- use Ultrasonic;
=======
with MicroBit.Ultrasonic;
>>>>>>> a14d575a2e61f226cf401cd59f38c67c1adc57bf
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
use MicroBit;

procedure Main is
<<<<<<< HEAD
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
=======
   package sensor1 is new Ultrasonic(MB_P16, MB_P0);
   package sensor2 is new Ultrasonic(MB_P15, MB_P0);
   package sensor3 is new Ultrasonic(MB_P14, MB_P0);

   Distance : Distance_cm := 0;
begin
   loop
      Put_Line ("");
      Distance := sensor1.Read;
      Put_Line ("Front: " & Distance_cm'Image(Distance)); -- a console line delay the loop significantly
      Distance := sensor2.Read;
      Put_Line ("Left: " & Distance_cm'Image(Distance)); -- a console line delay the loop significantly
      Distance := sensor3.Read;
      Put_Line ("Right: " & Distance_cm'Image(Distance)); -- a console line delay the loop significantly

      --NOTE:
      -- A delay directly after a read of about 50ms is needed since signal need to die out to be sure there is nothing
      -- With multiple sensors in different cardinal directions 50ms is fine since they dont overlap
      -- Smaller delays are possible but they will
      --    - Flood the serial port
      --    - A smaller delay is sometimes possible in situations where it can be guaranteed that no
      --      echo comes back later than the custom threshold (ie. echo's always come back).
      delay 0.05; --50ms
>>>>>>> a14d575a2e61f226cf401cd59f38c67c1adc57bf
   end loop;

end Main;


