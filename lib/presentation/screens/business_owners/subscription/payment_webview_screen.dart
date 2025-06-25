
import 'package:flutter/material.dart';
import 'package:pet_app/helper/dialog/show_custom_animated_dialog.dart';
import '../../../../core/route/route_path.dart';
import '../../../../core/route/routes.dart';
import '../../../components/custom_button/custom_button.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({super.key, required this.paymentUrl});
  final String paymentUrl;
  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  double _progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.paymentUrl)),
            onProgressChanged: (controller, progress) {
              setState(() {
                _progress = progress / 100;
              });
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final url = navigationAction.request.url.toString();
              bool isSuccess = url.contains('/success');
              bool isHttps = url.contains('https');
              if(isSuccess){
                showCustomAnimatedDialog(
                  context: context,
                  title: "Success",
                  subtitle:
                  "Your subscription plan has been changed successfully.",
                  animationSrc: "assets/animation/success.json",
                  // Path to your Lottie animation
                  isDismissible: true,
                  actionButton: [
                    CustomButton(
                      height: 36,
                      width: 100,
                      onTap: () {
                        AppRouter.route.goNamed(RoutePath.navigationPage);
                      },
                      title: "Confirm",
                      fontSize: 14,
                    ),
                  ],
                );
              }
              if(isHttps){
                return NavigationActionPolicy.ALLOW;
              }else{
                return NavigationActionPolicy.CANCEL;
              }
            },
            onLoadStop: (controller, url) {
              setState(() {
                _progress = 1.0;
              });
            },
          ),
          if (_progress < 1.0)
            Center(child: CircularProgressIndicator(value: _progress)),
        ],
      ),
    );
  }
}


