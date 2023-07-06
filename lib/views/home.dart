import 'package:flutter/material.dart';
import 'package:recipe_list/models/recipe.api.dart';
import 'package:recipe_list/models/recipe.dart';
import 'package:recipe_list/widgets/recipe_card.dart';

//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState(title);
//}
class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;
  bool _isLoading = true;
  HomePageState();

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Food Recipe')
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                      title: _recipes[index].name,
                      cookTime: _recipes[index].totalTime,
                      rating: _recipes[index].rating.toString(),
                      thumbnailUrl: _recipes[index].images);
                },
              ));
  }
}
