// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/repository/provider/detail_provider.dart';
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
  TextEditingController searchController = TextEditingController();

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();

    Provider.of<DetailProvider>(context, listen: false).init(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<DetailProvider>(context).restaurantDetail?.name ?? 'Detail Restaurant'),
        backgroundColor: appColor.quinaryBackgroundColor,
      ),
      body: Consumer<DetailProvider>(
        builder: (context, provider, child) {
          return provider.isLoading
              ? ShimmerLoaderGrid()
              : RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      provider.init(widget.id);
                    });
                  },
                  child: provider.showReview ? _buildReview(provider) : _buildBody(provider),
                );
        },
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
      return Consumer<DetailProvider>(builder: (context, value, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.foods!.length,
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
                  value.foods![index].name!,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            );
          },
        );
      });
    } else {
      return Consumer<DetailProvider>(builder: (context, value, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.drinks!.length,
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
                  value.drinks![index].name!,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            );
          },
        );
      });
    }
  }

  void search(String value) {
    Provider.of<DetailProvider>(context, listen: false).searchMenu(value);
  }

  _buildBody(DetailProvider provider) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.network(
              provider.imageRestaurantMedium(provider.restaurantDetail?.pictureId ?? ''),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // category with pill
                Row(
                  children: [
                    Text(
                      'Category : ',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(width: 8),
                    ...provider.restaurantDetail?.categories?.map((e) {
                          // pill category
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: appColor.quinaryBackgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Text(
                              e.name!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList() ??
                        [],
                  ],
                ),

                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        provider.restaurantDetail?.name ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    // how many review show with icon and bubble
                    InkWell(
                      onTap: () {
                        setState(() {
                          provider.showReview = true;
                        });
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              'See All Reviews (${provider.restaurantDetail?.customerReviews?.length ?? 0})',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: appColor.quinaryBackgroundColor,
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
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ],
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
                      provider.restaurantDetail?.city ?? '',
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
                      provider.restaurantDetail?.rating.toString() ?? '',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ReadMoreText(
                  provider.restaurantDetail?.description ?? '',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // tab "food" and "drink"
          Container(
            margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: Row(
              children: [
                Expanded(child: _buildTab(0, 'Food')),
                Expanded(child: _buildTab(1, 'Drink')),
              ],
            ),
          ),

          // search bar
          // size small
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                search(value);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                // color text
                hintStyle: Theme.of(context).textTheme.subtitle2,
                focusColor: appColor.quinaryBackgroundColor,
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
    );
  }

  _buildReview(DetailProvider provider) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        provider.restaurantDetail?.name ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    // show detail
                    InkWell(
                      onTap: () {
                        setState(() {
                          provider.showReview = false;
                        });
                      },
                      // back to detail
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              'Back to Detail',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_back_ios,
                              size: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: appColor.quinaryBackgroundColor,
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
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // add review form
                _buildAddReview(provider),
                const SizedBox(height: 8),
                // list review
                _buildListReview(provider),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildAddReview(DetailProvider provider) {
    // add review form [name, review]
    return Container(
      child: Column(
        children: [
          // name
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: TextField(
              controller: provider.nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                // color text
                hintStyle: Theme.of(context).textTheme.subtitle2,
                focusColor: appColor.quinaryBackgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          // review
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: TextField(
              controller: provider.reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Review',
                // color text
                hintStyle: Theme.of(context).textTheme.subtitle2,
                focusColor: appColor.quinaryBackgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          // button add review
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: appColor.quinaryBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                provider.addReview(provider, context);
              },
              child: Text('Add Review'),
            ),
          ),
        ],
      ),
    );
  }

  _buildListReview(DetailProvider provider) {
    return // all review
        ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      itemCount: provider.restaurantDetail?.customerReviews?.length ?? 0,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // icon user
                    const Icon(
                      Icons.person,
                      color: appColor.quinaryBackgroundColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        provider.restaurantDetail?.customerReviews?[index].name ?? '',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    Text(
                      provider.restaurantDetail?.customerReviews?[index].date ?? '',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Text(
                  // provider.restaurantDetail?.customerReviews?[index].review ?? '',
                  // style: Theme.of(context).textTheme.subtitle2,
                // ),
                ReadMoreText(
                  provider.restaurantDetail?.customerReviews?[index].review ?? '',
                  trimLines: 3,
                  colorClickableText: appColor.quinaryBackgroundColor,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
