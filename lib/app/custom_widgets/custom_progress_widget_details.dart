import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressCardDetails extends StatelessWidget {
  final String title;
  final String startDate;
  final String endDate;


  const ProgressCardDetails({
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

    int totalDays = end.difference(start).inDays + 1; // Include end date.
    int passedDays = now.isAfter(start) ? now.difference(start).inDays : 0;

    // Determine dot size based on the total number of days
    double dotSize = totalDays <= 12
        ? 32.0 // Large dots for small ranges
        : totalDays <= 46
        ? 30.0 // Medium dots for mid ranges
        : totalDays <= 62
        ? 26.0
        : totalDays <= 100
        ? 24.0
        : totalDays <= 188
        ? 22.0

        : totalDays <= 290
        ? 20.0

        :
    18.0; // dots for larger ranges

    return
      Wrap(
        spacing: 6, // Space between dots
        runSpacing: 6, // Space between rows
        children: List.generate(
          totalDays,
              (index) {
            DateTime currentDate = start.add(Duration(days: index));
            return Icon(
              Icons.circle,
              size: dotSize,
              color: currentDate.isBefore(now)
                  ? Colors.grey[700] // Passed days
                  : Colors.white, // Today and remaining days
            );
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Card(

      color: Colors.black,

      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildDotGrid(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inconsolata(
                        color: Colors.white, fontSize: 12
                    ),
                  ),
                  Text(
                    _calculateTimeLeft(),
                    style:  GoogleFonts.inconsolata(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}