import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class MyHomePage extends GetxController {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

class MyHomePage extends StatelessWidget {
  var yOffset = 10.0.obs;
  var xOffset = 10.0.obs;
  var blurAmount = 10.0.obs;
  var layerCount = 10.0.obs;
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
          Obx(() => Column(
            children: [
              slider(yOffset.value, "Y Offset"),
              slider(xOffset.value, "X Offset"),
              slider(blurAmount.value, "Blur Amount"),
              slider(layerCount.value, "Layer Count"),
              FlyingContainer(size, blurAmount.value, xOffset.value, yOffset.value)
            ],
          ))

        ],
      ),
    );
  }
}

class FlyingContainer extends StatefulWidget {
  FlyingContainer(this.size, this.blurAmount, this.xOffset, this.yOffset, {Key? key}) : super(key: key);
  var size, blurAmount, xOffset, yOffset;

  @override
  State<FlyingContainer> createState() => _FlyingContainerState();
}

class _FlyingContainerState extends State<FlyingContainer> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: Container(
        margin: EdgeInsets.all(20),
        height: widget.size.height * 0.1,
        width: widget.size.width * 0.6,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            boxShadow: [
              BoxShadow(
                blurRadius: widget.blurAmount,
                color: Colors.blue,
                offset: Offset(widget.xOffset, widget.yOffset),
              ),
            ]),
      ),
    );
  }
}


class slider extends StatefulWidget {
  double value;
  String heading;
  slider(this.value, this.heading);

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
                "${widget.value.round()}/100",
                style: const TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 30,
          child: Slider(
              min: 1.0,
              max: 100.0,
              value: widget.value,
              onChanged: (val) {
                setState(() {
                  widget.value = val;
                });
              }),
        ),
      ],
    );
  }
}
