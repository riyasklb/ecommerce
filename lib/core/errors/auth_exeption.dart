class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  factory AuthException.fromCode(String code) {
    switch (code) {
      case 'user-not-found':
        return AuthException('No user found for that email.');
      case 'wrong-password':
        return AuthException('Incorrect password.');
      case 'email-already-in-use':
        return AuthException('Email is already in use.');
      case 'weak-password':
        return AuthException('Password is too weak.');
      default:
        return AuthException('Authentication error occurred.');
    }
  }
}
