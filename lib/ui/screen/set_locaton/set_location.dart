import 'package:flutter/material.dart';
import 'package:school_finder/core/color.dart';

class SetLocation extends StatelessWidget {
  SetLocation({Key? key}) : super(key: key);

  // Dummy list of schools with their icons
  final List<Map<String, dynamic>> dummySchools = [
    {'name': 'School A', 'icon': Icons.school},
    {'name': 'School B', 'icon': Icons.school},
    {'name': 'School C', 'icon': Icons.school},
    {'name': 'School D', 'icon': Icons.school},
    // Add more dummy schools as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: logoColor,
        title: const Text('Admin'),
      ),
      body: ListView.builder(
        itemCount: dummySchools.length,
        itemBuilder: (BuildContext context, int index) {
          final school = dummySchools[index];
          return ListTile(
            leading: Icon(school['icon']), // Displaying the school icon
            title: Text(school['name']), // Displaying the school name
            onTap: () {
              // Perform action when the school is tapped
              print('Selected school: ${school['name']}');
            },
          );
        },
      ),
    );
  }
}
