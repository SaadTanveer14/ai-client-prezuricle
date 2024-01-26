import 'package:chat_gpt/model/credit_cut_model.dart';
import 'package:chat_gpt/model/credit_history_model.dart';
import 'package:chat_gpt/model/credit_list.dart';
import 'package:chat_gpt/model/gateway_list_model.dart';
import 'package:chat_gpt/model/general_page_model.dart';
import 'package:chat_gpt/model/image_history_model.dart';
import 'package:chat_gpt/model/profile_information_model.dart';
import 'package:chat_gpt/model/subscription_plan_list_model.dart';
import 'package:chat_gpt/model/suggestions_model.dart';
import 'package:chat_gpt/model/text_history_model.dart';
import 'package:chat_gpt/services/repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/banner_model.dart';
import '../model/category_model.dart';
import '../model/faq_model.dart';

final homeScreenBannerProvider =
    FutureProvider<BannerModel>((ref) => ApiService().getBanners());
final homeScreenCategoryProvider =
    FutureProvider<List<CategoryModel>>((ref) => ApiService().getCategories());
final suggestionsProvider =
    FutureProvider.family<List<SuggestionsModel>, String>(
        (ref, id) => ApiService().getSuggestions(id));
final profileProvider =
    FutureProvider.autoDispose<ProfileInformationModel>((ref) => ApiService().getProfile());
final faqProvider =
    FutureProvider<List<FaqModel>>((ref) => ApiService().getFaqs());
final privacyProvider =
    FutureProvider<GeneralPageModel>((ref) => ApiService().getPrivacyPolicy());
final planProvider =
FutureProvider<SubscriptionPlanListModel>((ref) => ApiService().getPlanList());
final creditProvider =
FutureProvider<CreditList>((ref) => ApiService().getCreditList());
final termsProvider =
    FutureProvider<GeneralPageModel>((ref) => ApiService().getTerms());
final gatewayProvider =
FutureProvider<GatewayListModel>((ref) => ApiService().getGatewayList());

final earnProvider = FutureProvider.autoDispose<CreditHistoryModel>(
    (ref) => ApiService().getCreditEarnHistory());
final costProvider = FutureProvider.autoDispose<CreditCutModel>(
    (ref) => ApiService().getCreditCostHistory());
final textHistoryProvider =
FutureProvider.autoDispose<TextHistoryModel>((ref) => ApiService().getTextHistory());
final imageHistoryProvider =
FutureProvider.autoDispose<ImageHistoryModel>((ref) => ApiService().getImageHistory());