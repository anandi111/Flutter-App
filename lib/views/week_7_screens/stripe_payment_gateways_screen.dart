import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:training_app/utils/buttons.dart';

class StripePaymentGatewayScreen extends StatefulWidget {
  const StripePaymentGatewayScreen({Key? key}) : super(key: key);

  @override
  State<StripePaymentGatewayScreen> createState() => _StripePaymentGatewayScreenState();
}

class _StripePaymentGatewayScreenState extends State<StripePaymentGatewayScreen> {
  Map<String, dynamic>? paymentIntent;
  TextEditingController priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  num price = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Enter payable price"),
                inputFormatters: [
                  FilteringTextInputFormatter.deny("."),
                  FilteringTextInputFormatter.deny("-"),
                  FilteringTextInputFormatter.deny(","),
                  FilteringTextInputFormatter.deny(" "),
                  LengthLimitingTextInputFormatter(6),
                ],
                controller: priceController,
                keyboardType: TextInputType.number,
                onSaved: (val) {
                  setState(() {
                    price = num.parse(val.toString());
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "fill it first...";
                  } else if (value == "0") {
                    return "please fill valid number..";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              MyButton(
                  label: "Make Payment",
                  callback: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      await makePayment();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      print(price);
      paymentIntent = await createPaymentIntent(amount: price.toString(), currency: 'INR');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  setupIntentClientSecret:
                      "sk_test_51MMpGRSHBtlcEYALRsNj9DclgL14rDsHmbtgIxhicaYiRAQL5iK8pmHCdQ1ZgbKRD5rmk1odmNyLAiXcXJ8luxtd00jGMw35fX",
                  // applePay: const PaymentSheetApplePay(
                  //   merchantCountryCode: '+92',
                  // ),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "IN", merchantCountryCode: "+91"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent({required String amount, required String currency}) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
        'description': "test payment",
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51MMpGRSHBtlcEYALRsNj9DclgL14rDsHmbtgIxhicaYiRAQL5iK8pmHCdQ1ZgbKRD5rmk1odmNyLAiXcXJ8luxtd00jGMw35fX',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    print(amount);
    var calculatedAmout = (int.parse(amount)) * 100;
    print(calculatedAmout);
    return calculatedAmout.toString();
  }
}
