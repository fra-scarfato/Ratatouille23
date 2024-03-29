import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ratatouille23/models/Utente.dart';
import 'package:ratatouille23/services/Utente_service.dart';

import '../amplifyconfiguration.dart';

class Amplify_controller {

  Future<void> configureAmplify() async {

    // Add any Amplify plugins you want to use
    final authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugin(authPlugin);

    // You can use addPlugins if you are going to be adding multiple plugins
    // await Amplify.addPlugins([authPlugin, analyticsPlugin]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      safePrint("Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  Future<bool> signOutCurrentUser() async {
    final result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      await FirebaseAnalytics.instance.logEvent(name: "Logout di un utente");
      return true;
    } else if (result is CognitoFailedSignOut) {
      throw (result.toString());
    }
    return false;
  }

  Future<Utente> confermaUtenteConNuovaPassword(String email, String confirmationCode, String oldPassword, String newPassword) async {
    await confirmUser(username: email, confirmationCode: newPassword);
    var result = await signInUser(email, oldPassword);
    if (result.nextStep.signInStep == AuthSignInStep.done) {
      Utente utente = await fetchCurrentUserAttributes();
      return utente;
    } else {
      throw "Credenziali errate";
    }
  }

  Future<Utente> confermaUtente(String email, String confirmationCode, String oldPassword, String newPassword) async {
    await confirmUser(username: email, confirmationCode: confirmationCode);
    var result = await signInUser(email, oldPassword);
    if (result.nextStep.signInStep == AuthSignInStep.done) {
      await updatePassword(oldPassword: oldPassword, newPassword: newPassword);
      Utente utente = await fetchCurrentUserAttributes();
      return utente;
    } else {
      throw "Credenziali errate";
    }
  }

  Future<Utente> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      Utente_service utente_service = Utente_service();
      return await utente_service.getUtenteWithEmail(result[2].value);
    } on AuthException {
      rethrow;
    }
  }

  Future<bool> fetchAuthSession() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
      if(result.isSignedIn) {
        await FirebaseAnalytics.instance.logEvent(name: "Login di un utente");
      }
      return result.isSignedIn;
    } on AuthException {
      rethrow;
    }
  }

  Future<SignInResult> signInUser(String email, String password) async {
    SignInResult result;
    try {
      result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
      await FirebaseAnalytics.instance.logEvent(name: "Login di un utente");
    } catch (e) {
      rethrow;
    }
    return result;
  }

  Future<void> confirmUser({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      await FirebaseAnalytics.instance.logEvent(name: "Conferma email di un utente");
    } on AuthException {
      rethrow;
    }
  }

  Future<void> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      await Amplify.Auth.signUp(
        username: email,
        password: password,
      );
      await FirebaseAnalytics.instance.logEvent(name: "Registrazione di un nuovo utente");
    } on AuthException {
      rethrow;
    }
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await Amplify.Auth.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } on AuthException catch (e) {
      safePrint('Error updating password: ${e.message}');
    }
  }
}