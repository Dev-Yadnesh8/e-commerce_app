class ProductModel {
  String? name;
  int? price;
  String? image;
  String? about;
  double? rating;
  int? reviews;
  String? id;

  ProductModel(
      {this.name,
        this.price,
        this.image,
        this.about,
        this.rating,
        this.reviews,
        this.id});

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    image = json['image'];
    about = json['about'];
    rating = json['rating'];
    reviews = json['reviews'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['about'] = about;
    data['rating'] = rating;
    data['reviews'] = reviews;
    data['id'] = id;
    return data;
  }
}