import 'package:flashcards/repositories/auth_repository.dart';
import 'package:flashcards/screens/login.dart';

import '../router.dart';

Future<void> loginWithGoogle() async {
  try {
    var result = await googleSignIn.signIn();
    var googleKey = await result?.authentication;
    await sendIdToken(googleKey?.idToken);
    navigatorKey.currentState.pushReplacementNamed(HomeViewRoute);
  } on Exception {
    //TODO Add handler
  }
}

Future<void> signInSilently() async {
  try {
    var result = await googleSignIn.signInSilently();
    var googleKey = await result?.authentication;
    await sendIdToken(googleKey?.idToken);
  } on Exception {
    loginWithGoogle();
  }
}
