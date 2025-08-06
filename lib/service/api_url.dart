class ApiUrl {
  ApiUrl._();
  static String base = "http://10.10.20.52:8001/api";

  static socketUrl({required String userID}) => '$base?id=$userID';

  ///Create Account
  static register() => '$base/auth/register';
  static test() => 'http://10.10.20.52:8001';
  static activateOtp() => '$base/auth/verify-email';
  static resendActiveOtp() => '$base/auth/resend-verification-code';

  /// Forget Password Flow
  static forget() => '$base/auth/forgot-password';
  static forgotOtp() => '$base/auth/verify-code';
  static reset() => '$base/auth/reset-password';

  /// Login Flow

  static login() => '$base/auth/login';
  static profile() => '$base/user/profile';

  static businessProfile() => '$base/owner/get-owner-details';


  static changePassword() => '$base/auth/change-password';
  static deleteUser() => '$base/user/delete-account';

  /// Pet Shop Registration

  static shopRegistration() => '$base/business/create';
  static petRegistration() => '$base/pet/create';

  ///=====================================
  static getTerms() => '$base/manage/get-terms-conditions';
  static getFaq() => '$base/manage/get-faq';

  static privacyPolicy() => '$base/manage/get-privacy-policy';

  ///Subscription============
  //static subscription() => '$base/subcription/purchase-subscription';

 // static connectStripe() => '$base/stripe/connect-stripe';



  ///Categories==================
  static getCategories() => '$base/category/all-categories';



  ///Update Profile=============
  static updateProfile() => '$base/normal-user/update-profile';



  //static updateVideo({required String id}) => '$base/video/update-video/$id';

  static searchPlace() => '$base/search-place';

  static createRegulation() => '$base/regulation/create-regulation';
  static updateRegulation({required String id}) => '$base/regulation/update-regulation/$id';

  //static sendCollaboration() => '$base/collaboration/send-request';

  //static homePageChange() => '$base/normal-user/increase-total-scroll';


  ///User All==================
  static getAllPost({required int pageKey}) => '$base/post/get-all-posts?page=$pageKey&limit=10';


  static getAllSearch({required int pageKey,required String search, required String placeId, required String city, required String country}) => '$base/place/get-all-place?searchTerm=$search&city=$city&country=$country&placeType=$placeId&status=Approved&page=$pageKey&limit=10';
  static getSinglePlace({required String id}) => '$base/place/get-single-place/$id';
  static addPlace() => '$base/place/add-place';
  static getNotification({required int pageKey}) => '$base/notification/get-all-notifications?page=$pageKey&limit=20';
  static deleteNotification({required String id}) => '$base/notification/delete-notification/$id';
  static getDashboard({required String status, required int page}) => '$base/place/get-all-place?status=$status&page=$page&limit=10&sortBy=updatedAt';

  static getCountryCity() => '$base/get-country-city';
  static updateStatus({required String id}) => '$base/place/approve-reject/$id';
  static getSingleRegulation({required String country}) => '$base/regulation/get-single-regulation?country=$country';





  static getAllInbox({required int pageKey, required String search}) => '$base/conversation/get-chat-list?page=$pageKey&limit=10&searchTerm=$search';
  static getAllCollaboration({required int pageKey, required String params}) => '$base/collaboration/my-collaborations?status=$params&page=$pageKey&limit=10';

  static acceptRejectCollaboration({required String id}) => '$base/collaboration/accept-reject-collaboration/$id';
  static completeCollaboration({required String id}) => '$base/collaboration/mark-as-complete/$id';
  static addRemoveBookmark({required String id}) => '$base/bookmark/add-delete-bookmark/$id';
}