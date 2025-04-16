import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).canvasColor,
              highlightColor: Theme.of(context).highlightColor,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // RELOAD THE APP
              SizedBox(
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).canvasColor,
                  highlightColor: Theme.of(context).highlightColor,
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).canvasColor,
                  highlightColor: Theme.of(context).highlightColor,
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),

              // SHOWING THE BOTTOM MODAL FOR FILTERING
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        child: Shimmer.fromColors(
                          baseColor: Theme.of(context).canvasColor,
                          highlightColor: Theme.of(context).highlightColor,
                          child: Container(
                            width: 40,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Shimmer.fromColors(
                              baseColor: Theme.of(context).canvasColor,
                              highlightColor: Theme.of(context).highlightColor,
                              child: Container(
                                width: 40,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),

                          SizedBox(
                            child: Shimmer.fromColors(
                              baseColor: Theme.of(context).canvasColor,
                              highlightColor: Theme.of(context).highlightColor,
                              child: Container(
                                width: 60,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
