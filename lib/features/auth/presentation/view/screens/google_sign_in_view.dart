import 'package:edupals/config/flavor_config.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class GoogleSignInView extends StatelessWidget {
  const GoogleSignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Google Sign In')),
      body: InAppWebView(
        initialUrlRequest:
            URLRequest(url: WebUri(mainController.googleLoginUrl)),
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          useShouldOverrideUrlLoading: true,
          userAgent: 'edupals',
          allowsInlineMediaPlayback: true,
          allowsBackForwardNavigationGestures: true,
          automaticallyAdjustsScrollIndicatorInsets: true,
          contentInsetAdjustmentBehavior:
              ScrollViewContentInsetAdjustmentBehavior.ALWAYS,
        ),
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          var uri = navigationAction.request.url;
          if (uri.toString().startsWith(FlavorConfig.websiteUrl)) {
            if (uri.toString().startsWith(FlavorConfig.replaceUrl)) {
              String temp =
                  uri.toString().replaceAll(FlavorConfig.replaceUrl, '');
              temp = temp.substring(0, temp.indexOf('&'));
              Navigator.pop(context, temp);
            } else {
              Navigator.pop(context);
            }
            return NavigationActionPolicy.CANCEL;
          }
          return NavigationActionPolicy.ALLOW;
        },
        onReceivedServerTrustAuthRequest: (controller, challenge) async {
          return ServerTrustAuthResponse(
            action: ServerTrustAuthResponseAction.PROCEED,
          );
        },
      ),
    );
  }
}
