import 'dart:async';

import 'package:attendance_gym/SuccessScreen.dart';
import 'package:attendance_gym/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nameController = TextEditingController();
  String? displayName;
  String timeText = "";
  String dateText = "";
  bool _isLoading = false;

  void getCurrentLiveTime() {
    final DateTime dateTimeNow = DateTime.now();
    final String liveTime = DateFormat("hh:mm:ss a").format(DateTime.now());
    final String liveDate = DateFormat("dd MMMM, yyyy").format(DateTime.now());

    if (this.mounted) {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentLiveTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
        body: Stack(children: [
      Container(
          height: height,
          width: width,
          child: Image.asset(
            'assets/blackbgdesktop.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          )),
      ListView(
        children: [
          Row(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dateText,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      timeText,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: (width < 615) ? height * 0.3 : height * 0.42),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (width>470)?Text(
                    'Please enter your name in the designated field and click the "Check In" button. Your check-in time will be recorded automatically. Thank you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ):Text(
                    'Enter your name and click "Check In" to automatically record your check-in time. Thank you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(28.0, 20, 28, 28),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: TextFormField(
                      controller: _nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter Your Name',
                        labelText: 'Name',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle:
                            TextStyle(fontSize: 16.0, color: Colors.white),
                        floatingLabelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        suffixIcon: Icon(Icons.person, color: Colors.white),
                      ),
                      onSaved: (value) {
                        displayName = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                (_isLoading)?ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: (){},
                  child: Loading()
                ):
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: _checkIn,
                  child: Text(
                    'Check In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: (width<450)?100:0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/brandbg.png',height: 100,width: 100,)
                ],
              ),

              Container(
                color: Colors.black,
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (width>360)?Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Text.rich(TextSpan(
                              text: 'Copyright © Sahil.  Made with ',
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: '❤️',
                                  style: TextStyle(color: Colors.red),
                                ),
                                TextSpan(
                                  text: ' by',
                                  style: TextStyle(color: Colors.white),
                                )
                              ])),
                          InkWell(
                              onTap: () async {
                                final Uri url = Uri.parse(
                                    'https://sahilpotdukhe.github.io/Portfolio-website/');
                                try {
                                  await launchUrl(url);
                                } catch (e) {
                                  print(e.toString());
                                }
                              },
                              child: Text(
                                '  Sahil Potdukhe',
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      ):Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Text.rich(TextSpan(
                              text: 'Made with ',
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: '❤️',
                                  style: TextStyle(color: Colors.red),
                                ),
                                TextSpan(
                                  text: ' by',
                                  style: TextStyle(color: Colors.white),
                                )
                              ])),
                          InkWell(
                              onTap: () async {
                                final Uri url = Uri.parse(
                                    'https://sahilpotdukhe.github.io/Portfolio-website/');
                                try {
                                  await launchUrl(url);
                                } catch (e) {
                                  print(e.toString());
                                }
                              },
                              child: Text(
                                '  Sahil Potdukhe',
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                    )),
              )
            ],
          )
        ],
      ),

    ]));
  }

  void _checkIn() async {
    String date = "";
    String time = "";
    time = DateFormat("hh:mm a").format(DateTime.now());
    date = DateFormat("dd MMMM, yyyy").format(DateTime.now());
    String name = _nameController.text;
    if (name.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection("Users")
          .doc('tZmrdkgweQOLpUAvDBm1GDqHPBA2')
          .collection('attendance')
          .add({'name': name, 'date': date, 'time': time});
      _nameController.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SuccessScreen()));
      setState(() {
        _isLoading = false;
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter Name',style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,),
      );
    }
  }
}
