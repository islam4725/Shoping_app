

class Cart{

  late final int? id;
  final String? productId;
  final String? productName;
  final int? intailPrice;
  final int? productPrice;
  final int? quantity;
  final String? unitTag;
  final String? iamge;


  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.intailPrice,
    required this.productPrice,
    required this.quantity,
    required this.unitTag,
    required this.iamge,
});

  Cart.fromMap(Map<dynamic,dynamic> res):
      id = res['id'],
        productId = res['productId'],
        productName = res['productName'],
        intailPrice = res['intailPrice'],
        productPrice = res['productPrice'],
        quantity = res['quantity'],
        unitTag = res['unitTag'],
        iamge = res['iamge'];

  Map<String,Object?> toMap(){
    return {
      'id' : id,
      'productId' : productId,
      'productName' : productName,
      'intailPrice' : intailPrice,
      'productPrice' : productPrice,
      'quantity' : quantity,
      'unitTag' : unitTag,
      'iamge' : iamge,
    };
  }


}