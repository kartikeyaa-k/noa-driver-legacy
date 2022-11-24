import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:noa_driver/components/buttons/primary_button.dart';
import 'package:noa_driver/components/snackbar/primary_snackbar.dart';
import 'package:noa_driver/core/controllers/address_controller.dart';
import 'package:noa_driver/core/environments/base_config.dart';
import 'package:noa_driver/core/helpers/app_helpers.dart';
import 'package:noa_driver/core/models/communities_model.dart';
import 'package:noa_driver/core/models/sub_community_model.dart';
import 'package:noa_driver/core/style/styles.dart';
import 'package:noa_driver/login-registration/model/custommer-login.dart';
import 'package:noa_driver/main.dart';
import 'package:noa_driver/order-details/order-controller.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart';

class BodyAddAddress {}

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({
    Key? key,
    required this.driverId,
    required this.onSubmitAddress,
    required this.driverLogin,
  }) : super(key: key);

  final String driverId;
  final DriverLogin? driverLogin;
  final Function(String, List<SubCommunityModel>) onSubmitAddress;
  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  late BodyAddAddress currentUserAddressData;
  String? communityId;
  String? currentSelectedCommunityName;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showErrorMessage = false;
  late List<CommunityModel> communityList = [];
  late List<SubCommunityModel> subCommunityList = [];
  late List<SubCommunityModel> subCommunityListAsPerSelectedCommunity = [];
  SubCommunityModel? currentSelectedSubCommunityFromDropdown;
  List<SubCommunityModel> currentlySelectedMultiSubCommunityFromDropdow = [];
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
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),

                              // COMMUNTIY
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

                                    currentlySelectedMultiSubCommunityFromDropdow
                                        .clear();

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

                              // SUBCOMMUNITY
                              // DropdownSearch<SubCommunityModel>(
                              //   compareFn: (item1, item2) =>
                              //       item1.id == item2.id,
                              //   popupProps: PopupProps.menu(
                              //     fit: FlexFit.loose,
                              //     showSearchBox: true,
                              //     showSelectedItems: true,
                              //     disabledItemFn: (SubCommunityModel s) =>
                              //         s.name.startsWith('#'),
                              //     menuProps: const MenuProps(
                              //       animationDuration:
                              //           Duration(microseconds: 100),
                              //     ),
                              //   ),
                              //   dropdownDecoratorProps: DropDownDecoratorProps(
                              //     dropdownSearchDecoration:
                              //         DropdownStyle.dropdownPrimaryStyle(
                              //             currentSelectedCommunityName != null
                              //                 ? 'Select a Sub-Community for $currentSelectedCommunityName'
                              //                 : 'First Select a Community'),
                              //   ),
                              //   selectedItem:
                              //       currentSelectedSubCommunityFromDropdown,
                              //   itemAsString: (SubCommunityModel u) => u.name,
                              //   onChanged:
                              //       (SubCommunityModel? selectedSubCommunity) {
                              //     if (selectedSubCommunity != null) {
                              //       setState(() {
                              //         currentSelectedSubCommunityFromDropdown =
                              //             selectedSubCommunity;
                              //       });
                              //     }
                              //   },
                              //   items: subCommunityListAsPerSelectedCommunity,
                              // ),

                              MultiSelectDialogField<SubCommunityModel>(
                                initialValue:
                                    currentlySelectedMultiSubCommunityFromDropdow,
                                separateSelectedItems: true,
                                items: subCommunityListAsPerSelectedCommunity
                                    .map((e) => MultiSelectItem(e, e.name))
                                    .toList(),
                                listType: MultiSelectListType.CHIP,
                                onConfirm: (values) {},
                                onSaved: (newSelectedSubCommunity) {
                                  currentlySelectedMultiSubCommunityFromDropdow
                                      .clear();

                                  newSelectedSubCommunity?.forEach((element) {
                                    if (currentSelectedCommunityFromDropdown
                                            ?.id ==
                                        element.communityId) {
                                      currentlySelectedMultiSubCommunityFromDropdow
                                          .add(element);
                                    }
                                  });

                                  setState(() {});
                                },
                                selectedColor: Paints.primary,
                                itemsTextStyle: TextStyles.body16x400,
                                selectedItemsTextStyle: TextStyles.body16x400
                                    .copyWith(color: Paints.background),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                    color: Paints.grey,
                                  ),
                                ),
                                buttonIcon: const Icon(
                                  Icons.category,
                                  color: Paints.primary,
                                ),
                                buttonText: Text(
                                  'Select a Sub-Community',
                                  style: TextStyles.body14x400.copyWith(
                                      color: Paints.grey,
                                      backgroundColor: Colors.transparent),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                  PrimaryButton(
                      onTap: () async {
                        formKey.currentState!.save();
                        if (currentlySelectedMultiSubCommunityFromDropdow
                                .isNotEmpty &&
                            currentSelectedCommunityFromDropdown != null) {
                          // Please Wait
                          ScaffoldMessenger.of(context).showSnackBar(
                            getSnackBar(
                              'Please wait...',
                            ),
                          );

                          // Constant Data
                          var title = 'Noa Market';
                          var supplierName =
                              provider.custommerLogin?.supplierName;

                          // Run through the loop
                          // Send notification to each subcommunity
                          for (var singleSubCommunity
                              in currentlySelectedMultiSubCommunityFromDropdow) {
                            String finalSubscriptionTopic = '/topics/';
                            // Default
                            String body =
                                "Our $supplierName is in ${singleSubCommunity.name} right now! Click here to purchase and enjoy near instant delivery.";
                            // Check if there is any specific message store wants to send.

                            var storeSpecificMessage =
                                widget.driverLogin?.description;
                            if (storeSpecificMessage != null &&
                                storeSpecificMessage != '') {
                              final document = parse(storeSpecificMessage);

                              String parsedString = (parse(document.body?.text)
                                      .documentElement
                                      ?.text)
                                  .toString();

                              // Supplier Name

                              if (parsedString.contains("-supplierName-")) {
                                parsedString = parsedString.replaceAll(
                                    '-supplierName-', supplierName.toString());
                              }
                              // SubCommunity Name
                              if (parsedString.contains("-subCommunityName-")) {
                                parsedString = parsedString.replaceAll(
                                    '-subCommunityName-',
                                    singleSubCommunity.name);
                              }

                              body = parsedString;
                            }

                            // Prepare Environment Config
                            var env = Environment().config.envType;

                            // If env == dev, then add prefix
                            // else add communit id without prefix
                            if (env == EnvironmentType.dev) {
                              finalSubscriptionTopic +=
                                  EnvironmentType.dev.name +
                                      '-' +
                                      singleSubCommunity.id;
                            } else {
                              finalSubscriptionTopic += singleSubCommunity.id;
                            }

                            // Send notification API call
                            await Provider.of<OrderController>(context,
                                    listen: false)
                                .sendNotificationToSubCommunityTopic(
                                    firebaseToken: '',
                                    userId: null,
                                    title: title,
                                    body: body,
                                    subComunityId:
                                        int.parse(singleSubCommunity.id),
                                    topic: finalSubscriptionTopic)
                                .then((value) {
                              if (value) {
                                // Notification sent
                                // if (env == EnvironmentType.dev) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     getSnackBar(
                                //       'Notification sent to $finalSubscriptionTopic',
                                //     ),
                                //   );
                                // }
                              } else {}
                            });
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            getSnackBar(
                              'Notifications sent',
                            ),
                          );
                          // End of for loop
                          widget.onSubmitAddress(
                              currentSelectedCommunityFromDropdown?.name ?? '',
                              currentlySelectedMultiSubCommunityFromDropdow);
                          Navigator.of(context).pop();
                        }
                      },
                      text: 'Broadcast'),
                  // const Spacer(),
                  // CONFIRM BUTTON
                  // PrimaryButton(
                  //   onTap: () async {
                  //     if (communityId != null &&
                  //         currentSelectedSubCommunityFromDropdown != null &&
                  //         currentSelectedCommunityName != null) {
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         getSnackBar(
                  //           'Please wait...',
                  //         ),
                  //       );

                  //       String subCommunityId;
                  //       String subCommunityName;

                  //       subCommunityId =
                  //           currentSelectedSubCommunityFromDropdown!.id;
                  //       subCommunityName =
                  //           currentSelectedSubCommunityFromDropdown!.name;

                  //       var supplierName =
                  //           provider.custommerLogin?.supplierName;

                  //       var body =
                  //           "Our $supplierName is in $subCommunityName right now! Click here to purchase and enjoy near instant delivery.";
                  //       var title = 'Noa Market';

                  //       if (currentSelectedSubCommunityFromDropdown!.name
                  //               .toLowerCase() ==
                  //           'all') {
                  //         // Broadcast to ALL under community
                  //         var toSendCommunity =
                  //             currentSelectedSubCommunityFromDropdown!
                  //                     .communityId +
                  //                 '-All';
                  //         var env = Environment().config.envType;
                  //         if (env == EnvironmentType.dev) {
                  //           toSendCommunity = EnvironmentType.dev.name +
                  //               '-' +
                  //               toSendCommunity;
                  //         }
                  //         await Provider.of<OrderController>(context,
                  //                 listen: false)
                  //             .sendNotificationToAllUnderCommunity(
                  //           title: title,
                  //           body: body,
                  //           subComunityId: int.parse(subCommunityId),
                  //           communityId: int.parse(
                  //               currentSelectedSubCommunityFromDropdown!
                  //                   .communityId),
                  //           topic: '/topics/$toSendCommunity',
                  //         )
                  //             .then((value) {
                  //           if (value) {
                  //             ScaffoldMessenger.of(context).showSnackBar(
                  //               getSnackBar(
                  //                 env == EnvironmentType.dev
                  //                     ? '(DEV) Notification sent to All under $currentSelectedCommunityName '
                  //                     : 'Notification sent to all members at $currentSelectedCommunityName',
                  //               ),
                  //             );

                  //             widget.onSubmitAddress(
                  //                 subCommunityName,
                  //                 currentSelectedCommunityName ?? '',
                  //                 subCommunityId);

                  //             Navigator.of(context).pop();
                  //           } else {
                  //             ScaffoldMessenger.of(context).showSnackBar(
                  //               getSnackBar(
                  //                 'Failed to send notification to All members at $currentSelectedCommunityName',
                  //               ),
                  //             );
                  //           }
                  //         });
                  //       } else {
                  //         // Broadcast to selected subcommunity
                  //         var toSendSubCommunity = subCommunityId;
                  //         var env = Environment().config.envType;
                  //         if (env == EnvironmentType.dev) {
                  //           toSendSubCommunity = EnvironmentType.dev.name +
                  //               '-' +
                  //               toSendSubCommunity;
                  //         }

                  //         toSendSubCommunity = '/topics/$toSendSubCommunity';

                  //         await Provider.of<OrderController>(context,
                  //                 listen: false)
                  //             .sendNotificationToSubCommunityTopic(
                  //                 firebaseToken: '',
                  //                 userId: null,
                  //                 title: title,
                  //                 body: body,
                  //                 subComunityId: int.parse(subCommunityId),
                  //                 topic: toSendSubCommunity)
                  //             .then((value) {
                  //           if (value) {
                  //             ScaffoldMessenger.of(context).showSnackBar(
                  //               getSnackBar(
                  //                 env == EnvironmentType.dev
                  //                     ? '(DEV) Notification to $toSendSubCommunity'
                  //                     : 'Notification sent to all members at $subCommunityName',
                  //               ),
                  //             );

                  //             // widget.onSubmitAddress(
                  //             //     subCommunityName ?? '',
                  //             //     currentSelectedCommunityName ?? '',
                  //             //     subCommunityId ?? '');
                  //             Navigator.of(context).pop();
                  //           } else {
                  //             ScaffoldMessenger.of(context).showSnackBar(
                  //               getSnackBar(
                  //                 'Failed to send notification to members at $subCommunityName',
                  //               ),
                  //             );
                  //           }
                  //         });
                  //       }
                  //     }
                  //   },
                  //   text: currentSelectedSubCommunityFromDropdown != null
                  //       ? 'Broadcast to ${currentSelectedSubCommunityFromDropdown!.name}'
                  //       : 'Broadcast',
                  //   backgroundColor: Paints.primaryBlueDarker,
                  // ),
                ],
              )));
    });
  }
}
