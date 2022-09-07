import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noa_driver/components/buttons/bottom_floating_action_button.dart';
import 'package:noa_driver/components/buttons/primary_button.dart';
import 'package:noa_driver/components/input/primary_text_field.dart';
import 'package:noa_driver/components/snackbar/primary_snackbar.dart';
import 'package:noa_driver/core/helpers/app_helpers.dart';
import 'package:noa_driver/core/models/order_model/order_update_request_model.dart'
    as updateDataPrepare;
import 'package:noa_driver/core/style/styles.dart';
import 'package:noa_driver/order-confirmation/components/order_product_content.dart';
import 'package:noa_driver/order-details/home.dart';
import 'package:noa_driver/order-details/model/order-details-response-data.dart';
import 'package:noa_driver/order-details/order-controller.dart';
import 'package:provider/provider.dart';

class OrderConfirmationByDriverPage extends StatefulWidget {
  const OrderConfirmationByDriverPage({
    Key? key,
    required this.currentOrder,
  }) : super(key: key);
  final OrderDetails currentOrder;

  @override
  State<OrderConfirmationByDriverPage> createState() =>
      _OrderConfirmationByDriverPageState();
}

class _OrderConfirmationByDriverPageState
    extends State<OrderConfirmationByDriverPage> {
  OrderDetails? orderSentByCustomer;
  TextEditingController amount = TextEditingController();
  String? firebaseToken;

  @override
  void initState() {
    orderSentByCustomer = widget.currentOrder;
    amount.text = orderSentByCustomer!.totalAmount.toString();
    firebaseToken = orderSentByCustomer!.remark?.split('#').last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Confirm Order'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Center(
              child: Text(
                'Please verify or update the order as per availability',
                style: TextStyles.body16x400.copyWith(color: Paints.greyText),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              color: Paints.primaryOrange.withOpacity(0.3),
              child: OrderProductContentWidget(
                orderSentByCustomer: orderSentByCustomer!,
                onTotalChanged: (OrderDetails udpatedOrder) {
                  amount.text = udpatedOrder.totalAmount.toString();
                  setState(() {
                    orderSentByCustomer = udpatedOrder;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Paints.primaryBlue.withOpacity(0.5),
              ),
              padding: const EdgeInsets.all(16),
              child: Text(
                'Final Amount : AED ${orderSentByCustomer!.totalAmount}',
                style: TextStyles.body16x500,
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 24),
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomFloatingActionButton(
        onTap: () async {
          //
          // update the amount for now
          if (orderSentByCustomer != null) {
            // Just updated the amount to whatever textfield value
            orderSentByCustomer!.remark = 'confirmed';

            // Now convert to request model
            // then update the customer order
            _driverUpdatesTheOrder(orderSentByCustomer!);
          } else {
            // When customer order is not fetched yet
            ScaffoldMessenger.of(context).showSnackBar(
              getSnackBar(
                'Please wait fetching order details',
              ),
            );
          }
        },
        buttonTitle: 'Confirm Order',
      ),
    );
  }

  _driverUpdatesTheOrder(
    OrderDetails customerSentOrder,
  ) async {
    await Provider.of<OrderController>(context, listen: false)
        .updateOrder(requestToUpdateOrder: orderSentByCustomer!)
        .then((value) {
      _sendNotificationToCustomerThatOrderIsConfirmed();
    });
  }

  _sendNotificationToCustomerThatOrderIsConfirmed() async {
    var customerName = widget.currentOrder.customerViewModel?.firstName;

    if (firebaseToken != null) {
      await AppHelper.sendNotificationToSpecificUser(
          context: context,
          firebaseToken: firebaseToken!,
          userName: customerName);
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(
          'Failed to send order confirmation notification',
        ),
      );
    }
  }

  // Helpers
  _getInvoiceRequestModel(List<InvoiceDetailsViewModels>? requestModel) {
    List<updateDataPrepare.InvoiceDetailsRequestModels> result = [];

    requestModel?.forEach((element) {
      var singleInvoiceDetailRequestModel = element;

      var resultSingleItem = updateDataPrepare.InvoiceDetailsRequestModels(
        productMasterId: singleInvoiceDetailRequestModel.productMasterId,
        quantity: 1,
        price: 1,
        // createdAt: '2022-02-01T06:29:44.380Z',
        productSubSKUId: singleInvoiceDetailRequestModel.productSkuId,
      );

      result.add(resultSingleItem);
    });

    return result;
  }

  _getOrderForGivenCustomerAsPerInvoiceID() async {
    var customerID = widget.currentOrder.customerId.toString();
    var invoiceID = widget.currentOrder.invoiceMasterId.toString();

    await Provider.of<OrderController>(context, listen: false)
        .getOrdersForAllCustomer(customerID, invoiceID)
        .then((value) {
      setState(() {
        orderSentByCustomer = value;
      });
    });
  }
}
