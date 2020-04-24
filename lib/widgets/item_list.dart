import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  final String title;
  final String subTitle;
  final String value;
  final Icon icon;
  final Color color;

  const ItemList(
      {Key key, this.title, this.subTitle, this.value, this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
      child: ListTile(
        dense: true,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(subTitle),
        trailing: Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: Container(
          height: 40,
          width: 40,
          child: Center(child: icon),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient:
                  RadialGradient(colors: [color, color.withOpacity(0.5)])),
        ),
      ),
    );
  }
}
