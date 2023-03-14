import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:training_app/utils/appbar.dart';

class PaymentGatewayScreen extends StatefulWidget {
  const PaymentGatewayScreen({Key? key}) : super(key: key);

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  late Razorpay razorpay;

  @override
  void initState() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.initState();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_NNbwJ9tmM0fbxj',
      'amount': 25000,
      'name': 'Anjali',
      'description': 'Payment',
      'prefill': {'contact': '9999999999', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS: ${response.paymentId}");
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "ERROR: ${response.code} - ${response.message}");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: ${response.walletName}");
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Payment Gateways"),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            ClipOval(
              child: Image.network(
                  'https://images.unsplash.com/photo-1565958011703-44f9829ba187?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80',
                  height: 200.0,
                  width: 200.0,
                  fit: BoxFit.cover),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Delicious cake with raspberries",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('\u{20B9} 250',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  openCheckout();
                },
                child: Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: Colors.pink),
                    child: const Center(
                        child: Text('Checkout',
                            style: TextStyle(
                                fontFamily: 'nunito',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)))))
          ],
        ),
      ),
    );
    ;
  }
}
