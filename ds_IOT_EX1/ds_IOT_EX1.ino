#include <Wire.h>  

#include <FirebaseESP32.h>  

#include <WiFi.h>  

#define WIFI_SSID "BADIS" //replace SSID with your wifi username  

#define WIFI_PASSWORD "Badis2023" //replace PWD with your wifi password  

#define FIREBASE_HOST "https://temp-783ae-default-rtdb.europe-west1.firebasedatabase.app" //link of api  

#define FIREBASE_API_Key "AIzaSyDTXKG9nuzu0-l-9VHX_MwpgpQiPvTflWQ"  



// Firebase Authentication Object
FirebaseAuth auth; 
// Firebase configuration Object
FirebaseConfig config; 
// Firebase database path
String databasePath = ""; 
// Firebase Unique Identifier
String fuid = ""; 
// Store device authentication status
bool isAuthenticated = false;
//database secret  


#define LED1 26 // DHT22 connecté à la pin GPIO18  

#define LED2 27 // DHT 22 (AM2302)  

//Variables  



FirebaseData firebaseData; 
bool allume_led_1= false;
bool allume_led_2= false;


void Wifi_Init() {
 WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
 Serial.print("Connecting to Wi-Fi");
 while (WiFi.status() != WL_CONNECTED){
  Serial.print(".");
  delay(300);
  }
 Serial.println();
 Serial.print("Connected with IP: ");
 Serial.println(WiFi.localIP());
 Serial.println();
}

void firebase_init() {
// configure firebase API Key
config.api_key = FIREBASE_API_Key;
// configure firebase realtime database url
config.database_url = FIREBASE_HOST;
// Enable WiFi reconnection 
Firebase.reconnectWiFi(true);
Serial.println("------------------------------------");
Serial.println("Sign up new user...");
// Sign in to firebase Anonymously
if (Firebase.signUp(&config, &auth, "", ""))
{
Serial.println("Success");
 isAuthenticated = true;
// Set the database path where updates will be loaded for this device
 fuid = auth.token.uid.c_str();
}
else
{
 Serial.printf("Failed, %s\n", config.signer.signupError.message.c_str());
 isAuthenticated = false;
}
// Initialise the firebase library
Firebase.begin(&config, &auth);
}

void setup() {  

Serial.begin(115200);  

Serial.print("Connecting to ");  

Wifi_Init();

firebase_init();//connect to Database  
 pinMode(LED1, OUTPUT);
 pinMode(LED2, OUTPUT);

  
 



} 

void loop() {  



allume_led_1 = getFirebaseBooleanValue("Led_1");  
if (allume_led_1)
  digitalWrite(LED1, HIGH);
else
  digitalWrite(LED1, LOW);
/* Firebase.setFloat(firebaseData,"Pression",pression); */  

allume_led_2= getFirebaseBooleanValue("Led_2");  
if (allume_led_2)
  digitalWrite(LED2, HIGH);
else
  digitalWrite(LED2, LOW);


/* Firebase.setFloat(firebaseData,"Pluie",pluie);   */

delay(500); // 1h  

} 

bool getFirebaseBooleanValue(const char *path) {
  if (Firebase.getBool(firebaseData, path)) {
    if (firebaseData.boolData()) {
      return true;
    } else {
      return false;
    }
  } else {
    Serial.println("Failed to get value from Firebase");
    return false;
  }
}