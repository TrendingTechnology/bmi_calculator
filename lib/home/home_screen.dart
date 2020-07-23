import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:bmicalculator/constants.dart';
import 'package:bmicalculator/home/bmi_info.dart';
import 'package:bmicalculator/home/bmi_result.dart';
import 'package:bmicalculator/home/curve_painter.dart';
import 'package:bmicalculator/home/gender_toggle_button.dart';
import 'package:bmicalculator/home/slider.dart';
import 'package:bmicalculator/models/gender.dart';
import 'package:bmicalculator/utils/bmi_calculator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Gender _selectedGender = Gender.Male;
  int height = 170;
  int weight = 65;
  bool showResult = false;

  Widget _buildGenderToggleButtons({String title, Gender gender}) {
    return GenderToggleButton(
      bgColor: _selectedGender == gender
          ? kActiveButtonBgColor
          : kInactiveButtonBgColor,
      icon: gender == Gender.Male
          ? FontAwesomeIcons.mars
          : FontAwesomeIcons.venus,
      onTap: !showResult
          ? () {
              setState(() {
                _selectedGender = gender;
              });
            }
          : null,
      text: title,
      textColor: _selectedGender == gender
          ? kActiveButtonTextColor
          : kInactiveButtonTextColor,
    );
  }

  Widget _buildBottomStackContent() {
    if (!showResult) {
      return BmiInfoWidget();
    } else {
      final BmiCalculator _bmiResult =
          BmiCalculator(height: height, weight: weight);

      return BmiResultWidget(bmiResult: _bmiResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: kAppBarTextStyle,
        ),
      ),
      body: Container(
        decoration: kMainContainerDecoration,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 13.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                      ),
                      child: Text(
                        'GENDER',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: _buildGenderToggleButtons(
                              title: 'Male',
                              gender: Gender.Male,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: _buildGenderToggleButtons(
                              title: 'Female',
                              gender: Gender.Female,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'HEIGHT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        bottom: 16.0,
                      ),
                      child: CustomSlider(
                        min: 120,
                        max: 220,
                        measurementUnit: 'cm',
                        value: height,
                        onChanged: !showResult
                            ? (double newValue) {
                                setState(() {
                                  height = newValue.round();
                                });
                              }
                            : null,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'WEIGHT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        bottom: 16.0,
                      ),
                      child: CustomSlider(
                        min: 40,
                        max: 120,
                        measurementUnit: 'kg',
                        value: weight,
                        onChanged: !showResult
                            ? (double newValue) {
                                setState(() {
                                  weight = newValue.round();
                                });
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                Container(
                  height: 190.0,
                  width: double.infinity,
                  child: const CustomPaint(
                    painter: CurvePainter(color: Color(0xFFEE7583), pathNo: 3),
                  ),
                ),
                Container(
                  height: 220.0,
                  width: double.infinity,
                  child: const CustomPaint(
                    painter: CurvePainter(color: Color(0xFFF6ABB2), pathNo: 2),
                  ),
                ),
                Container(
                  height: 260.0,
                  width: double.infinity,
                  child: const CustomPaint(
                    painter: CurvePainter(color: Colors.white, pathNo: 1),
                  ),
                ),
                _buildBottomStackContent(),
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 15.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: kPrimaryColor.withOpacity(0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: RaisedButton(
                      splashColor: kPrimaryColor,
                      //highlightColor: const Color(0xFFCA4F5D),
                      color: Colors.white,
                      elevation: 0.0,
                      onPressed: () {
                        setState(() {
                          showResult = !showResult;
                        });
                      },
                      padding: const EdgeInsets.all(24.0),
                      shape: const CircleBorder(),
                      child: Icon(
                        !showResult ? Icons.trending_flat : Icons.refresh,
                        color: kPrimaryColor,
                        size: 48.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
