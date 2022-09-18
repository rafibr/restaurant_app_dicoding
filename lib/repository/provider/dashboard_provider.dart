import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/endpoint.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/repository/restaurant_repo.dart';
import 'package:restaurant_app/utils/helper.dart';

class DashboardProvider extends ChangeNotifier with Helper {
  Restaurant restaurants = Restaurant();

  List<RestaurantList> restaurantList = [];
  List<RestaurantList> allRestaurantList = [];

  // 3 random restaurant
  List<RestaurantList> randomRestaurantList = [];
  // 3 popular restaurant
  List<RestaurantList> popularRestaurantList = [];

  List<RestaurantList> searchRestaurantList = [];

  RestaurantRepo _restaurantRepo = RestaurantRepo();

  bool isLoading = true;
  bool isError = false;
  String errorMessage = '';

  void setRestaurants(Restaurant restaurants) {
    restaurants = restaurants;
    notifyListeners();
  }

  void init() {
    isLoading = true;
    notifyListeners();

    getAllRestaurant();
  }

  Future<Restaurant> getAllRestaurant() async {
    isLoading = true;
    notifyListeners();


    try {
      restaurants = await _restaurantRepo.getListRestaurant();
      restaurantList = restaurants.restaurants!;
      allRestaurantList = restaurants.restaurants!;

      // random restaurant
      await randomRestaurant(allRestaurantList);
      // popular restaurant
      await popularRestaurant(allRestaurantList);

      isLoading = false;
      isError = false;
      notifyListeners();
      return restaurants;
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
      return restaurants;
    }
  }

  // util function

  Future<void> randomRestaurant(List<RestaurantList> restaurantList) async {
    // shuffle restaurant
    restaurantList.shuffle();

    // get 3 random restaurant
    randomRestaurantList = restaurantList.sublist(0, 3);

    notifyListeners();
  }

  Future<void> popularRestaurant(List<RestaurantList> restaurantList) async {
    // sort restaurant by rating
    restaurantList.sort((a, b) => b.rating!.compareTo(a.rating!));

    // get 3 popular restaurant
    popularRestaurantList = restaurantList.sublist(0, 3);

    notifyListeners();
  }
}
