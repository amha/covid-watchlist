import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19_app/model/covid_statistic.dart';
import 'package:flutter/material.dart';

class GlobalSnapshot extends StatefulWidget {
  List<CovidStatistic> globalData = [];

  GlobalSnapshot(this.globalData);

  @override
  _GlobalSnapshopState createState() {
    return _GlobalSnapshopState();
  }
}

class _GlobalSnapshopState extends State<GlobalSnapshot> {
  List<CovidStatistic> data = [];

  @override
  void initState() {
    super.initState();
    data = widget.globalData;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
          height: 120,
          width: double.infinity,
          child: Center(
            child: Column(
              children: [
                Text(
                  "Global Covid-19 infections",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  data[0].value.toString(),
                  style: TextStyle(fontSize: 48),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 270,
          width: double.infinity,
          child: DoughtnutPie.withSampleData(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Colors.blue[50],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.10),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 10,
                        height: 10,
                        child: CustomPaint(
                          painter: DrawCircle(Colors.green),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Infected"), Text(data[4].value)],
                  )
                ],
              ),
            ),
            Container(
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Colors.blue[50],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.10),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 10,
                        height: 10,
                        child: CustomPaint(
                          painter: DrawCircle(Colors.amber[400]),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Recovered"), Text(data[1].value)],
                  )
                ],
              ),
            ),
            Container(
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Colors.blue[50],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.10),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 10,
                        height: 10,
                        child: CustomPaint(
                          painter: DrawCircle(Colors.red[400]),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Deaths",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(data[2].value)
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}

class DoughtnutHoles {
  final int index;
  final int value;

  DoughtnutHoles(this.index, this.value);
}

class DoughtnutPie extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DoughtnutPie(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DoughtnutPie.withSampleData() {
    return new DoughtnutPie(
      _dataTransformation(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(seriesList,
        animate: animate,

        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(arcWidth: 16));
  }

  static List<charts.Series<DoughtnutHoles, int>> _dataTransformation() {
    final data = [
      DoughtnutHoles(0, 80),
      DoughtnutHoles(1, 20),
      DoughtnutHoles(2, 10),
    ];
    return [
      new charts.Series<DoughtnutHoles, int>(
          id: 'Sales',
          domainFn: (DoughtnutHoles sales, _) => sales.index,
          measureFn: (DoughtnutHoles sales, _) => sales.value,
          data: data,
          colorFn: (DoughtnutHoles sales, _) {
            switch (sales.index) {
              case 0:
                return charts.Color.fromHex(code: '#3ECB45');
              case 1:
                return charts.Color.fromHex(code: '#F5E93A');
              case 2:
                return charts.Color.fromHex(code: '#E25B5B');
              default:
                return charts.Color.fromHex(code: '#4B4FFF');
            }
          })
    ];
  }
}

class DrawCircle extends CustomPainter {
  Paint _paint;

  DrawCircle(Color color) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 0.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 10.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
