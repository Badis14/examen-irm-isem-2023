import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* num? temperature;
  num? humidity; */
  bool led1 = false;
  bool led2 = false;
  @override
  void initState() {
    // TODO: implement initState
    /*   getTempData();
    getHumidityData(); */
    initButtonStatus();
    super.initState();
  }

  /* void getTempData() {
    DatabaseReference tempRef =
        FirebaseDatabase.instance.ref().child('Temperature');
    tempRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as num?;
      if (data != null) {
        temperature = data;
        setState(() {});
      }
    });
  } */
  void initButtonStatus() async {
    DatabaseReference led1Ref = FirebaseDatabase.instance.ref().child('Led_1');
    DatabaseReference led2Ref = FirebaseDatabase.instance.ref().child('Led_2');
    DataSnapshot data1 = await led1Ref.get();
    DataSnapshot data2 = await led2Ref.get();
    led1 = data1.value as bool;
    led2 = data2.value as bool;
    setState(() {});
  }

  void controlleLED1(bool value) {
    DatabaseReference led1Ref = FirebaseDatabase.instance.ref().child('Led_1');
    led1Ref.set(value);
  }

  void controlleLED2(bool value) {
    DatabaseReference led2Ref = FirebaseDatabase.instance.ref().child('Led_2');
    led2Ref.set(value);
  }

  /* void getHumidityData() {
    DatabaseReference humidityRef =
        FirebaseDatabase.instance.ref().child('Humidite');
    humidityRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as num?;
      if (data != null) {
        humidity = data;
        setState(() {});
      }
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            const Center(
              child: Text(
                "ESP-32-Controlle System",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 50,
                ),
                Text(
                  "Led 1 :",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 60,
                ),
                Switch(
                  onChanged: (bool value) {
                    led1 = value;
                    controlleLED1(value);
                    setState(() {});
                  },
                  value: led1,
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 50,
                ),
                Text(
                  "Led 2 :",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 60,
                ),
                Switch(
                  onChanged: (bool value) {
                    led2 = value;
                    controlleLED2(value);
                    setState(() {});
                  },
                  value: led2,
                ),
              ],
            ),
          ]),
    );
  }
}
