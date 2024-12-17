class Category {
  String categoryId;
  String name;
  String? imageUrl;

  Category({required this.categoryId, required this.name, this.imageUrl});

  factory Category.fromFirestore(Map<String, dynamic> data, String id) {
    return Category(
      categoryId: id,
      name: data['name'],
      imageUrl: data['imageUrl'],
    );
  }
}
