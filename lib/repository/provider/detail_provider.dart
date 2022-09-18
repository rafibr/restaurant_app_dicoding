import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/repository/restaurant_repo.dart';
import 'package:restaurant_app/utils/helper.dart';

class DetailProvider extends ChangeNotifier with Helper {
  RestaurantDetail? restaurantDetail;
  RestaurantDetail? allRestaurantDetail;

  List<Food>? foods;
  List<Food>? allFoods;
  List<Drink>? drinks;
  List<Drink>? allDrinks;

  RestaurantRepo _restaurantRepo = RestaurantRepo();

  bool isLoading = false;
  bool isError = false;
  String errorMessage = '';

  bool showReview = false;
  bool showFormReview = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  void init(String id) async {
    isLoading = true;
    isError = false;
    errorMessage = '';
    showReview = false;

    restaurantDetail = RestaurantDetail(
      id: '',
      name: '',
      description: '',
      pictureId: '',
      city: '',
      rating: 0,
      menus: Menus(foods: [], drinks: []),
    );

    getDetailRestaurant(id);
    notifyListeners();
  }

  void getDetailRestaurant(String id) async {
    isLoading = true;
    notifyListeners();

    try {
      await _restaurantRepo.getDetailRestaurant(id).then((value) {
        restaurantDetail = value;
        allRestaurantDetail = value;
        foods = value.menus!.foods;
        allFoods = value.menus!.foods;
        drinks = value.menus!.drinks;
        allDrinks = value.menus!.drinks;
        isLoading = false;
        isError = false;
        errorMessage = '';
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
    }
  }

  void searchMenu(String value) {
    if (value.isEmpty) {
      foods = allFoods;
      drinks = allDrinks;
    } else {
      foods = allFoods!.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
      drinks = allDrinks!.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }
    notifyListeners();
  }

  void addReview(DetailProvider provider, BuildContext context) async {
    dynamic postData = await _restaurantRepo.addReview(provider);

    String message = postData['message'];
    bool isError = postData['error'];

    if (!isError) {
      showFormReview = false;
      showReview = true;

      reviewController.clear();
      nameController.clear();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ));

      getDetailRestaurant(restaurantDetail!.id!);
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ));
    }
  }
}
