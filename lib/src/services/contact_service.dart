import 'dart:math';

import 'package:ds_fluro_contact_list/src/constants/contact_constants.dart';
import 'package:ds_fluro_contact_list/src/models/contact.dart';

class ContactService {
  Future<List<Contact>> getContacts() async {
    try {
      await _shouldError("Can't get contact list.");
      return contactList;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Contact> getContactById(String id) async {
    try {
      await _shouldError("Cannot find contact with the ID of $id.");

      return contactList.firstWhere((Contact contact) => contact.id == id);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> _shouldError(String errorMessage) async {
    Random random = Random();
    final shouldError = random.nextBool();

    if (shouldError) {
      return await Future.delayed(
        Duration(seconds: 2),
        () => throw Exception(errorMessage),
      );
    }

    return Future.delayed(Duration(seconds: 2));
  }
}
