import 'package:flutter/material.dart';
import 'package:meals/models/settings.dart';

import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/categories_meals_screen.dart';
import 'utils/app_routes.dart';
import 'screens/tabs_screen.dart';

import '../models/meal.dart';
import '../data/dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  // ======================================================================================
  // filtrar comidas
  // ======================================================================================
  void _filterMeals(Settings settings) {
    setState(() {
      // ==================================================================================
      // altero as configurações
      this.settings = settings;
      // ==================================================================================
      // altero as comidas disponíveis
      _availableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten && !filterLactose && !filterVegan && !filterVegetarian;
      }).toList();
    });
  }

  // ===================================================================================
  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal) ? _favoriteMeals.remove(meal) : _favoriteMeals.add(meal);
    });
  }
  // ===================================================================================

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: Colors.amber,
        ),
        fontFamily: 'Raleway',
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                color: Colors.white,
              ),
            ),
      ),
      routes: {
        AppRoutes.HOME: (context) => TabsScreen(_favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (context) => CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (context) => MealDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.SETTINGS: (context) => SettingsScreen(settings, _filterMeals),
      },
      // ======================================================================================
      // função de teste que posso usar para criar rotas dinâmicas baseadas no NOME da ROTA
      // ======================================================================================
      // [
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/alguma-coisa') {
      //     return null;
      //   } else if (settings.name == '/outra-coisa') {
      //     return null;
      //   } else {
      //     return MaterialPageRoute(
      //       builder: (_) {
      //         return CategoriesScreen();
      //       },
      //     );
      //   // ]
      //   }
      // },
      // onUnknownRoute: (settings) {},
      // ==================================================================================
      // ==================================================================================
      debugShowCheckedModeBanner: false,
    );
  }
}
