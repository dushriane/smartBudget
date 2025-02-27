import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategorySelector({super.key, required this.onCategorySelected});

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final List<String> _categories = [
    'Food',
    'Transport',
    'Rent',
    'Entertainment',
    'Shopping',
    'Health',
    'Education',
    'Other'
  ];

  String _selectedCategory = 'Food'; // Default category

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      items: _categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedCategory = value;
          });
          widget.onCategorySelected(value);
        }
      },
      decoration: InputDecoration(
        labelText: 'Select Category',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
