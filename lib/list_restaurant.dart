import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/detail_restaurant.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/repository/provider/dashboard_provider.dart';
import 'package:restaurant_app/repository/provider/list_provider.dart';
import 'package:restaurant_app/repository/restaurant_repo.dart';
import 'package:restaurant_app/style/colors.style.dart';
import 'package:restaurant_app/style/shimmer_loader.dart';

class ListRestaurant extends StatefulWidget {
  // query
  String query;

  ListRestaurant({Key? key, required this.query}) : super(key: key);

  @override
  _ListRestaurantState createState() => _ListRestaurantState();
}

class _ListRestaurantState extends State<ListRestaurant> {
  final ScrollController _scrollController = ScrollController();

  bool _onSearch = true;

  String title = 'Our Restaurant';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ListProvider>(context, listen: false).searchRestaurant(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _onSearch ? _buildSearchField() : Text(title),
        backgroundColor: appColor.quinaryBackgroundColor,
        actions: [
          _onSearch
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _onSearch = false;
                      _searchController.clear();
                      Provider.of<ListProvider>(context, listen: false).getAllRestaurant();
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _onSearch = true;
                    });
                  },
                ),

          // sort
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _showSortDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text(widget.query),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  // showing your our restaurant
                  child: Consumer<ListProvider>(
                    builder: (context, provider, child) {
                      if (provider.isError) {
                        return const Center(
                          child: Text('Terjadi Kesalahan, silahkan coba lagi'),
                        );
                      } else if (provider.isLoading) {
                        return const Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        if (provider.restaurantList.isNotEmpty) {
                          return Text(
                            'Found ${provider.restaurantList.length} restaurant',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          _buildListRestaurant(),
        ],
      ),
    );
  }

  Widget _buildListRestaurant() {
    return Consumer<ListProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return ShimmerLoaderList();
        } else {
          if (provider.restaurantList.isEmpty) {
            return Column(
              children: [
                Image.asset(
                  'assets/img/ic_launcher.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 100,
                ),
                Text('Tidak ada restoran yang ditemukan :(')
              ],
            );
          } else {
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  if (_searchController.text.isEmpty) {
                    provider.getAllRestaurant();
                  } else {
                    provider.searchRestaurant(_searchController.text);
                  }
                },
                child: ListView.custom(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  childrenDelegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRestaurant(
                                id: provider.restaurantList[index].id!,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      provider.imageRestaurantSmall(provider.restaurantList[index].pictureId!),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.restaurantList[index].name!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      provider.restaurantList[index].city!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Text(
                                          provider.restaurantList[index].rating!.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                    },
                    childCount: provider.restaurantList.length,
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }

  _buildSearchField() {
    return Consumer<ListProvider>(builder: (context, provider, child) {
      return TextField(
        controller: _searchController,
        autofocus: true,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
          suffixIcon: provider.onSearch
              ? const SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {
                    provider.searchRestaurant(_searchController.text);
                  },
                ),
        ),
        onEditingComplete: () {
          provider.searchRestaurant(_searchController.text);
        },
        onChanged: (value) {
          provider.searchRestaurant(_searchController.text);
        },
      );
    });
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer<ListProvider>(
          builder: (context, provider, child) {
            return AlertDialog(
              title: const Text('Sort'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text('Sort by'),
                      const SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        value: provider.sortBy,
                        items: <String>['name', 'rating', 'city'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          provider.changeSortBy(value!);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text('Order by'),
                      const SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        value: provider.orderBy,
                        items: <String>['asc', 'desc'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          provider.changeOrderBy(value!);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    provider.sortRestaurant();
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
