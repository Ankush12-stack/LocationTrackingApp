// lib/screens/member_location_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locationtrackingapp/models/member.dart';
import 'package:intl/intl.dart'; // For formatting dates

class MemberLocationScreen extends StatefulWidget {
  final Member member;

  const MemberLocationScreen({super.key, required this.member});

  @override
  _MemberLocationScreenState createState() => _MemberLocationScreenState();
}

class _MemberLocationScreenState extends State<MemberLocationScreen> {
  late GoogleMapController mapController;
  DateTime selectedDate = DateTime.now(); // Default selected date is today

  // Sample visited locations
  final List<VisitedLocation> allVisitedLocations = [
    VisitedLocation('Location A', const LatLng(37.7749, -122.4194), DateTime.now().subtract(const Duration(hours: 1))),
    VisitedLocation('Location B', const LatLng(37.7849, -122.4294), DateTime.now().subtract(const Duration(days: 1))),
    VisitedLocation('Location C', const LatLng(37.7949, -122.4394), DateTime.now().subtract(const Duration(days: 1, hours: 2))),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter the visited locations based on the selected date
    List<VisitedLocation> filteredLocations = allVisitedLocations.where((location) {
      return isSameDate(location.visitTime, selectedDate);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Location of ${widget.member.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null && pickedDate != selectedDate) {
                setState(() {
                  selectedDate = pickedDate; // Update the selected date
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.member.currentLat, widget.member.currentLng),
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('current_location'),
                  position: LatLng(widget.member.currentLat, widget.member.currentLng),
                ),
              },
            ),
          ),
          // Display the filtered visited locations
          Expanded(
            child: ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredLocations[index].locationName),
                  subtitle: Text('Visited at: ${DateFormat.yMMMd().add_jm().format(filteredLocations[index].visitTime)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to check if two DateTime objects are on the same date
  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}

// Define a VisitedLocation model
class VisitedLocation {
  final String locationName;
  final LatLng coordinates;
  final DateTime visitTime;

  VisitedLocation(this.locationName, this.coordinates, this.visitTime);
}
