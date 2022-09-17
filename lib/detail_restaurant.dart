import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/repository/restaurant_repo.dart';
import 'package:restaurant_app/style/colors.style.dart';
import 'package:restaurant_app/style/shimmer_loader.dart';

class DetailRestaurant extends StatefulWidget {
  final String id;

  const DetailRestaurant({required this.id}) : super();

  @override
  _DetailRestaurantState createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  RestaurantList? restaurant;
  RestaurantList? allRestaurant;

  List<Food>? foods;
  List<Food>? allFoods;
  List<Drink>? drinks;
  List<Drink>? allDrinks;

  bool isLoading = true;

  TextEditingController searchController = TextEditingController();

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();

    RestaurantRepo().getDetailRestaurant(widget.id).then((value) {
      setState(() {
        restaurant = value;
        allRestaurant = value;
        foods = value.menus!.foods;
        drinks = value.menus!.drinks;
        allFoods = value.menus!.foods;
        allDrinks = value.menus!.drinks;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant?.name ?? ''),
        backgroundColor: appColor.quinaryBackgroundColor,
      ),
      body: isLoading
          ? ShimmerLoader(
              isLoading: isLoading,
              child: ListView(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 200,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 200,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 200,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 200,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 200,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 200,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 200,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Image.network(
                      restaurant?.pictureId ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant?.name ?? '',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: appColor.quinaryBackgroundColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              restaurant?.city ?? '',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: appColor.quinaryBackgroundColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              restaurant?.rating.toString() ?? '',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ReadMoreText(
                          restaurant?.description ?? '',
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),

                  // tab "food" and "drink"
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: Row(
                      children: [
                        Expanded(child: _buildTab(0, 'Food')),
                        Expanded(child: _buildTab(1, 'Drink')),
                      ],
                    ),
                  ),

                  // search bar
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        search(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  // list food and drink by tab
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: _buildListFoodAndDrink(),
                  ),
                ],
              ),
            ),
    );
  }

  _buildTab(int i, String s) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tabIndex = i;
        });
      },
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          setState(() {
            tabIndex = 0;
          });
        } else {
          setState(() {
            tabIndex = 1;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: tabIndex == i ? appColor.quinaryBackgroundColor : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: appColor.quinaryBackgroundColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          s,
          style: TextStyle(
            color: tabIndex == i ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _buildListFoodAndDrink() {
    // restaurant.menus.menu tab 0
    // restaurant.menus.drinks tab 1
    if (tabIndex == 0) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: foods!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: appColor.quinaryBackgroundColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Text(
                foods![index].name ?? '',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          );
        },
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: drinks!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: appColor.quinaryBackgroundColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Text(
                drinks![index].name ?? '',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          );
        },
      );
    }
  }

  void search(String value) {
    if (value.isEmpty) {
      setState(() {
        foods = allFoods;
        drinks = allDrinks;
      });
    } else {
      setState(() {
        foods = foods!.where((element) {
          return element.name!.toLowerCase().contains(value.toLowerCase());
        }).toList();
        drinks = drinks!.where((element) {
          return element.name!.toLowerCase().contains(value.toLowerCase());
        }).toList();
      });
    }
  }
}
