import 'package:grocery_store/src/services/api_services.dart';
import 'package:models/models.dart';

class CategoryRepository {
  final ApiService apiClient;

  const CategoryRepository({required this.apiClient});

  Future<Category> getCategoryById(String categoryId) async {
    final response = await apiClient.getCategoryById(categoryId);

    if (response is Map<String, dynamic>) {
      return Category.fromJson(response);
    } else {
      throw Exception('Failed to load category from the API');
    }
  }

  Future<List<Category>> getCategories() async {
    final response = await apiClient.getCategories();
    if (response is List) {
      return response.map((json) {
        return Category.fromJson(json as Map<String, dynamic>);
      }).toList();
    } else {
      throw Exception('Failed to load categories from the API');
    }
  }
}
