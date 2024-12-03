import 'package:flutter/material.dart';
import '../db_helper.dart';
import 'add_recipe_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  void _deleteRecipe(BuildContext context) async {
    await DBHelper().deleteRecipe(recipe['id']);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.blue.shade100,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Waktu Persiapan: ${recipe['preparation_time']}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Bahan-bahan:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              recipe['ingredients'],
              style: TextStyle(fontSize: 16, color: Colors.blue.shade600),
            ),
            SizedBox(height: 16),
            Text(
              'Langkah-langkah:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              recipe['instructions'],
              style: TextStyle(fontSize: 16, color: Colors.blue.shade600),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddRecipeScreen(
                          recipe: recipe,
                        ),
                      ),
                    ).then((_) => Navigator.pop(context, true));
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade300,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _deleteRecipe(context),
                  icon: Icon(Icons.delete),
                  label: Text('Hapus'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
