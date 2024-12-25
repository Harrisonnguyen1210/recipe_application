import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/models/models.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(ref.watch(firestoreProvider));
});

class FirestoreService {
  final FirebaseFirestore firestore;
  FirestoreService(this.firestore);

  Future<List<Recipe>> getAllRecipes() async {
    final recipeCollection = await firestore.collection('recipes').get();
    return recipeCollection.docs
        .map((doc) => Recipe.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  Future<Recipe?> getRecipeById(String recipeId) async {
    final recipeSnapShot =
        await firestore.collection('recipes').doc(recipeId).get();
    if (recipeSnapShot.data() != null) {
      return Recipe.fromFirestore(recipeSnapShot.data()!, recipeId);
    }
    return null;
  }

  Future<List<Recipe>> getRecipesByCategoryId(String categoryId) async {
    final recipesSnapShot = await firestore
        .collection('recipes')
        .where('categoryId', isEqualTo: categoryId)
        .get();
    return recipesSnapShot.docs
        .map((doc) => Recipe.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  Future<List<Category>> getAllCategories() async {
    final categoryCollection = await firestore.collection('categories').get();
    return categoryCollection.docs
        .map((doc) => Category.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  Future<void> addRecipe(Map<String, Object?> data) async {
    await firestore.collection('recipes').add(data);
  }

  Future<void> deleteRecipe(String recipeId) async {
    await firestore.collection('recipes').doc(recipeId).delete();
  }

  Future<void> toggleFavorite(
      String recipeId, String userId, bool isFavorite) async {
    final recipeRef = firestore.collection('recipes').doc(recipeId);

    if (isFavorite) {
      await recipeRef
          .collection('favorites')
          .doc(userId)
          .set({'isFavorite': true});
    } else {
      await recipeRef.collection('favorites').doc(userId).delete();
    }
  }

  Future<bool> isRecipeFavorited(String recipeId, String userId) async {
    final favoriteDoc = await firestore
        .collection('recipes')
        .doc(recipeId)
        .collection('favorites')
        .doc(userId)
        .get();

    return favoriteDoc.exists && (favoriteDoc.data()?['isFavorite'] ?? false);
  }

  Future<int> getFavoriteCount(String recipeId) async {
    final favorites = await firestore
        .collection('recipes')
        .doc(recipeId)
        .collection('favorites')
        .get();
    return favorites.size;
  }

  Future<List<Recipe>> getUserFavorites(String userId) async {
    final recipeSnapshot = await firestore.collection('recipes').get();

    List<Recipe> favoriteRecipes = [];

    for (var doc in recipeSnapshot.docs) {
      final favoriteDoc =
          await doc.reference.collection('favorites').doc(userId).get();
      if (favoriteDoc.exists && favoriteDoc.data()?['isFavorite'] == true) {
        favoriteRecipes.add(Recipe.fromFirestore(doc.data(), doc.id));
      }
    }

    return favoriteRecipes;
  }
}
