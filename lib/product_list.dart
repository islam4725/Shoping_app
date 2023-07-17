import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:untitled/cart_model.dart';
import 'package:untitled/cart_provider.dart';
import 'package:untitled/db_handler.dart';

import 'cart_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DBHelper? dbHelper = DBHelper();

  List<String> productNameList = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Mixed Friuts Baskit',
    'Cherry',
    'Peach'
  ];

  List<String> productUnitList = [
    'KG',
    'Dozen',
    'KILO',
    'Dozen',
    'KILO',
    'KIlo',
    'Dozen'
  ];

  List<int> productPriceList = [
    10,
    20,
    30,
    40,
    50,
    60,
    70,
  ];

  List<String> productImageList = [
    'https://images.unsplash.com/photo-1544531480-9eadeb3c8f41?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fG1hbmdvfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1557800636-894a64c1696f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8b3JhbmdlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1604425009198-26ab86fc4f8b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Z3JhcHN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8YmFuYW5hfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1662032380132-ee127738fbd7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fG1heGVkJTIwZnJpdXR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1559181567-c3190ca9959b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGZydWl0c3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1602813812581-0713dae489da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8UGVhY2h8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        backgroundColor: Colors.yellow,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
            },

            child: Center(
                child: badges.Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(value.getCounter().toString(), style: TextStyle(color: Colors.white));
                },
              ),
              animationDuration: Duration(milliseconds: 300),
              child: Icon(Icons.shopping_bag_outlined),
            )),
          ),
          SizedBox(width: 20.0),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: productNameList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image(
                                      width: 150,
                                      height: 150,
                                      image: NetworkImage(
                                          productImageList[index])),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          productNameList[index].toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          productUnitList[index].toString() +
                                              " " +
                                              r"$" +
                                              productPriceList[index]
                                                  .toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              dbHelper!
                                                  .insert(Cart(
                                                      id: index,
                                                      productId:
                                                          index.toString(),
                                                      productName:
                                                          productNameList[index]
                                                              .toString(),
                                                      intailPrice:
                                                          productPriceList[
                                                              index],
                                                      productPrice:
                                                          productPriceList[
                                                              index],
                                                      quantity: 1,
                                                      unitTag:
                                                          productUnitList[index]
                                                              .toString(),
                                                      iamge: productImageList[
                                                              index]
                                                          .toString()))
                                                  .then((value) {
                                                print('product added');
                                                cart.addTotalPrice(double.parse(
                                                    productPriceList[index]
                                                        .toString()));
                                                cart.addCounter();
                                              }).onError((error, stackTrace) {
                                                print("the error is "+error.toString());
                                              });
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Add To Cart',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ]),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
