import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  Future<PermissionStatus> getpermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.limited;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact List"),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                final PermissionStatus permissionStatus = await getpermission();
                if (permissionStatus == PermissionStatus.granted) {
                  List<Contact> contacts = await FlutterContacts.getContacts();
                  contacts = await FlutterContacts.getContacts(
                      withProperties: true, withPhoto: true);
                  var contactname = contacts[0].displayName;
                  print(contactname.toString());
                }
              },
              child: Text("helo")),
        ));
  }
}
