import 'package:chat_gpt/provider/home_screen_provider.dart';
import 'package:chat_gpt/screen/home/home.dart';
import 'package:chat_gpt/services/repositories.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:nb_utils/nb_utils.dart';


import '../Payment Screen/payment_screen.dart';
import '../widgets/constant.dart';

class BuyCredit extends StatefulWidget {
  const BuyCredit({super.key});
  @override
  State<BuyCredit> createState() => _BuyCreditState();
}

class _BuyCreditState extends State<BuyCredit> {
  @override
  Widget build(BuildContext context) {
    bool isDark=Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title:  Text("Buy Credit",style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor),),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        iconTheme:  IconThemeData(color: isDark?darkTitleColor:lightTitleColor),
        titleTextStyle: kTextStyle.copyWith(color: kTitleColor,fontWeight: FontWeight.bold,fontSize: 18.0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer(builder: (_,ref,watch){
        var credits = ref.watch(creditProvider);
        return credits.when(data: (credit){return ListView.builder(
            itemCount: credit.data?.length ?? 0,
            itemBuilder: (_,i){
              return Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListTile(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PaymentPage(
                              usePaypal: true,
                              useRazorpay: true,
                              useStripe: true,
                              useSslCommerz: true,
                              defaultPaymentMethod: "Stripe",
                              onSuccess: () async{
                                EasyLoading.show(status: "Loading");
                                try{
                                  bool val = await ApiService().buyCreditList(credit.data?[i].id.toString() ?? "");
                                  if(val){
                                    EasyLoading.showSuccess("Credit Purchased Successfully");
                                  }else{
                                    EasyLoading.showError("Error Occured. Try again");
                                  }
                                }catch(e) {
                                  EasyLoading.showError("Error occured. Try again");
                                  Navigator.pop(context);
                                }
                                ref.refresh(profileProvider);
                                Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                              },
                              onError: () async{
                                EasyLoading.showError("Error Occured. Try again");
                                Navigator.pop(context);
                              },
                              amount: credit.data![i].price.toString(),
                            )));
                  },
                  leading: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor
                    ),
                    child: const Icon(Icons.star_rounded,color: Colors.white,),
                  ),
                  title: Text(credit.data?[i].title ?? "",style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor),),
                  trailing: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                       "\$${credit.data?[i].price ?? ""}",style: kTextStyle.copyWith(color: Colors.white),),
                  ),
                ),
              );
            });}, error: (e,stack){
          return Center(child: Text(e.toString()),);
        }, loading: (){
          return const Center(child: CircularProgressIndicator());
        });

      }),
    );
  }
}
