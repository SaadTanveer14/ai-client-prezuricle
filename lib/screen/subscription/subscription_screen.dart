// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:chat_gpt/screen/Payment%20Screen/payment_screen.dart';
import 'package:chat_gpt/screen/subscription/buy_credits_screen.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/home_screen_provider.dart';
import '../../services/repositories.dart';
import '../home/home.dart';
import '../widgets/appbar_widgets.dart';
import 'dart:ui' as ui;
import 'package:chat_gpt/generated/l10n.dart' as lang;
import '../../model/subscription_plan_list_model.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({
    Key? key,
    this.userPlan,
    this.willExpire,
  }) : super(key: key);

  final Data? userPlan;
  final DateTime? willExpire;

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  List<String> featureList = [
    'Free Lifetime Update',
    'Android & iOS App Support',
    'Unlimited Access',
    'Priority Access to Experts',
    'Ad-free Experience',
    'Exclusive Content',
  ];

  List<String> packList = ['Free', 'Monthly', 'Yearly', 'Lifetime'];

  String selectedPack = 'Free';

  List<String> price = [
    '0',
    '20.00',
    '40.00',
    '100.00',
  ];

  Data? selectedProduct;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedProduct = widget.userPlan;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Consumer(builder: (_, ref, watch) {
      var plans = ref.watch(planProvider);
      return plans.when(data: (plan) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            elevation: 1.0,
            shadowColor: Theme.of(context).colorScheme.shadow,
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: ArrowBack(isDark: isDark),
            centerTitle: true,
            title: TitleText(
              isDark: isDark,
              text: lang.S.of(context).premium,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/subs.png"),
                  const SizedBox(height: 20.0),
                  // Image.asset(
                  //   "images/offer.png",
                  //   width: 300,
                  // ),
                  SizedBox(
                    child: RichText(
                      textScaleFactor: 1.05,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                      text: 'Get Awesome Access with ',
                      style: kTextStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 28,color: isDark?darkTitleColor:lightTitleColor),
                      children: [
                        TextSpan(
                          text: '50% OFF',
                          style: kTextStyle.copyWith(color: primaryColor)
                        )
                      ]
                    ),),
                  ),
                  const SizedBox(height: 50.0),
                  ListView.builder(
                      itemCount: plan.data?.length ?? 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedProduct = plan.data?[i];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: (plan.data?[i].id?.toInt() ?? 0) == selectedProduct?.id ? primaryColor.withOpacity(0.5) : Theme.of(context).colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: primaryColor)),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          plan.data?[i].title ?? "",
                                          style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor, fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          plan.data?[i].subtitle ?? "",
                                          style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "\$${plan.data?[i].price?.toInt() ?? 0}",
                                      style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor, fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
          bottomNavigationBar: Consumer(builder: (_, ref, watch) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: !(selectedProduct?.id == widget.userPlan?.id && (widget.willExpire?.isAfter(DateTime.now()) ?? false)),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: kButtonStyle,
                        onPressed: () async {
                          if (selectedProduct!.price!.toDouble() == 0) {
                            EasyLoading.show(status: "Loading");
                            try {
                              bool val = await ApiService().buyPackage(selectedProduct!.id.toString());
                              if (val) {
                                EasyLoading.showSuccess("Subscribed Successfully");
                              } else {
                                EasyLoading.showError("Error Occurred. Try different packages");
                              }
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const Home()));
                            } catch (e) {
                              EasyLoading.showError("You are not allowed to subscribe this package. Try different packages");
                              Navigator.pop(context);
                            }
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PaymentPage(
                                          usePaypal: true,
                                          useRazorpay: true,
                                          useStripe: true,
                                          useSslCommerz: true,
                                          defaultPaymentMethod: "Stripe",
                                          onSuccess: () async {
                                            EasyLoading.show(status: "Loading");
                                            try {
                                              bool val = await ApiService().buyPackage(selectedProduct!.id.toString());
                                              if (val) {
                                                EasyLoading.showSuccess("Subscribed Successfully");
                                              } else {
                                                EasyLoading.showError("Error Occured. Try again");
                                              }
                                              ref.refresh(profileProvider);
                                              Navigator.push(context, MaterialPageRoute(builder: (_) => const Home()));
                                            } catch (e) {
                                              EasyLoading.showError("You are not allowed to subscribe this package. Try different packages");
                                              Navigator.pop(context);
                                            }
                                          },
                                          onError: () async {
                                            EasyLoading.showError("Error Occurred. Try again");
                                            Navigator.pop(context);
                                          },
                                          amount: selectedProduct!.price.toString(),
                                        )));
                          }
                        },
                        child: Text(
                          "Continue",
                          style: kTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BuyCredit(),
                            ),
                          );
                        },
                        child: Text(
                          "Buy Credits",
                          style: kTextStyle.copyWith(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 18.0),
                        )),
                  )
                ],
              ),
            );
          }),
        );
      }, error: (e, stack) {
        return Scaffold(
          body: Center(
            child: Text(e.toString()),
          ),
        );
      }, loading: () {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
    });
  }
}

//_____________________________________________________________________-Subscription_container
class SubscriptionContainer extends CustomPainter {
  final bool isDark;

  SubscriptionContainer(this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.002985075, size.height * 0.02114163);
    path_0.cubicTo(size.width * 0.002985075, size.height * 0.01063304, size.width * 0.01501325, size.height * 0.002114165, size.width * 0.02985075, size.height * 0.002114165);
    path_0.lineTo(size.width * 0.9701493, size.height * 0.002114165);
    path_0.cubicTo(size.width * 0.9849881, size.height * 0.002114165, size.width * 0.9970149, size.height * 0.01063307, size.width * 0.9970149, size.height * 0.02114165);
    path_0.lineTo(size.width * 0.9970149, size.height * 0.9450317);
    path_0.cubicTo(size.width * 0.9970149, size.height * 0.9555412, size.width * 0.9849881, size.height * 0.9640592, size.width * 0.9701493, size.height * 0.9640592);
    path_0.lineTo(size.width * 0.6245522, size.height * 0.9640592);
    path_0.cubicTo(size.width * 0.6241493, size.height * 0.9640592, size.width * 0.6237463, size.height * 0.9640529, size.width * 0.6233254, size.height * 0.9640423);
    path_0.cubicTo(size.width * 0.6201284, size.height * 0.9639598, size.width * 0.6060507, size.height * 0.9636681, size.width * 0.5904597, size.height * 0.9644799);
    path_0.cubicTo(size.width * 0.5826657, size.height * 0.9648858, size.width * 0.5744299, size.height * 0.9655708, size.width * 0.5669552, size.height * 0.9667082);
    path_0.cubicTo(size.width * 0.5595373, size.height * 0.9678372, size.width * 0.5526030, size.height * 0.9694503, size.width * 0.5475970, size.height * 0.9718140);
    path_0.cubicTo(size.width * 0.5364388, size.height * 0.9770825, size.width * 0.5258627, size.height * 0.9835074, size.width * 0.5177761, size.height * 0.9885603);
    path_0.cubicTo(size.width * 0.5165433, size.height * 0.9893298, size.width * 0.5153731, size.height * 0.9900655, size.width * 0.5142716, size.height * 0.9907590);
    path_0.cubicTo(size.width * 0.5117224, size.height * 0.9923615, size.width * 0.5095254, size.height * 0.9937400, size.width * 0.5077194, size.height * 0.9948224);
    path_0.cubicTo(size.width * 0.5064239, size.height * 0.9955962, size.width * 0.5054030, size.height * 0.9961712, size.width * 0.5046507, size.height * 0.9965433);
    path_0.cubicTo(size.width * 0.5046179, size.height * 0.9965603, size.width * 0.5045881, size.height * 0.9965751, size.width * 0.5045612, size.height * 0.9965877);
    path_0.cubicTo(size.width * 0.5044776, size.height * 0.9965433, size.width * 0.5043881, size.height * 0.9964947, size.width * 0.5042955, size.height * 0.9964419);
    path_0.cubicTo(size.width * 0.5034179, size.height * 0.9959535, size.width * 0.5022418, size.height * 0.9952199, size.width * 0.5007552, size.height * 0.9942579);
    path_0.cubicTo(size.width * 0.4997851, size.height * 0.9936300, size.width * 0.4986925, size.height * 0.9929133, size.width * 0.4974955, size.height * 0.9921268);
    path_0.cubicTo(size.width * 0.4950896, size.height * 0.9905476, size.width * 0.4922657, size.height * 0.9886913, size.width * 0.4891761, size.height * 0.9867421);
    path_0.cubicTo(size.width * 0.4798925, size.height * 0.9808879, size.width * 0.4676925, size.height * 0.9738478, size.width * 0.4550209, size.height * 0.9695518);
    path_0.cubicTo(size.width * 0.4446925, size.height * 0.9660507, size.width * 0.4308149, size.height * 0.9646342, size.width * 0.4189701, size.height * 0.9640930);
    path_0.cubicTo(size.width * 0.4070358, size.height * 0.9635476, size.width * 0.3967731, size.height * 0.9638774, size.width * 0.3934567, size.height * 0.9640127);
    path_0.cubicTo(size.width * 0.3927612, size.height * 0.9640423, size.width * 0.3920955, size.height * 0.9640592, size.width * 0.3914299, size.height * 0.9640592);
    path_0.lineTo(size.width * 0.02985075, size.height * 0.9640592);
    path_0.cubicTo(size.width * 0.01501325, size.height * 0.9640592, size.width * 0.002985075, size.height * 0.9555412, size.width * 0.002985075, size.height * 0.9450317);
    path_0.lineTo(size.width * 0.002985075, size.height * 0.02114163);
    path_0.close();
    path_0.moveTo(size.width * 0.5053224, size.height * 0.9969493);
    path_0.cubicTo(size.width * 0.5053313, size.height * 0.9969535, size.width * 0.5053104, size.height * 0.9969471, size.width * 0.5052597, size.height * 0.9969281);
    path_0.cubicTo(size.width * 0.5052955, size.height * 0.9969387, size.width * 0.5053194, size.height * 0.9969471, size.width * 0.5053224, size.height * 0.9969493);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.005970149;
    paint0Stroke.shader = ui.Gradient.linear(
        Offset(size.width * 1, size.height * 0.04651163),
        Offset(size.width * 1, size.height),
        [const Color(0xff8756FD).withOpacity(0.1), const Color(0xff8756FD).withOpacity(0.25), const Color(0xff8756FD).withOpacity(0.3), const Color(0xff2658F5).withOpacity(1)],
        [0.031483, 0.611278, 0.829382, 1]);
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = isDark ? const Color(0xff1A1D25) : const Color(0xffFFFFFF);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
