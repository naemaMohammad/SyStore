import 'package:flutter/material.dart';

class OrderFilters extends StatefulWidget {
  const OrderFilters({super.key});

  @override
  State<OrderFilters> createState() => _OrderFiltersState();
}

class _OrderFiltersState extends State<OrderFilters> {
  int selectedIndex = 0;

  final List<String> filters = [
    "All",
    "Process",
    "Preparing",
    "On the way",
    "Delivered",
    "Cancelled",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ChoiceChip(
              showCheckmark: false,
              label: Text(filters[index]),
              selected: selectedIndex == index,
              onSelected: (val) {
                setState(() {
                  selectedIndex = index;
                });
              },
              selectedColor: const Color.fromARGB(255, 124, 122, 126),
              backgroundColor: Colors.grey.shade100,
              labelStyle: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.black,
              ),
            ),
          );
        }),
      ),
    );
  }
}
