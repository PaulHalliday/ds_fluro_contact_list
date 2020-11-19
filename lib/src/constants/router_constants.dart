import 'package:ds_fluro_contact_list/src/pages/contact_detail_page.dart';
import 'package:ds_fluro_contact_list/src/pages/contact_list_page.dart';
import 'package:ds_fluro_contact_list/src/pages/home_page.dart';
import 'package:ds_fluro_contact_list/src/pages/route_not_found_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static final routeNotFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    debugPrint("Route not found.");

    return RouteNotFoundPage();
  });

  static final rootRoute = AppRoute(
    '/',
    Handler(
      handlerFunc: (context, parameters) => HomePage(),
    ),
  );

  static final contactListRoute = AppRoute(
    '/contacts',
    Handler(
      handlerFunc: (context, parameters) => ContactListPage(),
    ),
  );

  static final contactDetailRoute = AppRoute(
    '/contacts/:id',
    Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      final String contactId = params["id"][0];

      return ContactDetailPage(contactId);
    }),
  );

  /// Primitive function to get one param detail route (i.e. id).
  static String getDetailRoute(String parentRoute, String id) {
    return "$parentRoute/$id";
  }

  static final List<AppRoute> routes = [
    rootRoute,
    contactListRoute,
    contactDetailRoute,
  ];
}
