import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String uuid;
  final String name;
  final String description;
  final int rank;
  final String status;
  final bool justDropped;
  final List<String>? images;
  final bool isDeleted;
  final String seo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Item(
    this.uuid, {
    this.name = "",
    this.seo = "",
    this.description = "",
    this.rank = 0,
    this.status = "",
    this.justDropped = false,
    this.images,
    this.isDeleted = false,
    this.createdAt,
    this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    final _uuid = json["uuid"];
    final _seo = json["seo"];
    final _name = json["name"];
    final _description = json["description"];
    final _rank = json["rank"];
    final _status = json["status"];
    final _images = <String>[];

    if (json.containsKey("imageUrls") && json["imageUrls"] is List) {
      (json["imageUrls"] as List).forEach((element) {
        _images.add(element);
      });
    }
    final _isDeleted = json["isDeleted"];
    final _justDropped = json["justDropped"];
    final _updatedAt =
        json["updatedAt"] != null ? DateTime.tryParse(json["updatedAt"]) : null;

    final _createdAt =
        json["createdAt"] != null ? DateTime.tryParse(json["createdAt"]) : null;

    return Item(
      _uuid,
      name: _name,
      seo: _seo,
      description: _description,
      rank: _rank,
      status: _status,
      images: _images,
      isDeleted: _isDeleted,
      justDropped: _justDropped,
      createdAt: _createdAt,
      updatedAt: _updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        uuid,
        name,
        status,
        images,
        isDeleted,
        justDropped,
        rank,
      ];
}

class AllItems extends Equatable {
  final List<Item> items;
  final Pagination pagination;
  AllItems(this.items, this.pagination);

  factory AllItems.fromJson(Map<String, dynamic> json) {
    final _list = <Item>[];
    if (json.containsKey("data") && json["data"] is List) {
      (json["data"] as List).forEach((element) {
        _list.add(Item.fromJson(element));
      });
    }

    final _paging = Pagination.fromJson(json["pagination"]);
    return AllItems(
      _list,
      _paging,
    );
  }

  @override
  List<Object?> get props => [items];
}

class Pagination extends Equatable {
  final int page;
  final int pageSize;
  final int totalCount;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.totalCount,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    final _page = json["page"] ?? 0;
    final _pageSize = json["pageSize"] ?? 0;
    final _totalCount = json["totalCount"] ?? 0;
    return Pagination(
      page: _page,
      pageSize: _pageSize,
      totalCount: _totalCount,
    );
  }

  @override
  List<Object?> get props => [page, pageSize, totalCount];
}
