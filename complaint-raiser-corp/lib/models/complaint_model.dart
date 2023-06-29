import 'package:cloud_firestore/cloud_firestore.dart';

import 'category_model.dart';


enum ComplaintStatus {
  requested,
  accepted,
  completed,
  rejected,
}

String getComplaintStatusString(ComplaintStatus status) {
  switch (status) {
    case ComplaintStatus.requested: return 'Requested';
    case ComplaintStatus.accepted: return 'Accepted';
    case ComplaintStatus.completed: return 'Completed';
    case ComplaintStatus.rejected: return 'Rejected';
  }
}

ComplaintStatus getComplaintStatus (String status) {
  switch (status) {
    case 'Requested': return ComplaintStatus.requested;
    case 'Accepted': return ComplaintStatus.accepted;
    case 'Completed': return ComplaintStatus.completed;
    case 'Rejected': return ComplaintStatus.rejected;
  }
  return ComplaintStatus.requested;
}

class ComplaintModel {
  CategoryType type;
  String id;
  String uid;
  String district;
  String ward;
  String address;
  ComplaintStatus status;
  String imageUrl;
  Timestamp date;
  int attempt;
  String desc;
  String rejectedReason;
  String proofImageUrl;

  ComplaintModel({
    required this.type,
    required this.id,
    required this.uid,
    required this.district,
    required this.ward,
    required this.address,
    required this.status,
    required this.imageUrl,
    required this.date,
    required this.attempt,
    required this.desc,
    required this.rejectedReason,
    required this.proofImageUrl,
  });

  factory ComplaintModel.fromMap(Map data, String docId) {

    print(data);

    String type = data['type'];
    String id = docId;
    String district = data['district'];
    String uid = data['uid'];
    String ward = data['ward'];
    String address = data['address'];
    String status = data['status'];
    String imageUrl = data['imageUrl'];
    Timestamp date = data['date'];
    int attempt = data['attempt'];
    String desc = data['desc'];
    String rejectedReason = data['rejectedReason'];
    String proofImageUrl = data['proofImageUrl'];


    return ComplaintModel(
        type:getCategoryType(type),
        id:id,
        district:district,
        uid:uid,
        ward:ward,
        address:address,
        status:getComplaintStatus(status),
        imageUrl:imageUrl,
        date:date,
        attempt:attempt,
        desc:desc,
        rejectedReason:rejectedReason,
        proofImageUrl:proofImageUrl,
    );
  }

  factory ComplaintModel.fromDoc(QueryDocumentSnapshot data) {

    print(data);

    String type = data.get('type');
    String id = data.id;
    String district = data.get('district');
    String uid = data.get('uid');
    String ward = data.get('ward');
    String address = data.get('address');
    String status = data.get('status');
    String imageUrl = data.get('imageUrl');
    Timestamp date = data.get('date');
    int attempt = data.get('attempt');
    String desc = data.get('desc');
    String rejectedReason = data.get('rejectedReason');
    String proofImageUrl = data.get('proofImageUrl');


    return ComplaintModel(
        type:getCategoryType(type),
        id:id,
        district:district,
        uid:uid,
        ward:ward,
        address:address,
        status:getComplaintStatus(status),
        imageUrl:imageUrl,
        date:date,
        attempt:attempt,
        desc:desc,
        rejectedReason:rejectedReason,
        proofImageUrl:proofImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': getCategoryName(type),
      'id': id,
      'district': district,
      'uid': uid,
      'ward': ward,
      'address': address,
      'status': getComplaintStatusString(status),
      'imageUrl': imageUrl,
      'date': date,
      'attempt': attempt,
      'desc': desc,
      'rejectedReason': rejectedReason,
      'proofImageUrl': proofImageUrl,
    };
  }
}
