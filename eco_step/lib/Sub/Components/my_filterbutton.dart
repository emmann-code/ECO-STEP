import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final Function(int) onSelected;

  FilterButtons({
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      ),
      height: 40.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(filters[index]),
              selected: selectedIndex == index,
              onSelected: (isSelected) {
                onSelected(index);
              },
              selectedColor: Theme.of(context).colorScheme.inversePrimary,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              labelStyle: TextStyle(
                color: selectedIndex == index
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        },
      ),
    );
  }
}
