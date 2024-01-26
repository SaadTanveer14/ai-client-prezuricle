import 'dart:typed_data';

import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;

import '../widgets/appbar_widgets.dart';

class ViewImage extends StatefulWidget {
  const ViewImage({
    Key? key,
    required this.url,
    required this.title
  }) : super(key: key);

  final String url;
  final String title;

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
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
          text: widget.title,
        ),
      ),
      body: Center(
        child: Container(
          height: 335,
          width: 335,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(widget.url),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: kButtonStyle,
            onPressed: () async{
              EasyLoading.show(status: "Downloading Image");
              try {
                // Fetch the image data using http
                final response = await http.get(Uri.parse(widget.url));

                // Save the image to the gallery
                final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.bodyBytes));

                if (result != null && result['isSuccess']) {
                  EasyLoading.showSuccess('Image saved to gallery');
                } else {
                  EasyLoading.showError('Failed to save image');
                }
              } catch (e) {
                EasyLoading.showError('Error downloading or saving image: $e');
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  FeatherIcons.downloadCloud,
                  color: kWhite,
                ),
                const SizedBox(width: 10.0),
                Text(
                  'Download',
                  style: kTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
