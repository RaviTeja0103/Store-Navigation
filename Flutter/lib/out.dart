import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class out extends StatefulWidget {
  @override
  _outState createState() => _outState();
}

class _outState extends State<out> {
  final List<String> l = [
    'Apple',
    'Guava',
    'Grape',
    'Cherry',
    'Mango',
    'Grape',
    'Cherry',
    'Mango',
    'Tomato',
    'Tomato',
  ];
  @override
  List<blockb> pout(List<String> a) {
    List<blockb> b = [];
    for (int i = 0; i < a.length; i++) {
      var temp = blockb(name: a[i]);
      b.add(temp);
    }
    return b;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Out",
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
                Container(
                  child: Image(
                    image: AssetImage("img/l11.png"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {},
                ),
                Container(
                  child: Column(children: pout(l)),
                ),
                Container(
                  child: FloatingActionButton.extended(
                    backgroundColor: Color(0xffCD0404),
                    label: Text(
                      "Download", //sum.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      final url =
                          "https://static.toiimg.com/thumb/msid-82136471,width-1280,height-720,resizemode-4/.jpg";
                      var response = await Dio().get(url,
                          options: Options(responseType: ResponseType.bytes));
                      final result = await ImageGallerySaver.saveImage(
                          Uint8List.fromList(response.data),
                          quality: 68,
                          name: "hii");
                      print(result);

                      final path = 'C:/Users/Ravi teja/Downloads/myfile.jpg';

                      await Dio().download(url, path);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class blockb extends StatelessWidget {
  final String name;
  const blockb({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IconButton(
            icon: Icon(Icons.south),
            onPressed: () {},
          ),
          Container(
            child: Text(name),
          )
        ],
      ),
    );
  }
}
