import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/repository/restaurant_repo.dart';
import 'package:restaurant_app/utils/helper.dart';

class ListProvider extends ChangeNotifier with Helper {
  Restaurant restaurants = Restaurant();

  List<RestaurantList> restaurantList = [];
  List<RestaurantList> allRestaurantList = [];

  final RestaurantRepo _restaurantRepo = RestaurantRepo();

  bool isLoading = false;
  bool isError = false;
  String errorMessage = '';

  bool onSearch = false;

  String sortBy = 'name';
  String orderBy = 'asc';

  void setRestaurants(Restaurant restaurants) {
    restaurants = restaurants;
    notifyListeners();
  }

  void init() {
    isLoading = true;
    isError = false;
    errorMessage = '';

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
  void searchRestaurant(String value) async {
    isLoading = true;
    isError = false;
    onSearch = true;
    notifyListeners();

    restaurantList = [];

    if (value.isEmpty) {
      getAllRestaurant();
      onSearch = false;
      notifyListeners();
    } else {
      // from _restaurantRepo.searchRestaurant(value)
      await _restaurantRepo.searchRestaurant(value).then((value) {
        // inspect(value.error);
        if (value.error == false) {
          restaurantList = value.restaurants!;
          isLoading = false;
          isError = false;
          notifyListeners();
        } else {
          restaurantList = [];
          isLoading = false;
          isError = true;
          errorMessage = 'Terjadi kesalahan, silahkan coba lagi';
          notifyListeners();
        }

        notifyListeners();
      });

      onSearch = false;
      notifyListeners();
    }
  }

  void sortRestaurant() {
    isLoading = true;
    isError = false;
    notifyListeners();

    log('sort by $sortBy, order by $orderBy');

    if (sortBy == 'name') {
      if (orderBy == 'asc') {
        restaurantList.sort((a, b) => a.name!.compareTo(b.name!));
      } else {
        restaurantList.sort((a, b) => b.name!.compareTo(a.name!));
      }
    } else if (sortBy == 'rating') {
      if (orderBy == 'asc') {
        restaurantList.sort((a, b) => a.rating!.compareTo(b.rating!));
      } else {
        restaurantList.sort((a, b) => b.rating!.compareTo(a.rating!));
      }
    } else if (sortBy == 'city') {
      if (orderBy == 'asc') {
        restaurantList.sort((a, b) => a.city!.compareTo(b.city!));
      } else {
        restaurantList.sort((a, b) => b.city!.compareTo(a.city!));
      }
    }

    isLoading = false;
    isError = false;
    notifyListeners();
  }

  void changeSortBy(String s) {
    sortBy = s;
    notifyListeners();
  }

  void changeOrderBy(String s) {
    orderBy = s;
    notifyListeners();
  }
}
