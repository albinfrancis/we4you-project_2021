class DoctorModel {
  String doctorid;
  String name;
  String department;
  String dateAvailable;
  String timeAvailable;

  DoctorModel.fromMap(Map<String, dynamic> data, String id) {
    doctorid = id;
    name = data['name'];
    department = data['specialised'];
    dateAvailable = data['daysAvailable'];
    timeAvailable = data['timeAvailable'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': doctorid,
      'name': name,
      'specialised': department,
      'dateAvailable': dateAvailable,
      'timeAvailable': timeAvailable,
    };
  }
}
