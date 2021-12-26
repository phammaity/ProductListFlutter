import 'package:api_repository/models/item.dart';
import 'package:flutter/material.dart';
import 'package:products_flutter/components/image_view.dart';

class ItemRowView extends StatelessWidget {
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
      child: Column(
        children: [
          Visibility(
            visible: imageUrlString != null,
            child: ImageUrlView(
              url: imageUrlString ?? "",
            ),
          ),
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
    );
  }
}
