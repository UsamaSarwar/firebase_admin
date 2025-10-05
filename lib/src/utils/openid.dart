/// Universal OpenID client interface that works across all platforms.
/// 
/// On platforms that support dart:io (mobile, desktop, server), this exports
/// the real OpenID client classes for authentication flows.
/// 
/// On web platforms, this provides stub implementations that throw helpful
/// errors directing users to use service account credentials instead.
export 'openid_stub.dart'
    if (dart.library.io) 'openid_io.dart';
