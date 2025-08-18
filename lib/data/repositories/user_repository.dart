import 'package:dio/dio.dart';

import 'package:learning_guru_app/core/models/api_response_model.dart';
import 'package:learning_guru_app/core/constants/api_endpoints.dart';
import 'package:learning_guru_app/core/network/dio_client.dart';

class UserRepository {
  final _network = NetworkService.instance;

  Future<ApiResponseModel> login(String email, String password) async {
    final data = {"email": email, "password": password};
    return await _network.post(ApiEndpoints.login(), data: data);
  }

  Future<ApiResponseModel> logout() async {
    return await _network.post(ApiEndpoints.logout());
  }

  Future<ApiResponseModel> requestOtp(String email) async {
    final data = {"email": email};
    return await _network.post(ApiEndpoints.requestOtp(), data: data);
  }

  Future<ApiResponseModel> verifyOtp(String email, String otp) async {
    final data = {"email": email, "otp": otp};
    return await _network.post(ApiEndpoints.verifyOtp(), data: data);
  }

  Future<ApiResponseModel> registerUser(Map<String, dynamic> userData) async {
    return await _network.post(ApiEndpoints.register(), data: userData);
  }

  Future<ApiResponseModel> uploadUserDocuments({
    required int userId,
    required String type,
    required List<MultipartFile> files,
  }) async {
    final formData = FormData.fromMap({
      "user_id": userId,
      "type": type,
      "files": files,
    });

    return await _network.postMultipart(ApiEndpoints.uploadUserDoc(), formData: formData);
  }

  Future<ApiResponseModel> forgetPassword(String email, String newPassword) async {
    final data = {"email": email, "password": newPassword};
    return await _network.put(ApiEndpoints.forgetPassword(), data: data);
  }

  Future<ApiResponseModel> updateUserStatus(int userId, {required String status, String? reason}) async {
    final data = {"status": status, "reason": reason ?? ""};
    return await _network.put(ApiEndpoints.updateUserStatus(userId), data: data);
  }

  Future<ApiResponseModel> updateUser(int userId, Map<String, dynamic> userData) async {
    return await _network.put(ApiEndpoints.updateUser(userId), data: userData);
  }

  Future<ApiResponseModel> updateProfilePicture(int userId, MultipartFile file) async {
    final formData = FormData.fromMap({
      "profile_picture": file,
    });
    return await _network.put(ApiEndpoints.updateProfilePic(userId), data: formData);
  }

  Future<ApiResponseModel> sessionCheck({required String token}) async {
    return await _network.get(
      ApiEndpoints.session(),
      //options: Options(headers: {"Authorization": "Bearer $token"}),
      headers: {
        "Authorization": "Bearer $token",  // Bearer token in headers
      },
    );
  }

  Future<ApiResponseModel> getAllUsers() async {
    return await _network.get(ApiEndpoints.getAllUsers());
  }

  Future<ApiResponseModel> getUsersByStatus(int status) async {
    return await _network.get(ApiEndpoints.getUsersByStatus(status));
  }

  Future<ApiResponseModel> getUserDocumentsById(int id) async {
    return await _network.get(ApiEndpoints.getUserDocsById(id));
  }

  Future<ApiResponseModel> getUserById(int id) async {
    return await _network.get(ApiEndpoints.getUserById(id));
  }
}
