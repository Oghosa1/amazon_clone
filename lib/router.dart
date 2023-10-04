import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/screens/auth_screen.dart';
import 'package:amazon_clone/screens/category_deals_screen.dart';
import 'package:amazon_clone/screens/home_screen.dart';
import 'package:amazon_clone/screens/product_details.dart';
import 'package:flutter/material.dart';

import 'admin/screens/add_product_screen.dart';
import 'screens/search_screen.dart';
import 'widgets/bottom_bar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());

    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());

    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(searchQuery: searchQuery));

    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as ProductModel;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(productModel: product));

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(category: category));

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
