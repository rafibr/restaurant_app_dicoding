import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoaderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        // 3 list tile
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 48,
                height: 48,
                color: Colors.white,
              ),
              title: Container(
                width: double.infinity,
                height: 8,
                color: Colors.white,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  width: double.infinity,
                  height: 8,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Container(
                width: 48,
                height: 48,
                color: Colors.white,
              ),
              title: Container(
                width: double.infinity,
                height: 8,
                color: Colors.white,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  width: double.infinity,
                  height: 8,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Container(
                width: 48,
                height: 48,
                color: Colors.white,
              ),
              title: Container(
                width: double.infinity,
                height: 8,
                color: Colors.white,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  width: double.infinity,
                  height: 8,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}

class ShimmerLoaderGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      direction: ShimmerDirection.ltr,
      // 2 Card in row
      child: Wrap(
        children: [
          Card(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.white,
                ),
                ListTile(
                  title: Container(
                    width: double.infinity,
                    height: 8,
                    color: Colors.white,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      width: double.infinity,
                      height: 8,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.white,
                ),
                ListTile(
                  title: Container(
                    width: double.infinity,
                    height: 8,
                    color: Colors.white,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      width: double.infinity,
                      height: 8,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
