#include <Servo.h>

const uint8_t servoPin = 5;

Servo servo;

void setup() {
  // put your setup code here, to run once:
  servo.attach(servoPin);
  servo.write(90);
  delay(5000);

}


void reset_servo(void){
  servo.write(90);
}

void press_button(int floor){
  servo.write(floor*180);
  delay(100);
  reset_servo();
}

void loop() {
  press_button(0);
  delay(500);
  press_button(1);
  delay(500);
}
