import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import 'package:meals/models/category.dart';
import '../data/dummy_data.dart';
import 'package:meals/components/meal_item.dart';


class CategoriesMealsScreen extends StatelessWidget {
  CategoriesMealsScreen(category);

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as Category;

  final categoryMeals = DUMMY_MEALS.where((meal) {
    return meal.categories.contains(category.id);
  }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (ctx, index) {
            return MealItem(categoryMeals[index]);
          }
        ),
      ),
    );
  }
}
