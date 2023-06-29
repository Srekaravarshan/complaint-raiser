import 'package:complaint_raiser_official/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/app_themes.dart';
import '../../models/complaint_model.dart';
import '../widgets/widgets.dart';

class ComplaintArguments {
  final ComplaintModel complaint;

  ComplaintArguments(this.complaint);
}

class ComplaintScreen extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintScreen({Key? key, required this.complaint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String date = DateFormat('dd/MM/yyyy').format(complaint.date.toDate());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Complaint'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: AppThemes.lightPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: heading(getComplaintStatusString(complaint.status),
                          color: AppThemes.primaryColor)),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(complaint.imageUrl)),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    heading(getCategoryName(complaint.type),
                        color: AppThemes.primaryColor),
                    Flexible(
                      flex: 1,
                      child: heading(date, color: AppThemes.primaryColor),
                    )
                  ],
                ),
                const Divider(height: 50, color: AppThemes.primaryColor),
                heading('Description:'),
                const SizedBox(height: 10),
                subText(complaint.desc),
                const Divider(height: 50, color: AppThemes.primaryColor),
                heading('Location Details'),
                const SizedBox(height: 10),
                dataText('Ward no:', complaint.ward),
                const SizedBox(height: 6),
                dataText('District:', complaint.district),
                const SizedBox(height: 6),
                subText(complaint.address),
                const Divider(height: 50, color: AppThemes.primaryColor),
                subText('Attempt No: ${complaint.attempt}'),
                if (complaint.rejectedReason.trim().isNotEmpty)
                  const SizedBox(height: 10),
                if (complaint.rejectedReason.trim().isNotEmpty)
                  subText(complaint.rejectedReason),
                const Divider(height: 50, color: AppThemes.primaryColor),
                if (complaint.status == ComplaintStatus.completed)
                  heading('Proof of Completion'),
                if (complaint.status == ComplaintStatus.completed)
                  const SizedBox(height: 18),
                if (complaint.status == ComplaintStatus.completed)
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.network(complaint.proofImageUrl),
                  )
              ],
            ),
          ),
        ));
  }
}
