import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:restaurant_app/model/restaurant.dart';

class RestaurantRepo {
  // get data from lib/data/local_restaurant.dart

  getAllRestaurant() async {
    final String data =
        await rootBundle.loadString('lib/data/local_restaurant.json');

    // get data simulating network delay
    await Future.delayed(const Duration(seconds: 2));

    return Restaurant.fromJson(json.decode(data));
  }

  // get 3 random data from lib/data/local_restaurant.dart
  get3RandomRestaurant() async {
    await Future.delayed(const Duration(seconds: 2));

    final String data =
        await rootBundle.loadString('lib/data/local_restaurant.json');
    final Restaurant restaurant = Restaurant.fromJson(json.decode(data));
    restaurant.restaurants!.shuffle();
    restaurant.restaurants = restaurant.restaurants!.sublist(0, 3);
    return restaurant;
  }

  // populare 3 restaurant base on rating
  get3PopularRestaurant() async {
    await Future.delayed(const Duration(seconds: 2));

    final String data =
        await rootBundle.loadString('lib/data/local_restaurant.json');
    final Restaurant restaurant = Restaurant.fromJson(json.decode(data));
    restaurant.restaurants!.sort((a, b) => b.rating!.compareTo(a.rating!));
    restaurant.restaurants = restaurant.restaurants!.sublist(0, 3);
    return restaurant;
  }

  // search restaurant by name
  searchRestaurant(String value) async {
    await Future.delayed(const Duration(seconds: 1));

    final String data =
        await rootBundle.loadString('lib/data/local_restaurant.json');
    final Restaurant restaurant = Restaurant.fromJson(json.decode(data));
    restaurant.restaurants!.removeWhere((element) =>
        !element.name!.toLowerCase().contains(value.toLowerCase()));
    return restaurant;
  }

  // get detail restaurant by id
  getDetailRestaurant(String id) async {
    await Future.delayed(const Duration(seconds: 2));

    final String data =
        await rootBundle.loadString('lib/data/local_restaurant.json');
    final Restaurant restaurant = Restaurant.fromJson(json.decode(data));
    return restaurant.restaurants!.firstWhere((element) => element.id == id);
  }

  // search food and drink by name
  searchFoodAndDrink(String value) async {
    await Future.delayed(const Duration(seconds: 1));

    final String data =
        await rootBundle.loadString('lib/data/local_restaurant.json');
    final Restaurant restaurant = Restaurant.fromJson(json.decode(data));
    for (var element in restaurant.restaurants!) {
      element.menus!.foods!.removeWhere((element) =>
          !element.name!.toLowerCase().contains(value.toLowerCase()));
      element.menus!.drinks!.removeWhere((element) =>
          !element.name!.toLowerCase().contains(value.toLowerCase()));
    }
    return restaurant;
  }
}
