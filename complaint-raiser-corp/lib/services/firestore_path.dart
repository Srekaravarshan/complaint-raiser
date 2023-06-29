class FirestorePath {

  static String complaint(String complaintId) => 'complaints/$complaintId';
  static String complaints() => 'complaints';
}

class StoragePath {
  static String category(String fileName) => 'category/$fileName';
  static String product(String fileName) => 'product/$fileName';
  static String proof(String fileName) => 'product/$fileName';
}