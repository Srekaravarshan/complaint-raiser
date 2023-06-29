import 'package:complaint_raiser_corp/constants/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/category_model.dart';
import '../../../models/complaint_model.dart';
import '../../../routes.dart';
import '../../complaints/complaint_screen.dart';
import '../widgets.dart';

class ComplaintCard extends StatelessWidget {
  final ComplaintModel complaint;
  const ComplaintCard({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd/MM/yyyy').format(complaint.date.toDate());

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.complaint,
          arguments: ComplaintArguments(complaint)),
      child: Container(
        decoration: BoxDecoration(
            color: AppThemes.lightPrimaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading(getCategoryName(complaint.type)),
                  const SizedBox(height: 12),
                  subText(complaint.desc),
                  const SizedBox(height: 12),
                  ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        complaint.imageUrl,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(height: 12),
                  heading2('Address'),
                  const SizedBox(height: 8),
                  subText(complaint.address),
                  const SizedBox(height: 12),
                  heading2('Date: $date')
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppThemes.primaryColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10))),
              padding: const EdgeInsets.all(15),
              child: Text(
                getComplaintStatusString(complaint.status),
                style: const TextStyle(
                    color: AppThemes.light,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
