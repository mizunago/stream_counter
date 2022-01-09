#include <WiFiMulti.h>
#include <HTTPClient.h>


const char URL[] = "http://192.168.11.101/cgi/stream_buttons/index.rb";
WiFiMulti wifiMulti;
int input_val = 0;
int button = 0;
#define PIN 32 // 入力ピン
#define LED_BUILTIN 2

void sendMessage();

void setup() {
  Serial.begin(115200); // このシリアル通信はモニター用
  delay(10);

  pinMode(PIN, INPUT);
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.print("wifi connecting...\n");
  // Wi-Fi 接続 https://www.sglabs.jp/esp-wroom-02-wi-fi/
  wifiMulti.addAP("aterm-xxxxxx-a", "12345678901234567890abcdef");
  while (wifiMulti.run() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.print("wifi connected\n");
}

void loop() {
  // ボタンは何も押されていない初期状態に更新
  button = 0;
  input_val = analogRead(PIN);
  //Serial.print(input_val);
  //Serial.print("\n");
  switch (input_val) {
    case 0 ... 32:
      Serial.print("Killed a pirate.\n");
      button = 1;
      break;
    case 50 ... 100:
      Serial.print("Sunk a sloop.\n");
      button = 2;
      break;
    case 300 ... 400:
      Serial.print("Sunk a brig.\n");
      button = 3;
      break;
    case 600 ... 700:
      Serial.print("Sunk a galleon.\n");
      button = 4;
      break;
    case 1000 ... 1300:
      Serial.print("Ship has sunk.\n");
      button = 5;
      break;
    case 1700 ... 2000:
      Serial.print("A pirate killed.\n");
      button = 6;
      break;
    case 2700 ... 3000:
      Serial.print("Counter was reset.\n");
      button = 7;
      break;
    case 4000 ... 4096:
      //Serial.print("None of the buttons were pressed.\n");
      break;
  }
  // なにかのボタンが押されている場合のみ実行
  if (button != 0) {
    sendMessage(button);
    brink_built_in_led(); // 送信完了をLED光らせて通知
    delay(1500); // 再送禁止期間
  }
}

void brink_built_in_led() {
  for (int i = 0; i <= 3; i++) {
    digitalWrite(LED_BUILTIN, HIGH);
    delay(100);
    digitalWrite(LED_BUILTIN, LOW);
    delay(50);
  }
}

void sendMessage(int button) {
  WiFiClientSecure client;
  HTTPClient http;
  // http.begin(URL);
  http.begin(String(URL) + "?button=" + String(button));
  Serial.print(button);

  int httpCode = http.GET();

  Serial.printf("Response: %d", httpCode);
  Serial.println();
  if (httpCode == HTTP_CODE_OK) {
    String body = http.getString();
    Serial.print("Response Body: ");
    Serial.println(body);
  }

  Serial.println("closing connection");
}