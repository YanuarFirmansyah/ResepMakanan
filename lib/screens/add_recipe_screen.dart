import 'package:flutter/material.dart';
import '../db_helper.dart';

class AddRecipeScreen extends StatefulWidget {
  final Map<String, dynamic>? recipe;

  const AddRecipeScreen({Key? key, this.recipe}) : super(key: key);

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _timeController;
  late TextEditingController _ingredientsController;
  late TextEditingController _instructionsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.recipe?['name'] ?? '');
    _timeController =
        TextEditingController(text: widget.recipe?['preparation_time'] ?? '');
    _ingredientsController =
        TextEditingController(text: widget.recipe?['ingredients'] ?? '');
    _instructionsController =
        TextEditingController(text: widget.recipe?['instructions'] ?? '');
  }

  Future<void> _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      final recipe = {
        'name': _nameController.text,
        'preparation_time': _timeController.text,
        'ingredients': _ingredientsController.text,
        'instructions': _instructionsController.text,
      };
      if (widget.recipe == null) {
        await DBHelper().insertRecipe(recipe);
      } else {
        await DBHelper().updateRecipe(widget.recipe!['id'], recipe);
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe == null ? 'Tambah Resep' : 'Edit Resep'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.blue.shade100,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Resep',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama resep tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Waktu Persiapan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Waktu persiapan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _ingredientsController,
                decoration: InputDecoration(
                  labelText: 'Bahan-bahan',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bahan-bahan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _instructionsController,
                decoration: InputDecoration(
                  labelText: 'Langkah-langkah',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Langkah-langkah tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _saveRecipe,
                icon: Icon(Icons.save),
                label: Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
