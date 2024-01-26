// import 'package:chat_gpt/screen/history/image_history_details.dart';
// import 'package:chat_gpt/screen/widgets/constant.dart';
// import 'package:community_material_icon/community_material_icon.dart';
// import 'package:flutter/material.dart';
// import 'package:chat_gpt/generated/l10n.dart' as lang;
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:nb_utils/nb_utils.dart';
// import '../../theme/theme.dart';
// import '../widgets/appbar_widgets.dart';
// class HistoryScreen extends StatefulWidget {
//   const HistoryScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }
//
// class _HistoryScreenState extends State<HistoryScreen> with TickerProviderStateMixin {
//   late TabController controller;
//   int activeIndex=0;
//   @override
//   void initState() {
//     controller=TabController(
//         length: 2, vsync: this,initialIndex: activeIndex);
//     super.initState();
//   }
//   List<String> titleList=[
//     'Education Image',
//     'Gardening  Image',
//     'Plant Image',
//     'Best gardening Image',
//     'Education Image',
//     'Education Image',
//     'Education Image',
//     'Education Image',
//     'Education Image',
//     'Gardening  Image',
//     'Plant Image',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     bool isDark = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1.0,
//         shadowColor: Theme.of(context).colorScheme.shadow,
//         backgroundColor: Theme.of(context).colorScheme.background,
//         leading: InkWell(
//             onTap: (){
//               Navigator.pop(context);
//             },
//             child: const Icon(Icons.arrow_back_ios,color: kTitleColor,)),
//         centerTitle: true,
//         title: TitleText(
//           isDark: isDark,
//           text: lang.S.of(context).history,
//         ),
//       ),
//       body: Column(
//         children: [
//           TabBar(
//               labelColor: const Color(0xff001EC0),
//               unselectedLabelColor: const Color(0xff525252),
//               indicatorColor: const Color(0xff001EC0),
//               controller: controller,
//               indicatorWeight: 2.0,
//               tabs: const [
//                 Tab(
//                   text: 'Chat History',
//                 ),
//                 Tab(
//                   text: 'Image History',
//                 )
//               ]),
//           Expanded(
//             child: TabBarView(
//                 controller: controller,
//                 children: [
//                   Container(
//                     color: Colors.red,
//                   ),
//                   SingleChildScrollView(
//                     child: ListView.builder(
//                         itemCount: titleList.length,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (_,i){
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const ImageHistoryDetails()));
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: kWhite,
//                                     border: Border.all(color: kBorderColorTextField,width: 0.5),
//                                   borderRadius: BorderRadius.circular(10)
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(titleList[i],style: kTextStyle.copyWith(fontWeight: FontWeight.bold),),
//                                           const SizedBox(height: 10,),
//                                           Text('See your recent Image',style: kTextStyle.copyWith(color: kLightNeutralColor),)
//                                         ],
//                                       ),
//                                       const Spacer(),
//                                       Container(
//                                         height: 28,
//                                         width: 28,
//                                         decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: kDarkWhite
//                                         ),
//                                         child: PopupMenuButton(
//                                           color: Theme.of(context).colorScheme.primaryContainer,
//                                           elevation: 0,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(4.0),
//                                           ),
//                                           padding: EdgeInsets.zero,
//                                           itemBuilder: (BuildContext bc) => [
//                                             PopupMenuItem(
//                                               child: InkWell(
//                                                 onTap: (){
//                                                   setState(() {
//                                                     titleList.removeAt(i);
//                                                   });
//                                                   finish(context);
//                                                 },
//                                                 child: Row(
//                                                   children: [
//                                                     Icon(
//                                                       FeatherIcons.trash2,
//                                                       color: isDark ? darkTitleColor : lightTitleColor,
//                                                     ),
//                                                     const SizedBox(
//                                                       width: 10.0,
//                                                     ),
//                                                     Text(
//                                                       'Remove',
//                                                       style: kTextStyle.copyWith(color: isDark ? darkTitleColor : lightTitleColor),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                           onSelected: (value) {
//                                             Navigator.pushNamed(context, '$value');
//                                           },
//                                           child: Icon(
//                                             FeatherIcons.moreVertical,
//                                             color: kLightNeutralColor,
//                                             size: 18,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                   )
//                 ]),
//           )
//         ],
//       ),
//     );
//   }
// }
