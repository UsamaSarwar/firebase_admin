import 'package:firebase_admin/firebase_admin.dart';

/// Example demonstrating Firebase Admin usage on Flutter Web.
/// 
/// Note: On Flutter Web, file-based credentials are not supported.
/// You must provide service account credentials as a Map object.
void main() async {
  // Define your service account credentials as a Map
  // In a real app, you should load these from a secure source
  // and NEVER commit them to version control
  final serviceAccount = {
    'type': 'service_account',
    'project_id': 'your-project-id',
    'private_key_id': 'your-private-key-id',
    'private_key': '-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n',
    'client_email': 'your-service-account@your-project.iam.gserviceaccount.com',
    'client_id': 'your-client-id',
    'auth_uri': 'https://accounts.google.com/o/oauth2/auth',
    'token_uri': 'https://oauth2.googleapis.com/token',
    'auth_provider_x509_cert_url': 'https://www.googleapis.com/oauth2/v1/certs',
    'client_x509_cert_url': 'https://www.googleapis.com/robot/v1/metadata/x509/your-service-account%40your-project.iam.gserviceaccount.com',
  };

  // Initialize the Firebase Admin app with the service account Map
  var app = FirebaseAdmin.instance.initializeApp(AppOptions(
    credential: ServiceAccountCredential(serviceAccount),
    projectId: 'your-project-id',
  ));

  try {
    // Example: Get a user by email
    var user = await app.auth().getUserByEmail('user@example.com');
    print('User found: ${user.toJson()}');

    // Example: Generate a password reset link
    var link = await app.auth().generatePasswordResetLink(
      'user@example.com',
      ActionCodeSettings(url: 'https://example.com/reset-password'),
    );
    print('Password reset link: $link');

    // Example: List users
    var result = await app.auth().listUsers();
    print('Found ${result.users.length} users');
    for (var user in result.users) {
      print('- ${user.email}');
    }
  } on FirebaseException catch (e) {
    print('Firebase error: ${e.message}');
  } catch (e) {
    print('Error: $e');
  }
}
