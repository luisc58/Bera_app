
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Item.dart';

class GridItem extends StatefulWidget {
  final Key key;
  final Item item;
  final ValueChanged<bool> isSelected;

  const GridItem({this.key, this.item, this.isSelected}) : super(key: key);
  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isSelected = !isSelected;
        widget.isSelected(isSelected);
      },
      child: Stack(
        children: <Widget>[
          Container(
            height: 150.0,
            width: 150.0,
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : null,
              border: Border.all(
                color: Colors.black45,
                width: 1
              ),
              borderRadius:
                BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: Text(
                  widget.item.title,
                  style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                textAlign: TextAlign.center
              ),
            ),
          ),
        ],
      ),

    );
  }
}