class ApiUrl {
  ApiUrl._();
  static String base = "http://10.10.20.52:8001/api";
  static String imageBase = "http://10.10.20.52:8001/";

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
  static changePassword() => '$base/user/change-password';

  /// Pet Shop Registration

  static shopRegistration() => '$base/business/create';
  static petRegistration() => '$base/pet/create';

  ///=====================================
  static getTerms() => '$base/terms-condition/get';
  static getFaq() => '$base/faq/get';
  static giveFeedbacks() => '$base/help/create';
  static privacyPolicy() => '$base/privacy/get';

  ///Subscription============
  //static subscription() => '$base/subcription/purchase-subscription';
 // static connectStripe() => '$base/stripe/connect-stripe';

  ///Advertisement==================


  static addAdvertisement()=> '$base/advertisement/add-advertisement';
  static getAdvertisement()=> '$base/advertisement/get-ads';

  ///Update Profile=============

  static businessUpdateProfile() => '$base/owner/update-owner-details';
  static updateProfile() => '$base/user/update-profile';
  static getBusinessShopProfile() => '$base/business/get';

 ///======UserAll

  static getHomeHeader() => '$base/user-home-page/totalPetsForLoggedInUser';
  static getProfile() => '$base/user/get-profile';
  static addPet() => '$base/pet/create';
  static getMyAllPet() => '$base/user/my-pets';
  static myAllPetDetails({required String id}) => '$base/pet/get/$id';
  static updateMyPet({required String id}) => '$base/pet/update/$id';
  static deletedPet({required String id}) => '$base/pet/delete/$id';
  static getCategoryDetails({required String id}) => '$base/services/getServicesById/$id';
  static getService({required String type,required int page}) => '$base/user-home-page/getServicesByType/$type?limit=10&page=$page';
  static getPetHealth({required String status,required int page,required String id}) => '$base/pet/get-medical-history/$id?treatmentStatus=$status&limit=1&page=$page';

  /// Booking MY Appointment
  static createBookingAppointment() => '$base/booking/create-booking';
  static getBookingAppointmentDetails({required String id}) => '$base/booking/get-bookings-by-service-id/$id';
  static getBookingAppointment({required int page}) => '$base/booking/get-bookings?limit=10&page=$page';
  static deletedBookingAppointment({required String id}) => '$base/booking/delete/$id';
  ///Business All Pets

  static getBusinessAllPets() => '$base/owner/get-all-pets-who-booked';
  static businessPetDetails({required String id}) => '$base/owner/get-pet-details-by-pet-id/$id';
  ///Health update

  static getPetBusiness() => '$base/owner/get-all-pets-who-booked';
  ///Health update

  static getHealthHistory({required String id,required String status,required int page}) => '$base/pet-medical-history/get/$id?treatmentStatus=$status&limit=10&page=$page';
  static healthHistoryCreate({required String id}) => '$base/pet-medical-history/create/$id';
  static healthHistoryUpdate({required String id}) => '$base/pet-medical-history/update/$id';
  static deleteHealthHistory({required String id}) => '$base/pet-medical-history/delete/$id';
  //static updateVideo({required String id}) => '$base/video/update-video/$id';
  ///Business Service
  static getBusinessService() => '$base/services/getServices';
  static addService() => '$base/services/createService';
  static deletedService({required String id}) => '$base/services/deleteService/$id';
  static updateService({required String id}) => '$base/services/updateService/$id';
 /// Review
  static addReview() => '$base/review/create';
  static getReview({required String id}) => '$base/review/get-all-reviews-by-service/$id';














  ///User All==================

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