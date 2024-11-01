import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/item_provider.dart';

class ItemTrackerScreen extends StatelessWidget {
  const ItemTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey _itemKey = GlobalKey();
    final itemProvider = Provider.of<ItemProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox box = _itemKey.currentContext?.findRenderObject() as RenderBox;
      print("Widget position: ${box.localToGlobal(Offset.zero)}");
      print("Widget size: ${box.size}");
    });

    return Scaffold(
      key: _itemKey,
      appBar: AppBar(backgroundColor: Colors.blue, title: const Text('Item Tracker')),
      body: SafeArea(
        child: ListView.builder(
          itemCount: itemProvider.items.length,
          itemBuilder: (context, index) {
            final item = itemProvider.items[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showEditDialog(context, itemProvider, index);
                    },
                  ),
                  IconButton(icon: const Icon(Icons.delete), onPressed: () => _showDeleteDialog(context, itemProvider, index)),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showAddDialog(context, itemProvider);
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context, ItemProvider provider) {
    String name = '';
    String description = '';
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              title: const Text('Add Item'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) => name = value,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    onChanged: (value) => description = value,
                    decoration: const InputDecoration(labelText: 'Description'),
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      if (name.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Name cannot be empty!!")));
                        return;
                      }
                      provider.addItem(name, description);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'))
              ]);
        });
  }

  void _showEditDialog(BuildContext context, ItemProvider provider, int index) {
    String name = provider.items[index].name;
    String description = provider.items[index].description;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              title: const Text('Edit Item'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                      onChanged: (value) => name = value,
                      controller: TextEditingController(text: name),
                      decoration: const InputDecoration(labelText: 'Name')),
                  TextField(
                      onChanged: (value) => description = value,
                      controller: TextEditingController(text: description),
                      decoration: const InputDecoration(labelText: 'Description')),
                ],
              ),
              actions: [
                TextButton(
                    style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue)),
                    onPressed: () {
                      provider.editItem(index, name, description);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save', style: TextStyle(color: Colors.white)))
              ]);
        });
  }

  void _showDeleteDialog(BuildContext context, ItemProvider provider, int index) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(title: const Text('Are you sure, you want to delete this item ??'), actions: [
            TextButton(
              style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.red)),
              onPressed: () {
                provider.removeItem(index);
                Navigator.of(context).pop();
              },
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
            ),
          ]);
        });
  }
}
