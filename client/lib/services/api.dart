import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:women_mentor/constants/strings.dart';
import 'package:women_mentor/models/booking.dart';
import 'package:women_mentor/models/booking_response.dart';
import 'package:women_mentor/models/ranked_mentors_response.dart';

class ApiProvider {
  Client client = Client();
  final _baseURL = Strings.baseURL;

  Future<List<RankedMentor>> getRankedMentors(String userId) async {
    print('userid: ' + userId);
    final response = await client.get(
      Uri.parse("$_baseURL/rankedmentors"),
      headers: {"x-user-id": userId},
    );

    print(response.statusCode);

    print(response.body.toString());
    if (response.statusCode == 200) {
      RankedMentorsResponse rankedMentorsResponse =
          rankedMentorsResponseFromJson(response.body);
      return rankedMentorsResponse.data;
    } else {
      throw PlatformException(
        code: response.statusCode.toString(),
        message: response.body,
      );
    }
  }

  Future<BookingResponse> postBookingRequest(
      {required Booking booking, required String userID}) async {
    booking.toJson().forEach((key, value) => print('$key: $value'));
    print('#####');
    // print(booking.toJson());
    print(json.encode(booking.toJson()));

    final response = await client.post(
      Uri.parse("$_baseURL/bookings"),
      body: json.encode(booking),
      headers: {"x-user-id": userID, "Content-Type": "application/json"},
    );

    print(response.body.toString());
    if (response.statusCode == 200) {
      BookingResponse bookingResponse = bookingResponseFromJson(response.body);
      return bookingResponse;
    } else {
      throw PlatformException(
        code: response.statusCode.toString(),
        message: response.body,
      );
    }
  }

  Future<BookingResponse> updateBookingRequest(
      {required Booking booking, required String userID}) async {
    booking.toJson().forEach((key, value) => print('$key: $value'));

    final response = await client.patch(
      Uri.parse("$_baseURL/bookings"),
      body: booking.toJson(),
      headers: {"x-user-id": userID},
    );

    print(response.body.toString());
    if (response.statusCode == 200) {
      BookingResponse bookingResponse = bookingResponseFromJson(response.body);
      return bookingResponse;
    } else {
      throw PlatformException(
        code: response.statusCode.toString(),
        message: response.body,
      );
    }
  }
}
