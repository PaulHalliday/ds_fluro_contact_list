import 'package:flutter/foundation.dart';

@immutable
class Contact {
  final String id;
  final String name;

  const Contact({
    @required this.id,
    @required this.name,
  });
}
