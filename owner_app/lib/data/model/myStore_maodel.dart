class StoreModel {

  String id;

  String name;

  String description;

  String phone;

  String logo;

  String coverImage;

  List<String> categories;

  StoreModel({

    required this.id,

    required this.name,

    required this.description,

    required this.phone,

    required this.logo,

    required this.coverImage,

    required this.categories,
  });

  factory StoreModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return StoreModel(

      id: json['id'],

      name: json['name'],

      description: json['description'],

      phone: json['phone'],

      logo: json['logo'],

      coverImage: json['coverImage'],

      categories:
          List<String>.from(
            json['categories'],
          ),
    );
  }

  Map<String, dynamic> toJson() {

    return {

      'id': id,

      'name': name,

      'description': description,

      'phone': phone,

      'logo': logo,

      'coverImage': coverImage,

      'categories': categories,
    };
  }
}