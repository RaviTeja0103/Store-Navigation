import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Cartpage.dart';

class itempage extends StatefulWidget {
  final Map<String, double> cart;
  final Map<String, int> ccart;
  final String a;
  final List<String> itemnames;
  final List<int> costs;
  const itempage(
      {Key? key,
      required this.cart,
      required this.ccart,
      required this.a,
      required this.costs,
      required this.itemnames})
      : super(key: key);

  @override
  _itempageState createState() => _itempageState();
}

class _itempageState extends State<itempage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Items",
          style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Color(0xff00ffdd),
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  widget.a,
                  style: TextStyle(fontSize: 40, color: Colors.black),
                ),
                Center(
                  child: Container(
                    child: ItemCollection(
                      cart: widget.cart,
                      collname: widget.a[0],
                      itemnames: widget.itemnames,
                      costs: widget.costs,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffCD0404),
        child: Icon(Icons.card_travel),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cartpage(
                cart: widget.cart,
                ccart: widget.ccart,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemCollection extends StatefulWidget {
  final String collname;
  final List<String> itemnames;
  final Map<String, double> cart;
  final List<int> costs;

  const ItemCollection(
      {Key? key,
      required this.collname,
      required this.itemnames,
      required this.cart,
      required this.costs})
      : super(key: key);

  @override
  _ItemCollectionState createState() => _ItemCollectionState();
}

class _ItemCollectionState extends State<ItemCollection> {
  @override
  List<Itemadder> items() {
    List<Itemadder> a = [];
    List<String> k = ["Apple", "Gova", "Grape", "cherry", "Mango"];
    int i;
    for (i = 0; i < widget.itemnames.length; i++) {
      if (k.contains(widget.itemnames[i])) {
        var temp = Itemadder(
          itemname: widget.itemnames[i],
          cart: widget.cart,
          cost: widget.costs[i],
          tem: "Kg",
        );
        a.add(temp);
      } else {
        var temp = Itemadder(
          itemname: widget.itemnames[i],
          cart: widget.cart,
          cost: widget.costs[i],
          tem: "Item",
        );
        a.add(temp);
      }
    }
    return a;
  }

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: items()),
        ),
      ),
    );
  }
}

class Itemadder extends StatefulWidget {
  final String itemname;
  final Map<String, double> cart;
  final int cost;
  final String tem;

  const Itemadder(
      {Key? key,
      required this.itemname,
      required this.cost,
      required this.tem,
      required this.cart})
      : super(key: key);

  @override
  _ItemadderState createState() => _ItemadderState();
}

class _ItemadderState extends State<Itemadder> {
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage("img/Apple.png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          //print("hii");
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Select The amount:"),
                              content: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 80, right: 80),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffB3FFAE),
                                      borderRadius: BorderRadius.circular(10.0),
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
