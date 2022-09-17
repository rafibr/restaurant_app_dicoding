// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:restaurant_app/detail_restaurant.dart';
import 'package:restaurant_app/list_restaurant.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/repository/restaurant_repo.dart';
import 'package:restaurant_app/style/colors.style.dart';
import 'package:restaurant_app/style/shimmer_loader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // scrollview
  final ScrollController _scrollController = ScrollController();
  Restaurant? itemRestaurant;
  Restaurant? itemRandomRestaurant;
  Restaurant? itemPopularRestaurant;

  String goodWhat = 'Good Morning';

  @override
  void initState() {
    super.initState();

    // get data from lib/data/local_restaurant.dart
    RestaurantRepo().getAllRestaurant().then((value) {
      setState(() {
        itemRestaurant = value;
      });
    });

    // get 3 random data from lib/data/local_restaurant.dart
    RestaurantRepo().get3RandomRestaurant().then((value) {
      setState(() {
        itemRandomRestaurant = value;
      });
    });

    // populare 3 restaurant base on rating
    RestaurantRepo().get3PopularRestaurant().then((value) {
      setState(() {
        itemPopularRestaurant = value;
      });
    });

    // get time
    var now = DateTime.now();
    if (now.hour >= 0 && now.hour < 12) {
      goodWhat = 'Good Morning';
    } else if (now.hour >= 12 && now.hour < 17) {
      goodWhat = 'Good Afternoon';
    } else if (now.hour >= 17 && now.hour < 19) {
      goodWhat = 'Good Evening';
    } else if (now.hour >= 19 && now.hour < 24) {
      goodWhat = 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    // sliver app bar
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nongskuy'),
        backgroundColor: appColor.quinaryBackgroundColor,
      ),
      body: FutureBuilder<dynamic>(
        future: RestaurantRepo().getAllRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 150,
                        decoration: const BoxDecoration(
                          color: appColor.quaternaryBackgroundColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, left: 20),
                          width: double.infinity,
                          child: Text(
                            '$goodWhat, \nWhat do you want to eat?',
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
                        // shadow
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // 3 menu with icon
                                    Expanded(
                                      child: _buildItemMenu(
                                        title: 'High Rated',
                                        icon: Icons.star,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ListRestaurant(
                                                query: 'high',
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // vertical divider
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    Expanded(
                                      child: _buildItemMenu(
                                        title: 'Restaurant',
                                        icon: Icons.restaurant,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ListRestaurant(
                                                query: 'all',
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // vertical divider 
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    Expanded(
                                      child: _buildItemMenu(
                                        icon: Icons.favorite,
                                        title: 'Favorite',
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ListRestaurant(
                                                query: 'favorite',
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Random Restaurant
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Random Restaurant',
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                                color: appColor.primaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: _buildItemRestaurant(
                                  item: itemRandomRestaurant!.restaurants![0],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailRestaurant(
                                          id: itemRandomRestaurant!.restaurants![0].id!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 200,
                                child: _buildItemRestaurant(
                                  item: itemRandomRestaurant!.restaurants![1],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailRestaurant(
                                          id: itemRandomRestaurant!.restaurants![1].id!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 200,
                                child: _buildItemRestaurant(
                                  item: itemRandomRestaurant!.restaurants![2],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailRestaurant(
                                          id: itemRandomRestaurant!.restaurants![2].id!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // popular restaurant
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Popular Restaurant',
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                                color: appColor.primaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: _buildItemRestaurant(
                                  item: itemPopularRestaurant!.restaurants![0],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailRestaurant(
                                          id: itemPopularRestaurant!.restaurants![0].id!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 200,
                                child: _buildItemRestaurant(
                                  item: itemPopularRestaurant!.restaurants![1],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailRestaurant(
                                          id: itemPopularRestaurant!.restaurants![1].id!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 200,
                                child: _buildItemRestaurant(
                                  item: itemPopularRestaurant!.restaurants![2],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailRestaurant(
                                          id: itemPopularRestaurant!.restaurants![2].id!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            // shimmer
            return ShimmerLoader(
              isLoading: true,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        color: Colors.white,
                      ),
                      title: Container(
                        width: 100,
                        height: 20,
                        color: Colors.white,
                      ),
                      subtitle: Container(
                        width: 50,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  _buildItemMenu({required IconData icon, required String title, required Null Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: appColor.quaternaryColor,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _buildItemRestaurant({required RestaurantList item, required Null Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // column
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(item.pictureId.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    item.name.toString(),
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: appColor.quaternaryColor,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          item.city.toString(),
                          style: Theme.of(context).textTheme.labelSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: appColor.quaternaryColor,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        item.rating.toString(),
                        style: Theme.of(context).textTheme.labelSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
