import 'package:learning_guru_app/core/models/api_response_model.dart';
import 'package:learning_guru_app/core/constants/api_endpoints.dart';
import 'package:learning_guru_app/core/network/dio_client.dart';

class CategoryRepository {
  final _network = NetworkService.instance;

  Future<ApiResponseModel> getAllCategories() async {
    return await _network.get(ApiEndpoints.getCategory());
  }

  Future<ApiResponseModel> getCategoryById(int id) async {
    return await _network.get(ApiEndpoints.categoryById(id));
  }

  Future<ApiResponseModel> getCategoryByRole(int roleId) async {
    return await _network.get(ApiEndpoints.categoryByRole(roleId));
  }

  Future<ApiResponseModel> createCategory({required String name, required int role}) async {
    final data = {"name": name, "role": role};
    return await _network.post(ApiEndpoints.storeCategory(), data: data);
  }

  Future<ApiResponseModel> updateCategory(int id, {required String name, required int role}) async {
    final data = {"name": name, "role": role};
    return await _network.put(ApiEndpoints.categoryById(id), data: data);
  }

  Future<ApiResponseModel> deleteCategory(int id) async {
    return await _network.delete(ApiEndpoints.deleteCategory(id));
  }
}
