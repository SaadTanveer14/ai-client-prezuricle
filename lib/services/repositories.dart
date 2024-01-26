import 'dart:convert';

import 'package:chat_gpt/model/ad_network_model.dart';
import 'package:chat_gpt/model/app_products_model.dart';
import 'package:chat_gpt/model/banner_model.dart';
import 'package:chat_gpt/model/category_model.dart';
import 'package:chat_gpt/model/credit_cut_model.dart';
import 'package:chat_gpt/model/credit_history_model.dart';
import 'package:chat_gpt/model/credit_list.dart';
import 'package:chat_gpt/model/gateway_list_model.dart';
import 'package:chat_gpt/model/general_model.dart';
import 'package:chat_gpt/model/general_page_model.dart';
import 'package:chat_gpt/model/image_history_model.dart';
import 'package:chat_gpt/model/profile_information_model.dart';
import 'package:chat_gpt/model/sign_in_model.dart';
import 'package:chat_gpt/model/sign_up_model.dart';
import 'package:chat_gpt/model/subscription_plan_list_model.dart';
import 'package:chat_gpt/model/suggestions_model.dart';
import 'package:chat_gpt/model/text_generate_model.dart';
import 'package:chat_gpt/model/text_history_model.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/services/config.dart';
import 'package:chat_gpt/services/database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../model/faq_model.dart';

class ApiService {
  DataBase dataBase = DataBase();

  Future<SignUpModel> signUp(String name, String email, String phone,
      String password, String imagePath) async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiUrl + Config.signUpUrl));
    request.fields.addAll(
        {'name': name, 'password': password, 'email': email, 'phone': phone});
    if (imagePath != 'No Data') {
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    SignUpModel signUpModel = SignUpModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      dataBase.saveString(signUpModel.data?.token ?? "", "token");
      EasyLoading.showSuccess("Sign Up Successful");
      return signUpModel;
    } else {
      throw Exception(signUpModel.message);
    }
  }

  Future<SignInModel> signIn(String email, String password) async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiUrl + Config.signInUrl));
    request.fields.addAll({'email': email, 'password': password});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    SignInModel signInModel = SignInModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      dataBase.saveString(signInModel.data?.token ?? "", "token");
      EasyLoading.showSuccess("Sign In Successful");
      return signInModel;
    } else {
      throw Exception(signInModel.message);
    }
  }

  Future<GeneralModel> forgotPassword(String email) async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiUrl + Config.forgotPasswordUrl));
    request.fields.addAll({
      'email': email,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    GeneralModel generalModel = GeneralModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      EasyLoading.showSuccess(generalModel.message ?? "Successful");
      return generalModel;
    } else {
      throw Exception(generalModel.message);
    }
  }

  Future<GeneralModel> verifyOtp(String code, String email) async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiUrl + Config.verifyOtpUrl));
    request.fields.addAll({'code': code, 'email': email});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    GeneralModel generalModel = GeneralModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      EasyLoading.showSuccess(generalModel.message ?? "Successful");
      return generalModel;
    } else {
      throw Exception(generalModel.message);
    }
  }

  Future<GeneralModel> resetPassword(
      String code, String email, String password) async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiUrl + Config.resetPasswordUrl));
    request.fields.addAll({
      'password': password,
      'password_confirmation': password,
      'code': code,
      'email': email
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    GeneralModel generalModel = GeneralModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      EasyLoading.showSuccess(generalModel.message ?? "Successful");
      return generalModel;
    } else {
      throw Exception(generalModel.message);
    }
  }

  Future<AdNetworkModel> getAdId() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.adNetworkUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    print(data.body);
    AdNetworkModel adNetworkModel =
        AdNetworkModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return adNetworkModel;
    } else {
      throw Exception(adNetworkModel.message);
    }
  }

  Future<ProfileInformationModel> getProfile() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.getProfileUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    print(data.body);
    ProfileInformationModel profileInformationModel =
        ProfileInformationModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      var ads = await getAdId();
      String id = ads.data?.videoAdId ?? "";
      dataBase.saveString(id, "admob");
      return profileInformationModel;
    } else {
      throw Exception(profileInformationModel.message);
    }
  }

  Future<GeneralModel> updateProfile(
      String name, String email, String phone, String imagePath) async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiUrl + Config.getProfileUrl));
    request.fields.addAll({'name': name, 'email': email, 'phone': phone});
    if (imagePath != 'No Data') {
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    GeneralModel generalModel = GeneralModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      EasyLoading.showSuccess(generalModel.message ?? "Successful");
      return generalModel;
    } else {
      throw Exception(generalModel.message);
    }
  }

  Future<GeneralModel> changePassword(
      String currentPassword, String newPassword) async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiUrl + Config.changePasswordUrl));
    request.fields.addAll({
      'current_password': currentPassword,
      'password': newPassword,
      'password_confirmation': newPassword
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    GeneralModel generalModel = GeneralModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      EasyLoading.showSuccess(generalModel.message ?? "Successful");
      return generalModel;
    } else {
      throw Exception(generalModel.message);
    }
  }

  Future<BannerModel> getBanners() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.getBannerUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    BannerModel bannerModel = BannerModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return bannerModel;
    } else {
      throw Exception(bannerModel.message);
    }
  }

  Future<GeneralModel> logOut() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.logoutUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    GeneralModel generalModel = GeneralModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return generalModel;
    } else {
      throw Exception(generalModel.message);
    }
  }

  Future<TextHistoryModel> getTextHistory() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.textHistoryUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    TextHistoryModel textHistoryModel =
        TextHistoryModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return textHistoryModel;
    } else {
      throw Exception(textHistoryModel.message);
    }
  }

  Future<TextGenerateModel> getText(String query) async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.Request('POST', Uri.parse(Config.apiUrl + Config.textGenerateUrl));
    request.body = json.encode({"prompt": query});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    TextGenerateModel textGenerateModel =
        TextGenerateModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return textGenerateModel;
    } else {
      throw Exception(textGenerateModel.message);
    }
  }

  Future<TextGenerateModel> getImage(String query,String size) async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
    http.Request('POST', Uri.parse(Config.apiUrl + Config.imageGenerateUrl));
    request.body = json.encode({
      "prompt": query,
      "size": size
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    print(data.body);
    TextGenerateModel textGenerateModel =
    TextGenerateModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return textGenerateModel;
    } else {
      throw Exception(textGenerateModel.message);
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.getCategoryUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    final jsonData = json.decode(data.body);
    List<CategoryModel> categoryModel = [];
    jsonData.forEach((v) {
      categoryModel.add(CategoryModel.fromJson(v));
    });
    if (response.statusCode == 200) {
      return categoryModel;
    } else {
      throw Exception("No Category Found");
    }
  }

  Future<List<SuggestionsModel>> getSuggestions(String id) async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            "${Config.apiUrl}${Config.getSuggestionsUrl}?category_id=$id"));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    final jsonData = json.decode(data.body);
    List<SuggestionsModel> suggestions = [];
    jsonData.forEach((v) {
      suggestions.add(SuggestionsModel.fromJson(v));
    });
    if (response.statusCode == 200) {
      return suggestions;
    } else {
      throw Exception("No Suggestions Found");
    }
  }

  Future<List<FaqModel>> getFaqs() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.getFaqUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    final jsonData = json.decode(data.body);
    List<FaqModel> faqModel = [];
    jsonData.forEach((v) {
      faqModel.add(FaqModel.fromJson(v));
    });
    if (response.statusCode == 200) {
      return faqModel;
    } else {
      throw Exception("No Faq Found");
    }
  }

  Future<GeneralPageModel> getPrivacyPolicy() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.getPrivacyUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    print(data.body);
    GeneralPageModel pageModel =
        GeneralPageModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return pageModel;
    } else {
      throw Exception(pageModel.message);
    }
  }

  Future<GeneralPageModel> getTerms() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.getTermsUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    GeneralPageModel pageModel =
        GeneralPageModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return pageModel;
    } else {
      throw Exception(pageModel.message);
    }
  }

  Future<GeneralModel> addCredit(String amount, String reason) async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiUrl + Config.addCreditUrl));
    request.fields.addAll({'credits': amount, 'platform': reason});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    GeneralModel model = GeneralModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return model;
    } else {
      throw Exception(model.message);
    }
  }

  Future<CreditHistoryModel> getCreditEarnHistory() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.getCreditEarnUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    CreditHistoryModel creditHistoryModel =
        CreditHistoryModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return creditHistoryModel;
    } else {
      throw Exception(creditHistoryModel.message);
    }
  }

  Future<CreditCutModel> getCreditCostHistory() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(token);
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.getCreditSpendUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    CreditCutModel creditCutModel =
        CreditCutModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return creditCutModel;
    } else {
      throw Exception(creditCutModel.message);
    }
  }

  Future<ImageHistoryModel> getImageHistory() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(token);
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.imageGenerateUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    ImageHistoryModel imageHistoryModel =
    ImageHistoryModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return imageHistoryModel;
    } else {
      throw Exception(imageHistoryModel.message);
    }
  }
  Future<AppProductsModel> getProductList() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(token);
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.buyCreditUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    print(data.body);
    AppProductsModel appProductsModel =
    AppProductsModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return appProductsModel;
    } else {
      throw Exception(appProductsModel.message);
    }
  }
  Future<SubscriptionPlanListModel> getPlanList() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(token);
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.subscriptionListUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    SubscriptionPlanListModel subscriptionPlanListModel =
    SubscriptionPlanListModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return subscriptionPlanListModel;
    } else {
      throw Exception(subscriptionPlanListModel.message);
    }
  }

  Future<CreditList> getCreditList() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(token);
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.buyCreditUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    CreditList creditList =
    CreditList.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return creditList;
    } else {
      throw Exception(creditList.message);
    }
  }

  Future<GatewayListModel> getGatewayList() async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(token);
    var request = http.MultipartRequest(
        'GET', Uri.parse(Config.apiUrl + Config.gatewayListUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    GatewayListModel gatewayListModel =
    GatewayListModel.fromJson(jsonDecode(data.body));
    if (response.statusCode == 200) {
      return gatewayListModel;
    } else {
      throw Exception(gatewayListModel.message);
    }
  }

  Future<bool> buyCreditList(String id) async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(token);
    var request = http.MultipartRequest(
        'GET', Uri.parse("${Config.apiUrl}${Config.buyCreditUrl}/$id"));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Error Occured: " + response.statusCode.toString());
    }
  }

  Future<bool> buyCredit(String id) async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(token);
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiUrl + Config.buyCreditUrl));

    request.headers.addAll(headers);
    request.fields.addAll({
      'product_id': id
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Error Occured");
    }
  }
  Future<bool> buyPackage(String id) async {
    String? token = await dataBase.retrieveString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(token);
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiUrl + Config.buySubscriptionUrl));

    request.headers.addAll(headers);
    request.fields.addAll({
      'plan_id': id
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Error Occured");
    }
  }
}
