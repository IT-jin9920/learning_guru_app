/// Provides centralized API endpoints used throughout the app.
///
/// Avoids hardcoding URLs directly in the app to improve maintainability
/// and ensure consistent URL usage.
///
class ApiEndpoints {
  /// The base URL of the API server.
  static const String baseUrl = "http://capriyankajain.in";

  /// The API prefix path for all API endpoints.
  static const String apiPrefix = "/api";

  // ---------------- Category Endpoints ----------------

  /// Base path for category-related APIs.
  static const String categoryBase = "$apiPrefix/category";

  /// Gets full URL for fetching all categories.
  static String getCategory() => "$baseUrl$categoryBase";

  /// Gets full URL for creating a new category.
  static String storeCategory() => "$baseUrl$categoryBase/store";

  /// Gets full URL for fetching a category by its ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the category.
  static String categoryById(int id) => "$baseUrl$categoryBase/$id";

  /// Gets full URL for fetching categories by role ID.
  ///
  /// - Parameters:
  ///   - [roleId]: The role ID to filter categories.
  static String categoryByRole(int roleId) => "$baseUrl$categoryBase/role/$roleId";

  /// Gets full URL for deleting a category by ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the category to delete.
  static String deleteCategory(int id) => "$baseUrl$categoryBase/delete/$id";

  // ---------------- Subcategory Endpoints ----------------

  /// Base path for subcategory-related APIs.
  static const String subCategoryBase = "$apiPrefix/subcategory";

  /// Gets full URL for fetching all subcategories.
  static String getSubCategory() => "$baseUrl$subCategoryBase";

  /// Gets full URL for creating a new subcategory.
  static String storeSubCategory() => "$baseUrl$subCategoryBase/store";

  /// Gets full URL for fetching a subcategory by ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the subcategory.
  static String subCategoryById(int id) => "$baseUrl$subCategoryBase/$id";

  /// Gets full URL for deleting a subcategory by ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the subcategory to delete.
  static String deleteSubCategory(int id) => "$baseUrl$subCategoryBase/delete/$id";

  // ---------------- Course Endpoints ----------------

  /// Base path for course-related APIs.
  static const String courseBase = "$apiPrefix/course";

  /// Gets full URL for fetching all courses.
  static String getCourse() => "$baseUrl$courseBase";

  /// Gets full URL for creating a new course.
  static String createCourse() => "$baseUrl$courseBase/create";

  /// Gets full URL for updating course basic details by ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the course.
  static String updateCourse(int id) => "$baseUrl$courseBase/basic/update/$id";

  /// Gets full URL for deleting a course by ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the course to delete.
  static String deleteCourse(int id) => "$baseUrl$courseBase/delete/$id";

  /// Gets full URL for fetching a course by ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the course.
  static String courseById(int id) => "$baseUrl$courseBase/$id";

  /// Gets full URL for uploading course content.
  static String uploadCourseContent() => "$baseUrl$courseBase/upload";

  /// Gets full URL for updating course chapters.
  static String updateCourseContent() => "$baseUrl$courseBase/chapter/update";

  // ---------------- Free Course Endpoints ----------------

  /// Base path for free course-related APIs.
  static const String freeCourseBase = "$apiPrefix/free_course";

  /// Gets full URL for fetching all free courses.
  static String getAllFreeCourses() => "$baseUrl$freeCourseBase";

  /// Gets full URL for creating a new free course.
  static String createFreeCourse() => "$baseUrl$freeCourseBase/create";

  /// Gets full URL for updating free course basic details by ID.
  /// - Parameters:
  ///   - [id]: The ID of the free course.
  static String updateFreeCourse(int id) => "$baseUrl$freeCourseBase/basic/update/$id";

  /// Gets full URL for deleting a free course by ID.
  /// - Parameters:
  ///   - [id]: The ID of the free course to delete.
  static String deleteFreeCourse(int id) => "$baseUrl$freeCourseBase/delete/$id";

  /// Gets full URL for fetching a free course by ID.
  /// - Parameters:
  ///   - [id]: The ID of the free course.
  static String freeCourseById(int id) => "$baseUrl$freeCourseBase/$id";

  /// Gets full URL for uploading free course content.
  static String uploadFreeCourseContent() => "$baseUrl$freeCourseBase/upload";

  /// Gets full URL for updating free course chapters.
  static String updateFreeCourseContent() => "$baseUrl$freeCourseBase/chapter/update";

  // ---------------- Sort Video Endpoints ----------------

  /// Base path for sort video-related APIs.
  static const String sortVideoBase = "$apiPrefix/sort_video";

  /// Gets full URL for creating a new sort video.
  static String createSortVideo() => "$baseUrl$sortVideoBase/store";

  /// Gets full URL for updating a sort video by ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the sort video.
  static String updateSortVideo(int id) => "$baseUrl$sortVideoBase/$id";

  /// Gets full URL for deleting a sort video by ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the sort video to delete.
  static String deleteSortVideo(int id) => "$baseUrl$sortVideoBase/delete/$id";

  /// Gets full URL for fetching a sort video by ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the sort video.
  static String sortVideoById(int id) => "$baseUrl$sortVideoBase/$id";

  // ---------------- Chat Endpoints ----------------

  /// Base path for chat-related APIs.
  static const String chatBase = "$apiPrefix/chat";

  /// Gets full URL for sending a chat message.
  static String sendMessage() => "$baseUrl$chatBase/send";

  /// Gets full URL for creating a chat group.
  static String createGroup() => "$baseUrl$chatBase/group/create";

  /// Gets full URL for adding a user to a chat group.
  static String addUserToGroup() => "$baseUrl$chatBase/group/add-user";

  /// Gets full URL for editing a chat message by ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the message to edit.
  static String editMessage(int id) => "$baseUrl$chatBase/edit/$id";

  /// Gets full URL for marking a message as read by ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the message.
  static String markRead(int id) => "$baseUrl$chatBase/mark-read/$id";

  /// Gets full URL for deleting a chat message by ID.
  ///
  /// - Parameters:
  ///   - [id]: The ID of the message to delete.
  static String deleteMessage(int id) => "$baseUrl$chatBase/delete/$id";

  /// Gets full URL for retrieving all chat messages.
  static String getMessages() => "$baseUrl$chatBase/messages";

  /// Gets full URL for retrieving all chat groups a user belongs to.
  ///
  /// - Parameters:
  ///   - [userId]: The user ID.
  static String getUserGroups(int userId) => "$baseUrl$chatBase/group/user/$userId";

  /// Gets full URL for retrieving messages exchanged between two users.
  ///
  /// - Parameters:
  ///   - [user1]: First user ID.
  ///   - [user2]: Second user ID.
  static String getMessagesBetweenUsers(int user1, int user2) =>
      "$baseUrl$chatBase/messages/$user1/$user2";

  // ---------------- User Endpoints ----------------

  /// Base path for user-related APIs.
  static const String userBase = "$apiPrefix/user";

  /// Gets full URL for user login.
  static String login() => "$baseUrl$userBase/login";

  /// Gets full URL for user logout.
  static String logout() => "$baseUrl$userBase/logout";

  /// Gets full URL for requesting OTP.
  static String requestOtp() => "$baseUrl$userBase/reqOTP";

  /// Gets full URL for verifying OTP.
  static String verifyOtp() => "$baseUrl$userBase/verifyOTP";

  /// Gets full URL for user registration.
  static String register() => "$baseUrl$userBase/registration";

  /// Gets full URL for uploading user documents.
  static String uploadUserDoc() => "$baseUrl$userBase/doc/upload";

  /// Gets full URL for forgetting password.
  static String forgetPassword() => "$baseUrl$userBase/forgetPassword";

  /// Gets full URL for updating user status by ID.
  ///
  /// - Parameters:
  ///   - [id]: The user ID.
  static String updateUserStatus(int id) => "$baseUrl$userBase/statusupdate/$id";

  /// Gets full URL for updating user details by ID.
  ///
  /// - Parameters:
  ///   - [id]: The user ID.
  static String updateUser(int id) => "$baseUrl$userBase/update/$id";

  /// Gets full URL for updating user profile picture by ID.
  ///
  /// - Parameters:
  ///   - [id]: The user ID.
  static String updateProfilePic(int id) => "$baseUrl$userBase/update-profile-picture/$id";

  /// Gets full URL for user session info.
  static String session() => "$baseUrl$userBase/session";

  /// Gets full URL for fetching all users.
  static String getAllUsers() => "$baseUrl$userBase/all";

  /// Gets full URL for fetching users filtered by status.
  ///
  /// - Parameters:
  ///   - [status]: Status filter value.
  static String getUsersByStatus(int status) => "$baseUrl$userBase/status/$status";

  /// Gets full URL for fetching user documents by user ID.
  ///
  /// - Parameters:
  ///   - [id]: The user ID.
  static String getUserDocsById(int id) => "$baseUrl$userBase/document/$id";

  /// Gets full URL for fetching user details by ID.
  ///
  /// - Parameters:
  ///   - [id]: The user ID.
  static String getUserById(int id) => "$baseUrl$userBase/$id";
}
