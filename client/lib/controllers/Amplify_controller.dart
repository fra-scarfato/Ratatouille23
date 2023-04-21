import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

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
      return true;
    } else if (result is CognitoFailedSignOut) {
      throw (result.toString());
    }
    return false;
  }

  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
      }
    } on AuthException catch (e) {
      safePrint('Error fetching user attributes: ${e.message}');
    }
  }

  Future<bool> fetchAuthSession() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
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
    } catch (e) {
      rethrow;
    }
    return result;
  }

  Future<void> resetPassword(String nuovaPassword) async {
    try {
      await Amplify.Auth.confirmSignIn(
        confirmationValue: nuovaPassword,
      );
    }catch (e) {
      rethrow;
    }
  }
}