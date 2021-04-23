import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

// https://pub.dev/packages/settings_ui
// Settings template

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {


 // bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SettingsList(
        sections: [
          SettingsSection(
            subtitle: Center(
                child: Text(
                  'Settings',
                )),
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'Svenska',
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Change Email',
                leading: Icon(Icons.mail),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Change Password',
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

