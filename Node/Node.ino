#include <Servo.h>
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>


#ifndef STASSID
#define STASSID "IU PublicNet"
#define STAPSK NULL
#endif

bool debug = false; // Turn to true for local server only
bool strings = true; // turn false to remove serial printing


const char* ssid = STASSID;
const char* pass = STAPSK;
const uint8_t servoPin = 5;
const int led = 13;

int httpCode;
int floor_code;
String payload;

Servo servo;
ESP8266WebServer server(80);
HTTPClient http;
WiFiClient wifi;



void println(String message, bool t=strings){
  if (t){
    Serial.println(message);
  }
}
void print(String message, bool t=strings){
  if (t){
    Serial.print(message);
  }
}

void handleRoot() {
  digitalWrite(led, 1);
  server.send(200, "text/plain", "root\r\n");
  digitalWrite(led, 0);
}

void handleNotFound() {
  digitalWrite(led, 1);
  String message = "File Not Found\n\n";
  message += "URI: ";
  message += server.uri();
  message += "\nMethod: ";
  message += (server.method() == HTTP_GET) ? "GET" : "POST";
  message += "\nArguments: ";
  message += server.args();
  message += "\n";
  for (uint8_t i = 0; i < server.args(); i++) {
    message += " " + server.argName(i) + ": " + server.arg(i) + "\n";
  }
  server.send(404, "text/plain", message);
  digitalWrite(led, 0);
}

void reset_servo(void){
  servo.write(90);
}

void press_button(int floor){
  println("BUTTON CALLED\n");
  servo.write(floor*180);
  delay(100);
  reset_servo();
}

void press_up(){
  server.send(200, "text/plain", "Going Up!\r\n");
  press_button(1);
  delay(1000);
}
void press_down(){
  server.send(200, "text/plain", "Going Down!\r\n");
  press_button(0);
  delay(1000);
}

void local_server_up(){
  server.on("/", handleRoot);
  server.on("/press1", press_up);
  server.on("/press0", press_down);
  server.onNotFound(handleNotFound);
  server.begin();
}

void setup() {
  // put your setup code here, to run once:
  pinMode(led, OUTPUT);
  digitalWrite(led, 0);
  Serial.begin(115200);
  print("MAC: ");
  println(WiFi.macAddress());
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, pass);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    print(".");
  }
  println("");
  print("Connected to ");
  println(ssid);
  print("IP address: ");
  println(WiFi.localIP());

  if (MDNS.begin("esp8266")) {
    println("MDNS responder started");
  }


  if(debug){
    local_server_up();
  }

  http.begin(wifi, "http://ec2-18-219-245-250.us-east-2.compute.amazonaws.com/getCall");
  println("HTTP server started");
  servo.attach(servoPin);
  servo.write(90);
  delay(5000);

}

void loop() {
  if(debug){

  server.handleClient();
  MDNS.update();

  }
  if (!debug){

    httpCode = http.GET();

    if (httpCode > 0){

      print("HTTP CODE:");
      println(httpCode);
      payload = http.getString();
      println(payload);
      floor_code = payload.toInt();
      switch(floor_code){
        case -1:
          println("No Waiting Calls");
          break;
        case 0:
          println("Down Button Pressed!");
          break;
      }
      if (floor_code == -1){
        println("No Waiting calls");
      }

      if(floor_code == 0){
        println("DOWN BUTTON PRESSED");
        press_down();
      }

      if(floor_code == 1){
        println("UP BUTTON PRESSED");
        press_up();
      }
      else{
        print("FLOOR ");
        println(floor_code);
      }
    }
    delay(5000);
  }
}
