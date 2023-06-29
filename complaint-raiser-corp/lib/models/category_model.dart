import 'package:cloud_firestore/cloud_firestore.dart';

enum CategoryType {
  electricity,
  drainage,
  road,
  streetLights,
  other
}

String getCategoryName(CategoryType type) {
  switch(type) {
    case CategoryType.electricity: return 'Electricity';
    case CategoryType.drainage: return 'Drainage & Water';
    case CategoryType.road: return 'Road';
    case CategoryType.streetLights: return 'Street lights';
    case CategoryType.other: return 'Other Complaints';
  }
}
CategoryType getCategoryType(String type) {
  switch(type) {
    case 'Electricity': return CategoryType.electricity;
    case 'Drainage & Water': return CategoryType.drainage;
    case 'Road': return CategoryType.road;
    case 'Street lights': return CategoryType.streetLights;
    case 'Other Complaints': return CategoryType.other;
  }
  return CategoryType.other;
}

class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;

  CategoryModel({required this.id, required this.name, required this.imageUrl});

  factory CategoryModel.fromMap(Map<String, dynamic> data) {
    print(data['name']);
    String name = data['name'];
    String imageUrl = data['imageUrl'];
    String id = data['id'];

    print('fromMappppppppp');
    print(data);
    print(imageUrl);

    return CategoryModel(id:id, name: name, imageUrl: imageUrl);
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl
    };
  }
}

class CategoriesModel {
  final List<CategoryModel> categories;

  CategoriesModel({ required this.categories});


  factory CategoriesModel.fromMap(DocumentSnapshot data, String documentId) {
    print('frommmmmmmmmm mapppppppppppppppppp');
    print(data.get('categories'));
    var categoriesList = data.get('categories');
    List<CategoryModel> categories = [];

    for (var categoryMap in categoriesList) {
      print('flooooooooppp');
      print(categoryMap);
      categories.add(CategoryModel.fromMap(categoryMap));
    }


    return CategoriesModel(categories: categories);
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> categoriesList = [];

    for (var categoryMap in categories) {
      categoriesList.add(categoryMap.toMap());
    }
    return {
      'categories': categoriesList,
    };
  }
}