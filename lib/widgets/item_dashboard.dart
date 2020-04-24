import 'package:flutter/material.dart';

class ItemDashboard extends StatelessWidget {
  final IconData iconData;
  final String textItem;
  final Color colorItem;
  final VoidCallback callback;

  ItemDashboard({this.iconData, this.textItem, this.colorItem, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 150,
        height: 150,
        color: colorItem == null ? Colors.blue : colorItem,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, size: 60),
            Text(
              textItem,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  decoration: TextDecoration.none),
            )
          ],
        ),
      ),
      onTap: callback,
    );
  }
}
