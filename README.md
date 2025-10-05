
[![Ceasefire Now](https://badge.techforpalestine.org/default)](https://techforpalestine.org/learn-more)


A pure Dart implementation of the Firebase admin sdk

Currently, only supports admin methods for the following firebase services:

* authentication
* realtime database

## Platform Support

This package supports all Flutter and Dart platforms:
- ✅ Flutter Mobile (iOS, Android)
- ✅ Flutter Desktop (Windows, macOS, Linux)
- ✅ Flutter Web
- ✅ Dart Server (VM)

### Flutter Web Limitations

When using this package on Flutter Web, please note:

* **File-based credentials are not supported** - You cannot use file paths to load service account credentials. Instead, provide credentials as a Map object.
* **Login functionality is not available** - The `Credentials.login()` method is not supported on web. Use service account credentials or other authentication methods.
* **Environment variables** - Access to environment variables may be limited depending on the web server configuration.

**Example for Flutter Web:**

```dart
import 'package:firebase_admin/firebase_admin.dart';

void main() async {
  // Instead of using a file path, provide the service account as a Map
  final serviceAccount = {
    'type': 'service_account',
    'project_id': 'your-project-id',
    'private_key_id': 'your-private-key-id',
    'private_key': 'your-private-key',
    'client_email': 'your-client-email',
    'client_id': 'your-client-id',
  };
  
  var app = FirebaseAdmin.instance.initializeApp(AppOptions(
    credential: ServiceAccountCredential(serviceAccount),
    projectId: 'your-project-id',
  ));

  // Use Firebase Admin features as usual
  var user = await app.auth().getUserByEmail('user@example.com');
  print(user.toJson());
}
```

> **⚠️ Security Warning for Web Applications:**
> 
> Firebase Admin SDK provides unrestricted access to your Firebase resources. Service account credentials should **NEVER** be embedded directly in client-side web applications as they would be exposed to end users. 
>
> For web applications, you should:
> - Use Firebase Client SDK instead of Admin SDK for user-facing operations
> - Only use Admin SDK on a secure backend server
> - If you must use Admin SDK features, proxy requests through your backend server
> - Never commit service account credentials to version control

## Example using service account

```dart
import 'package:firebase_admin/firebase_admin.dart';

main() async {
  var app = FirebaseAdmin.instance.initializeApp(AppOptions(
    credential: ServiceAccountCredential('service-account.json'),
  ));

  var link = await app.auth().generateSignInWithEmailLink('jane@doe.com',
      ActionCodeSettings(url: 'https://example.com'));

  print(link);
}
```
## Example using default credentials

```dart
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_admin/src/credential.dart';

void main() async {
  // applicationDefault() will look for credentials in the following locations:
  // * the env variable GOOGLE_APPLICATION_CREDENTIALS
  // * a configuration file, specific for this library, stored in the user's home directory
  // * gcloud's application default credentials
  // * credentials from the firebase tools
  var credential = Credentials.applicationDefault();

  // when no credentials found, login using openid
  // the credentials are stored on disk for later use
  credential ??= await Credentials.login();

  // create an app
  var app = FirebaseAdmin.instance.initializeApp(AppOptions(
      credential: credential ?? Credentials.applicationDefault(),
      projectId: 'some-project'));

  try {
    // get a user by email
    var v = await app.auth().getUserByEmail('jane@doe.com');
    print(v.toJson());
  } on FirebaseException catch (e) {
    print(e.message);
  }
}

```


## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/appsup-dart/firebase_admin/issues


## Sponsor

Creating and maintaining this package takes a lot of time. If you like the result, please consider to [:heart: sponsor](https://github.com/sponsors/rbellens). 
With your support, I will be able to further improve and support this project.
Also, check out my other dart packages at [pub.dev](https://pub.dev/packages?q=publisher%3Aappsup.be).



