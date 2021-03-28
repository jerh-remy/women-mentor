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

  Future<RankedMentorsResponse> getRankedMentors(String userId) async {
    final response = await client.post(
      Uri.parse("$_baseURL/rankedMentors"),
      headers: {"x-user-id": userId},
    );

    print(response.body.toString());
    if (response.statusCode == 200) {
      RankedMentorsResponse rankedMentorsResponse =
          rankedMentorsResponseFromJson(response.body);
      return rankedMentorsResponse;
    } else {
      throw PlatformException(
        code: response.statusCode.toString(),
        message: response.body,
      );
    }
  }

  Future<BookingResponse> postBookingRequest(Booking booking) async {
    booking.toJson().forEach((key, value) => print('$key: $value'));

    final response = await client.post(
      Uri.parse("$_baseURL/bookings"),
      body: booking.toJson(),
      headers: {"x-user-id": booking.requesterId},
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

  Future<BookingResponse> updateBookingRequest(Booking booking) async {
    booking.toJson().forEach((key, value) => print('$key: $value'));

    final response = await client.patch(
      Uri.parse("$_baseURL/bookings"),
      body: booking.toJson(),
      headers: {"x-user-id": booking.requesterId},
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
