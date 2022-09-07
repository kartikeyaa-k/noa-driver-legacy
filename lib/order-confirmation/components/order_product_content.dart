import 'package:flutter/material.dart';
import 'package:noa_driver/components/input/primary_text_field.dart';
import 'package:noa_driver/core/style/styles.dart';
import 'package:noa_driver/order-details/model/order-details-response-data.dart';

class OrderProductContentWidget extends StatefulWidget {
  const OrderProductContentWidget({
    Key? key,
    required this.orderSentByCustomer,
    required this.onTotalChanged,
  }) : super(key: key);
  final OrderDetails orderSentByCustomer;
  final Function(OrderDetails) onTotalChanged;
  @override
  State<OrderProductContentWidget> createState() =>
      _OrderProductContentWidgetState();
}

class _OrderProductContentWidgetState extends State<OrderProductContentWidget> {
  List<InvoiceDetailsViewModels>? productList;
  late OrderDetails updatedOrder;
  late double cartTotal;
  late Map<String, Object> request;

  @override
  void initState() {
    productList = widget.orderSentByCustomer.invoiceDetailsViewModels;
    updatedOrder = widget.orderSentByCustomer;
    cartTotal = widget.orderSentByCustomer.totalAmount ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: const BoxDecoration(
          // color: Colors.white30,
          ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Products in the cart : ',
              style: TextStyles.body16x500,
            ),
          ),
          const SizedBox(height: 16),
          if (productList != null)
            SizedBox(
              height: 200,
              child: ListView.builder(
                  clipBehavior: Clip.antiAlias,
                  itemCount: productList!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var product = productList![index];
                    var qty = productList![index].quantity ?? 0.0;
                    var pricePerUnit = productList![index].price ?? 0.0;
                    var price = qty * pricePerUnit;

                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Paints.primaryBlueDarker,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.3)),
                            style: ListTileStyle.drawer,
                            tileColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            selectedColor: Colors.transparent,
                            selectedTileColor: Colors.transparent,
                            // Image
                            leading: Container(
                              decoration: BoxDecoration(
                                color: Paints.primaryBlue.withOpacity(0.5),
                              ),
                              height: 50,
                              width: 50,
                              child: const Icon(Icons.image),
                            ),
                            // Name
                            title: Text(
                              product.productName ?? 'Product Name',
                              style: TextStyles.body14x400
                                  .copyWith(color: Paints.background),
                            ),
                            // Description
                            subtitle: Text(
                              'Product ID : ${product.productMasterId}',
                              style: TextStyles.body12x400.copyWith(
                                  color: Paints.background.withOpacity(0.5)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            color: Colors.white,
                            width: double.infinity,
                            child: Row(children: [
                              Expanded(
                                  child: PrimaryTextField(
                                      labelText: 'Qty',
                                      enabled: true,
                                      initialValue: qty.toString(),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        // Null check taken care

                                        setState(() {
                                          updatedOrder
                                                  .invoiceDetailsViewModels![index]
                                                  .quantity =
                                              double.parse(value.toString());
                                          _getTotalAmount();
                                        });
                                      })),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: PrimaryTextField(
                                labelText: 'Price',
                                enabled: true,
                                initialValue: price.toString(),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    updatedOrder
                                        .invoiceDetailsViewModels![index]
                                        .price = double.parse(value.toString());
                                    _getTotalAmount();
                                  });
                                },
                              )),
                            ]),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
        ],
      ),
    );
  }

  _getTotalAmount() {
    double totalAmount = 0.0;
    for (var element in updatedOrder.invoiceDetailsViewModels!) {
      totalAmount += element.price ?? 0;
    }
    if (cartTotal != totalAmount) {
      updatedOrder.totalAmount = totalAmount;
      widget.onTotalChanged(updatedOrder);
    }
  }
}
