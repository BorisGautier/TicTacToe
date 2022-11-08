// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, prefer_final_fields

import 'package:tictactoe/Helper/color.dart';
import 'package:tictactoe/Helper/constant.dart';
import 'package:tictactoe/Helper/utils.dart';
import 'package:tictactoe/functions/advertisement.dart';
import 'package:tictactoe/screens/home_screen.dart';
import 'package:tictactoe/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GameHistory extends StatefulWidget {
  @override
  GameHistoryState createState() => GameHistoryState();
}

class GameHistoryState extends State<GameHistory> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  var matchPlayed = "";
  String? selectedDropdownvalue = "All";
  List<Map?> historyData = [];
  FirebaseDatabase instance = FirebaseDatabase.instance;
  DataSnapshot? dataSnapshot;
  late String todaysDate, yesterdaysDate;
  bool sortAs = true;
  String datafound = "";
  final rows = <TableRow>[];

  @override
  void initState() {
    todaysDate = substractDate(DateTime.now());
    yesterdaysDate =
        substractDate(DateTime.now().subtract(const Duration(days: 1)));
    Advertisement.loadAd();
    getUserScore();
    super.initState();
  }

  void getUserScore() async {
    DatabaseEvent dataSnapshot = await FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("matchplayed")
        .once();

    await fetchHistory("All");

    if (mounted) {
      setState(() {
        matchPlayed = dataSnapshot.snapshot.value.toString();
      });
    }
  }

  rowsData() {
    rows.clear();
    for (int i = 0; i < historyData.length; i++) {
      rows.add(TableRow(children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              historyData[i]!["gotCoin"].toString(),
              style: TextStyle(
                  color: i % 2 == 0 ? primaryColor : secondarySelectedColor),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              historyData[i]!["playedStatus"].toString(),
              style: TextStyle(
                  color: i % 2 == 0 ? primaryColor : secondarySelectedColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  substractDate(DateTime.parse(historyData[i]!["playedDate"])),
                  style: TextStyle(
                      color:
                          i % 2 == 0 ? primaryColor : secondarySelectedColor),
                  textAlign: TextAlign.center,
                ),
                Text(
                  substractTime(DateTime.parse(historyData[i]!["playedDate"])),
                  style: TextStyle(
                      color:
                          i % 2 == 0 ? primaryColor : secondarySelectedColor),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ]));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //Advertisement.showAd();
        music.play(click);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              music.play(click);
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/historyWhite_icon.png"),
              Text(
                " ${utils.getTranslated(context, "history")}",
              )
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          matchPlayed,
                          style: const TextStyle(color: white),
                        ),
                        Text(
                          utils.getTranslated(context, "matchPlayed"),
                          style: const TextStyle(color: white),
                        ),
                      ],
                    ),
                    const Expanded(child: Coin()),
                    DropdownButton(
                      iconEnabledColor: white,
                      underline: Container(),
                      dropdownColor: secondaryColor,
                      style: const TextStyle(color: white),
                      value: selectedDropdownvalue,
                      items: ['All', 'Today', 'Yesterday']
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onTap: () {
                        music.play(click);
                      },
                      onChanged: (String? selectedValue) async {
                        music.play(click);
                        historyData.clear();

                        await fetchHistory(selectedValue);
                        setState(() {
                          selectedDropdownvalue = selectedValue;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Text(
                        utils.getTranslated(context, "transaction"),
                        style: const TextStyle(
                          color: white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          utils.getTranslated(context, "status"),
                          style: const TextStyle(
                            color: white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              utils.getTranslated(context, "dateTime"),
                              style: const TextStyle(
                                color: white,
                              ),
                            ),
                            sortAs == true
                                ? const Icon(
                                    Icons.arrow_drop_down,
                                    color: white,
                                  )
                                : const Icon(Icons.arrow_drop_up, color: white)
                          ],
                        ),
                        onTap: () {
                          music.play(click);
                          setState(() {
                            sortAs = !sortAs;
                          });
                          if (sortAs) {
                            historyData.sort((a, b) {
                              var adate = a!['playedDate'];
                              var bdate = b!['playedDate'];
                              return adate.compareTo(bdate);
                            });
                            rowsData();
                          } else {
                            historyData.sort((a, b) {
                              var adate = a!['playedDate'];
                              var bdate = b!['playedDate'];
                              return bdate.compareTo(adate);
                            });
                            rowsData();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                  //height: MediaQuery.of(context).size.height * 0.7,
                  child: historyData.isEmpty
                      ? datafound == ""
                          ? const Center(child: CircularProgressIndicator())
                          : Center(
                              child: Text(
                              utils.getTranslated(context, "noHistoryFound"),
                              style: const TextStyle(color: primaryColor),
                            ))
                      : ListView(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Table(
                                border: TableBorder.symmetric(
                                    inside: const BorderSide(
                                  color: primaryColor,
                                  width: 0.3,
                                )),
                                children: rows,
                              ),
                            )
                          ],
                        )),
            )
          ],
        ),
      ),
    );
  }

  Future fetchHistory(String? filter) async {
    FirebaseDatabase db = FirebaseDatabase.instance;
    DatabaseEvent databaseEvent = await db
        .ref()
        .child("gameHistory")
        .child(_auth.currentUser!.uid)
        .child("played")
        .orderByChild("playedDate")
        .once();

    if (databaseEvent.snapshot.value != null) {
      Map? map = databaseEvent.snapshot.value as Map;
      for (var element in map.keys) {
        String date = substractDate(DateTime.parse(map[element]["playedDate"]));

        if (filter == "All") {
          historyData.add(map[element]);
        } else if (filter == "Today") {
          // 0 means both dates are same
          if (todaysDate.compareTo(date) == 0) {
            historyData.add(map[element]);
          }
        } else {
          //yesterdays data
          if (yesterdaysDate.compareTo(date) == 0) {
            historyData.add(map[element]);
          }
        }
      }

      historyData.sort((a, b) {
        var adate = a!['playedDate'];
        var bdate = b!['playedDate'];

        return adate.compareTo(bdate);
      });
      if (historyData.isEmpty) {
        datafound = "No";
      }
      rowsData();
    } else {
      datafound = "No";
    }
    setState(() {});
  }

  String substractDate(date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String substractTime(date) {
    return DateFormat('kk:mm:EEEE').format(date);
  }
}
