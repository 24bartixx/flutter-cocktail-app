class Ingredient {

  final int id;
  final String name;
  final String? description;
  final bool alcohol;
  final String? type;
  final int percentage;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? measure;

  Ingredient({
    required this.id,
    required this.name,
    required this.description,
    required this.alcohol,
    required this.type,
    required this.percentage,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.measure
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    print('kurw');
    print(json['id']);
    return switch(json) {
      {
        "id": int id,
        "name": String name,
        "description": String? description,
        "alcohol": bool alcohol,
        "type": String? type,
        "percentage": int? percentage,
        "imageUrl": String? imageUrl,
        "createdAt": String createdAt,
        "updatedAt": String updatedAt,
        "measure": String measure?
      } => 
      Ingredient(
        id: id,
        name: name,
        description: description,
        alcohol: alcohol,
        type: type,
        percentage: percentage ?? 0,
        imageUrl: imageUrl,
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
        measure: measure
      ),
      {
        "id": int id,
        "name": String name,
        "description": String? description,
        "alcohol": bool alcohol,
        "type": String? type,
        "percentage": int? percentage,
        "imageUrl": String? imageUrl,
        "createdAt": String createdAt,
        "updatedAt": String updatedAt
      } => 
      Ingredient(
        id: id,
        name: name,
        description: description,
        alcohol: alcohol,
        type: type,
        percentage: percentage ?? 0,
        imageUrl: imageUrl,
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
        measure: null
      ),
      _ => throw const FormatException("Faild to load ingredient.")
      
    };
  }

}