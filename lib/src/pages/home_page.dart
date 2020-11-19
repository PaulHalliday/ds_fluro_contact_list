import 'package:ds_fluro_contact_list/src/constants/router_constants.dart';
import 'package:ds_fluro_contact_list/src/models/app_router.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Home Page",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "Fluro routing examples",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              // onPressed: () => Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => ContactListPage(),
              //   ),
              // ),
              onPressed: () => AppRouter.router.navigateTo(
                context,
                AppRoutes.contactListRoute.route,
              ),
              child: const Text("Contact List"),
            )
          ],
        ),
      ),
    );
  }
}
