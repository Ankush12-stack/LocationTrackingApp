import 'package:flutter/material.dart';
import 'package:locationtrackingapp/member_location_screen.dart';  // Import location screen
import 'package:locationtrackingapp/models/member.dart';  // Import Member class

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Tracking App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  // Mock data: list of members
  final List<Member> members = [
    Member(
      name: 'John Doe', 
      currentLat: 37.7749, 
      currentLng: -122.4194),
    Member(
      name: 'Jane Smith', 
      currentLat: 40.7128, 
      currentLng: -74.0060),
  ]; 
   AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(members[index].name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.info),
                  onPressed: () {
                    // Handle member details logic
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.location_on),
                  onPressed: () {
                    // Navigate to Member Location screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemberLocationScreen(member: members[index]),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
