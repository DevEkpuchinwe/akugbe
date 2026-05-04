import 'package:akugbe/api_response_models/klik_model.dart';
import 'package:akugbe/screens/klik_chat_screen.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KlikDetailScreen extends StatelessWidget with AppNavigator {
  final Klik klik;

  KlikDetailScreen({super.key, required this.klik});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(klik.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(klik.imageUrl),
                radius: 50,
              ),
            ),
            SizedBox(height: 20),
            Text("📍 Location: ${klik.location}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text("🔒 Privacy: ${klik.privacy}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text("👥 Max People: ${klik.maxPeople ?? 'No limit'}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text(
                "💰 Total Contribution: \$${klik.totalAmount.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text("💵 Min Contribution: \$${klik.minAmount.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text("⚤ Gender: ${klik.gender}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text("📅 Start Date: ${klik.startDate}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text("📅 End Date: ${klik.endDate}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("📝 Description:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(klik.description ?? "No description provided",
                style: TextStyle(fontSize: 16)),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle joining the klik
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("You have joined ${klik.name}!")),
                  );
                },
                child: Text("Join klik"),
              ),
            ),
            10.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle joining the klik
                  pushTo(
                      context,
                      KlikChatScreen(
                          groupName: "New Klik",
                          groupImageUrl: "groupImageUrl",
                          description: "Klik Description",
                          minContribution: 800,
                          startDate: "23rd August, 2025",
                          endDate: "23rd August, 2025",
                          members: []));
                },
                child: Text("Open klik"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
