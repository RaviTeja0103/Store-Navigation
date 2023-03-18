import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Cartpage.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Map<String, double> cart = Map();
  Map<String, int> ccart = {
    'Apple': 5,
    'Guava': 10,
    'Grape': 12,
    'Cherry': 25,
    'Mango': 50,
    'Tomato': 10,
    'Brinjal': 12,
    'Onion': 25,
    'Carrot': 50,
    'Potato': 10,
    'Soap': 70,
    'Lipstick': 5,
    'Hair Oil': 10,
    'Face Cream': 12,
    'Lip Bam': 25,
    'Milk': 5,
    'Butter': 10,
    'Cheese': 12,
    'Yogurt': 25,
    'Cream': 50,
  };
  List<String> a = ["Frits", "Vegetables", "Cosmetics", "Dairy Products"];
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Image(
            image: AssetImage('img/l1.png'),
          ),
          title: Text(
            "Market",
            style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Color(0xff00ffdd),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Collection(
                  collname: "Fruits",
                  cart: cart,
                  ccart: ccart,
                  itemnames: ["Apple", "Guava", "Grape", "Cherry", "Mango"],
                  costs: [5, 10, 12, 25, 50],
                ),
                Collection(
                  collname: "Vegetables",
                  cart: cart,
                  ccart: ccart,
                  itemnames: ["Tomato", "Brinjal", "Onion", "Carrot", "Potato"],
                  costs: [10, 12, 25, 50, 10, 70],
                ),
                Collection(
                  collname: "Cosmetics",
                  cart: cart,
                  ccart: ccart,
                  itemnames: [
                    "Soap",
                    "Lipstick",
                    "Hair Oil",
                    "Face Cream",
                    "Lip Bam"
                  ],
                  costs: [5, 10, 12, 25, 50],
                ),
                Collection(
                  collname: "Dairy Products",
                  cart: cart,
                  ccart: ccart,
                  itemnames: ["Milk", "Butter", "Cheese", "Yogurt", "Cream"],
                  costs: [5, 10, 12, 25, 50],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffff0032),
          child: Icon(Icons.card_travel),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cartpage(
                  cart: cart,
                  ccart: ccart,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Collection extends StatefulWidget {
  final String collname;
  final List<String> itemnames;
  final List<int> costs;
  final Map<String, double> cart;
  final Map<String, int> ccart;
  const Collection({
    Key? key,
    required this.collname,
    required this.itemnames,
    required this.cart,
    required this.ccart,
    required this.costs,
  }) : super(key: key);

  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  @override
  List<Itemblok> items() {
    List<Itemblok> a = [];
    List<String> k = ["Apple", "Guava", "Grape", "cherry", "Mango"];
    int i;
    for (i = 0; i < widget.itemnames.length; i++) {
      if (k.contains(widget.itemnames[i])) {
        var temp = Itemblok(
          itemname: widget.itemnames[i],
          ccart: widget.ccart,
          itemnames: widget.itemnames,
          cart: widget.cart,
          cost: widget.costs[i],
          costs: widget.costs,
          a: widget.collname,
          tem: "Kg",
        );
        a.add(temp);
      } else {
        var temp = Itemblok(
          itemname: widget.itemnames[i],
          ccart: widget.ccart,
          itemnames: widget.itemnames,
          cart: widget.cart,
          cost: widget.costs[i],
          costs: widget.costs,
          a: widget.collname,
          tem: "Item",
        );
        a.add(temp);
      }
    }
    return a;
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      widget.collname,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
              ),
              /*Container(
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              )*/
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: items()),
          ),
        ],
      ),
    );
  }
}

class Itemblok extends StatefulWidget {
  final String itemname;
  final List<String> itemnames;
  final Map<String, double> cart;
  final Map<String, int> ccart;
  final int cost;
  final List<int> costs;
  final String tem;
  final String a;
  const Itemblok(
      {Key? key,
      required this.itemname,
      required this.itemnames,
      required this.cart,
      required this.tem,
      required this.ccart,
      required this.cost,
      required this.costs,
      required this.a})
      : super(key: key);

  @override
  _ItemblokState createState() => _ItemblokState();
}

class _ItemblokState extends State<Itemblok> {
  late TextEditingController controller = TextEditingController();
  @override
  int temp = 0;

  void additem(String item) {
    if (widget.cart.containsKey(item)) {
      setState(() {
        temp = temp + 1;
        widget.cart.update(item, (value) => widget.cart[item]! + 1);
      });
    } else {
      setState(() {
        //temp = 1;
        widget.cart[item] = 1;
      });
    }
  }

  void removeitem(String item) {
    if (widget.cart.containsKey(item)) {
      if (widget.cart[item]! > 0) {
        setState(() {
          //temp = temp - 1;
          widget.cart.update(item, (value) => widget.cart[item]! - 1);
        });
      }
    }
  }

  void update(String item, double amount) {
    //print(widget.cart);
    setState(() {
      widget.cart[item] = amount;
      //print(widget.cart);
    });
  }

  Widget build(BuildContext context) {
    additem(widget.itemname);
    removeitem(widget.itemname);
    return Container(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xffC780FA),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
              color: Color(0xffB3FFAE),
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 150,
            width: 200,
            child: Container(
              margin: EdgeInsets.only(left: 2, top: 20),
              child: Row(children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          widget.itemname,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Rs. " +
                              widget.cost.toString() +
                              " Per " +
                              widget.tem,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage("img/" + widget.itemname + ".png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (widget.tem == "Kg") {
                            final double? amount =
                                double.tryParse(await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Enter The amount:"),
                                          content: TextField(
                                            decoration: InputDecoration(
                                                hintText: "In KiloGrams"),
                                            controller: controller,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r"^[0-9]+\.?[0-9]*$")),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(controller.text);
                                              },
                                              child: Text(
                                                "SUBMIT",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Color(0xffff0032)),
                                              ),
                                            ),
                                          ],
                                        )));
                            //print(amount);
                            update(widget.itemname, amount!);
                            print(widget.cart);
                            //print(amount);
                          } else {
                            //print("hii");
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Select The amount:"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "SUBMIT",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xffff0032)),
                                    ),
                                  ),
                                ],
                                content: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 80, right: 80),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffB3FFAE),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      width: 100,
                                      height: 180,
                                      child: StatefulBuilder(
                                          builder: (context, state) {
                                        return Container(
                                          width: 50,
                                          height: 180,
                                          decoration: BoxDecoration(
                                            color: Color(0xffB3FFAE),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                child: IconButton(
                                                  iconSize: 30,
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    additem(widget.itemname);
                                                    print(widget.cart);
                                                    state(() {});
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffB3FFAE),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  width: 50,
                                                  height: 50,
                                                  child: Center(
                                                      child: Text(
                                                          '${widget.cart[widget.itemname]}')),
                                                ),
                                              ),
                                              Container(
                                                width: 50,
                                                height: 50,
                                                child: IconButton(
                                                  iconSize: 30,
                                                  icon: Icon(Icons.minimize),
                                                  onPressed: () {
                                                    removeitem(widget.itemname);
                                                    print(widget.cart);
                                                    state(() {});
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text("+ADD"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xffff0032)),
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
