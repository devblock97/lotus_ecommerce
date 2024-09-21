import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

String parseNonceFromHeader(Map<String, String> headers) {
  // Check for both possibilities (nonce and x-wc-store-api-nonce)
  if (headers.containsKey('nonce')) {
    return headers['nonce']!;
  } else if (headers.containsKey('x-wc-store-api-nonce')) {
    return headers['x-wc-store-api-nonce']!;
  } else {
    throw Exception('Nonce not found in headers');
  }
}

void showFeatureComingSoon(BuildContext context) {
  showTopSnackBar(Overlay.of(context), const CustomSnackBar.info(
    message: 'Coming soon', backgroundColor: Colors.orange,));
}