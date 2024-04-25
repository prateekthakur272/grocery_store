import 'package:models/models.dart';

class CategoryRepository{
  Future<Category> getCategoryById(String id) async {
    return Category.sampleData.firstWhere((element) => element.id == id);
  }

  Future<List<Category>> getCategories() async {
    return Category.sampleData;
  }
}