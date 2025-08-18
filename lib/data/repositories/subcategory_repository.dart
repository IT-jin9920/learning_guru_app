import 'package:learning_guru_app/core/models/api_response_model.dart';
import 'package:learning_guru_app/core/constants/api_endpoints.dart';
import 'package:learning_guru_app/core/network/dio_client.dart';

class SubCategoryRepository {
  final _network = NetworkService.instance;

  /// Fetches all subcategories.
  Future<ApiResponseModel> getAllSubCategories() async {
    return await _network.get(ApiEndpoints.getSubCategory());
  }

  /// Fetches a subcategory by ID.
  Future<ApiResponseModel> getSubCategoryById(int id) async {
    return await _network.get(ApiEndpoints.subCategoryById(id));
  }

  /// Creates a new subcategory.
  Future<ApiResponseModel> createSubCategory({
    required String name,
    required int categoryId,
  }) async {
    final data = {
      "name": name,
      "category_id": categoryId,
    };
    return await _network.post(ApiEndpoints.storeSubCategory(), data: data);
  }

  /// Updates an existing subcategory.
  Future<ApiResponseModel> updateSubCategory(
      int id, {
        required String name,
        required int categoryId,
      }) async {
    final data = {
      "name": name,
      "category_id": categoryId,
    };
    return await _network.put(ApiEndpoints.subCategoryById(id), data: data);
  }

  /// Deletes a subcategory by ID.
  Future<ApiResponseModel> deleteSubCategory(int id) async {
    return await _network.delete(ApiEndpoints.deleteSubCategory(id));
  }
}
