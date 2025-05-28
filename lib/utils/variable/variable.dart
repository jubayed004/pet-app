import 'package:get/get.dart';
import 'package:logger/logger.dart';


String dummyProfileImage =
    'https://www.webxcreation.com/event-recruitment/images/profile-1.jpg';
// String dummyImgImg ='https://images.pexels.com/photos/62613/heliconius-melpomene-butterfly-exotic-62613.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
// String dummyCatImg ='https://site-images.similarcdn.com/image?url=fpoimg.com&t=4&s=1&h=1449187c387db98af0e1271f320f3e5714296230aef41d228ed0c7fd47ea936c';
var logger = Logger(printer: PrettyPrinter());
String imageUrl =
    'https://images.pexels.com/photos/27781997/pexels-photo-27781997/free-photo-of-a-blue-butterfly-is-sitting-on-top-of-a-plant.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
String userBoxName = 'user';
const String settingBox = 'settings';
const String authBox = 'Auth';
const String languageKey = 'language';
String initialKey = 'initial';
String verifyEmail = 'verify email';
String tokenKey = 'token';
String verifyTokenKey = 'verify token';
// Condition options
final List<String> condition = ['New', 'Used'];

// Sort By options
final List<String> sortBy = [
  'Latest First',
  'Price: Low to High',
  'Price: High to Low',
  'Most Viewed',
];
double ratio =  1 / 1.16;
class SubscriptionModel{
  final String title;
  final String price;
  final String imgUrl;
  final int index;

  SubscriptionModel({required this.title, required this.price, required this.imgUrl, required this.index});
}
class OnboardingModel {
  final String title;
  final String message;
  final String? backgroundImgUrl;
  final String? frontImgUrl;

  OnboardingModel(
      {required this.title,
        required this.message,
        this.backgroundImgUrl,
        this.frontImgUrl});
}
class LanguageModel {
  final String name;
  final String code;

  LanguageModel({
    required this.name,
    required this.code,
  });
}
/*final List<SubscriptionModel> subsList=[
  SubscriptionModel(title: "Basic Plan", price: "23.99", imgUrl: basicIcon,
      index: 1),
  SubscriptionModel(title: "Premium Plan", price: "24.99", imgUrl: premiumIcon,
      index: 2),
];*/
final List<LanguageModel> languageList = [
  LanguageModel(name: 'English', code: 'en'),
  LanguageModel(name: 'عربي', code: 'ar'),
];
class Address {
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Address({
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });
}
final Address fromAddress = Address(
  city: 'New York',
  state: 'NY',
  postalCode: '10001',
  country: 'USA',
);
class ShippingOption {
  final String id;
  final String title;
  final String description;
  final double price;

  ShippingOption({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
  });
}

/*final List<ShippingOption> shippingOptions = [
  ShippingOption(
    id: 'local',
    title: AppStaticStrings.localDelivery,
    description: AppStaticStrings.localMarket,
    price: 5.0,

  ),
  ShippingOption(
    id: 'container',
    title: AppStaticStrings.container,
    description: AppStaticStrings.daysDelivery,
    price: 20.0,

  ),
  ShippingOption(
    id: 'air',
    title: AppStaticStrings.airShipping,
    description:AppStaticStrings.weeksDelivery,
    price: 50.0,

  ),
];*/
final Address toAddress = Address(
  city: 'Los Angeles',
  state: 'CA',
  postalCode: '90001',
  country: 'USA',
);
// Category options
final List<String> category = [
  'Electronics',
  'Jewelry',
  "Men's Fashion",
  "Women's Fashion",
  'Home Decor',
  'Kitchen Tools',
  'Health Products',
  'Kids & Toys',
  'Others',
];
/*List<String> paymentList =[
  AppStaticStrings.paymentMethod,
  AppStaticStrings.cashHandDelivery
];
List<ProductOptionModel> productOptions =[
  ProductOptionModel(title: AppStaticStrings.specifications,
      route: SpecificationPage.routeName),
  ProductOptionModel(title: AppStaticStrings.sellingInformation,
      route:SellingInfoPage.routeName),
  ProductOptionModel(title: AppStaticStrings.customerReview, route:ReviewPage.routeName),
  ProductOptionModel(title: AppStaticStrings.shipping, route:ShippingPage.routeName),
  ProductOptionModel(title: AppStaticStrings.sellerInformation,
      route: SellerInformationPage.routeName),
  ProductOptionModel(title: AppStaticStrings.chat, route:MessageListPage.routeName)
];*/
class MyListingsModel {
  final String img;
  final String title;

  MyListingsModel({required this.img, required this.title});
}class ProductOptionModel {
  final String title;
  final String route;

  ProductOptionModel({required this.title, required this.route});

}

String dummyDesc =
    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for  will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).';
List<String> imageUrls = [
  "https://picsum.photos/id/10/800/600",  // Forest stream
  "https://picsum.photos/id/11/800/600",  // Mountain valley
  "https://picsum.photos/id/12/800/600",  // Ocean cliff
  "https://picsum.photos/id/13/800/600",  // Misty lake
  "https://picsum.photos/id/14/800/600",  // Desert canyon
  "https://picsum.photos/id/15/800/600",  // Waterfall
  "https://picsum.photos/id/16/800/600",  // Mountain lake
  "https://picsum.photos/id/17/800/600",  // Rocky beach
  "https://picsum.photos/id/18/800/600",  // Forest path
  "https://picsum.photos/id/19/800/600",  // Sunset field
  "https://picsum.photos/id/20/800/600",  // City skyline
  "https://picsum.photos/id/21/800/600",  // Modern bridge
  "https://picsum.photos/id/22/800/600",  // Old town street
  "https://picsum.photos/id/23/800/600",  // Skyscraper
  "https://picsum.photos/id/24/800/600",  // Train station
  "https://picsum.photos/id/25/800/600",  // City at night
  "https://picsum.photos/id/26/800/600" ];