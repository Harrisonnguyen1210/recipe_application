class Category {
  String categoryId;
  String name;

  Category({required this.categoryId, required this.name});

  factory Category.fromFirestore(Map<String, dynamic> data, String id) {
    return Category(
      categoryId: id,
      name: data['name'],
    );
  }
}
