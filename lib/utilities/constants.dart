import 'package:flutter/material.dart';

final kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 80,
  fontWeight: FontWeight.w100,
  wordSpacing: 0.2,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 50,
);

const kButtonTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 30,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 70,
);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.black45,
  icon: Icon(
    Icons.location_city,
    color: Colors.black,
    size: 50.0,
  ),
  hintText: 'Enter City Name',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15.0),
    ),
    borderSide:BorderSide.none,
  ),
);