import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/cart_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:untitled/db_handler.dart';
import 'cart_model.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    DBHelper db = DBHelper();
    // Stripe.publishableKey = 'pk_test_51NNXchCULQsbOdy2xy1cPczm8QhJSt0PKZezBkKJ3FEX7mHtyQNm1cBBV0BfJ1RHkT0Z44QnK5UL0e9kczp2PhAV00HofOQm6t';

    return Scaffold(
        appBar: AppBar(
          title: Text('MY Products'),
          backgroundColor: Colors.yellow,
          centerTitle: true,
          actions: [
            Center(
                child: badges.Badge(
                  badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return Text(
                        value.getCounter().toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  child: Icon(Icons.shopping_bag_outlined),
                )),
            SizedBox(width: 20.0),
          ],
        ),
        body: Column(
            children: [
            FutureBuilder(
            future: cart.getData(),
        builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(4.0),

                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image(
                                      width: 150,
                                      height: 150,
                                      image: NetworkImage(snapshot
                                          .data![index].iamge
                                          .toString())),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data![index]
                                                    .productName
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    db.delete(snapshot
                                                        .data![index]
                                                        .id!);

                                                    cart.removeCounter();
                                                    cart.removeTotalPrice(
                                                        double.parse(
                                                            snapshot
                                                                .data![index]
                                                                .productPrice
                                                                .toString()));
                                                  },
                                                  child:
                                                  Icon(Icons.delete)),
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              snapshot.data![index]
                                                  .unitTag
                                                  .toString() +
                                                  " " +
                                                  r"$" +
                                                  snapshot.data![index]
                                                      .productPrice
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment:
                                          Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 35,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    5),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        int quantity =
                                                        snapshot
                                                            .data![
                                                        index]
                                                            .quantity!;
                                                        int price = snapshot
                                                            .data![index]
                                                            .intailPrice!;
                                                        quantity--;
                                                        int newPrice =
                                                            quantity *
                                                                price;
                                                        if (quantity >
                                                            0) {
                                                          db
                                                              .update(
                                                              Cart(
                                                                  id: snapshot
                                                                      .data![
                                                                  index]
                                                                      .id,
                                                                  productId: snapshot
                                                                      .data![
                                                                  index]
                                                                      .id
                                                                      .toString(),
                                                                  productName: snapshot
                                                                      .data![
                                                                  index]
                                                                      .productName,
                                                                  intailPrice: snapshot
                                                                      .data![
                                                                  index]
                                                                      .intailPrice,
                                                                  productPrice:
                                                                  newPrice,
                                                                  quantity:
                                                                  quantity,
                                                                  unitTag: snapshot
                                                                      .data![
                                                                  index]
                                                                      .unitTag
                                                                      .toString(),
                                                                  iamge: snapshot
                                                                      .data![
                                                                  index]
                                                                      .iamge
                                                                      .toString()))
                                                              .then(
                                                                  (value) {
                                                                quantity =
                                                                0;
                                                                newPrice =
                                                                0;
                                                                cart
                                                                    .removeTotalPrice(
                                                                    double
                                                                        .parse(
                                                                        snapshot
                                                                            .data![
                                                                        index]
                                                                            .intailPrice
                                                                            .toString()));
                                                              }).onError((error,
                                                              stackTrace) {
                                                            print(error
                                                                .toString());
                                                          });
                                                        }
                                                      },
                                                      child: const Icon(
                                                          Icons.remove,
                                                          color: Colors
                                                              .white),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data![index]
                                                          .quantity
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .white),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        int quantity =
                                                        snapshot
                                                            .data![
                                                        index]
                                                            .quantity!;
                                                        int price = snapshot
                                                            .data![index]
                                                            .intailPrice!;
                                                        quantity++;
                                                        int newPrice =
                                                            quantity *
                                                                price;

                                                        db
                                                            .update(Cart(
                                                            id: snapshot
                                                                .data![
                                                            index]
                                                                .id,
                                                            productId: snapshot
                                                                .data![
                                                            index]
                                                                .id
                                                                .toString(),
                                                            productName: snapshot
                                                                .data![
                                                            index]
                                                                .productName,
                                                            intailPrice: snapshot
                                                                .data![
                                                            index]
                                                                .intailPrice,
                                                            productPrice:
                                                            newPrice,
                                                            quantity:
                                                            quantity,
                                                            unitTag: snapshot
                                                                .data![
                                                            index]
                                                                .unitTag
                                                                .toString(),
                                                            iamge: snapshot
                                                                .data![
                                                            index]
                                                                .iamge
                                                                .toString()))
                                                            .then(
                                                                (value) {
                                                              quantity =
                                                              0;
                                                              newPrice =
                                                              0;
                                                              cart
                                                                  .addTotalPrice(
                                                                  double
                                                                      .parse(
                                                                      snapshot
                                                                          .data![
                                                                      index]
                                                                          .intailPrice
                                                                          .toString()));
                                                            }).onError((error,
                                                            stackTrace) {
                                                          print(error
                                                              .toString());
                                                        });
                                                      },
                                                      child: const Icon(
                                                          Icons.add,
                                                          color: Colors
                                                              .white),
                                                    ),
                                                  ],
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
                      );

                  }),
            );
          } else {
            print("the data is null");
            return const Center(

              child: Image(image: AssetImage('assets/emptyimage.png')),
            );
          }
        }),
    Consumer<CartProvider>(
    builder: (context, value, child) {
    return Visibility(
    visible:
    value.getTotalPrice().toString() == "0.0" ? false : true,
    child: Column(
    children: [
    ReuseableWidget(
    title: 'sub_title',
    value: r'$' + value.getTotalPrice().toStringAsFixed(2))
    ],
    ),
    );
    },
    ),

    TextButton(onPressed: (){

    },

    child: const Text('pay now', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

    )

    ],
    ),
    );
  }
}

class ReuseableWidget extends StatelessWidget {
  final String title, value;

  const ReuseableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme
                .of(context)
                .textTheme
                .subtitle2,
          ),
          Text(
            value.toString(),
            style: Theme
                .of(context)
                .textTheme
                .subtitle2,
          )
        ],
      ),
    );
  }

}
//   Future<void> createPaymentIntent(int price) async {
//     try {
//       // Create the payment intent
//       final paymentIntent = await Stripe.instance.createPaymentIntent(
//         amount: price, // Amount in cents (e.g., $20.00)
//         currency: 'usd',
//         paymentMethodTypes: ['card'],
//       );
//
//       // Handle the payment intent response
//       // You can perform further operations based on the payment intent status, such as displaying a payment confirmation screen.
//       if (paymentIntent.status == PaymentIntentsStatus.RequiresAction) {
//         // Additional action required, e.g., 3D Secure authentication
//         // You need to handle this based on the payment intent's nextAction property
//       } else if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
//         // Payment succeeded, process the order or show a success message
//       } else if (paymentIntent.status == PaymentIntentsStatus.RequiresPaymentMethod) {
//         // Payment requires a different payment method
//       } else {
//         // Handle other status scenarios
//       }
//     } catch (e) {
//       // Handle any errors that occur during the API request
//     }
//   }
// }
