import 'package:flutter/material.dart';

class SafetyTips extends StatelessWidget {
  List<String> categories = [
    "coffee",
    "nurse",
    "government",
    "families",
    "warehouse"
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 8,
          crossAxisSpacing: 6,
          crossAxisCount: 2,
          childAspectRatio: 1),
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            children: [
              Container(
                width: 200,
                height: 200,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Image.asset(
                  'assets/categories/' + categories[index] + '.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                width: 200,
                height: 190,
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomLeft,
                child: Text(
                  categories[index],
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black54,
                          offset: Offset(1.0, 2.0),
                        ),
                      ]),
                ),
              )
            ],
          ),
        );
      },
      itemCount: categories.length,
    );
  }
}
