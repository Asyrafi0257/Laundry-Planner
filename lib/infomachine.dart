import 'package:flutter/material.dart';

//==============ni untuk bahagian info wash=========================
class InfoWash extends StatefulWidget {
  const InfoWash({super.key});

  @override
  State<InfoWash> createState() => _InfoWashState();
}

class _InfoWashState extends State<InfoWash> {
  String selectedType = "normal";
  double outputLoad = 0;
  double outputWater = 0;
  double outputTime = 0;
  TextEditingController shirtController = TextEditingController();
  TextEditingController capacityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            //nak bagi space dalam sikit
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "WASHING MACHINE",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  //kita letak gambar machine
                  Image.asset("assets/images/machine3.png", scale: 1.5),
                  SizedBox(height: 50),

                  //ni bahagian user kena isi maklumat sebelum start
                  SizedBox(
                    child: Column(
                      children: [
                        TextField(
                          controller: shirtController,
                          keyboardType: TextInputType.number,
                          //decoration ni kita nk style kan bahagian luar box like border radius
                          decoration: InputDecoration(
                            labelText: "Number of shirt",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        TextField(
                          controller: capacityController,
                          keyboardType: TextInputType.number,
                          //decoration ni kita nk style kan bahagian box like border radius
                          decoration: InputDecoration(
                            labelText: "Capacity",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),

                        //dekat sini nak buat dropdown button
                        SizedBox(
                          width: 300,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                                child: Text(
                                  "Wash Type :",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(width: 15),
                              DropdownButton<String>(
                                value: selectedType,
                                items: <String>["normal", "quick", "heavy"].map((
                                  String value,
                                ) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                    ), //nilai yang akan paparkan dekat dropdown
                                  );
                                }).toList(), //tukar nilai dari map kepada list
                                //? => nak bagitahu flutter yang nilai tu boleh jadi null
                                onChanged: (String? newValue) {
                                  selectedType = newValue!;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),

                        //nak display output
                        Container(
                          width: 290,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white54, // warna background
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.black26,
                              width: 1,
                            ), // border hitam
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Number of Loads : $outputLoad",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 5),

                                  Text(
                                    "Total time : $outputTime",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),

                                  SizedBox(height: 5),

                                  Text(
                                    "Total Water : $outputWater",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),

                        //buat button
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[300],
                            ),
                            onPressed: calculate,
                            child: Text(
                              "Calculate",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // function untuk button calculate
  void calculate() {
    //set water(L) for normal, quick and heavy
    double waterNormal = 50;
    double waterHeavy = 70;
    double waterQuick = 30;

    //sum of time and water used
    double totalWater = 0;
    double totalTime = 0;

    //handle handling if user input invalid input
    int? numShirts = int.tryParse(shirtController.text);
    int? sumCapacity = int.tryParse(capacityController.text);

    // check if textfield empty or not
    if (shirtController.text.trim().isEmpty ||
        capacityController.text.trim().isEmpty) {
      SnackBar snackBar = const SnackBar(
        content: Text('Please fill in all fields'),
      );

      //kita paparkan balik message yang kita buat
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } else if (numShirts == null || sumCapacity == null) {
      SnackBar snackBar = const SnackBar(
        content: Text('Please insert valid input'),
      );

      //kita paparkan balik message yang kita buat
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } else {
      //nilai input yang user type
      // int numShirt = int.parse(shirtController.text);
      // int sumCapacity = int.parse(capacityController.text);

      //total load
      double totalLoad = (numShirts / sumCapacity).ceilToDouble();

      final standardType = selectedType.toLowerCase();

      //logic bila user choose normal, quick and heavy
      if (standardType == 'normal') {
        totalWater = totalLoad * waterNormal;
        totalTime = totalLoad * 40;
      } else if (standardType == 'quick') {
        totalWater = totalLoad * waterQuick;
        totalTime = totalLoad * 20;
      } else if (standardType == 'heavy') {
        totalWater = totalLoad * waterHeavy;
        totalTime = totalLoad * 60;
      }

      setState(() {
        outputLoad = totalLoad;
        outputTime = totalTime;
        outputWater = totalWater;
      });
    }
  }
}

//=================Bahagian info dryer====================
class InfoDry extends StatefulWidget {
  const InfoDry({super.key});

  @override
  State<InfoDry> createState() => _InfoDryState();
}

class _InfoDryState extends State<InfoDry> {
  String selectedType = "normal";
  double outputLoad = 0;
  double outputEnergy = 0;
  double outputTime = 0;
  TextEditingController shirtController = TextEditingController();
  TextEditingController capacityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            //nak bagi space dalam sikit
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "DRYER MACHINE",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  //kita letak gambar machine
                  Image.asset("assets/images/dryer3.jpg", scale: 2.5),
                  SizedBox(height: 50),

                  //ni bahagian user kena isi maklumat sebelum start
                  SizedBox(
                    child: Column(
                      children: [
                        TextField(
                          controller: shirtController,
                          keyboardType: TextInputType.number,
                          //decoration ni kita nk style kan bahagian luar box like border radius
                          decoration: InputDecoration(
                            labelText: "Number of shirt",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        TextField(
                          controller: capacityController,
                          keyboardType: TextInputType.number,
                          //decoration ni kita nk style kan bahagian box like border radius
                          decoration: InputDecoration(
                            labelText: "Capacity",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),

                        //dekat sini nak buat dropdown button
                        SizedBox(
                          width: 300,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                                child: Text(
                                  "Dry Type :",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(width: 15),
                              DropdownButton<String>(
                                value: selectedType,
                                items: <String>["normal", "quick", "heavy"].map((
                                  String value,
                                ) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                    ), //nilai yang akan paparkan dekat dropdown
                                  );
                                }).toList(), //tukar nilai dari map kepada list
                                //? => nak bagitahu flutter yang nilai tu boleh jadi null
                                onChanged: (String? newValue) {
                                  selectedType = newValue!;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),

                        //nak display output
                        Container(
                          width: 290,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white54, // warna background
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.black26,
                              width: 1,
                            ), // border hitam
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Number of Loads : $outputLoad",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 5),

                                  Text(
                                    "Total time : $outputTime",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),

                                  SizedBox(height: 5),

                                  Text(
                                    "Total Energy : $outputEnergy",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),

                        //buat button
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[300],
                            ),
                            onPressed: calculate,
                            child: Text(
                              "Calculate",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // function untuk button calculate
  void calculate() {
    //set energy
    double energyNormal = 1.5;
    double energyHeavy = 1.0;
    double energyQuick = 2.0;

    double totalTime = 0;
    double totalEnergy = 0;

    //handle handling if user input invalid input
    int? numShirts = int.tryParse(shirtController.text);
    int? sumCapacity = int.tryParse(capacityController.text);

    // check if textfield empty or not
    if (shirtController.text.trim().isEmpty ||
        capacityController.text.trim().isEmpty) {
      SnackBar snackBar = const SnackBar(
        content: Text('Please fill in all fields'),
      );

      //kita paparkan balik message yang kita buat
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } else if (numShirts == null || sumCapacity == null) {
      SnackBar snackBar = const SnackBar(
        content: Text('Please insert valid input'),
      );

      //kita paparkan balik message yang kita buat
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } else {
      //total load
      double totalLoad = (numShirts / sumCapacity).ceilToDouble();

      final standardType = selectedType.toLowerCase();

      //logic bila user choose normal, quick and heavy
      if (standardType == 'normal') {
        totalTime = totalLoad * energyNormal;
        totalEnergy = totalLoad * 40;
      } else if (standardType == 'quick') {
        totalTime = totalLoad * energyQuick;
        totalEnergy = totalLoad * 20;
      } else if (standardType == 'heavy') {
        totalTime = totalLoad * energyHeavy;
        totalEnergy = totalLoad * 60;
      }

      setState(() {
        outputLoad = totalLoad;
        outputTime = totalTime;
        outputEnergy = totalEnergy;
      });
    }
  }
}
