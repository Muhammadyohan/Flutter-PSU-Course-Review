import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';

class MyEventsSearchBar extends StatefulWidget {
  const MyEventsSearchBar({super.key});

  @override
  State<MyEventsSearchBar> createState() => _MyEventsSearchBarState();
}

class _MyEventsSearchBarState extends State<MyEventsSearchBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: _searchController,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        onChanged: (key) {
          context.read<EventBloc>().add(SearchMyEventsEvent(searchQuery: key));
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.deepPurple,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.clear,
              color: Colors.deepPurple,
            ),
            onPressed: () {
              _searchController.clear();
              context.read<EventBloc>().add(SearchClearEvent());
              FocusScope.of(context).unfocus();
            },
          ),
          hintText: 'Search',
          hintStyle: const TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
