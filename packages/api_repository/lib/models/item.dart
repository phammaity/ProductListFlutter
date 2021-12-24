import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String uuid;
  final String name;
  Item(this.uuid, {this.name = ""});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item("uuid", name: "Ty");
  }

  @override
  List<Object?> get props => [uuid];
}

class AllItems extends Equatable {
  final List<Item> items;
  AllItems(this.items);

  factory AllItems.fromJson(Map<String, dynamic> json) {
    final _list = <Item>[];
    if (json.containsKey("data") && json["data"] is List) {
      (json["data"] as List).forEach((element) {
        _list.add(Item.fromJson(element));
      });
    }
    return AllItems(_list);
  }

  @override
  List<Object?> get props => [items];
}
