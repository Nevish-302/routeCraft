class DiscoverModel {
  List<Items>? items;

  DiscoverModel({this.items});

  DiscoverModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? vacationDuration;
  String? name;
  String? description;
  String? imageLink;
  String? why;
  String? location;

  Items(
      {this.vacationDuration,
      this.name,
      this.description,
      this.imageLink,
      this.why,
      this.location});

  Items.fromJson(Map<String, dynamic> json) {
    vacationDuration = json['vacationDuration'];
    name = json['name'];
    description = json['description'];
    imageLink = '';
    why = json['why'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vacationDuration'] = this.vacationDuration;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image_link'] = this.imageLink;
    data['why'] = this.why;
    data['location'] = this.location;
    return data;
  }
}
