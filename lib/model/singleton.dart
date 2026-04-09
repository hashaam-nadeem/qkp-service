import 'dart:io';
import 'dart:ui';

import 'package:attendance/model/usermodel.dart';


class User {
  // singleton
  static final User _singleton = User._internal();
  factory User() => _singleton;
  User._internal();
  static User get userData => _singleton;
  var token;
  var lat,long;
  File image;
  UserResult userResult;
  var productId;
}
