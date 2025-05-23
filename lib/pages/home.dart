import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodDeliveryApp/pages/details.dart';
import 'package:foodDeliveryApp/service/database.dart';
import 'package:foodDeliveryApp/widgets/widget_support.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burguer = false;

  Stream? fooditemStream;

  ontheload() async {
    fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allItemsVertically() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      detail: ds["Detail"],
                                      name: ds["Name"],
                                      price: ds["Price"],
                                      image: ds["Image"],
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20.0, bottom: 20.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                Column(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        ds["Name"],
                                        style:
                                            AppWidget.semiBooldTextFeildStyle(),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        ds["Detail"],
                                        style: AppWidget.LightTextFeildStyle(),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        "\$" + ds["Price"],
                                        style:
                                            AppWidget.semiBooldTextFeildStyle(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  // Widget allItems() {
  //   return StreamBuilder(
  //       stream: fooditemStream,
  //       builder: (context, AsyncSnapshot snapshot) {
  //         return snapshot.hasData
  //             ? ListView.builder(
  //                 padding: EdgeInsets.zero,
  //                 itemCount: snapshot.data.docs.length,
  //                 shrinkWrap: true,
  //                 scrollDirection: Axis.horizontal,
  //                 itemBuilder: (context, index) {
  //                   DocumentSnapshot ds = snapshot.data.docs[index];
  //                   return GestureDetector(
  //                     onTap: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => Details(
  //                                     detail: ds["Detail"],
  //                                     name: ds["Name"],
  //                                     price: ds["Price"],
  //                                     image: ds["Image"],
  //                                   )));
  //                     },
  //                     child: Container(
  //                       margin: EdgeInsets.all(4),
  //                       child: Material(
  //                           elevation: 5.0,
  //                           borderRadius: BorderRadius.circular(20),
  //                           child: Container(
  //                             padding: EdgeInsets.all(14),
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 ClipRRect(
  //                                   borderRadius: BorderRadius.circular(20),
  //                                   child: Image.network(
  //                                     ds["Image"],
  //                                     height: 135,
  //                                     width: 180,
  //                                     fit: BoxFit.cover,
  //                                   ),
  //                                 ),
  //                                 SizedBox(height: 5.0),
  //                                 Text(
  //                                   ds["Name"],
  //                                   style: AppWidget.semiBooldTextFeildStyle(),
  //                                 ),
  //                                 SizedBox(height: 5.0),
  //                                 Text(
  //                                   ds["Detail"],
  //                                   style: AppWidget.LightTextFeildStyle(),
  //                                 ),
  //                                 SizedBox(height: 5.0),
  //                                 Text(
  //                                   "\$" + ds["Price"],
  //                                   style: AppWidget.semiBooldTextFeildStyle(),
  //                                 )
  //                               ],
  //                             ),
  //                           )),
  //                     ),
  //                   );
  //                 })
  //             : CircularProgressIndicator();
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(
        top: 50.0,
        left: 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Text("Delicious Food", style: AppWidget.HeadlineTextFeildStyle()),
            Text("Descubre y consigue buena comida.",
                style: AppWidget.LightTextFeildStyle()),
            SizedBox(height: 20.0),
            Container(margin: EdgeInsets.only(right: 20.0), child: showItem()),
            SizedBox(height: 30.0),
            // Container(height: 270, child: allItems()),
            SizedBox(height: 30.0),
            allItemsVertically(),
          ],
        ),
      ),
    ));
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            icecream = true;
            pizza = false;
            salad = false;
            burguer = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Icecream");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: icecream ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "assets/helado.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = true;
            salad = false;
            burguer = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "assets/pizza.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            salad = true;
            burguer = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Salad");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "assets/ensaladaa.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            salad = false;
            burguer = true;
            fooditemStream = await DatabaseMethods().getFoodItem("Burger");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: burguer ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "assets/hamburguesa.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: burguer ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
