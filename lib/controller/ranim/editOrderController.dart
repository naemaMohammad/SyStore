import 'package:get/get.dart';

class EditOrderController extends GetxController {

  var products = [
    {
      "image": "assets/images/photo_2026-05-09_17-04-30.jpg",
      "title": "Modern T-shirt",
      "price": 300,
      "size": "M",
      "color": "blue",
      "qty": 1,
    },
    {
      "image": "assets/images/photo_2026-05-09_17-04-30.jpg",
      "title": "Modern T-shirt",
      "price": 200,
      "size": "L",
      "color": "red",
      "qty": 2,
    },
  ].obs;

  void increaseQty(int index) {
    products[index]["qty"] =
        (products[index]["qty"] as int) + 1;
    products.refresh();
  }

  void decreaseQty(int index) {
    int qty = products[index]["qty"] as int;

    if (qty > 1) {
      products[index]["qty"] = qty - 1;
      products.refresh();
    }
  }

  void deleteItem(int index) {
    products.removeAt(index);
  }

  int get total {
    int sum = 0;
    for (var p in products) {
      sum += (p["price"] as int) * (p["qty"] as int);
    }
    return sum;
  }
}