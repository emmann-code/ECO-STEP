import 'package:flutter/material.dart';
import '../Components/Searchtextfield.dart';
import '../Components/filterbutton.dart';

class SearchAndFilterWidget extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final Function(int) onFilterSelected;

  SearchAndFilterWidget({
    required this.filters,
    required this.selectedIndex,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomMapSearchTextfield(title: 'Search'),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: FilterButtons(
            filters: filters,
            selectedIndex: selectedIndex,
            onSelected: onFilterSelected,
          ),
        ),
      ],
    );
  }
}
