// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/detail_restaurant.dart';
import 'package:restaurant_app/list_restaurant.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/repository/provider/dashboard_provider.dart';
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

  String goodWhat = 'Good Morning';

  @override
  void initState() {
    super.initState();

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

    // get list restaurant
    Provider.of<DashboardProvider>(context, listen: false).getAllRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    // sliver app bar
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nongskuy'),
        backgroundColor: appColor.quinaryBackgroundColor,
      ),
      body:
          // pull to refresh
          RefreshIndicator(
        onRefresh: () async {
          Provider.of<DashboardProvider>(context, listen: false).getAllRestaurant();
        },
        child:
            // scroll view
            SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                        '$goodWhat, \nWhere do you want to eat?',
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
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListRestaurant(query: ''),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // icon spoon and fork
                                  Icon(
                                    Icons.restaurant,
                                    color: appColor.quaternaryBackgroundColor,
                                  ),
                                  // search field
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: TextField(
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        hintText: 'Where do you want to eat?',
                                        border: InputBorder.none,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.search,
                                            color: appColor.quaternaryBackgroundColor,
                                          ),
                                          onPressed: null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Consumer<DashboardProvider>(
                builder: (context, value, _) {
                  if (!value.isLoading && !value.isError) {
                    return Column(
                      children: [
                        // random restaurant
                        _buildRandomRestaurant(),
                        // popular restaurant
                        _buildPopularRestaurant(),
                      ],
                    );
                  } else if (value.isError) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                // image error
                                Image.asset(
                                  'assets/img/ic_launcher.png',
                                  width: 100,
                                  height: 100,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Terjadi kesalahan saat memuat data, silahkan muat ulang halaman',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ShimmerLoaderGrid();
                  }
                },
              ),
            ],
          ),
        ),
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
            Consumer<DashboardProvider>(builder: (context, value, child) {
              return Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(value.imageRestaurantSmall(item.pictureId!)),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Terjadi kesalahan saat memuat gambar'),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
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

  _buildRandomRestaurant() {
    return Consumer<DashboardProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            value.isLoading && !value.isError
                ? ShimmerLoaderGrid()
                :
                // random restaurant
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
                                  item: value.randomRestaurantList[0],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailRestaurant(
                                          id: value.randomRestaurantList[0].id!,
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
                                  item: value.randomRestaurantList[1],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailRestaurant(
                                          id: value.randomRestaurantList[1].id!,
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
                                  item: value.randomRestaurantList[2],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailRestaurant(
                                          id: value.randomRestaurantList[2].id!,
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
        );
      },
    );
  }

  _buildPopularRestaurant() {
    return Consumer<DashboardProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            // popular restaurant
            value.isLoading && !value.isError
                ? ShimmerLoaderGrid()
                : // popular restaurant
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
                                  item: value.popularRestaurantList[0],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailRestaurant(
                                          id: value.popularRestaurantList[0].id!,
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
                                  item: value.popularRestaurantList[1],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailRestaurant(
                                          id: value.popularRestaurantList[1].id!,
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
                                  item: value.popularRestaurantList[2],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailRestaurant(
                                          id: value.popularRestaurantList[2].id!,
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
        );
      },
    );
  }
}
