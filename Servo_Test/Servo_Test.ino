#include <Servo.h>
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>

#ifndef STASSID
#define STASSID "Device Net"
#define STAPSK NULL
#endif

const char* ssid = STASSID;
const char* pass = STAPSK;
const uint8_t servoPin = 5;
const int led = 13;

Servo servo;
ESP8266WebServer server(80);


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
  Serial.print("BUTTON CALLED\n");
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

void setup() {
  // put your setup code here, to run once:
  pinMode(led, OUTPUT);
  digitalWrite(led, 0);
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, pass);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  if (MDNS.begin("esp8266")) {
    Serial.println("MDNS responder started");
  }

  server.on("/", handleRoot);
  server.on("/press1", press_up);
  server.on("/press0", press_down);
  server.onNotFound(handleNotFound);
  server.begin();
  Serial.println("HTTP server started");
  servo.attach(servoPin);
  servo.write(90);
  delay(5000);

}

void loop() {
  server.handleClient();
  MDNS.update();
}
