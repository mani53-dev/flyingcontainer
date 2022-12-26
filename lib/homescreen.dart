import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var _yOffset = 10.0;
var _xOffset = 10.0;
var _blurAmount = 10.0;

var _red = 10;
var _green = 10;
var _blue = 10;

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello jee"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          slider(_yOffset, "Y Offset",
              min: 1.0,
              max: 40.0,
              callback: (yOffset) => setState(() {
                    _yOffset = yOffset;
                  })),
          slider(_xOffset, "X Offset",
              min: 1.0,
              max: 40.0,
              callback: (xOffset) => setState(() {
                    _xOffset = xOffset;
                  })),
          slider(_blurAmount, "Blur Amount",
              min: 1.0,
              max: 50.0,
              callback: (blurAmount) => setState(() {
                    _blurAmount = blurAmount;
                  })),
          slider(_red.toDouble(), "Red",
              min: 1.0,
              max: 255.0,
              callback: (red) => setState(() {
                    _red = red.toInt();
                  })),
          slider(_green.toDouble(), "Green",
              min: 1.0,
              max: 255.0,
              callback: (green) => setState(() {
                    _green = green.toInt();
                  })),
          slider(_blue.toDouble(), "Blue",
              min: 1.0,
              max: 255.0,
              callback: (blue) => setState(() {
                    _blue = blue.toInt();
                  })),
          FlyingContainer(
            size,
            _blurAmount,
            _xOffset,
            _yOffset,
            red: _red,
            blue: _blue,
            green: _green,
          )
        ],
      ),
    );
  }
}

class FlyingContainer extends StatelessWidget {
  FlyingContainer(this.size, this.blurAmount, this.xOffset, this.yOffset,
      {Key? key, this.red, this.green, this.blue})
      : super(key: key);
  var size, blurAmount, xOffset, yOffset, red, green, blue;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: Container(
        margin: EdgeInsets.all(50),
        height: size.height * 0.1,
        width: size.width * 0.6,
        decoration: BoxDecoration(
            color: Color.fromRGBO(red, green, blue, 1),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),

            boxShadow: [
              BoxShadow(
                blurRadius: blurAmount,
                color: Color.fromRGBO(red, green, blue, 1),
                offset: Offset(xOffset, yOffset),
              ),
            ]),
      ),
    );
  }
}

class slider extends StatefulWidget {
  double value;
  String heading;
  var callback;
  var min, max;
  slider(this.value, this.heading, {this.callback, this.min, this.max});

  @override
  State<slider> createState() => _sliderState();
}

class _sliderState extends State<slider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.heading,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                "${widget.value.round()}/${widget.max.round()}",
                style: const TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 30,
          child: Slider(
              min: widget.min,
              max: widget.max,
              value: widget.value,
              onChanged: (val) {
                setState(() {
                  widget.value = val;
                  widget.callback(val);
                });
              }),
        ),
      ],
    );
  }
}
