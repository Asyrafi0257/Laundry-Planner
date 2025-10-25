import 'package:flutter/material.dart';
import 'package:laundry/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashPage());
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    //nak set masa berapa second sebelum ke page lain
    Future.delayed(Duration(seconds: 2), () {
      //nak check sama ada widget masih active ke tidak
      if (!mounted) return;

      //tukar halaman selepas 2 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  //kita nak create ui page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          //nak center kan content dalam page
          mainAxisAlignment: MainAxisAlignment.center,

          //nak buat lebih daripada 1 widget
          children: [
            //letak image
            Image.asset("assets/images/laundry.png", scale: 8),

            //buat ada space antara widget
            SizedBox(height: 30),
            Text(
              "Laundry Planner",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            //code untuk buat dia loading
            CircularProgressIndicator(),
            SizedBox(height: 40),

            Text(
              "Loading ...",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
