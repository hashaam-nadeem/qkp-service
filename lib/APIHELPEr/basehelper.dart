import 'dart:io';

import 'package:attendance/APIHELPEr/API.dart';
import 'package:attendance/model/rostermodel.dart';
import 'package:attendance/model/singleton.dart';
import 'package:attendance/screens/homepage.dart';
import 'package:attendance/screens/login.dart';
import 'package:attendance/utils/const.dart';
import 'package:attendance/utils/route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseHelper {
  chooseImage(bool selectImage) async {
    File _image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: selectImage == true ? ImageSource.gallery : ImageSource.camera,
        maxHeight: 400,
        maxWidth: 400);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print(_image);
      return _image;
    } else {
      return null;
      print('No image selected.');
    }
    //                     .then((value) {
    //   print(value.path);
    //   if (value != null) {
    //     return value;
    //   } else {
    //     return null;
    //   }
    // });
    //print('Image file from gallery is $file ');
  }

  Future<dynamic> getPlaceDetailFromId(
    String placeId,
  ) async {
    const kGoogleApiKey = "AIzaSyDruBo_2bXpTSTl7cb71GCqHueSV2jX30g";
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$kGoogleApiKey';
    final response = await http.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // final components =
        //     result['result']['address_components'] as List<dynamic>;
        print(result);
        final locationOf =
            result['result']['geometry']['location'] as Map<String, dynamic>;
        print(locationOf);
        // final double lang = result['result']['geometry']['location']['lng'];
        // locationOf.contains('location');

        // int lang = location['lng'];
        // print(lang);
        // build result
        // final place = PlaceSearch();
        // place.lat = ;
        // place.lng = locationOf['lng'];
        LatLng location = LatLng(locationOf['lat'], locationOf['lng']);
        return location;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<dynamic> uploadImage(image, lat, long, place, context) async {
    var header = {
      'Access-Control-Allow-Origin': "*",
      "Connection": "keep-alive",
      "Accept-Encoding": "gzip, deflate, br",
      "Accept": "*/*",
      "Accept": "application/json",
      // "Authorization": "Bearer ${User.userData.token}",
    };
    print(header);
    var url = "${API.API_URL}${API.uploadImage}";
    print("$url");

    try {
      // print(User.userData.video);
      String fileName = image.path.split('/').last;

      print("File Name = $fileName");

      EasyLoading.show();
      // print("${User.userData.token}");
      FormData data = FormData.fromMap({
        "lat": "0.0",
        "long": "0.0",
        "place": "$place",
        "file": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });
      url = "${API.API_URL}${API.uploadImage}";
      print(url);
      print("dataaaaa: ${data.fields}");
      print("files: ${data.files[0].value.filename}");
      Dio dio = new Dio();
      EasyLoading.show();
      dio.options.headers["Authorization"] = "Bearer ${User.userData.token}";
      dio.options.headers["Accept"] = "application/json";
      dio.options.headers["Connection"] = "keep-alive";
      dio.options.headers["Accept-Encoding"] = "gzip, deflate, br";
      dio.options.headers["Access-Control-Allow-Origin"] = "*";

      dio.post("$url", data: data).then((response) {
        print("DSadsafsadasfdsa" + response.toString());
        Response res = response;
        EasyLoading.dismiss();
        if (res.statusCode == 200) {
          EasyLoading.dismiss();
          if (res.data['code'] == 400) {
            showAlertDialog(context, "${res.data['message']}");
          } else {
            // AppRoutes.makeFirst(context, MainScreen());
            showAlertDialog(context, "Successfully Posted");
            AppRoutes.makeFirst(context, HomePage());
            // showCustomAlertDialog(context, "Successfully Posted");
          }
          // showCustomAlertDialog(context, "${res.data['message']}");
          // AppRoutes.makeFirst(context, MainScreen());
        } else {
          EasyLoading.dismiss();
          showAlertDialog(context, "Something went Wrong");
        }
        // print("body: $body");
        // print("header $header");
        // EasyLoading.show();
      }).catchError((error) {
        EasyLoading.dismiss();
        showAlertDialog(context, "${error.response}");
      });
    } on SocketException {
      EasyLoading.dismiss();
      // constValues().toast("${getTranslated(context, "no_internet")}", context);
      // EasyLoading.dismiss();
      showAlertDialog(context, "No Internet Connection");
      return null;
      print('No Internet connection 😑');
    } on HttpException catch (error) {
      EasyLoading.dismiss();
      print(error);
      showAlertDialog(context, "$error");
      // constValues().toast("$error", context);
      // EasyLoading.dismiss();
      print("Couldn't find the post 😱");
      return null;
    } on FormatException catch (error) {
      EasyLoading.dismiss();
      print(error);
      showAlertDialog(context, "$error");
      // constValues().toast("$error", context);
      // EasyLoading.dismiss();
      print("Bad response format 👎");
      return null;
    } catch (value) {
      EasyLoading.dismiss();
      showAlertDialog(context, "$value");
      // constValues().toast("$value", context);
      // EasyLoading.dismiss();
      print(value);
      return null;
    }
  }

  Future<dynamic> login(email, password, context) async {
    var header = {
      'Access-Control-Allow-Origin': "*",
      "Connection": "keep-alive",
      "Accept-Encoding": "gzip, deflate, br",
      "Accept": "*/*",
      "Accept": "application/json",
      // "Authorization": "Bearer ${User.userData.token}",
    };
    var url = "${API.API_URL}${API.login}";
    print("$url");

    try {
      var body = {"email": "$email", "password": "$password"};
      print("body: $body");
      print("header $header");
      EasyLoading.show();
      final response = await http.post(url, headers: header, body: body);
      var Json = json.decode(response.body);
      print("sign up response:$Json");
      print("Status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("response status code: ${response.statusCode}");

        print(json.decode(response.body));
        // constValues().toast("${Json['message']}", context);
        EasyLoading.dismiss();
        return Json;
      } else if (response.statusCode == 422) {
        EasyLoading.dismiss();
        showAlertDialog(context, "${Json['message']}");
        // constValues()
        //     .toast("${getTranslated(context, "maintainance")}", context);
      } else {
        EasyLoading.dismiss();
        showAlertDialog(context, "${Json['message']}");
        // constValues().toast("${Json['message']}", context);
      }
    } on SocketException {
      // constValues().toast("${getTranslated(context, "no_internet")}", context);
      EasyLoading.dismiss();
      showAlertDialog(context, "No Internet Connection");
      print('No Internet connection 😑');
    } on HttpException catch (error) {
      print(error);
      showAlertDialog(context, "$error");
      // constValues().toast("$error", context);
      EasyLoading.dismiss();
      print("Couldn't find the post 😱");
    } on FormatException catch (error) {
      print(error);
      showAlertDialog(context, "$error");
      // constValues().toast("$error", context);
      EasyLoading.dismiss();
      print("Bad response format 👎");
    } catch (value) {
      showAlertDialog(context, "$value");
      // constValues().toast("$value", context);
      EasyLoading.dismiss();
      print(value);
    }
  }
  Future<dynamic> registerUser(name,email, password, context) async {
    var header = {
      'Access-Control-Allow-Origin': "*",
      "Connection": "keep-alive",
      "Accept-Encoding": "gzip, deflate, br",
      "Accept": "*/*",
      "Accept": "application/json",
      // "Authorization": "Bearer ${User.userData.token}",
    };
    var url = "${API.API_URL}${API.register}";
    print("$url");

    try {
      var body = {"email": "$email",
      "name":"$name",
       "password": "$password"};
      print("body: $body");
      print("header $header");
      EasyLoading.show();
      final response = await http.post(url, headers: header, body: body);
      var Json = json.decode(response.body);
      print("sign up response:$Json");
      print("Status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("response status code: ${response.statusCode}");

        print(json.decode(response.body));
        // constValues().toast("${Json['message']}", context);
        EasyLoading.dismiss();
        return Json;
      } else if (response.statusCode == 422) {
        EasyLoading.dismiss();
        showAlertDialog(context, "${Json['message']}");
        // constValues()
        //     .toast("${getTranslated(context, "maintainance")}", context);
      } 
      
      else {
        EasyLoading.dismiss();
        showAlertDialog(context, "${Json['message']}");
        // constValues().toast("${Json['message']}", context);
      }
    } on SocketException {
      // constValues().toast("${getTranslated(context, "no_internet")}", context);
      EasyLoading.dismiss();
      showAlertDialog(context, "No Internet Connection");
      print('No Internet connection 😑');
    } on HttpException catch (error) {
      print(error);
      showAlertDialog(context, "$error");
      // constValues().toast("$error", context);
      EasyLoading.dismiss();
      print("Couldn't find the post 😱");
    } on FormatException catch (error) {
      print(error);
      showAlertDialog(context, "$error");
      // constValues().toast("$error", context);
      EasyLoading.dismiss();
      print("Bad response format 👎");
    } catch (value) {
      showAlertDialog(context, "$value");
      // constValues().toast("$value", context);
      EasyLoading.dismiss();
      print(value);
    }
  }

  Future<dynamic> getProfile(email, password, context) async {
    var header = {
      'Access-Control-Allow-Origin': "*",
      "Connection": "keep-alive",
      "Accept-Encoding": "gzip, deflate, br",
      "Accept": "*/*",
      "Accept": "application/json",
      // "Authorization": "Bearer ${User.userData.token}",
    };
    var url = "${API.API_URL}${API.login}";
    print("$url");

    try {
      var body = {"email": "$email", "password": "$password"};
      print("body: $body");
      print("header $header");
      // EasyLoading.show();
      final response = await http.post(url, headers: header, body: body);
      var Json = json.decode(response.body);
      print("sign up response:$Json");
      print("Status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("response status code: ${response.statusCode}");

        print(json.decode(response.body));
        // constValues().toast("${Json['message']}", context);
        // EasyLoading.dismiss();
        return Json;
      } else if (response.statusCode == 422) {
        AppRoutes.makeFirst(context, LoginScreen());
        // EasyLoading.dismiss();
        // showAlertDialog(context, "${Json['message']}");
        // constValues()
        //     .toast("${getTranslated(context, "maintainance")}", context);
      } else {
        AppRoutes.makeFirst(context, LoginScreen());
        // EasyLoading.dismiss();
        // showAlertDialog(context, "${Json['message']}");
        // constValues().toast("${Json['message']}", context);
      }
    } on SocketException {
      // constValues().toast("${getTranslated(context, "no_internet")}", context);
      EasyLoading.dismiss();
      showAlertDialog(context, "No Internet Connection");
      AppRoutes.makeFirst(context, LoginScreen());
      print('No Internet connection 😑');
    } on HttpException catch (error) {
      print(error);
      // showAlertDialog(context, "$error");
      // constValues().toast("$error", context);
      // EasyLoading.dismiss();
      AppRoutes.makeFirst(context, LoginScreen());
      print("Couldn't find the post 😱");
    } on FormatException catch (error) {
      print(error);
      // showAlertDialog(context, "$error");
      // constValues().toast("$error", context);
      AppRoutes.makeFirst(context, LoginScreen());
      // EasyLoading.dismiss();
      print("Bad response format 👎");
    } catch (value) {
      // showAlertDialog(context, "$value");
      // constValues().toast("$value", context);
      // EasyLoading.dismiss();
      AppRoutes.makeFirst(context, LoginScreen());
      print(value);
    }
  }

  Future<dynamic> checkinOut(lat, long, place, context) async {
    var header = {
      'Access-Control-Allow-Origin': "*",
      "Connection": "keep-alive",
      "Accept-Encoding": "gzip, deflate, br",
      "Accept": "*/*",
      "Accept": "application/json",
      "Authorization": "Bearer ${User.userData.token}",
    };
    var url = "${API.API_URL}${API.checkIn}";
    print("$url");

    try {
      var body = {"lat": "0.0", "long": "0.0", "place": "$place"};
      print("body: $body");
      print("header $header");
      EasyLoading.show();
      final response = await http.post(url, headers: header, body: body);
      var Json = json.decode(response.body);
      print("sign up response:$Json");
      print("Status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("response status code: ${response.statusCode}");

        print(json.decode(response.body));
        // constValues().toast("${Json['message']}", context);
        EasyLoading.dismiss();
        return Json;
      } else if (response.statusCode == 422) {
        EasyLoading.dismiss();
        showAlertDialog(context, "${Json['message']}");
        // constValues()
        //     .toast("${getTranslated(context, "maintainance")}", context);
      } else {
        EasyLoading.dismiss();
        showAlertDialog(context, "${Json['message']}");
        // constValues().toast("${Json['message']}", context);
      }
    } on SocketException {
      // constValues().toast("${getTranslated(context, "no_internet")}", context);
      EasyLoading.dismiss();
      showAlertDialog(context, "No Internet Connection");
      print('No Internet connection 😑');
    } on HttpException catch (error) {
      print(error);
      showAlertDialog(context, "$error");
      // constValues().toast("$error", context);
      EasyLoading.dismiss();
      print("Couldn't find the post 😱");
    } on FormatException catch (error) {
      print(error);
      showAlertDialog(context, "$error");
      // constValues().toast("$error", context);
      EasyLoading.dismiss();
      print("Bad response format 👎");
    } catch (value) {
      showAlertDialog(context, "$value");
      // constValues().toast("$value", context);
      EasyLoading.dismiss();
      print(value);
    }
  }
  Future<RosterModel> getSchdule(context, ValueNotifier notifier,var page) async {
    var header = {
      'Access-Control-Allow-Origin': "*",
      "Connection": "keep-alive",
      "Accept-Encoding": "gzip, deflate, br",
      "Accept": "*/*",
      "Accept": "application/json",
      "Authorization": "Bearer ${User.userData.token}",
    };
    var url = "${API.API_URL}${API.roster}?page=$page";
    print("$url");

    try {
      var body ;
      // {"lat": "$lat", "long": "$long", "place": "$place"};
      print("body: $body");
      print("header $header");
      // EasyLoading.show();
      final response = await http.get(url, headers: header);
      var Json = json.decode(response.body);
      print("sign up response:$Json");
      print("Status code: ${response.statusCode}");
      RosterModel rosterModel=RosterModel();
      
      if (response.statusCode == 200) {
        print("response status code: ${response.statusCode}");
        rosterModel=RosterModel.fromJson(Json['data']);
        // for(int i=0;i<rosterModel.result.length;i++)
        // {
        //   rosterModel.result.add(rosterModel.result[i]);
        // }
        notifier.value=rosterModel;
        return rosterModel;
        print(json.decode(response.body));
        // constValues().toast("${Json['message']}", context);
        // EasyLoading.dismiss();
        // return Json;
      } else if (response.statusCode == 422) {
        EasyLoading.dismiss();
        showAlertDialog(context, "${Json['message']}");
         return rosterModel;
        // constValues()
        //     .toast("${getTranslated(context, "maintainance")}", context);
      } else {
        
        // EasyLoading.dismiss();
        showAlertDialog(context, "${Json['message']}");
         return rosterModel;
        // constValues().toast("${Json['message']}", context);
      }
    } on SocketException {
      // constValues().toast("${getTranslated(context, "no_internet")}", context);
      EasyLoading.dismiss();
      showAlertDialog(context, "No Internet Connection");
      
      print('No Internet connection 😑');
    } on HttpException catch (error) {
      print(error);
      showAlertDialog(context, "$error");
      // constValues().toast("$error", context);
      EasyLoading.dismiss();
      print("Couldn't find the post 😱");
    } on FormatException catch (error) {
      print(error);
      showAlertDialog(context, "$error");
      // constValues().toast("$error", context);
      EasyLoading.dismiss();
      print("Bad response format 👎");
    } catch (value) {
      showAlertDialog(context, "$value");
      // constValues().toast("$value", context);
      EasyLoading.dismiss();
      print(value);
    }
  }

}
