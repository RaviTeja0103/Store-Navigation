import 'package:flutter/material.dart';
import 'out.dart';

class Cartpage extends StatefulWidget {
  final Map<String, double> cart;
  final Map<String, int> ccart;

  const Cartpage({Key? key, required this.cart, required this.ccart})
      : super(key: key);

  @override
  _CartpageState createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  final List<String> flist = [];
  void clear() {
    for (String key in widget.cart.keys) {
      setState(() {
        widget.cart[key] = 0;
      });
    }
  }

  num total() {
    num sum = 0;
    for (String key in widget.cart.keys) {
      sum += (widget.cart[key]! * widget.ccart[key]!);
    }
    setState(() {
      sum = sum;
    });
    return sum;
  }

  List<finalblock> items() {
    List<finalblock> a = [];
    for (String key in widget.cart.keys) {
      if (widget.cart[key] != 0) {
        var temp = finalblock(
          cart: widget.cart,
          name: key,
          n: widget.cart[key]!,
          cost: widget.ccart[key],
        );
        a.add(temp);
      }
    }

    return a;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Color(0xff00ffdd),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Text(
                  "Cart",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Column(
                  children: items(),
                ),
                Container(
                  child: Center(
                    child: Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Expanded(
                                child: Text(
                                  "Total :", //sum.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Expanded(
                                child: Text(
                                  "Rs." +
                                      total()
                                          .toStringAsFixed(2), //sum.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FloatingActionButton.extended(
                  backgroundColor: Color(0xffff0032),
                  label: Text(
                    "Check Out", //sum.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    for (String key in widget.cart.keys) {
                      if (widget.cart[key] != 0) {
                        flist.add(key);
                      }
                    }
                    print(flist);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => out(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffff0032),
        child: Icon(Icons.layers_clear),
        onPressed: () {
          clear();
        },
      ),
    );
  }
}

class finalblock extends StatefulWidget {
  final String name;
  final double n;
  final Map<String, double> cart;
  final cost;
  const finalblock(
      {Key? key,
      required this.name,
      required this.cart,
      required this.n,
      required this.cost})
      : super(key: key);

  @override
  _finalblockState createState() => _finalblockState();
}

class _finalblockState extends State<finalblock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 100,
                  child: Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage("img/" + widget.name + ".png"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  widget.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2.0),
                                              child: Text(
                                                "Rs. " +
                                                    widget.cost.toString() +
                                                    " X " +
                                                    widget.n
                                                        .toStringAsFixed(2) +
                                                    " = ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: Text(
                                            (widget.cost * widget.n)
                                                .toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
