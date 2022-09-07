import 'package:flutter/material.dart';
import 'package:noa_driver/components/snackbar/primary_snackbar.dart';
import 'package:noa_driver/core/models/communities_model.dart';
import 'package:noa_driver/core/models/sub_community_model.dart';
import 'package:noa_driver/core/style/styles.dart';
import 'package:noa_driver/order-details/order-controller.dart';
import 'package:provider/provider.dart';

class AppHelper {
  static List<SubCommunityModel> getSubCommunitiesBasedOnSelectedCommunityId(
      List<SubCommunityModel> subCommunityList, String? id) {
    if (id == null) {
      return subCommunityList;
    }
    return subCommunityList
        .where((element) => element.communityId == id)
        .toList();
  }

  static CommunityModel? getCurrentCommunityModelFromId(
      List<CommunityModel> list, String? id) {
    if (id == null) {
      return null;
    }
    return list.firstWhere((element) => element.id == id);
  }

  static SubCommunityModel? getCurrentSubCommunityModelFromId(
      List<SubCommunityModel> list, String? id) {
    if (id == null) {
      return null;
    }
    return list.firstWhere((element) => element.id == id);
  }

  static String getCommunityNameFromId(List<CommunityModel> list, String? id) {
    String result = 'NA';
    if (id == null) {
      return result;
    }

    for (var element in list) {
      if (id == element.id) {
        result = element.name;
        break;
      }
    }

    return result;
  }

  static String getSubCommunityNameFromId(
      List<SubCommunityModel> list, String? id) {
    String result = 'NA';
    if (id == null) {
      return result;
    }

    for (var element in list) {
      if (id == element.id) {
        result = element.name;
        break;
      }
    }

    return result;
  }

  static List<DropdownMenuItem<CommunityModel>> getEntireCommunityListDropdown(
      List<CommunityModel> list) {
    return list.map<DropdownMenuItem<CommunityModel>>((CommunityModel value) {
      return DropdownMenuItem<CommunityModel>(
        value: value,
        child: Text(
          value.name,
          style: TextStyles.body16x400.copyWith(
              color: Paints.primary, backgroundColor: Colors.transparent),
        ),
      );
    }).toList();
  }

  static List<String> getEntireCommunityListDropdownInString(
      List<CommunityModel> list) {
    List<String> names = [];
    for (var element in list) {
      names.add(element.name);
    }
    print('names : ${names.length}');
    return names;
  }

  static List<DropdownMenuItem<SubCommunityModel>>
      getEntireSubCommunityListDropdown(List<SubCommunityModel> list) {
    return list
        .map<DropdownMenuItem<SubCommunityModel>>((SubCommunityModel value) {
      return DropdownMenuItem<SubCommunityModel>(
        value: value,
        child: Text(
          value.name,
          style: TextStyles.body16x400.copyWith(
              color: Paints.primary, backgroundColor: Colors.transparent),
        ),
      );
    }).toList();
  }

  static sendNotificationToSpecificUser(
      {required BuildContext context,
      required String firebaseToken,
      String? userName}) async {
    await Provider.of<OrderController>(context, listen: false)
        .sendPushMessageToIndividual(
            'Your order has been confirmed. Please proceed with payment',
            'Order confirmed',
            firebaseToken)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(
          'Order confirmation notification sent ${userName != null ? 'to $userName' : ''}',
        ),
      );
    });
  }

  static sendNotificationOnTheWay(
      {required BuildContext context,
      required String firebaseToken,
      String? userName}) async {
    await Provider.of<OrderController>(context, listen: false)
        .sendPushMessageToIndividual(
            'Your order has been confirmed. It is on the way to your address',
            'Hi ${userName?.toUpperCase()}',
            firebaseToken)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(
          'Order on the way notification sent ${userName != null ? 'to $userName' : ''}',
        ),
      );
    });
  }

  static sendNotificationOrderCompleted(
      {required BuildContext context,
      required String firebaseToken,
      String? userName}) async {
    await Provider.of<OrderController>(context, listen: false)
        .sendPushMessageToIndividual(
            'We hope you loved using Noa. For any issues or feedback, please reach out to us on WhatsApp 0585387662 or via email at hello@noa.market.',
            'Noa Market',
            firebaseToken)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(
          'Order delivered notification sent ${userName != null ? 'to $userName' : ''}',
        ),
      );
    });
  }
}
