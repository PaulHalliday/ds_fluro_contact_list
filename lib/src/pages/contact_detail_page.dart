import 'package:ds_fluro_contact_list/src/constants/router_constants.dart';
import 'package:ds_fluro_contact_list/src/models/app_router.dart';

import 'package:ds_fluro_contact_list/src/models/contact.dart';

import 'package:ds_fluro_contact_list/src/services/contact_service.dart';

import 'package:flutter/material.dart';

class ContactDetailPage extends StatefulWidget {
  static Route<ContactDetailPage> route(String contactId) =>
      MaterialPageRoute(builder: (context) => ContactDetailPage(contactId));

  final String _contactId;
  const ContactDetailPage(String contactId) : _contactId = contactId;

  @override
  _ContactDetailPageState createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  final ContactService _contactService = ContactService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Detail"),
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () => AppRouter.router.pop(context),
              )
            : IconButton(
                icon: Icon(Icons.home),
                onPressed: () => AppRouter.router.navigateTo(
                  context,
                  AppRoutes.contactListRoute.route,
                  replace: true,
                  clearStack: true,
                ),
              ),
      ),
      body: FutureBuilder(
        future: _contactService.getContactById(widget._contactId),
        builder: (BuildContext context, AsyncSnapshot<Contact> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.error),
                  TextButton(
                    onPressed: _refreshList,
                    child: const Text("Try Again"),
                  )
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            final _contact = snapshot.data;
            return ListTile(
              title: Text(_contact.name),
              subtitle: Text(_contact.id),
            );
          }

          return Center(
            child: const Text("Couldn't find contact."),
          );
        },
      ),
    );
  }

  Future<void> _refreshList() async {
    print("Reloading...");
    setState(() {});
  }
}
