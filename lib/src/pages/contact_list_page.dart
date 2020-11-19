import 'package:ds_fluro_contact_list/src/constants/router_constants.dart';
import 'package:ds_fluro_contact_list/src/models/app_router.dart';
import 'package:ds_fluro_contact_list/src/models/contact.dart';

import 'package:ds_fluro_contact_list/src/services/contact_service.dart';

import 'package:flutter/material.dart';

class ContactListPage extends StatefulWidget {
  static Route<ContactListPage> route() =>
      MaterialPageRoute(builder: (context) => ContactListPage());

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final ContactService _contactService = ContactService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
      ),
      body: FutureBuilder(
        future: _contactService.getContacts(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
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
            final _contactList = snapshot.data;
            return RefreshIndicator(
              onRefresh: _refreshList,
              child: ListView.builder(
                itemCount: _contactList.length,
                itemBuilder: (BuildContext context, int index) {
                  final _contact = _contactList[index];

                  return ListTile(
                    title: Text(_contact.name),
                    subtitle: Text(_contact.id),
                    onTap: () => AppRouter.router.navigateTo(
                      context,
                      AppRoutes.getDetailRoute(
                          AppRoutes.contactListRoute.route, _contact.id),
                    ),
                  );
                },
              ),
            );
          }

          return Center(
            child: const Text("No Contacts Found"),
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
