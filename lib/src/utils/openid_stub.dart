/// Stub implementation for OpenID client operations on unsupported platforms.

class Issuer {
  static Issuer get google => throw UnsupportedError(
    'Login functionality is not supported on this platform. '
    'Please use service account credentials instead.'
  );
  
  static Future<Issuer> discover(Issuer issuer) {
    throw UnsupportedError(
      'Login functionality is not supported on this platform. '
      'Please use service account credentials instead.'
    );
  }
}

class Client {
  Client(dynamic issuer, String clientId, {String? clientSecret}) {
    throw UnsupportedError(
      'Login functionality is not supported on this platform. '
      'Please use service account credentials instead.'
    );
  }
  
  String get clientId => throw UnsupportedError(
    'Login functionality is not supported on this platform.'
  );
  
  String? get clientSecret => throw UnsupportedError(
    'Login functionality is not supported on this platform.'
  );
}

class Authenticator {
  Authenticator(Client client, {List<String>? scopes, int? port}) {
    throw UnsupportedError(
      'Login functionality is not supported on this platform. '
      'Please use service account credentials instead.'
    );
  }
  
  dynamic get flow => throw UnsupportedError(
    'Login functionality is not supported on this platform.'
  );
  
  Future<dynamic> authorize() {
    throw UnsupportedError(
      'Login functionality is not supported on this platform. '
      'Please use service account credentials instead.'
    );
  }
}
