with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console ;
use MicroBit;
with Ada.Execution_Time; use Ada.Execution_Time;
with MicroBit; use MicroBit;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MicroBit.MotorDriver;

package body Brain is

   task body Sense is
      Time_Now_Stopwatch : Time;
      Time_Now_CPU : CPU_Time;
      Elapsed_Stopwatch : Time_Span;
      Elapsed_CPU : Time_Span;
      AmountOfMeasurement: Integer := 10; -- do 10 measurement and average

      -------------------
      type DriveState is (Forward,
                          Backward,
                          Left,
                          Right,
                          Forward_Left,
                          Forward_Right,
                          Backward_Left,
                          Backward_Right,
                          Lateral_Left,
                          Lateral_Right,
                          Rotating_Left,
                          Rotating_Right,
                          Curve_Forward_Left,
                          Curve_Forward_Right,
                          Stop);
      drive : DriveState := Forward;
      -------------------
   begin
      loop
         Elapsed_Stopwatch := Time_Span_Zero;
         Elapsed_CPU := Time_Span_Zero;

         for Index in 1..AmountOfMeasurement loop
            Time_Now_Stopwatch := Clock;
            Time_Now_CPU := Clock;

            case drive is
               when Forward               => MotorDriver.Drive(MotorDriver.Forward);
               when Backward              => MotorDriver.Drive(MotorDriver.Backward);
               when Left                  => MotorDriver.Drive(MotorDriver.Left);
               when Right                 => MotorDriver.Drive(MotorDriver.Right);
               when Forward_Left          => MotorDriver.Drive(MotorDriver.Forward_Left);
               when Forward_Right         => MotorDriver.Drive(MotorDriver.Forward_Right);
               when Backward_Left         => MotorDriver.Drive(MotorDriver.Backward_Left);
               when Backward_Right        => MotorDriver.Drive(MotorDriver.Backward_Right);
               when Lateral_Left          => MotorDriver.Drive(MotorDriver.Lateral_Left);
               when Lateral_Right         => MotorDriver.Drive(MotorDriver.Lateral_Right);
               when Rotating_Left         => MotorDriver.Drive(MotorDriver.Rotating_Left);
               when Rotating_Right        => MotorDriver.Drive(MotorDriver.Rotating_Right);
               when Curve_Forward_Left    => MotorDriver.Drive(MotorDriver.Forward, (4095,4095,0,0));
               when Curve_Forward_Right   => MotorDriver.Drive(MotorDriver.Forward, (0,0,4095,4095));
               when Stop                  => MotorDriver.Drive(MotorDriver.Stop);
            end case;


            Elapsed_CPU := Elapsed_CPU + (Clock - Time_Now_CPU);
            Elapsed_Stopwatch := Elapsed_Stopwatch + (Clock - Time_Now_Stopwatch);
         end loop;

         Elapsed_CPU := Elapsed_CPU / AmountOfMeasurement;
         Elapsed_Stopwatch := Elapsed_Stopwatch / AmountOfMeasurement;

            Put_Line ("Average CPU time: " & To_Duration (Elapsed_CPU)'Image & " seconds");
            Put_Line ("Average Stopwatch time: " & To_Duration (Elapsed_Stopwatch)'Image & " seconds");
            delay(0.03);
      end loop;
   end Sense;
end Brain;
