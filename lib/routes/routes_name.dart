import 'package:get/get.dart';

// Authentication imports
import '../presentation/authentication/splash_screen/splash_screen.dart';
import '../presentation/authentication/walkthrough/walkthrough.dart';
import '../presentation/authentication/user_selection/SelectionScree.dart';
import '../presentation/authentication/login_screen/login_screen.dart';
import '../presentation/authentication/register_screen/register_screen.dart';
import '../presentation/authentication/forgot_password/forgot_password_screen.dart';
import '../presentation/authentication/reset_password/reset_password_screen.dart';
import '../presentation/authentication/otp_verification_page/otp_verification_page.dart';

// Profile setup imports
import '../presentation/authentication/setup_your_profile/setup_profile_page.dart';
import '../presentation/authentication/setup_your_profile/profile_setup_page.dart';
import '../presentation/authentication/mentor_details/mentor_setup_page.dart';
import '../presentation/authentication/bank_details_page/bank_details_page.dart';
import '../presentation/authentication/verify_documents_page.dart';

// Navigation imports
import '../presentation/app_navigation/bottom_navigation_page.dart';

// Mentor imports
import '../presentation/mentor/home_screen/mentro_home_page.dart';
import '../presentation/mentor/chat_screen/chat_page.dart';
import '../presentation/mentor/session_screen/session_page.dart';
import '../presentation/mentor/session_screen/session_details_page.dart';
import '../presentation/mentor/course_screen/course_page.dart';
import '../presentation/mentor/course_screen/video_detail_page.dart';

// Student imports
import '../presentation/student/home_screen/student_home_page.dart';
import '../presentation/student/community_page/student_community_page.dart';
import '../presentation/student/learning_page/student_learning_page.dart';
import '../presentation/student/learning_page/explore_learnig_screen.dart';
import '../presentation/student/learning_page/my_learning_page.dart';
import '../presentation/student/learning_page/video_detail_page.dart' as student_video;
import '../presentation/student/mentor_page/student_mentor_page.dart';
import '../presentation/student/mentor_page/explore_mentor_screen.dart';
import '../presentation/student/mentor_page/mentor_list_page.dart';
import '../presentation/student/mentor_page/mentors_search_page.dart';
import '../presentation/student/home_screen/profile_details/profile_details_mantors.dart';
import '../presentation/student/home_screen/my_session/my_sessions_page.dart';
import '../presentation/student/community_page/chat_details_page/chat_details.dart';

// Profile imports
import '../presentation/profile_screen/profile_page.dart';
import '../presentation/profile_screen/student_profile_page.dart';
import '../presentation/profile_screen/setting_page/settings/settings_page.dart';
import '../presentation/profile_screen/edit_profile_image/edit_profile_image.dart';
import '../presentation/profile_screen/edit_profile_image/edit_profileInfo_page.dart';
import '../presentation/profile_screen/edit_profile_image/edit_bank_details_page.dart';
import '../presentation/profile_screen/edit_profile_image/edit_mentorship_details_page.dart';
import '../presentation/profile_screen/edit_profile_image/edit_certifications.dart';

import 'app_routes.dart';
import 'route_middleware.dart';

class AppPages {
  static final List<GetPage> pages = [
    // Authentication Routes
    GetPage(
      name: RoutesName.splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
     // middlewares: MiddlewareHelper.publicRoute(),
    ),
    GetPage(
      name: RoutesName.walk,
      page: () => const WalkthroughScreen(),
      transition: Transition.rightToLeft,
     // middlewares: MiddlewareHelper.publicRoute(),
    ),
    GetPage(
      name: RoutesName.userSelection,
      page: () => const UserSelectionScreen(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.publicRoute(),
    ),
    GetPage(
      name: RoutesName.login,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
     // middlewares: MiddlewareHelper.publicRoute(),
    ),
    GetPage(
      name: RoutesName.register,
      page: () => const RegisterScreen(),
      transition: Transition.rightToLeft,
     // middlewares: MiddlewareHelper.publicRoute(),
    ),
    GetPage(
      name: RoutesName.forgotPassword,
      page: () => const ForgotPasswordPage(),
      transition: Transition.rightToLeft,
     // middlewares: MiddlewareHelper.publicRoute(),
    ),
    GetPage(
      name: RoutesName.resetPassword,
      page: () => const ResetPasswordPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.publicRoute(),
    ),
    // GetPage(
    //   name: RoutesName.otpVerification,
    //   page: () => const OTPVerificationPage(),
    //   transition: Transition.rightToLeft,
    //   middlewares: MiddlewareHelper.publicRoute(),
    // ),

    GetPage(
      name: RoutesName.otpVerification,
      page: () => OTPVerificationPage(source: Get.arguments),
    ),


    // Profile Setup Routes
    GetPage(
      name: RoutesName.setupProfileImg,
      page: () => SetupProfileScreen(),
      transition: Transition.rightToLeft,
    //  middlewares: [MiddlewareHelper.auth(), MiddlewareHelper.analytics(), MiddlewareHelper.errorHandling()],
    ),
    GetPage(
      name: RoutesName.profileSetupInfo,
      page: () => const ProfileSetupPage(),
      transition: Transition.rightToLeft,
    //  middlewares: [MiddlewareHelper.auth(), MiddlewareHelper.analytics(), MiddlewareHelper.errorHandling()],
    ),
    GetPage(
      name: RoutesName.mentoringSetup,
      page: () => const MentoringSetupScreen(),
      transition: Transition.rightToLeft,
    //  middlewares: [MiddlewareHelper.auth(), MiddlewareHelper.role('mentor'), MiddlewareHelper.analytics(), MiddlewareHelper.errorHandling()],
    ),
    GetPage(
      name: RoutesName.bankDetails,
      page: () => BankDetailsPage(),
      transition: Transition.rightToLeft,
    //  middlewares: [MiddlewareHelper.auth(), MiddlewareHelper.role('mentor'), MiddlewareHelper.analytics(), MiddlewareHelper.errorHandling()],
    ),
    GetPage(
      name: RoutesName.verifyDocuments,
      page: () => VerifyDocumentsPage(),
      transition: Transition.rightToLeft,
    //  middlewares: [MiddlewareHelper.auth(), MiddlewareHelper.role('mentor'), MiddlewareHelper.analytics(), MiddlewareHelper.errorHandling()],
    ),

    // Navigation
    GetPage(
      name: RoutesName.navigation,
      page: () => const BottomNavigationPage(),
      transition: Transition.fadeIn,
    //  middlewares: MiddlewareHelper.protectedRoute(),
    ),

    // Mentor Routes
    GetPage(
      name: RoutesName.mentorHome,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    //  middlewares: MiddlewareHelper.mentorRoute(),
    ),
    GetPage(
      name: RoutesName.mentorChat,
      page: () => const ChatPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.mentorRoute(),
    ),
    GetPage(
      name: RoutesName.mentorSessions,
      page: () => const SessionPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.mentorRoute(),
    ),
    GetPage(
      name: RoutesName.sessionDetails,
      page: () => const SessionDetailsPage(),
      transition: Transition.rightToLeft,
   //   middlewares: MiddlewareHelper.mentorRoute(),
    ),
    GetPage(
      name: RoutesName.mentorCourses,
      page: () => const CoursePage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.mentorRoute(),
    ),
    GetPage(
      name: RoutesName.videoDetail,
      page: () => const VideoDetailPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.mentorRoute(),
    ),

    // Student Routes
    GetPage(
      name: RoutesName.studentHome,
      page: () => const StudentHomePage(),
      transition: Transition.fadeIn,
    //  middlewares: MiddlewareHelper.studentRoute(),
    ),
    GetPage(
      name: RoutesName.studentCommunity,
      page: () => const StudentCommunityPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.studentRoute(),
    ),
    GetPage(
      name: RoutesName.studentLearning,
      page: () => const StudentLearningPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.studentRoute(),
    ),
    GetPage(
      name: RoutesName.exploreLearning,
      page: () => const ExploreLearnigScreen(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.studentRoute(),
    ),
    GetPage(
      name: RoutesName.myLearning,
      page: () => const MyLearningPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.studentRoute(),
    ),
    GetPage(
      name: RoutesName.studentMentors,
      page: () => const StudentMentorPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.studentRoute(),
    ),
    GetPage(
      name: RoutesName.exploreMentors,
      page: () => const ExploreMentorScreen(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.studentRoute(),
    ),
    GetPage(
      name: RoutesName.mentorsList,
      page: () => const MentorListPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.studentRoute(),
    ),
    GetPage(
      name: RoutesName.mentorsSearch,
      page: () => const MentorsSearchPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.studentRoute(),
    ),
    GetPage(
      name: RoutesName.profileDetails,
      page: () => ProfileDetailsMantors(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.studentRoute(),
    ),
    GetPage(
      name: RoutesName.mySessions,
      page: () => const MySessionsPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.studentRoute(),
    ),
    // GetPage(
    //   name: RoutesName.chatDetails,
    //   page: () => const ChatDetailsPage(),
    //   transition: Transition.rightToLeft,
    // ),

    // Profile Routes
    GetPage(
      name: RoutesName.profile,
      page: () => const ProfilePage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.protectedRoute(),
    ),
    GetPage(
      name: RoutesName.studentProfile,
      page: () => const StudentProfilePage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.studentRoute(),
    ),
    GetPage(
      name: RoutesName.settings,
      page: () => SettingsScreen(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.protectedRoute(),
    ),
    // GetPage(
    //   name: RoutesName.editProfileImage,
    //   page: () => const EditProfileImagePage(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: RoutesName.editProfile,
    //   page: () => const EditProfileInfoPage(),
    //   transition: Transition.rightToLeft,
    // ),
    GetPage(
      name: RoutesName.editBankDetails,
      page: () => const EditBankDetailsPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.mentorRoute(),
    ),
    GetPage(
      name: RoutesName.editMentorshipDetails,
      page: () => const EditMentorshipDetailsPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.mentorRoute(),
    ),
    // GetPage(
    //   name: RoutesName.editCertifications,
    //   page: () => const EditCertificationsPage(),
    //   transition: Transition.rightToLeft,
    // ),

    // Legacy Routes (for backward compatibility)
    GetPage(
      name: RoutesName.home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
   //   middlewares: MiddlewareHelper.protectedRoute(),
    ),
    GetPage(
      name: RoutesName.courses,
      page: () => const CoursePage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.protectedRoute(),
    ),
    GetPage(
      name: RoutesName.courseDetail,
      page: () => const VideoDetailPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.protectedRoute(),
    ),
    GetPage(
      name: RoutesName.sessions,
      page: () => const SessionPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.protectedRoute(),
    ),
    GetPage(
      name: RoutesName.chat,
      page: () => const ChatPage(),
      transition: Transition.rightToLeft,
    //  middlewares: MiddlewareHelper.protectedRoute(),
    ),
  ];
}
