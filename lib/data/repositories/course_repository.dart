import 'package:dio/dio.dart';

import 'package:learning_guru_app/core/models/api_response_model.dart';
import 'package:learning_guru_app/core/constants/api_endpoints.dart';
import 'package:learning_guru_app/core/network/dio_client.dart';

class CourseRepository {
  final _network = NetworkService.instance;
  Future<ApiResponseModel> getAllCourses() async {
    return await _network.get(ApiEndpoints.getCourse());
  }

  Future<ApiResponseModel> getCourseById(int id) async {
    return await _network.get(ApiEndpoints.courseById(id));
  }

  Future<ApiResponseModel> createCourse({
    required int userId,
    required String name,
    required int categoryId,
    required String price,
    required String description,
    required String studentLearn,
    required MultipartFile thumbnail,
  }) async {
    final formData = FormData.fromMap({
      "user_id": userId,
      "name": name,
      "category_id": categoryId,
      "price": price,
      "description": description,
      "student_learn": studentLearn,
      "thumbnail": thumbnail,
    });

    return await _network.postMultipart(ApiEndpoints.createCourse(), formData: formData);
  }

  Future<ApiResponseModel> updateCourse(
      int id, {
        required int userId,
        required String name,
        required int categoryId,
        required String description,
        required String studentLearn,
        MultipartFile? thumbnail,
      }) async {
    final formData = FormData.fromMap({
      "user_id": userId,
      "name": name,
      "category_id": categoryId,
      "description": description,
      "student_learn": studentLearn,
      if (thumbnail != null) "thumbnail": thumbnail,
    });

    return await _network.put(ApiEndpoints.updateCourse(id), data: formData);
  }

  Future<ApiResponseModel> uploadCourseContent({
    required int courseId,
    required String chapters,
    required MultipartFile file,
  }) async {
    final formData = FormData.fromMap({
      "courseId": courseId,
      "chapters": chapters,
      "files": file,
    });

    return await _network.postMultipart(ApiEndpoints.uploadCourseContent(), formData: formData);
  }

  Future<ApiResponseModel> updateCourseContent({
    required int courseId,
    required String chapters,
    MultipartFile? file,
  }) async {
    final formData = FormData.fromMap({
      "courseId": courseId,
      "chapters": chapters,
      if (file != null) "files": file,
    });

    return await _network.put(ApiEndpoints.updateCourseContent(), data: formData);
  }

  Future<ApiResponseModel> deleteCourse(int id) async {
    return await _network.delete(ApiEndpoints.deleteCourse(id));
  }

}
