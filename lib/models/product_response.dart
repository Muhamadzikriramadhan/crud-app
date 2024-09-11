class ProductResponse {
  String? ids;
  int? id;
  int? categoryId;
  String? categoryName;
  String? sku;
  String? name;
  String? description;
  int? weight;
  int? width;
  int? length;
  int? height;
  String? image;
  int? harga;

  ProductResponse(
      {this.ids,
        this.id,
        this.categoryId,
        this.categoryName,
        this.sku,
        this.name,
        this.description,
        this.weight,
        this.width,
        this.length,
        this.height,
        this.image,
        this.harga});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    ids = json['_id'];
    id = json['id'];
    categoryId = json['CategoryId'];
    categoryName = json['categoryName'];
    sku = json['sku'];
    name = json['name'];
    description = json['description'];
    weight = json['weight'];
    width = json['width'];
    length = json['length'];
    height = json['height'];
    image = json['image'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.ids;
    data['id'] = this.id;
    data['CategoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['description'] = this.description;
    data['weight'] = this.weight;
    data['width'] = this.width;
    data['length'] = this.length;
    data['height'] = this.height;
    data['image'] = this.image;
    data['harga'] = this.harga;
    return data;
  }
}
