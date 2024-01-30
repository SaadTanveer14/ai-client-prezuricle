import 'dart:convert';
import 'package:chat_gpt/model/gateway_list_model.dart';
import 'package:chat_gpt/provider/home_screen_provider.dart';
import 'package:chat_gpt/screen/Payment%20Screen/payment_credentials.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/services/const_information.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_easy_checkout/flutter_paypal_checkout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.usePaypal,required this.useRazorpay, required this.useStripe, required this.useSslCommerz, required this.defaultPaymentMethod, required this.onSuccess, required this.onError, required this.amount});
  final bool usePaypal;
  final bool useRazorpay;
  final bool useStripe;
  final bool useSslCommerz;
  final String defaultPaymentMethod;
  final String amount;
  final Function onSuccess;
  final Function onError;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final primaryColor = const Color(0xFF27AE60);
  final kGreyTextColor = const Color(0xFF828282);
  String? whichPaymentIsChecked;

  @override
  void initState() {
    setState(() {
      whichPaymentIsChecked = widget.defaultPaymentMethod;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    bool isDark=Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 1.0,
        shadowColor: Theme.of(context).colorScheme.shadow,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        iconTheme: IconThemeData(color: isDark?darkTitleColor:lightTitleColor),
        titleSpacing: 10,
        centerTitle: false,
        title: Text("Payment Methods",style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor),),
      ),
      body: Consumer(builder: (_,ref,watch){
        var gateways = ref.watch(gatewayProvider);
        return gateways.when(data: (cred){
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Material(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: whichPaymentIsChecked == 'Paypal' ? primaryColor : kGreyTextColor.withOpacity(0.1))),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: CheckboxListTile(
                        value: whichPaymentIsChecked == 'Paypal',
                        checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        onChanged: (val) {
                          setState(() {
                            val == true ? whichPaymentIsChecked = 'Paypal' : whichPaymentIsChecked = 'Cash on Delivery';
                          });
                        },
                        contentPadding: const EdgeInsets.all(10.0),
                        activeColor: primaryColor,
                        title:  Text(
                          'Paypal',
                          style: TextStyle(
                            color: isDark?darkTitleColor:lightTitleColor,
                          ),
                        ),
                        secondary: Image.asset(
                          'images/paypal-logo.png',
                          height: 50.0,
                          width: 80.0,
                        ),
                      ),
                    ),
                  ).visible(widget.usePaypal),
                  // const SizedBox(
                  //   height: 10.0,
                  // ).visible(widget.useStripe),
                  // Material(
                  //   elevation: 0.0,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //       side: BorderSide(color: whichPaymentIsChecked == 'Stripe' ? primaryColor : kGreyTextColor.withOpacity(0.1))),
                  //   color: Colors.white,
                  //   child: CheckboxListTile(
                  //     value: whichPaymentIsChecked == 'Stripe',
                  //     checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  //     onChanged: (val) {
                  //       setState(() {
                  //         val == true ? whichPaymentIsChecked = 'Stripe' : whichPaymentIsChecked = 'Cash on Delivery';
                  //       });
                  //     },
                  //     contentPadding: const EdgeInsets.all(10.0),
                  //     activeColor: primaryColor,
                  //     title: const Text(
                  //       'Stripe',
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     secondary: Image.asset(
                  //       'images/stripe-logo.png',
                  //       height: 50.0,
                  //       width: 80.0,
                  //     ),
                  //   ),
                  // ).visible(widget.useStripe),
                  // const SizedBox(
                  //   height: 10.0,
                  // ).visible(widget.useRazorpay),
                  // Material(
                  //   elevation: 0.0,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //       side: BorderSide(color: whichPaymentIsChecked == 'Razorpay' ? primaryColor : kGreyTextColor.withOpacity(0.1))),
                  //   color: Colors.white,
                  //   child: CheckboxListTile(
                  //     value: whichPaymentIsChecked == 'Razorpay',
                  //     checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  //     onChanged: (val) {
                  //       setState(() {
                  //         val == true ? whichPaymentIsChecked = 'Razorpay' : whichPaymentIsChecked = 'Cash on Delivery';
                  //       });
                  //     },
                  //     contentPadding: const EdgeInsets.all(10.0),
                  //     activeColor: primaryColor,
                  //     title: const Text(
                  //       'Razorpay',
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     secondary: Image.asset(
                  //       'images/razorpay-logo.png',
                  //       height: 50.0,
                  //       width: 80.0,
                  //     ),
                  //   ),
                  // ).visible(widget.useRazorpay),
                  const SizedBox(
                    height: 10.0,
                  ).visible(widget.useSslCommerz),
                  Material(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: whichPaymentIsChecked == 'SSLCommerz' ? primaryColor : kGreyTextColor.withOpacity(0.1))),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: CheckboxListTile(
                        value: whichPaymentIsChecked == 'SSLCommerz',
                        checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        onChanged: (val) {
                          setState(() {
                            val == true ? whichPaymentIsChecked = 'SSLCommerz' : whichPaymentIsChecked = 'Cash on Delivery';
                          });
                        },
                        contentPadding: const EdgeInsets.all(10.0),
                        activeColor: primaryColor,
                        title:  Text(
                          'SSLCommerz',
                          style: TextStyle(
                            color: isDark?darkTitleColor:lightTitleColor,
                          ),
                        ),
                        secondary: Image.asset(
                          'images/sslcommerz.jpg',
                          height: 50.0,
                          width: 80.0,
                        ),
                      ),
                    ),
                  ).visible(widget.useSslCommerz),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: (){
                      _handlePayment(widget.amount, "usd",cred);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14.0),
                      width: context.width(),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      child: const Center(child: Text('Purchase Now',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }, error: (e,stack){
          return Center(child: Text(e.toString()),);
        }, loading: (){
          return Center(child: CircularProgressIndicator(),);
        });
      }),
    );
  }


  //Handle Multiple Payment system
  _handlePayment(String totalAmount, String currency, GatewayListModel gateway) {
    switch (whichPaymentIsChecked) {
      // case 'Razorpay':
      //   _handleRazorpayPayment(totalAmount, currency);
      //   break;
      case 'Paypal':
        _handlePaypalPayment(totalAmount, currency,gateway);
        break;
      case 'SSLCommerz':
        _handleSslCommerzPayment(totalAmount, currency,gateway);
        break;
      // case 'Stripe':
      //   _handleStripePayment(totalAmount, currency,gateway);
      //   break;
      default:
        _handleCashOnDelivery(totalAmount, currency);
    }
  }

  //Cash on Delivery Payment
  _handleCashOnDelivery(String totalAmount, String currency) {
    widget.onSuccess;
  }

  //Stripe Payment
  createPaymentIntent(String amount, String currency, GatewayListModel gateway) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': stripeCurrency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {'Authorization': 'Bearer ${gateway.data?.stripeClientSecret}', 'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );
      print(response.body);
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  // _handleStripePayment(String totalAmount, String currency, GatewayListModel gateway) async {
  //
  //   try {
  //     //STEP 1: Create Payment Intent
  //     var paymentIntent = await createPaymentIntent((totalAmount.toDouble() * 100).toInt().toString(), stripeCurrency,gateway);
  //     Stripe.publishableKey = gateway.data?.stripeClientId ?? "";
  //     print("TEst Stripe Payment");
  //     //STEP 2: Initialize Payment Sheet
  //     await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //           customerId: paymentIntent['customer'],
  //             paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
  //             style: ThemeMode.light,
  //             merchantDisplayName: 'MaanAi'));
  //     print("Showing intent");
  //     //STEP 3: Display Payment sheet
  //       await Stripe.instance.presentPaymentSheet().then((value) {
  //         widget.onSuccess();
  //         paymentIntent = null;
  //       });
  //   } on StripeException catch (e) {
  //     print(e.toString());
  //     widget.onError();
  //   }
  // }

  Future<void> _handleSslCommerzPayment(String totalAmount, String currency, GatewayListModel gateway) async {

    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        //Use the ipn if you have valid one, or it will fail the transaction.
        ipn_url: "www.ipnurl.com",
        currency: SSLCurrencyType.BDT,
        product_category: "AI",
        sdkType: (gateway.data?.sslcommerzIsLive ?? "1")!= "1"
            ? SSLCSdkType.TESTBOX
            : SSLCSdkType.LIVE,
        store_id: gateway.data?.sslcommerzClientId ?? "1",
        store_passwd: gateway.data?.sslcommerzClientSecret ?? "1",
        total_amount: totalAmount.toDouble(),
        tran_id: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
    try {
      SSLCTransactionInfoModel result = await sslcommerz.payNow();
      print("${gateway.data!.sslcommerzClientId}dfgofhgodhfg");
      if (result.status!.toLowerCase() == "failed") {
        widget.onError();
        Fluttertoast.showToast(
          msg: "Transaction is Failed....",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (result.status!.toLowerCase() == "closed") {
        Fluttertoast.showToast(
          msg: "SDK Closed by User",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        widget.onSuccess();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Razorpay payment
  // _handleRazorpayPayment(String totalAmount, String currency) {
  //   Razorpay razorpay = Razorpay();
  //   var options = {
  //     'key': gateway.data?.razorpayClientId ?? "1",
  //     'amount': totalAmount,
  //     'name': 'Maan AI',
  //     'description': 'Purchase From MAAN AI',
  //     'retry': {'enabled': true, 'max_count': 1},
  //     'send_sms_hash': true,
  //     'external': {
  //       'wallets': ['paytm']
  //     }
  //   };
  //   razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, () {
  //     widget.onError();
  //   });
  //   razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
  //     widget.onSuccess();
  //   });
  //   razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, () {});
  //   razorpay.open(options);
  // }

  //Paypal payment
  _handlePaypalPayment(String totalAmount, String currency, GatewayListModel gateway) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalEasyCheckout(
            sandboxMode: (gateway.data?.paypalIsLive ?? "1") == "1" ? false :true,
            clientId: gateway.data?.paypalClientId ?? "1",
            secretKey: gateway.data?.paypalClientSecret ?? "1",
            returnURL: "https://samplesite.com/return",
            cancelURL: "https://samplesite.com/cancel",
            transactions: [
              {
                "amount": {
                  "total": totalAmount,
                  "currency": paypalCurrency,
                  "details": {
                    "subtotal": totalAmount,
                    "shipping": '0',
                    "shipping_discount": 0
                  }
                },
                "description": "Purchase From $appsName",
                // "payment_options": {
                //   "allowed_payment_method":
                //       "INSTANT_FUNDING_SOURCE"
                // },
                "item_list": {
                  "items": [
                    {
                      "name": appsName,
                      "quantity": 1,
                      "price": totalAmount,
                      "currency": paypalCurrency,
                    }
                  ],
                }
              }
            ],
            note: "Contact us for any questions on your order.",
            onSuccess: (Map params) async {
              widget.onSuccess;
            },
            onError: (error) {
              widget.onError;
            },
            onCancel: (params) {
              widget.onError;
            }),
      ),
    );
  }


}