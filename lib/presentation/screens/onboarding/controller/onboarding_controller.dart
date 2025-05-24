import 'package:get/get.dart';
import 'package:pet_app/presentation/screens/onboarding/model/onboarding_model.dart';

class OnboardingController extends GetxController {
  RxInt currentIndex = 0.obs;

  final List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image:"assets/images/splashlogo.png",
      title:"Hey! Welcome",
      details:  "Where every pet’s journey begins.",
    ),

    OnboardingModel(
      image: "assets/images/getstartedone.png",
      title: "Keep now !",
      details: "Find vets, groomers, pet shops, hotels & pet-friendly spots near you. Book services in just a few taps — quick, easy, and stress-free.",
    ),

    OnboardingModel(
      image: "assets/images/getstartedtwo.png",
      title: "We provide",
      details:  "Track health Stay organized",
    ),
  ];
}
