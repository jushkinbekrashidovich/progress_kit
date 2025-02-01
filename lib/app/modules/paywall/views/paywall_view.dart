import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/theme/app_colors.dart';
import '../controllers/paywall_controller.dart';

class PaywallView extends GetView<PaywallController> {
  const PaywallView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ProgressKit pro",style: GoogleFonts.inconsolata(fontSize: 17.5, color: AppColors.white),),
        ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Subscription Cards
            _buildSubscriptionCard("Monthly", "\$1.07"),
            _buildSubscriptionCard("Annual", "\$9.07"),

            // Cancel Anytime Text
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Center(
                child: Text(
                  "cancel anytime.\nor",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),

            // Lifetime Card
            _buildSubscriptionCard("Lifetime", "\$27.07", isLifetime: true),

            // Lifetime Description
            const Padding(
              padding: EdgeInsets.only(top: 2, bottom: 15),
              child: Center(
                child: Text(
                  "Pay once. Unlimited access forever",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
           SizedBox(height: 14,),
            // Features List
            _buildFeatureItem("Unlimited number of widgets"),
            _buildFeatureItem("Access to future updates"),
            _buildFeatureItem("Access to future updates"),
            _buildFeatureItem("Access to future updates"),

            const Spacer(),

            // Restore Purchase
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Already subscribed? Restore the purchase",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(String title, String price, {bool isLifetime = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              price,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.yellow),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

