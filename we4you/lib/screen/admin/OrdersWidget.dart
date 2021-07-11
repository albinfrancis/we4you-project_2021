import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we4you/modelz/orderz.dart';
import 'package:we4you/screen/admin/OrderDetails.dart';
import 'package:we4you/utils/colors.dart';

class OrdersWidget extends StatelessWidget {
  final OrderModel orderList;

  const OrdersWidget({Key key, this.orderList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, bottom: 12),
      child: InkWell(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  OrderDetails(orderList, prefs.getString('usertype'))));
        },
        child: Ink(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(108, 116, 138, 1).withOpacity(0.15),
                      blurRadius: 4,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          '(OrderId :' + orderList.oid + ")\n",
                          style: TextStyle(
                              color: Color(0XFF000000),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                    ],
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                        text: 'Order placed on :' + orderList.date,
                        style: TextStyle(
                            color: kcTextLight,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: '\nOrder status :' + orderList.status,
                            style: TextStyle(
                                color: kcTextLight,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          )
                        ]),
                  ),
                  trailing: Container(
                    width: 24,
                    height: 24,
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/ic_nextarrow.png')),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
