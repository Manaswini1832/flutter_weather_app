import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 60.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 30.0,
);

const kConditionTextStyle = TextStyle(
  fontSize: 120.0,
  fontFamily: 'Poppins',
);

const kErrorTitleStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Poppins',
);

const kErrorTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'Poppins',
);

const kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white60,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
);

const kCityButtonDecoration = InputDecoration(
  hintText: 'Enter a city ....',
  hintStyle: TextStyle(
    fontSize: 22,
    fontFamily: 'Poppins',
    color: Colors.white70,
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Color(0xFFFFFFFF),
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      width: 2,
      color: Colors.lightBlue,
    ),
  ),
);
