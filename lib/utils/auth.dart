import 'package:flashcards/repositories/auth_repository.dart';
import 'package:flashcards/screens/login.dart';

import '../router.dart';

Future<void> loginWithGoogle() async {
  try {
    var result = await googleSignIn.signIn();
    var googleKey = await result.authentication;
    await sendIdToken(googleKey.idToken);
  } on Exception {
    //TODO Add handler
  }
  navigatorKey.currentState.pushReplacementNamed(HomeViewRoute);
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
