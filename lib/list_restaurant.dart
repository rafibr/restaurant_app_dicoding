import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:restaurant_app/detail_restaurant.dart';
import 'package:restaurant_app/model/restaurant.dart';
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
  Restaurant? itemRestaurant;
  Restaurant? allRestaurant;

  int itemLength = 0;

  bool _isLoading = true;
  bool _onSearch = false;

  String title = 'Our Restaurant';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.query == 'all') {
      RestaurantRepo().getAllRestaurant().then((value) {
        setState(() {
          title = 'Our Restaurant';
          _isLoading = false;

          itemRestaurant = value;
          allRestaurant = value;
          itemLength = itemRestaurant!.restaurants!.length;
        });
      });
    } else if (widget.query == 'high') {
      RestaurantRepo().getAllRestaurant().then((value) {
        setState(() {
          title = 'Favorite Restaurant';
          _isLoading = false;

          itemRestaurant = value;
          // sort by rating
          itemRestaurant!.restaurants!
              .sort((a, b) => b.rating!.compareTo(a.rating!));
          allRestaurant = itemRestaurant;
          itemLength = itemRestaurant!.restaurants!.length;
        });
      });
    } else {
      RestaurantRepo().getAllRestaurant().then((value) {
        setState(() {
          _isLoading = false;
          title = 'Search Result';

          itemRestaurant = value;
          allRestaurant = value;
          itemLength = itemRestaurant!.restaurants!.length;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _onSearch ? _buildSearchField() : Text(title),
        backgroundColor: appColor.quinaryBackgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _onSearch = !_onSearch;
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),

                  // showing your our restaurant
                  child: Text(
                    'Showing $itemLength restaurant',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: _isLoading
                ? ShimmerLoader(
                    isLoading: _isLoading,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 10,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 10,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 10,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : ListView.custom(
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
                                  id: itemRestaurant!.restaurants![index].id!,
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
                                        itemRestaurant!
                                            .restaurants![index].pictureId!,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        itemRestaurant!
                                            .restaurants![index].name!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        itemRestaurant!
                                            .restaurants![index].city!,
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
                                            itemRestaurant!
                                                .restaurants![index].rating!
                                                .toString(),
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
                      childCount: itemRestaurant!.restaurants!.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: onSearchTextChanged,
    );
  }

  void onSearchTextChanged(String value) {
    log('value: ${value.isEmpty}');
    log('allRestaurant: ${allRestaurant!.restaurants!.length}');

    setState(() {
      if (value.isEmpty) {
        itemRestaurant = allRestaurant;
      } else {
        _isLoading = true;
        RestaurantRepo().searchRestaurant(value).then((value) {
          setState(() {
            _isLoading = false;
            itemRestaurant = value;
          });
        });
      }
    });
  }
}
