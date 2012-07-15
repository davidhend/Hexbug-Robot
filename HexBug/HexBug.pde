int IN1 = 3; //2(Originally)Input pin determines driving mode(forward,reverse,standby)
int IN2 = 2; //3(Originally)Input pin determines driving mode(forward,reverse,standby)
int ENA1 = 5; //4(Originally)Input pin enable/disable drivers O1/O2
int ENA2 = 4; //5(Originally)Input pin enable/disable drivers O3/O4
int itteration = 0;
int i = 0;

// this constant won't change.  It's the pin number
// of the sensor's output:
const int pingPin = 7;
 
void setup() {
   // initialize serial communication:
   Serial.begin(9600);

   pinMode(IN1, OUTPUT);
   pinMode(IN2, OUTPUT);
   pinMode(ENA1, OUTPUT);
   pinMode(ENA2, OUTPUT);
 }
 
void loop()
 {
   // establish variables for duration of the ping, 
  // and the distance result in inches and centimeters:
   long duration, inches, cm;
 
  // The PING))) is triggered by a HIGH pulse of 2 or more microseconds.
   // Give a short LOW pulse beforehand to ensure a clean HIGH pulse:
   pinMode(pingPin, OUTPUT);
   digitalWrite(pingPin, LOW);
   delayMicroseconds(2);
   digitalWrite(pingPin, HIGH);
   delayMicroseconds(5);
   digitalWrite(pingPin, LOW);
 
  // The same pin is used to read the signal from the PING))): a HIGH
   // pulse whose duration is the time (in microseconds) from the sending
   // of the ping to the reception of its echo off of an object.
   pinMode(pingPin, INPUT);
   duration = pulseIn(pingPin, HIGH);
 
  // convert the time into a distance
   inches = microsecondsToInches(duration);
   cm = microsecondsToCentimeters(duration);
   
   if (cm >= 20) {
     moveForward();
     delay(500);
   }else{
     moveBackward();
     delay(500);
     turnLeft();
   }

 }
 
long microsecondsToInches(long microseconds)
 {
   // According to Parallax's datasheet for the PING))), there are
   // 73.746 microseconds per inch (i.e. sound travels at 1130 feet per
   // second).  This gives the distance travelled by the ping, outbound
   // and return, so we divide by 2 to get the distance of the obstacle.
   // See: http://www.parallax.com/dl/docs/prod/acc/28015-PING-v1.3.pdf
   return microseconds / 74 / 2;
 }
 
long microsecondsToCentimeters(long microseconds)
 {
   // The speed of sound is 340 m/s or 29 microseconds per centimeter.
   // The ping travels out and back, so to find the distance of the
   // object we take half of the distance travelled.
   return microseconds / 29 / 2;
 }
 
 
void turnLeft()
{
 digitalWrite(IN1, LOW);
 digitalWrite(ENA1, HIGH);
 delay(300);
 digitalWrite(IN1, LOW);
 digitalWrite(ENA1, LOW);
}

void turnRight()
{
 digitalWrite(IN1, HIGH);
 digitalWrite(ENA1, HIGH);
 delay(300);
 digitalWrite(IN1, LOW);
 digitalWrite(ENA1, LOW);
}

void moveForward()
{
 digitalWrite(IN2, LOW);
 digitalWrite(ENA2, HIGH); 
}

void moveBackward()
{
 digitalWrite(IN2, HIGH);
 digitalWrite(ENA2, HIGH); 
}

void stopMoving()
{
 digitalWrite(IN1, LOW);
 digitalWrite(ENA1, LOW);
 digitalWrite(IN2, LOW);
 digitalWrite(ENA2, LOW); 
}
