import 'package:covid19_app/model/watchlistModel.dart';
import 'package:covid19_app/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'country_detail.dart';
import 'search.dart';

class Watchlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 400) {
          // build desktop view
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black87),
              title: Text(
                "Covid-19 Watchlist",
                style: TextStyle(color: Colors.black87),
              ),
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(context: context, delegate: Delegate());
                    }),
                IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    Provider.of<WatchlistModel>(context, listen: false)
                        .clearWatchlist();
                  },
                )
              ],
            ),
            body: _buildWeb(context),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                showSearch(context: context, delegate: Delegate());
              },
              label: Text('Add Countries'),
              icon: Icon(Icons.search),
              backgroundColor: Colors.black87,
            ),
          );
        } else {
          // screen size less than 400, return mobile view
          return _buildMobile(context);
        }
      },
    );
  }

  Widget _buildWeb(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.lightBlue[50],
              child: _buildWebList(context),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: _buildEmptyWatchlistScreen(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          'Covid-19 Watchlist',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: Delegate());
              }),
          IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: () {
              Provider.of<WatchlistModel>(context, listen: false)
                  .clearWatchlist();
            },
          )
        ],
      ),
      body: Consumer<WatchlistModel>(
        builder: (context, watchlist, child) => (watchlist.items.length == 0)
            ? _buildEmptyWatchlistScreen(context)
            : ListView.builder(
                itemCount: watchlist.items.length,
                itemExtent: 90,
                itemBuilder: (context, index) => ListTile(
                      title: Text(watchlist.items[index].name),
                      subtitle:
                          Text(watchlist.items[index].population.toString()),
                      leading: watchlist.items[index].hasFlag
                          ? Image.asset(
                              "assets/" + watchlist.items[index].name + ".png",
                              width: 48,
                            )
                          : Image.asset(
                              'assets/Default.png',
                              width: 48,
                            ),
                      trailing: Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: 80,
                          height: 100,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 50,
                                  child: Text(
                                    "+12%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CountryDetail(watchlist.items[index])));
                      },
                    )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showSearch(context: context, delegate: Delegate());
        },
        label: Text('Add Countries'),
        icon: Icon(Icons.search),
        backgroundColor: Colors.black87,
      ),
    );
  }

  _buildEmptyWatchlistScreen(BuildContext context) {
    return Column(
      //padding: EdgeInsets.fromLTRB(0, 64, 0, 0),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/search.png',
          width: 200,
          height: 200,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            margin: EdgeInsets.all(0),
            alignment: Alignment.center,
            child: Text(
              "Build your watchlist",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
            )),
      ],
    );
  }

  _buildWebList(BuildContext context) {
    //List savedCountries = Provider.of<WatchlistModel>(context).items.toList();
    return Text("We got nothing");
  }
}
