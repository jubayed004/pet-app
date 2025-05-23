import 'package:get/get.dart';
import 'package:pet_app/presentation/screens/onboarding/model/onboarding_model.dart';

class OnboardingController extends GetxController {
  RxInt currentIndex = 0.obs;

  final List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image:"assets/icons/onb1.svg",
      title:"Welcome to Bet Wise Easy Money Picks!",
      details:  "Your journey to smarter sports betting starts here. Follow top cappers, get winning tips, and stay ahead!",
    ),

    OnboardingModel(
      image: "assets/icons/onb2.svg",
      title: "Follow Trusted Cappers",
      details: "Subscribe to expert bettors, access their premium picks, and increase your winning chances!",
    ),

    OnboardingModel(
      image: "assets/icons/onb3.svg",
      title: "Get Real-Time Winning Tips",
      details:  "Stay notified with instant betting predictions, updates, and game-day insights, wherever you are.",
    ),
  ];
}
