import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iCOOK/Screens/Welcome_screen.dart';
import 'package:iCOOK/components/rounded_button.dart';
import 'package:iCOOK/models/user.dart';
import 'package:iCOOK/services/database.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

//String _currentUserName;
//String _currentGender;
//String _currentEmail;
//DateTime _currentDate;

class Gender {
  int id;
  String name;

  Gender(this.id, this.name);

  static List<Gender> getGenders() {
    return <Gender>[
      Gender(1, 'Male'),
      Gender(2, 'Female'),
    ];
  }
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> gender = ['male', 'female'];
  int _currentIndex = 3;
  List<Gender> _genders = Gender.getGenders();
  List<DropdownMenuItem<Gender>> _dropdownMenuItems;
  Gender _selectedGender;
  String select;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_genders);
    _selectedGender = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Gender>> buildDropdownMenuItems(List genders) {
    List<DropdownMenuItem<Gender>> items = List();
    for (Gender company in genders) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Gender selectedGender) {
    setState(() {
      _selectedGender = selectedGender;
    });
  }

  @override
  Widget build(BuildContext context) {
    /*final users = Provider.of<List<InfoUser>>(context);
    users.forEach((user) {
      print(user.username);
      print(user.email);
      print(user.gender);
      print(user.date);
    });
    return StreamProvider<List<InfoUser>>.value(
      value: DatabaseService().users,*/

    final user = Provider.of<User>(context);

    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.lightGreen,
                  title: Text('iCOOK - profile'),
                  centerTitle: true,
                ),
                body: Container(
                  padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        buildTextField("Name", ""),
                        //pass value
                        buildTextField("Email", ""),

                        Text(
                          "Gender",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        DropdownButton(
                          value: _selectedGender,
                          items: _dropdownMenuItems,
                          onChanged: onChangeDropdownItem,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Birthday",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${selectedDate.toLocal()}".split(' ')[0]),
                        SizedBox(
                          height: 5.0,
                        ),
                        RaisedButton(
                          onPressed: () => _currentDate(context),
                          child: Text('Select date'),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        // ignore: missing_required_param
                        RoundedButton(
                            textColor: Colors.white,
                            color: Colors.red[200],
                            text: "UPDATE",
                            press: () async {
                              if (_formKey.currentState.validate()) {
                                await DatabaseService(uid: user.uid)
                                    .updateUserData();
                              }
                            }),
                        /*print(_currentUserName);
                            print(_currentEmail);
                            print(_currentGender);
                            print(_currentDate);
                          },*/

                        // ignore: missing_required_param
                        RoundedButton(
                          text: "LOG OUT",
                          textColor: Colors.redAccent,
                          color: Colors.pink[50],
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return WelcomeScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  iconSize: 30,
                  selectedFontSize: 15,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.linked_camera),
                        // ignore: deprecated_member_use
                        title: Text('Camera'),
                        backgroundColor: Colors.lightGreen),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu_book),
                        // ignore: deprecated_member_use
                        title: Text('Recipes'),
                        backgroundColor: Colors.lightGreen),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.rule),
                        // ignore: deprecated_member_use
                        title: Text('Tips'),
                        backgroundColor: Colors.lightGreen),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        // ignore: deprecated_member_use
                        title: Text('Profile'),
                        backgroundColor: Colors.lightGreen),
                  ],
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            );
          } else {}
        });
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 24,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Future<void> _currentDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
