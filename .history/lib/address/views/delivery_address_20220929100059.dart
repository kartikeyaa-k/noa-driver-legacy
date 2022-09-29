import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noa_driver/components/snackbar/primary_snackbar.dart';
import 'package:noa_driver/core/controllers/address_controller.dart';
import 'package:noa_driver/core/environments/base_config.dart';
import 'package:noa_driver/core/helpers/app_helpers.dart';
import 'package:noa_driver/core/models/communities_model.dart';
import 'package:noa_driver/core/models/sub_community_model.dart';
import 'package:noa_driver/core/style/styles.dart';
import 'package:noa_driver/main.dart';
import 'package:noa_driver/order-details/order-controller.dart';

import 'package:provider/provider.dart';

class BodyAddAddress {}

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({
    Key? key,
    required this.driverId,
    required this.onSubmitAddress,
  }) : super(key: key);

  final String driverId;
  final Function(String, String, String) onSubmitAddress;
  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  late BodyAddAddress currentUserAddressData;
  String? communityId;
  String? currentSelectedCommunityName;

  final _formKey = GlobalKey<FormState>();
  bool showErrorMessage = false;
  late List<CommunityModel> communityList = [];
  late List<SubCommunityModel> subCommunityList = [];
  late List<SubCommunityModel> subCommunityListAsPerSelectedCommunity = [];
  SubCommunityModel? currentSelectedSubCommunityFromDropdown;
  CommunityModel? currentSelectedCommunityFromDropdown;
  bool isCommunityOrSubcommunityLoading = true;

  @override
  void initState() {
    print('Driver : ' + widget.driverId);

    if (mainCommunityList.isEmpty) {
      Provider.of<AddressController>(context, listen: false)
          .getAllCommunities()
          .then((value) {
        setState(() {
          communityList = value;
          isCommunityOrSubcommunityLoading = true;
        });
      });
    } else {
      setState(() {
        communityList = mainCommunityList;
        isCommunityOrSubcommunityLoading = true;
      });
    }

    if (mainSubCommunityList.isEmpty) {
      Provider.of<AddressController>(context, listen: false)
          .getAllSubCommunities()
          .then((value) {
        setState(() {
          subCommunityList = value;
          isCommunityOrSubcommunityLoading = false;
        });
      });
    } else {
      setState(() {
        subCommunityList = mainSubCommunityList;
        isCommunityOrSubcommunityLoading = false;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(builder: (context, provider, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Paints.primaryBlueDarker,
            ),
            backgroundColor: Paints.primaryBlueDarker,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios)),
            title: const Text('Address'),
            centerTitle: true,
          ),
          body: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Paints.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              DropdownSearch<CommunityModel>(
                                compareFn: (item1, item2) =>
                                    item1.name == item2.name,
                                popupProps: PopupProps.menu(
                                  fit: FlexFit.loose,
                                  showSearchBox: true,
                                  showSelectedItems: true,
                                  disabledItemFn: (CommunityModel s) =>
                                      s.name.startsWith('1'),
                                  menuProps: const MenuProps(
                                    animationDuration:
                                        Duration(microseconds: 100),
                                  ),
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration:
                                      DropdownStyle.dropdownPrimaryStyle(
                                          communityList.isEmpty
                                              ? 'Loading Communities..'
                                              : 'Select a Community'),
                                ),
                                selectedItem:
                                    currentSelectedCommunityFromDropdown,
                                itemAsString: (CommunityModel u) => u.name,
                                onChanged: (CommunityModel? selectedCommunity) {
                                  setState(() {
                                    communityId = selectedCommunity?.id;
                                    currentSelectedCommunityName =
                                        selectedCommunity?.name;
                                    currentSelectedCommunityFromDropdown =
                                        selectedCommunity;

                                    currentSelectedSubCommunityFromDropdown =
                                        null;
                                    subCommunityListAsPerSelectedCommunity
                                        .clear();

                                    subCommunityListAsPerSelectedCommunity =
                                        subCommunityList
                                            .where((element) =>
                                                element.communityId ==
                                                communityId)
                                            .toList();
                                  });
                                },
                                items: communityList,
                              ),
                              const SizedBox(height: 16),
                              DropdownSearch<SubCommunityModel>(
                                compareFn: (item1, item2) =>
                                    item1.id == item2.id,
                                popupProps: PopupProps.menu(
                                  fit: FlexFit.loose,
                                  showSearchBox: true,
                                  showSelectedItems: true,
                                  disabledItemFn: (SubCommunityModel s) =>
                                      s.name.startsWith('#'),
                                  menuProps: const MenuProps(
                                    animationDuration:
                                        Duration(microseconds: 100),
                                  ),
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration:
                                      DropdownStyle.dropdownPrimaryStyle(
                                          currentSelectedCommunityName != null
                                              ? 'Select a Sub-Community for $currentSelectedCommunityName'
                                              : 'First Select a Community'),
                                ),
                                selectedItem:
                                    currentSelectedSubCommunityFromDropdown,
                                itemAsString: (SubCommunityModel u) => u.name,
                                onChanged:
                                    (SubCommunityModel? selectedCommunity) {
                                  if (selectedCommunity != null) {
                                    setState(() {
                                      currentSelectedSubCommunityFromDropdown =
                                          selectedCommunity;
                                    });
                                  }
                                },
                                items: subCommunityListAsPerSelectedCommunity,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              if (showErrorMessage)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '*Villa/House Number, Community, and Sub-Community are required fields',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles.body12x400.copyWith(
                                        color: Paints.red,
                                        fontStyle: FontStyle.italic),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      if (communityId != null) {
                        String? subCommunityId;
                        String? subCommunityName;

                        if (currentSelectedSubCommunityFromDropdown == null) {
                          subCommunityId = communityId;
                          subCommunityName = currentSelectedCommunityName;
                        } else {
                          subCommunityId =
                              currentSelectedSubCommunityFromDropdown!.id;
                          subCommunityName =
                              currentSelectedSubCommunityFromDropdown!.name;
                        }

                        if (subCommunityId == null) {
                        } else {
                          var supplierName =
                              provider.custommerLogin?.supplierName;

                          var body =
                              "Our $supplierName is in $subCommunityName right now! \nClick here to purchase and enjoy near instant delivery.";
                          var title = 'Noa Market';

                          // var toSendSubCommunity = '/topics/${subCommunityId}';
                          var toSendSubCommunity = subCommunityId;
                          var env = Environment().config.envType;

                          if (env == EnvironmentType.dev) {
                            toSendSubCommunity = EnvironmentType.dev.name +
                                '-' +
                                toSendSubCommunity;
                          }

                          await Provider.of<OrderController>(context,
                                  listen: false)
                              .sendNotificationToSubCommunityTopic(
                                  firebaseToken: '',
                                  userId: null,
                                  title: title,
                                  body: body,
                                  subComunityId: int.parse(subCommunityId!),
                                  topic: '/topics/${subCommunityId}')
                              .then((value) {
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                getSnackBar(
                                  'Notification sent to all members at $subCommunityName',
                                ),
                              );

                              widget.onSubmitAddress(
                                  subCommunityName ?? '',
                                  currentSelectedCommunityName ?? '',
                                  subCommunityId ?? '');
                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                getSnackBar(
                                  'Failed to send notification to members at $subCommunityName',
                                ),
                              );
                            }
                          });
                        }
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Paints.primaryBlueDarker),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(top: 16),
                        width: 100,
                        child: const Text(
                          "Confirm",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Paints.background,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              )));
    });
  }
}
