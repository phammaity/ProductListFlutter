import 'package:flutter/material.dart';

abstract class ListItem {}

class ActionItem extends StatelessWidget implements ListItem {
  final String name;
  final VoidCallback onTap;
  ActionItem({required this.name, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        color: Colors.grey,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
      onTap: this.onTap,
    );
  }
}

class SectionItem extends StatelessWidget implements ListItem {
  final String sectionName;

  SectionItem(this.sectionName);

  @override
  Widget build(BuildContext context) {
    return Text(
      sectionName,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
