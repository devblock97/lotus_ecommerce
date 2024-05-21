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