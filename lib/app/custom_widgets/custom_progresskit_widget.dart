import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    DateTime now = DateTime.now();

    int totalDays = end.difference(start).inDays + 1; // Include end date.
    int passedDays = now.isAfter(start) ? now.difference(start).inDays : 0;

    return Card(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(

              child: LayoutBuilder(
                builder: (context, constraints) {
                  double availableWidth = constraints.maxWidth;
                  double spacing = 6; // Adjust spacing dynamically if needed
                  int crossAxisCount = (availableWidth / 20).floor(); // Dynamically calculate columns
                  double dotSize = (availableWidth / crossAxisCount) - spacing;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                    ),
                    itemCount: totalDays,
                    itemBuilder: (context, index) {
                      DateTime currentDate = start.add(Duration(days: index));
                      return Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentDate.isBefore(now)
                              ? Colors.grey // Passed days
                              : Colors.white, // Today and remaining days
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inconsolata(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                Text(
                  _calculateTimeLeft(),
                  style: GoogleFonts.inconsolata(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
