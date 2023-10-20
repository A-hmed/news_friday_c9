import 'package:flutter/material.dart';
import 'package:news_friday_c9/data/model/category_dm.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryDM categoryDM;
  const CategoryWidget({super.key, required this.categoryDM});
  final radius = const Radius.circular(24);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: categoryDM.backgroundColor,
        borderRadius: BorderRadius.only(
          topRight: radius,
          topLeft: radius,
          bottomLeft: categoryDM.isLeftSided ? Radius.zero : radius,
          bottomRight: !categoryDM.isLeftSided ? Radius.zero : radius
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(categoryDM.imagePath, height: MediaQuery.of(context).size.height * .15,),
          Text(categoryDM.title, style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}
