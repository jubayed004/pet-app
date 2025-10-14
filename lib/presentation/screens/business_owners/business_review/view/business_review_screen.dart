import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/see_more_text.dart';

class BusinessReviewScreen extends StatelessWidget {
  const BusinessReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reviews = [
      {
        "name": "Haylie Aminoff",
        "time": "Just now",
        "rating": 4.5,
        "comment":
        "The thing I like best about COCO is the amount of time it has saved while trying to manage my three pets.sdfsdfdfsdfsdfsdfsdfsdfsdfsdfsdfsadfsadfdfdfdfdf",
        "avatar": "https://randomuser.me/api/portraits/women/1.jpg",
      },
      {
        "name": "Carla Septimus",
        "time": "32 minutes ago",
        "rating": 4.5,
        "comment":
        "Lorem ipsum dolor sit amet, consectetur sadi spssicing elit, sed diam nonumy",
        "avatar": "https://randomuser.me/api/portraits/women/2.jpg",
      },
      {
        "name": "Carla George",
        "time": "2 days ago",
        "rating": 4.5,
        "comment":
        "Lorem ipsum dolor sit amet, consectetur sadi spssicing elit, sed diam nonumy",
        "avatar": "https://randomuser.me/api/portraits/women/3.jpg",
      },
    ];

    return Scaffold(

      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "Reviews",),
          /// Rating header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("4.5",
                      style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(height: 4),
                  RatingBarIndicator(
                    rating: 4.5,
                    itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 24,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Based on 89 reviews",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          /// Divider
          SliverToBoxAdapter(
            child: Divider(thickness: 1, color: Colors.grey.shade300),
          ),

          /// Reviews List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final review = reviews[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// User Info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(review['avatar']),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                review['time'],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      /// Star rating
                      Row(
                        children: [
                          Text(
                            review['rating'].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(width: 4),
                          RatingBarIndicator(
                            rating: review['rating'],
                            itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: Colors.amber),
                            itemCount: 5,
                            itemSize: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      /// Comment
                        ExpandableText(text: review['comment'],),
                      const SizedBox(height: 10),

                      /// Divider
                      Divider(thickness: 1, color: Colors.grey.shade200),
                    ],
                  ),
                );
              },
              childCount: reviews.length,
            ),
          ),
        ],
      ),
    );
  }
}
