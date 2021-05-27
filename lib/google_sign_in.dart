import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn;
GoogleSignInAccount _currentUser;

class SignInGoogle extends StatefulWidget {
  @override
  State createState() => _SignInGoogle();
}

class _SignInGoogle extends State<SignInGoogle> {
  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  initState() {
    super.initState();

    _googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'profile',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );

    _googleSignIn.onCurrentUserChanged.listen((user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  Widget getLoginWidget() {
    GoogleSignInAccount user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GoogleUserCircleAvatar(
            identity: user,
          ),
          Text(user.displayName ?? ''),
          Text(user.email),
          ElevatedButton(
              onPressed: () async {
                _googleSignIn.signOut();
                _handleSignOut();
              },
              child: Text("Sign Out"))
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                try {
                  await _googleSignIn.signIn();
                } on Exception catch (e) {
                  return AlertDialog(
                    title: Text('Unable to Sign In to Google'),
                    content: Text(e.toString()),
                    actions: <Widget>[
                      TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                      )
                    ],
                  );
                  print(e);
                }
              },
              child: Text("Google Sign In")),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: getLoginWidget(),
        ));
  }
}
