import 'package:restaurant_app/data/endpoint.dart';

class Helper {
  String imageRestaurantSmall(String id) {
    return Endpoint.imageSmall + id;
  }

  String imageRestaurantMedium(String id) {
    return Endpoint.imageMedium + id;
  }

  String imageRestaurantLarge(String id) {
    return Endpoint.imageLarge + id;
  }
}
