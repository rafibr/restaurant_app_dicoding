import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:restaurant_app/data/endpoint.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/repository/provider/detail_provider.dart';

class RestaurantRepo {
  final Dio _dio = Dio();

  // get list restaurant
  Future<Restaurant> getListRestaurant() async {
    _dio.interceptors.add(dioLoggerInterceptor);

    try {
      Response response = await _dio.get(Endpoint.list);
      log('response: ${response.data}');
      return Restaurant.fromJson(response.data);
    } on DioError catch (e) {
      log('error: ${e.response}');
      return Restaurant.fromJson(e.response!.data);
    }
  }

  // get image restaurant
  Future<String> getImageRestaurant(String id) async {
    _dio.interceptors.add(dioLoggerInterceptor);

    try {
      Response response = await _dio.get(Endpoint.imageMedium + id);
      log('response: ${response.data}');
      return response.data;
    } on DioError catch (e) {
      log('error: ${e.response}');
      return e.response!.data;
    }
  }

  // search restaurant
  Future<Restaurant> searchRestaurant(String query) async {
    _dio.interceptors.add(dioLoggerInterceptor);

    try {
      Response response = await _dio.get(Endpoint.search + query);
      log('response: ${response.data}');
      return Restaurant.fromJson(response.data);
    } on DioError catch (e) {
      log('error: ${e.response}');
      return Restaurant.fromJson(e.response!.data);
    }
  }

  // get detail restaurant
  Future<RestaurantDetail> getDetailRestaurant(String id) async {
    _dio.interceptors.add(dioLoggerInterceptor);

    try {
      Response response = await _dio.get(Endpoint.detail + id);
      log('response: ${response.data}');
      return RestaurantDetail.fromJson(response.data['restaurant']);
    } on DioError catch (e) {
      log('error: ${e.response}');
      return RestaurantDetail.fromJson(e.response!.data['restaurant']);
    }
  }

  Future<dynamic> addReview(DetailProvider provider) async {
    _dio.interceptors.add(dioLoggerInterceptor);

    try {
      Response response = await _dio.post(Endpoint.addReview, data: {
        'id': provider.restaurantDetail!.id,
        'name': provider.nameController.text,
        'review': provider.reviewController.text,
      });
      log('response: ${response.data}');
      return response.data;
    } on DioError catch (e) {
      log('error: ${e.response}');
      return e.response!.data;
    }
  }
}
