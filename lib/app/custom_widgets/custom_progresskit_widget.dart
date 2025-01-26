import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final String startDate;
  final String endDate;

  const ProgressCard({
    Key? key,
    required this.title,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  String _calculateTimeLeft() {
    DateTime end = DateTime.parse(endDate);
    DateTime now = DateTime.now();
    Duration diff = end.difference(now);

    return "${diff.inDays} days left";
  }

  double _calculateCompletionPercentage() {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    DateTime now = DateTime.now();

    int totalDays = end.difference(start).inDays;
    int passedDays = now.isAfter(start) ? now.difference(start).inDays : 0;

    return (passedDays / totalDays) * 100;
  }

  Widget _buildDotGrid() {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    DateTime now = DateTime.now();

    int totalDays = end.difference(start).inDays + 1; // Include the end date.
    int passedDays = now.isAfter(start) ? now.difference(start).inDays : 0;

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: List.generate(
        totalDays,
            (index) => Icon(
          Icons.circle,
          size: 8,
          color: index < passedDays
              ? Colors.white // Passed days
              : Colors.white, // Remaining days
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double completionPercentage = _calculateCompletionPercentage();
    return Card(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  _calculateTimeLeft(),
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDotGrid(),
          ],
        ),
      ),
    );
  }
}
