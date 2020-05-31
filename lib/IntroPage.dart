import 'package:flutter/material.dart';
import 'package:fluttersoptask/GamePage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() => _IntroductionState();
}

//List<String> names = new List<String>();
//
//SharedPreferences preferencesNames;

//TextEditingController one = new TextEditingController();
TextEditingController two = new TextEditingController();

//Future<List<String>> loadNameList() async {
//  preferencesNames = await SharedPreferences.getInstance();
//  if (preferencesNames == null) {
//    return null;
//  } else {
//    return preferencesNames.getStringList('names');
//  }
//}

String name;

int n;

class _IntroductionState extends State<Introduction> {
//  Future<bool> saveNameList() async {
//    preferencesNames = await SharedPreferences.getInstance();
//    return await preferencesNames.setStringList('names', names);
//  }
//
//  setNameList() {
//    loadNameList().then(
//      (value) {
//        setState(
//          () {
//            names = value;
//          },
//        );
//      },
//    );
//  }

  String temp;

  int tempN;
  String tempName;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.all(50.0),
//            child: TextField(
//              style: TextStyle(color: Colors.yellow),
//              controller: one,
//              onChanged: (identity) {
//                setState(
//                  () {
//                    tempName = identity;
//                  },
//                );
//              },
//              decoration: InputDecoration(
//                hintStyle: TextStyle(color: Colors.yellow),
//                hintText: 'Enter Name',
//                enabledBorder: UnderlineInputBorder(
//                  borderSide: BorderSide(color: Colors.red),
//                ),
//                focusedBorder: UnderlineInputBorder(
//                  borderSide: BorderSide(color: Colors.green),
//                ),
//              ),
//            ),
//          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: TextField(
              style: TextStyle(color: Colors.yellow),
              controller: two,
              onChanged: (number) {
                setState(
                  () {
                    tempN = int.parse(number);
                  },
                );
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.yellow),
                hintText: 'Enter even number n (grid side)',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.teal,
              child: Text(
                'Proceed',
                style: optionStyle,
              ),
              onPressed: () {
                if(tempN == null) {
                  Alert(
                    context: context,
                    title: 'Invalid Entry!',
                    desc: 'Enter data',
                  ).show();
                }
//                else if(tempName == null) {
//                  Alert(
//                    context: context,
//                    title: 'Invalid Entry!',
//                    desc: 'Enter non empty name',
//                  ).show();
////                  one.clear();
//                }
                else if (!(tempN % 2 == 0)) {
                  Alert(
                    context: context,
                    title: 'Invalid Entry!',
                    desc: 'Enter even number',
                  ).show();
                  two.clear();
                } else {
                  setState(
                    () {
                      n = tempN;
//                      name = tempName;
//                      names.add(name);
//                      saveNameList();
//                      setNameList();
                    },
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(
                        gridNumber: n,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
