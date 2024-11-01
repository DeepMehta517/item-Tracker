import 'package:flutter_test/flutter_test.dart';
import 'package:itemtracker/provider/item_provider.dart';

void main() {
  test('Add item test', () {
    final provider = ItemProvider();
    provider.addItem('Test', 'Description');
    expect(provider.items.length, 1);
  });
}
