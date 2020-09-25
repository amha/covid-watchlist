import 'package:covid19_app/Model/watchlistModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Search.dart';

class Watchlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          'Covid 19 Watchlist',
          style: TextStyle(color: Colors.black87),
        ),
        bottomOpacity: 0.0,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: () {
              Provider.of<WatchlistModel>(context,listen: true).items.clear();
            },
          )
        ],
      ),
      body: Consumer<WatchlistModel>(
        builder: (context, watchlist, child) => (watchlist.items.length == 0)
            ? Container(
                width: 200,
                height: 200,
                alignment: Alignment.center,
                child: Text(
                  "Empty List",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                ))
            : ListView.builder(
                itemCount: watchlist.items.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(watchlist.items[index].name),
                      subtitle:
                          Text(watchlist.items[index].population.toString()),
                      leading: watchlist.items[index].hasFlag
                          ? Image.asset(
                              "assets/" + watchlist.items[index].name + ".png",
                              width: 48,
                            )
                          : Image.asset('assets/Default.png'),
                    )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Search()));
        },
        label: Text('Add Countries'),
        icon: Icon(Icons.search),
        backgroundColor: Colors.black87,
      ),
    );
  }

// Widget _buildRow(Country country, BuildContext context) {
//   return GestureDetector(
//     onTap: () {
//       Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => CountryDetail(country)));
//     },
//     child: Container(
//       height: 90,
//       width: 300,
//       child: Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               padding: EdgeInsets.all(8),
//               width: 60,
//               height: 60,
//               child: Image.asset(
//                 "assets/" + country.name + ".png",
//                 width: 48,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Container(
//               padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     country.population.toString() + " Infections",
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//                     textAlign: TextAlign.left,
//                   ),
//                   Text("485784 Number of deaths")
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Container(
//               padding: EdgeInsets.all(8),
//               width: 80,
//               height: 100,
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 25,
//                       child: Text(
//                         "+1,593",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w800),
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.all(Radius.circular(8))),
//                       alignment: Alignment.center,
//                       height: 25,
//                       width: 50,
//                       child: Text(
//                         "+12%",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w900),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }
}
