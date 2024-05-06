import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class DjangoServices {
  final String domain = "http://192.168.137.34:8000";
  login(Function(String message, int statusCode, dynamic data) callback,
      String username, String password) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request('POST', Uri.parse('$domain/salons/login/'));
      request.body = json
          .encode({"username": username, "password": password, "type": "in"});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());
        callback(responseBody['message'], responseBody['status'],
            responseBody['data']);
      } else {
        callback(response.reasonPhrase, 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  register(
      Function(String message, int statusCode, dynamic data) callback,
      String name,
      String email,
      String phoneNumber,
      String address,
      String password,
      bool hasSaloon) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request;
      if (hasSaloon) {
        request = http.Request('POST', Uri.parse('$domain/salons/owner/'));
        request.body = json.encode({
          "user": {
            "username": email,
            "email": email,
            "is_active": false,
            "type": "owner",
            "password": password
          },
          "name": name,
          "phone": phoneNumber
        });
        request.headers.addAll(headers);
      } else {
        request = http.Request('POST', Uri.parse('$domain/salons/customer/'));
        request.body = json.encode({
          "user": {
            "username": email,
            "email": email,
            "is_active": true,
            "type": "customer",
            "password": password
          },
          "name": name,
          "phone": phoneNumber
        });
        request.headers.addAll(headers);
      }

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());
        callback("success",200,
            responseBody['user']);
      } else {
        callback(response.reasonPhrase, 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }
}
