// Copyright 2021 Amha Mogus. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';

class SafetyTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(0),
              child: Image.asset('assets/healthy.jpg'),
            ),
            Container(
              margin: EdgeInsets.all(24),
              child: Text(
                "Staying Healthy",
                style: TextStyle(fontSize: 40),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(32, 8, 32, 16),
              alignment: Alignment.center,
              child: Text(
                'If COVID-19 is spreading in your community, stay safe by taking some simple precautions, such as physical distancing, wearing a mask, keeping rooms well ventilated, avoiding crowds, cleaning your hands, and coughing into a bent elbow or tissue. Check local advice where you live and work. Do it all!',
                style: TextStyle(
                  fontSize: 16,
                  height: 2,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(32),
              child: Text(
                "What to do to keep yourself and others safe from COVID-19",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black,
              thickness: .2,
              indent: 32,
              endIndent: 32,
            ),
            Container(
              margin: EdgeInsets.all(32),
              child: Text(
                'Maintain at least a 1-metre distance between yourself and others',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black,
              thickness: .2,
              indent: 32,
              endIndent: 32,
            ),
            Container(
              margin: EdgeInsets.all(32),
              child: Text(
                'Make wearing a mask a normal part of being around other people',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
            )
          ],
        ),
      ),
    );
  }
}
