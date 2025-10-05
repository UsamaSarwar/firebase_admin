# Flutter Web Platform Support

## Overview

This document describes the technical implementation of Flutter Web support in the `firebase_admin` package.

## Problem Statement

The original implementation used `dart:io` directly, which is not available on Flutter Web. This prevented the package from being used in web applications.

## Solution

We implemented conditional imports to provide platform-specific implementations:

### Conditional Import Pattern

Dart's conditional imports allow different implementations based on the platform:

```dart
export 'io_stub.dart'
    if (dart.library.io) 'io_io.dart';
```

This exports:
- `io_io.dart` on platforms that support `dart:io` (VM, mobile, desktop)
- `io_stub.dart` on platforms that don't support `dart:io` (web)

## Implementation Details

### 1. Universal IO Interface (`lib/src/utils/io.dart`)

**Files:**
- `lib/src/utils/io.dart` - Main export file with conditional logic
- `lib/src/utils/io_io.dart` - Re-exports dart:io classes for native platforms
- `lib/src/utils/io_stub.dart` - Stub implementations for web platform

**Key Classes:**
- `File` - File operations wrapper
- `Directory` - Directory operations wrapper  
- `Platform` - Platform detection wrapper

**Web Behavior:**
The stub implementations throw `UnsupportedError` with helpful messages directing users to use Map objects instead of file paths.

### 2. Universal OpenID Interface (`lib/src/utils/openid.dart`)

**Files:**
- `lib/src/utils/openid.dart` - Main export file with conditional logic
- `lib/src/utils/openid_io.dart` - Re-exports openid_client_io for native platforms
- `lib/src/utils/openid_stub.dart` - Stub implementations for web platform

**Key Classes:**
- `Issuer` - OAuth issuer
- `Client` - OAuth client
- `Authenticator` - Interactive authentication flow (requires native platform)

**Web Behavior:**
The stub implementations throw `UnsupportedError` since the interactive login flow requires opening a native browser window.

### 3. Updated Imports

All files that previously imported `dart:io` now import from our universal interfaces:

**Before:**
```dart
import 'dart:io';
```

**After:**
```dart
import 'package:firebase_admin/src/utils/io.dart';
```

**Files Updated:**
- `lib/src/admin.dart`
- `lib/src/credential.dart`
- `lib/src/app/app_extension.dart`
- `lib/src/auth/credential.dart`

## Usage on Flutter Web

### Supported

✅ **Service Account Authentication** - Using Map objects
```dart
final serviceAccount = {
  'type': 'service_account',
  'project_id': 'your-project-id',
  // ... other fields
};
var credential = ServiceAccountCredential(serviceAccount);
```

✅ **All Firebase Admin API calls** - Once authenticated
- User management (auth)
- Database operations
- Storage operations (if configured)

### Not Supported

❌ **File-based credentials** - Cannot read from file system
```dart
// This will throw UnsupportedError on web
var credential = ServiceAccountCredential('service-account.json');
```

❌ **Interactive login** - Requires native platform
```dart
// This will throw UnsupportedError on web
var credential = await Credentials.login();
```

❌ **File system operations** - For credentials or configuration

## Security Considerations

**⚠️ CRITICAL:** Service account credentials grant full admin access to Firebase resources.

### For Web Applications:

1. **Never embed credentials in client code** - They will be visible to all users
2. **Use Firebase Client SDK** - For user-facing features
3. **Proxy through backend** - If you need Admin SDK features, call them from your server
4. **Environment separation** - Never commit credentials to version control

### Recommended Architecture for Web:

```
Web App (Client) → Backend Server → Firebase Admin SDK
                         ↑
                   Service Account
                   (Secure Storage)
```

## Testing

The package includes:
- Example code for web usage (`example/web_example.dart`)
- Updated README with web-specific instructions
- Comprehensive documentation of limitations

## Compilation

The package can be compiled for all platforms:

```bash
# For web
flutter build web

# For mobile
flutter build apk
flutter build ios

# For desktop
flutter build windows
flutter build macos
flutter build linux
```

## Future Enhancements

Possible improvements:
1. Add web-specific credential providers (e.g., from localStorage with encryption)
2. Add browser-compatible environment variable access
3. Provide helper utilities for secure credential management in web apps
4. Add compile-time checks for web-incompatible code paths

## References

- [Dart Conditional Imports](https://dart.dev/guides/libraries/create-library-packages#conditionally-importing-and-exporting-library-files)
- [Flutter Web Documentation](https://flutter.dev/web)
- [Firebase Admin SDK](https://firebase.google.com/docs/admin/setup)
