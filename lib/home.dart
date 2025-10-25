import 'package:flutter/material.dart';
import 'package:laundry/infomachine.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
          child: Column(
            children: [
              Text(
                "Select your laundry option",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 50),

              //nak buat macam card style
              SizedBox(
                height: 150,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InfoWash()),
                    );
                  },

                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/washShirt.png",
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(width: 40),
                      Text(
                        "Wash",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              SizedBox(
                height: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InfoDry()),
                    );
                  },

                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/dry2.png",
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(width: 40),
                      Text(
                        "Dryer",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
