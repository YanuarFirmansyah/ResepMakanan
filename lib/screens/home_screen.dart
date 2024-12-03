import 'package:flutter/material.dart';
import '../db_helper.dart';
import 'add_recipe_screen.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final data = await DBHelper().getRecipes();
    setState(() {
      _recipes = data;
    });
  }

  void _deleteRecipe(int id) async {
    await DBHelper().deleteRecipe(id);
    _loadRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resep Masakan'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.blue.shade100, // Background warna solid biru muda
        child: _recipes.isEmpty
            ? Center(
                child: Text(
                  'Belum ada resep. Tambahkan!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: _recipes.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  final recipe = _recipes[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue.shade300,
                        child: Icon(
                          Icons.restaurant_menu,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        recipe['name'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      subtitle: Text(
                        'Waktu: ${recipe['preparation_time']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade600,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecipeDetailScreen(recipe: recipe),
                          ),
                        ).then((_) => _loadRecipes());
                      },
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                        onPressed: () => _deleteRecipe(recipe['id']),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRecipeScreen()),
          ).then((_) => _loadRecipes());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
