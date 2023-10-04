import 'package:amazon_clone/common/categories.dart';
import 'package:amazon_clone/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopScreenCategory extends StatefulWidget {
  const TopScreenCategory({super.key});

  @override
  State<TopScreenCategory> createState() => _TopScreenCategoryState();
}

class _TopScreenCategoryState extends State<TopScreenCategory> {
  void navavigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      CategoryDealsScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      // color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Categories.categoryImages.length,
        itemExtent: 75,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navavigateToCategoryPage(
              context,
              Categories.categoryImages[index]['title']!,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      Categories.categoryImages[index]['images']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  Categories.categoryImages[index]['title']!,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
