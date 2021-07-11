import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:we4you/utils/colors.dart';
import 'package:we4you/utils/styles.dart';

class ItemWidget extends StatefulWidget {
  final String productName;

  final String price;
  final Uint8List bytes;
  final void Function() onPressedAdd;
  final void Function() onPressedRemove;

  ItemWidget(
      {Key key,
      this.productName,
      this.price,
      this.bytes,
      this.onPressedAdd,
      this.onPressedRemove})
      : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  int _itemCount = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: NeumorphicButton(
          style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25)),
          ),
          padding: const EdgeInsets.all(7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.memory(
                widget.bytes,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.topLeft,
                child: Text(widget.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: ktButton),
              ),
              SizedBox(height: 4),
              Align(
                alignment: Alignment.topLeft,
                child: Text('₹ ' + (widget.price.toString()), style: ktBody1),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 90,
                        padding: EdgeInsets.all(3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            NeumorphicButton(
                                margin: EdgeInsets.only(top: 12),
                                onPressed: () {
                                  widget.onPressedRemove();
                                  setState(() => _itemCount != 0
                                      ? _itemCount--
                                      : _itemCount = 0);
                                },
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.convex,
                                  boxShape: NeumorphicBoxShape.circle(),
                                ),
                                padding: const EdgeInsets.all(7.0),
                                child: Icon(
                                  Icons.remove,
                                  color: kcText,
                                  size: 16,
                                )),
                            Padding(
                              padding: EdgeInsets.fromLTRB(4, 10, 4, 0),
                              child: Text(
                                _itemCount.toString(),
                                style: ktBodysmall,
                              ),
                            ),
                            NeumorphicButton(
                                margin: EdgeInsets.only(top: 12),
                                onPressed: () {
                                  widget.onPressedAdd();
                                  setState(() => _itemCount++);
                                },
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.convex,
                                  boxShape: NeumorphicBoxShape.circle(),
                                ),
                                padding: const EdgeInsets.all(7.0),
                                child: Icon(
                                  Icons.add,
                                  color: kcText,
                                  size: 16,
                                )),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
