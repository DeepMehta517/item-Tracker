import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../itemTracker/item_model.dart';

class ItemProvider with ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

  void addItem(String name, String description) {
    _items.add(Item(name: name, description: description));
    notifyListeners();
  }

  void editItem(int index, String newName, String newDescription) {
    _items[index] = Item(name: newName, description: newDescription);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
