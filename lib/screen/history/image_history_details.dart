import 'dart:typed_data';
import 'dart:io';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../widgets/appbar_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../widgets/constant.dart';

class ImageHistoryDetails extends StatefulWidget {
  const ImageHistoryDetails({Key? key}) : super(key: key);

  @override
  State<ImageHistoryDetails> createState() => _ImageHistoryDetailsState();
}

class _ImageHistoryDetailsState extends State<ImageHistoryDetails> {

  String imageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6Wdgr_b0od6y1Mm8NdHg5RlmN7MSxINk7KmFDx4vbX7_IsGQStk2Z1pdK5TSbA4Fg1Kc&usqp=CAU';

  Future<void> downloadImage() async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;
      String dir = (await getTemporaryDirectory()).path;
      File imageFile = File('$dir/image.jpg');
      await imageFile.writeAsBytes(bytes);

      // Now the image is saved to the device's temporary directory as 'image.jpg'
    }
  }
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 1.0,
        shadowColor: Theme.of(context).colorScheme.shadow,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child:  Icon(Icons.arrow_back_ios,color: isDark?darkTitleColor:kTitleColor,)),
        centerTitle: true,
        title: TitleText(
          isDark: isDark,
          text: lang.S.of(context).imageHistory,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 335,
              width: MediaQuery.of(context).size.width/1.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                    image: AssetImage('images/women.png'))
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: (){
            downloadImage();
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(FeatherIcons.downloadCloud,color: kWhite,),
                const SizedBox(width: 3,),
                Text(lang.S.of(context).download,style: kTextStyle.copyWith(fontWeight: FontWeight.bold,color: kWhite),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
