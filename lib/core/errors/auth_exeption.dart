class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;

  static String handleFirebaseAuthError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already in use. Please use another one.';
      case 'invalid-email':
        return 'Invalid email format. Please check your email.';
      case 'weak-password':
        return 'Password is too weak. Please use a stronger password.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Wrong password. Please try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
