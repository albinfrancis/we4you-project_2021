class OrderModel {
  String oid;
  String customer;
  String date;
  String email;
  String token;
  String totalbill;
  String status;
  List<dynamic> itemlist;

  OrderModel.fromMap(Map<String, dynamic> data, String id) {
    oid = id;
    customer = data['Customer'];
    date = data['date'];
    email = data['email'];
    token = data['token'];
    status = data['status'];
    totalbill = data['totalbill'];
    itemlist = data['Item'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': oid,
      'name': customer,
      'email': email,
      'date': date,
      'token': token,
      'status': status,
      "totalbill": totalbill,
      'itemlist': itemlist.map((i) => i.toMap()).toList(), // this worked well
    };
  }
}
