import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(new MaterialApp(home: new MyApp()));
}

Future navigateToSubPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MySubPage()));
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  // ignore: deprecated_member_use
  return double.parse(s, (e) => null) != null;
}

final myController1 = TextEditingController();
final myController2 = TextEditingController();
final myController3 = TextEditingController();
List<String> itemdesc = [];
List<String> itemcost = [];
var charges = 0;
double counter = 0;
double goal = 0;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
  MyApp({Key key}) : super(key: key);
}

class MySubPage extends StatefulWidget {
  @override
  _MySubPageState createState() => _MySubPageState();
}

//class MySubPage extends StatefulWidget {
//@override
//_MySubPageState createState() => _MySubPageState();
//}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text(r"Your Cash Saving Wizard",
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        )),
        backgroundColor: Colors.green[500],
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15,15,15,5),
            child: Text(r"CashWiz",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 55,
              color: Colors.black38,
              fontWeight: FontWeight.bold,
            )),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text("Spending Goal",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ))
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(5.0,5.0,5.0,20.0),
              child: Text(
                (r"$" + goal.toStringAsFixed(2)).toString(),
                style: TextStyle(fontSize: 40),
              )),
          Padding(padding: EdgeInsets.fromLTRB(15.0,15,15, 5), child: Text("Total Spent",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.red[500],
          ))),
          Padding(
              padding: EdgeInsets.fromLTRB(5.0,5.0,5.0,20.0),
              child: Text(
                (r"$" + counter.toStringAsFixed(2)).toString(),
                style: TextStyle(fontSize: 50),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15,15, 10),
            child: RaisedButton(
              color: Colors.green[300],
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.blue[50],
                        content: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: myController2,
                                      decoration: InputDecoration(
                                        hintText: "Enter Cost",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      autocorrect: false,
                                      autofocus: true,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: myController1,
                                      decoration: InputDecoration(
                                        hintText: "Enter Description",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      autocorrect: false,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      color: Colors.greenAccent[100],
                                      child: Text("Add Charge"),
                                      onPressed: () {
                                        bool check =
                                            isNumeric(myController2.text);
                                        if (!check) {
                                          return showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    content: Text(
                                                      'Invalid entry of cost. Please enter ' +
                                                          'a numerical value.',
                                                    ),
                                                    actions: [
                                                      RaisedButton(
                                                          child: Text("OK"),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }),
                                                    ]);
                                              });
                                        }
                                        return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text(
                                                r"A charge of $" +
                                                    myController2.text +
                                                    " has been added to your charge history under " +
                                                    myController1.text +
                                                    ".",
                                              ),
                                              actions: [
                                                RaisedButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      var cost = double.parse(
                                                        myController2.text,
                                                      );
                                                      setState(() {
                                                        counter =
                                                            counter + cost;
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                      itemdesc.insert(0,
                                                          myController1.text);
                                                      itemcost.insert(0,
                                                          myController2.text);
                                                      myController1.clear();
                                                      myController2.clear();
                                                      charges++;
                                                    })
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        color: Colors.pinkAccent[100],
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Text("New Charge"),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(15.0,10,15,10),
              child: RaisedButton(
                child: Text('View Charges'),
                color: Colors.green[300],
                onPressed: () {
                  navigateToSubPage(context);
                },
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(15,10,15,10),
            child: RaisedButton(
              child: Text('Set Goal'),
              color: Colors.green[300],
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Stack(
                        overflow: Overflow.visible,
                        children: <Widget> [
                          Form(
                        key: _formKey,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                        Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: myController3,
                          decoration: InputDecoration(
                            hintText: "Enter Spending Goal",
                            hintStyle:
                            TextStyle(color: Colors.grey),
                          ),
                          autocorrect: false,
                          autofocus: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: Colors.greenAccent[100],
                          child: Text("Set Goal"),
                          onPressed: () {
                            bool check =
                            isNumeric(myController3.text);
                            if (!check) {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        content: Text(
                                          'Invalid entry of cost. Please enter ' +
                                              'a numerical value.',
                                        ),
                                        actions: [
                                          RaisedButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                Navigator.of(
                                                    context)
                                                    .pop();
                                              }),
                                        ]);
                                  });
                            }
                            return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(
                                    r"$" +
                                        myController3.text +
                                        " has been set as your goal.",
                                  ),
                                  actions: [
                                    RaisedButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          setState(() {
                                            goal = double.parse(myController3.text,);
                    }

                                          );

                                          Navigator.of(context)
                                              .pop();
                                          Navigator.of(context)
                                              .pop();

                                          myController3.clear();

                                        })
                                  ],
                                );
                              },
                            );
                          },
                        ),


                          ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    color: Colors.pinkAccent[100],
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                              )
                        ]
                      )
                    ),
                    ]));
                  }
                );
              }
            )
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(15,10,15,10),
              child: RaisedButton(
                  child: Text('Clear'),
                  onPressed: () {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              content: Text(
                                  "Would you like to clear data to start a new budgeting cycle?"),
                              actions: [
                                RaisedButton(
                                    child: Text("Yes"),
                                    color: Colors.red[300],
                                    onPressed: () {
                                      setState(() {
                                        counter = 0;
                                        itemcost = [];
                                        itemdesc = [];
                                      });
                                      Navigator.of(context).pop();
                                    }),
                                RaisedButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ]);
                        });
                  }))
        ],
      )),
    );
  }
}

class _MySubPageState extends State<MySubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Past Charges'),
        backgroundColor: Colors.green[400],
      ),
      body: Center(
        child: ListView(children: <Widget>[
          SingleChildScrollView(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: itemcost.length,
                itemBuilder: (context, index) {
                  final item = itemcost[index];
                  return Dismissible(
                    background: Container(color: Colors.red),
                    key: Key(item),
                    onDismissed: (direction) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(r"$" +
                              itemcost[index] +
                              ' charge ' +
                              "under " +
                              itemdesc[index] +
                              " deleted.")));
                      setState(() {
                        counter = counter - double.parse(itemcost[index]);
                        itemdesc.removeAt(index);
                        itemcost.removeAt(index);
                      });
                    },
                    child: ListTile(
                      title: Text(itemdesc[index]),
                      subtitle: Text(r"$" + itemcost[index]),
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
