class PatientModel {
  String pid;
  String name;
  String email;
  String status;
  String date;
  String doctorName;

  PatientModel.fromMap(Map<String, dynamic> data, String id) {
    pid = id;

    name = data['user'];
    email = data['email'];
    status = data['status'];
    date = data['bookingdate'];
    doctorName = data['doctor'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': pid,
      'user': name,
      'email': email,
      'status': status,
      'bookingdate': date,
      'doctor': doctorName
    };
  }
}
