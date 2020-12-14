import 'package:flutter/material.dart';

import 'package:iCOOK/Screens/Welcome_screen.dart';
import 'package:iCOOK/components/rounded_button.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

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
    return Scaffold(
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
              buildTextField("Name", ""), //pass value
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
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
              SizedBox(
                height: 40,
              ),
              // ignore: missing_required_param
              RoundedButton(
                text: "UPDATE",
                press: () {},
                textColor: Colors.white,
                color: Colors.red[200],
              ),
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
    );
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

  Future<void> _selectDate(BuildContext context) async {
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
