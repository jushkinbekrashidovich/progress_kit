import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final String startDate;
  final String endDate;
  final bool isPercentage;

  const ProgressCard({
    Key? key,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.isPercentage
  }) : super(key: key);

  String _calculateTimeLeft() {
    DateTime end = DateTime.parse(endDate).add(Duration(days: 1)); // Include end date
    DateTime now = DateTime.now();
    Duration diff = end.difference(now);

    int totalDays = diff.inDays + 1;

    // Show exact days left if totalDays is 60 or less
    if (totalDays <= 60) {
      return "$totalDays days left";
    }

    if (totalDays >= 365) {
      int years = totalDays ~/ 365;
      int remainingDays = totalDays % 365;

      return remainingDays == 0
          ? "$years years left"
          : "$years years $remainingDays days left";
    } else if (totalDays >= 30) {
      int months = totalDays ~/ 30;
      int remainingDays = totalDays % 30;

      return remainingDays == 0
          ? "$months months left"
          : "$months months $remainingDays days left";
    } else {
      int weeks = totalDays ~/ 7;
      int remainingDays = totalDays % 7;

      return remainingDays == 0
          ? "$weeks weeks left"
          : "$weeks weeks $remainingDays days left";
    }
  }




  String _calculatePercentageLeft() {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    DateTime now = DateTime.now();

    int totalDays = end.difference(start).inDays + 1;
    int passedDays = now.isBefore(start)
        ? 0
        : now.difference(start).inDays;

    double percentagePassed = (passedDays / totalDays) * 100;
    double percentageLeft = 100 - percentagePassed;

    return double.parse(percentageLeft.toStringAsFixed(1)).toString() +"% left"; // Keep one decimal place
  }




  Widget _buildDotGrid() {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    DateTime now = DateTime.now();

    int totalDays = end.difference(start).inDays + 1;

    if (totalDays > 720) {
      return _buildYearlyGrid(start, totalDays, now);
    } else {
      return _buildDailyGrid(start, totalDays, now);
    }
  }

  Widget _buildYearlyGrid(DateTime start, int totalDays, DateTime now) {
    int totalYears = (totalDays / 365).floor();

    double dotSize = _getDotSize(totalYears, isYearly: true);

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: List.generate(
        totalYears,
            (index) {
          int year = start.year + index;
          bool isPastYear = year < now.year;
          return Icon(
            Icons.circle,
            size: dotSize,
            color: isPastYear ? Colors.grey[700] : Colors.white,
          );
        },
      ),
    );
  }

  Widget _buildDailyGrid(DateTime start, int totalDays, DateTime now) {
    double dotSize = _getDotSize(totalDays);

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: List.generate(
        totalDays,
            (index) {
              DateTime currentDate = start.add(Duration(days: index));
              DateTime currentDateOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);
              DateTime nowOnly = DateTime(now.year, now.month, now.day);
              return Icon(
                  Icons.circle,
                  size: dotSize,
                  color: currentDateOnly.isBefore(nowOnly) || currentDateOnly.isAtSameMomentAs(now)
                  ? Colors.grey[700] // Passed days
                  : Colors.white); // Today and remaining days
        },
      ),
    );
  }

  double _getDotSize(int total, {bool isYearly = false}) {
    if (isYearly) {
      return total <= 12 ? 32.0 : total <= 46 ? 26.0 : total <= 100 ? 18.0 : 12.0;
    }
    return total <= 12 ? 32.0 : total <= 46 ? 26.0 : total <= 290 ? 10.0 : 8.0;
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            _buildDotGrid(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inconsolata(color: Colors.white, fontSize: 12),
                ),
               isPercentage == false?
                Text(
                  _calculateTimeLeft(),
                  style: GoogleFonts.inconsolata(color: Colors.white70, fontSize: 12),
                ):Text(
                 _calculatePercentageLeft().toString(),
                 style: GoogleFonts.inconsolata(color: Colors.white70, fontSize: 12),
               )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
