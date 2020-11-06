import 'package:flutter/material.dart';

Widget sectionTitle(String title) {
  return Container(
    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
    child: Text(
      "$title",
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF8B7CFF)),
    ),
  );
}

Widget bigNumber(
    BuildContext context, String label, String value, bool showBox) {
  return Container(
    height: 100,
    width: MediaQuery.of(context).size.width - 40,
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: showBox ? Color(0xFF8B7CFF) : Colors.transparent,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$label',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900)),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.w300),
        )
      ],
    ),
  );
}
