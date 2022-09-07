import 'package:flutter/cupertino.dart';
import 'package:noa_driver/core/models/communities_model.dart';
import 'package:noa_driver/core/models/sub_community_model.dart';
import 'package:noa_driver/core/repositories/delivery_address_repository.dart';
import 'package:noa_driver/locator/locator.dart';

class AddressController extends ChangeNotifier {
  final _addressRepository = locator<DeliveryAddressRepository>();

  List<CommunityModel> communityList = [];
  List<SubCommunityModel> subCommunityList = [];

  Future<List<CommunityModel>> getAllCommunities() async {
    try {
      var response = await _addressRepository.getCommunities();
      communityList = response.data;
    } catch (e) {
      // ignore: avoid_print
      print(
          'ERROR WHILE GETTING COMMMUNITIES========================================');
      // ignore: avoid_print
      print('ERROR : ' + e.toString());
      print('END========================================');
    }
    return communityList;
  }

  Future<List<SubCommunityModel>> getAllSubCommunities() async {
    try {
      var response = await _addressRepository.getSubCommunities();
      subCommunityList = response.data;
    } catch (e) {
      // ignore: avoid_print
      print(
          'ERROR WHILE GETTING SUB-COMMMUNITIES========================================');
      // ignore: avoid_print
      print('ERROR : ' + e.toString());
      print('END========================================');
    }
    return subCommunityList;
  }

  Future<bool> sendNotificationToEntireSubCommunity(
      {required String driverId, required String subCommunityId}) async {
    bool result = false;
    try {
      var response =
          await _addressRepository.sendNotificationToEntireSubCommunity(
              driverId: driverId, subCommunityId: int.parse(subCommunityId));
      result = true;
    } catch (e) {
      // ignore: avoid_print
      print(
          'ERROR WHILE GETTING SUB-COMMMUNITIES========================================');
      // ignore: avoid_print
      print('ERROR : ' + e.toString());
      print('END========================================');
      result = false;
    }
    return result;
  }
}
