import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import '../../components/components.dart';

class ItemRowView extends StatelessWidget implements ListItem {
  final String name;
  final String description;
  final String? imageUrlString;

  ItemRowView(
    Key? key, {
    this.name = "",
    this.description = "",
    this.imageUrlString,
  }) : super(key: key);

  factory ItemRowView.fromItemModel(Item item) {
    return ItemRowView(
      Key(item.uuid),
      name: item.name,
      description: item.description,
      imageUrlString: item.images?.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: imageUrlString != null,
            child: Container(
              width: 100,
              height: 100,
              child: ImageUrlView(
                url: imageUrlString ?? "",
              ),
            ),
          ),
          SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
