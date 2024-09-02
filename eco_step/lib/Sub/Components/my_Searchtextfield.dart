import 'package:flutter/material.dart';

class CustomMapSearchTextfield extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomMapSearchTextfield({required this.title});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(right: 18,left: 12,top: 12),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: IconButton( onPressed: () {

            }, icon: Icon(Icons.search,),),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
