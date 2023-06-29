

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_raiser_official/models/complaint_model.dart';

import 'firestore_path.dart';
import 'firestore_services.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase();

  final _firestoreService = FirestoreService.instance;

  //Method to create/update todoModel

  // Future<ProductModel> getProduct(String id) async {
  //   print(id);
  //   DocumentSnapshot doc =
  //       await _firestoreService.getDocument(path: FirestorePath.product(id));
  // print(doc.exists);
  // print(doc.id);
  //   return ProductModel.fromDoc(doc, doc.id);
  // }
  //
  Future<void> setComplaint(ComplaintModel complaint) async {
    await _firestoreService.set(
      path: FirestorePath.complaint(complaint.id),
      data: complaint.toMap(),
    );
  }
  //
  // Future<List<ComplaintModel>> getComplaints () async {
  //   List<QueryDocumentSnapshot<Object?>> snapshots = await _firestoreService.getCollection(path: FirestorePath.products());
    // List<ProductModel> products
  // }
  //
  // Future<void> deleteProduct(
  //     {required String id,
  //     required StorageDatabase storageDatabase,
  //     required String imageUrl}) async {
  //   await _firestoreService.deleteData(path: FirestorePath.product(id));
  //   await storageDatabase.deleteImageFromUrl(imageUrl);
  // }
  //
  // Future<void> setCategories(CategoriesModel categories) async {
  //   await _firestoreService.set(
  //     path: FirestorePath.categories(),
  //     data: categories.toMap(),
  //   );
  // }
  //
  // Future<void> deleteCategory(
  //     {required CategoriesModel categories,
  //     required String imageUrl,
  //     required StorageDatabase storageDatabase}) async {
  //   await _firestoreService.set(
  //     path: FirestorePath.categories(),
  //     data: categories.toMap(),
  //   );
  //   await storageDatabase.deleteImageFromUrl(imageUrl);
  // }
  //
  // Future<CategoriesModel> getCategories() async {
  //   DocumentSnapshot snapshot =
  //       await _firestoreService.getDocument(path: FirestorePath.categories());
  //   if (!snapshot.exists) return CategoriesModel(categories: []);
  //   CategoriesModel category = CategoriesModel.fromMap(snapshot, 'categories');
  //   return category;
  // }
  //
  // Future<void> setIngredient(IngredientsModel ingredients) async {
  //   await _firestoreService.set(
  //     path: FirestorePath.ingredients(),
  //     data: ingredients.toMap(),
  //   );
  // }
  //
  // Future<IngredientsModel> getIngredients() async {
  //   DocumentSnapshot snapshot =
  //       await _firestoreService.getDocument(path: FirestorePath.ingredients());
  //   if (!snapshot.exists) return IngredientsModel(ingredients: []);
  //   IngredientsModel ingredients = IngredientsModel.fromMap(snapshot);
  //   return ingredients;
  // }
  //
  // Future<void> setCart(CartModel cart) async {
  //   await _firestoreService.set(
  //     path: FirestorePath.cart(cart.uid),
  //     data: cart.toMap(),
  //   );
  // }
}
