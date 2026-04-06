import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/core/widgets/app_section_card.dart';
import 'package:flutter/material.dart';

class TaskHomePage extends StatelessWidget {
  const TaskHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.taskPageTitle)),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppSectionCard(
              title: AppStrings.appName,
              subtitle: AppStrings.taskPageSubtitle,
            ),
          ],
        ),
      ),
    );
  }
}
