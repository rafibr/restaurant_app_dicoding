import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

// {
//   "error": false,
//   "message": "success",
//   "restaurants": [
//     {
//       "id": "rqdv5juczeskfw1e867",
//       "name": "Melting Pot",
//       "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
//       "pictureId": "https://restaurant-api.dicoding.dev/images/medium/14",
//       "city": "Medan",
//       "rating": 4.2,
//       "menus": {
//         "foods": [
//           {
//             "name": "Paket rosemary"
//           },
//           {
//             "name": "Toastie salmon"
//           },
//           {
//             "name": "Bebek crepes"
//           },
//           {
//             "name": "Salad lengkeng"
//           }
//         ],
//         "drinks": [
//           {
//             "name": "Es krim"
//           },
//           {
//             "name": "Sirup"
//           },
//           {
//             "name": "Jus apel"
//           },
//           {
//             "name": "Jus jeruk"
//           },
//           {
//             "name": "Coklat panas"
//           },
//           {
//             "name": "Air"
//           },
//           {
//             "name": "Es kopi"
//           },
//           {
//             "name": "Jus alpukat"
//           },
//           {
//             "name": "Jus mangga"
//           },
//           {
//             "name": "Teh manis"
//           },
//           {
//             "name": "Kopi espresso"
//           },
//           {
//             "name": "Minuman soda"
//           },
//           {
//             "name": "Jus tomat"
//           }
//         ]
//       }
//     },
// }

@JsonSerializable()
class Restaurant {
  bool? error;
  String? message;
  int? count;
  List<RestaurantList>? restaurants;

  Restaurant({this.error, this.message, this.count, this.restaurants});

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}

@JsonSerializable()
class RestaurantList {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;

  RestaurantList({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) =>
      _$RestaurantListFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantListToJson(this);

  where(Function(dynamic element) param0) {}
}

@JsonSerializable()
class RestaurantDetail {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;
  List<Categories>? categories;
  Menus? menus;
  List<CustomerReviews>? customerReviews;

  RestaurantDetail({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDetailToJson(this);
}

@JsonSerializable()
class Menus {
  List<Food>? foods;
  List<Drink>? drinks;

  Menus({this.foods, this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) => _$MenusFromJson(json);

  Map<String, dynamic> toJson() => _$MenusToJson(this);
}

@JsonSerializable()
class Food {
  String? name;

  Food({this.name});

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  Map<String, dynamic> toJson() => _$FoodToJson(this);
}

@JsonSerializable()
class Drink {
  String? name;

  Drink({this.name});

  factory Drink.fromJson(Map<String, dynamic> json) => _$DrinkFromJson(json);

  Map<String, dynamic> toJson() => _$DrinkToJson(this);
}

@JsonSerializable()
class Categories {
  String? name;

  Categories({this.name});

  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}

@JsonSerializable()
class CustomerReviews {
  String? name;
  String? review;
  String? date;

  CustomerReviews({this.name, this.review, this.date});

  factory CustomerReviews.fromJson(Map<String, dynamic> json) =>
      _$CustomerReviewsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerReviewsToJson(this);
}
