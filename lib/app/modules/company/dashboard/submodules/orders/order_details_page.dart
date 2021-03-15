import 'package:e_commerce/app/components/buttons/secondary_button.dart';
import 'package:e_commerce/app/components/stars_widget/stars_widget.dart';
import 'package:e_commerce/app/shared/models/address/address.dart';
import 'package:e_commerce/app/shared/models/company/type_payment.dart';
import 'package:e_commerce/app/shared/models/order/cupon.dart';
import 'package:e_commerce/app/shared/models/order/order.dart';
import 'package:e_commerce/app/shared/models/order/order_item.dart';
import 'package:e_commerce/app/shared/models/order/order_status.dart';
import 'package:e_commerce/app/styles/font_style.dart';
import 'package:e_commerce/app/utils/date_util.dart';
import 'package:e_commerce/app/utils/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  Order order = Get.arguments as Order;

  double total = 0;

  List<Widget> ordersItems;
  int currentStatusIndex = 0;
  List<Widget> statusItems = List();

  @override
  void initState() {
    super.initState();
    total = order.deliveryCost;
    order.items.forEach((element) {
      total += element.getTotal();
    });
    if (order.cupon != null) {
      total += -order.cupon.calcPercentDiscount(total) -
          order.cupon.getMoneyDiscount();
    }
    ordersItems = order.items.map((e) => orderItem(e)).toList();
    int index = 0;
    order.status.values.forEach((element) {
      if (element.name == order.status.current.name) {
        currentStatusIndex = index;
        return;
      }
      index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: nestedScrollView(),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text(
        order.companyName,
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.whatsapp,
          ),
          onPressed: () async {
            var whatsAppLink = order.userPhoneNumber.whatsAppLink();
            if (await canLaunch(whatsAppLink)) {
              await launch(whatsAppLink);
            } else {
              //ScaffoldSnackBar.failure(context, _scaffoldKey, SOME_ERROR);
            }
          },
        ),
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return ["WhatsApp", "Ligar", "Cancelar"].map((String choice) {
              return PopupMenuItem(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          onSelected: (value) async {
            switch (value) {
              case "WhatsApp":
                var whatsAppLink = order.userPhoneNumber.whatsAppLink();
                if (await canLaunch(whatsAppLink)) {
                  await launch(whatsAppLink);
                } else {
                  //ScaffoldSnackBar.failure(context, _scaffoldKey, SOME_ERROR);
                }
                break;
              case "Ligar":
                var url = "tel: ${order.userPhoneNumber.toString()}";
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  //ScaffoldSnackBar.failure(context, _scaffoldKey, SOME_ERROR);
                }
                break;
              case "Cancelar":
                //showDialogCancelOrder();
                break;
            }
          },
        ),
      ],
    );
  }

  Widget nestedScrollView() {
    return NestedScrollView(
      controller: ScrollController(keepScrollOffset: true),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverList(delegate: SliverChildListDelegate([sliverBar()])),
        ];
      },
      body: body(), //refreshBody(),
    );
  }

  Widget sliverBar() {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: MediaQuery.of(context).size.width < 990
                ? MediaQuery.of(context).size.width < 600
                    ? 10
                    : MediaQuery.of(context).size.width / 9
                : MediaQuery.of(context).size.width / 5,
            right: MediaQuery.of(context).size.width < 990
                ? MediaQuery.of(context).size.width < 600
                    ? 10
                    : MediaQuery.of(context).size.width / 9
                : MediaQuery.of(context).size.width / 5,
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.all(0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: titleTextWidget(order.userName),
                              ),
                              dateTextWidget(
                                DateUtil.formatDateMouthHour(order.createdAt),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Card(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: ordersItems),
                            ),
                          ),
                          order.delivery ? textDelivery() : Container(),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                totalTextWidget(),
                                costTextWidget(
                                  "R\$ ${total.toStringAsFixed(2)}",
                                ),
                              ],
                            ),
                          ),
                          order.cupon != null ? cardCupon() : Container(),
                          paymentTypeWidget(order.typePayment),
                          addressDataWidget(order.deliveryAddress),
                          SizedBox(height: 10),
                          order.status.isLast() && order.evaluation != null
                              ? Column(
                                  children: [
                                    avaliationTextWidget(),
                                    StarsWidget(
                                      initialStar: order.evaluation.stars,
                                      size: 40,
                                    ),
                                    avaliationComenteTextWidget(),
                                  ],
                                )
                              : Container(),
                          //deliveryCurrentStatus(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget textDelivery() {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Taxa de entrega",
            textAlign: TextAlign.left,
            style: fontMessage(context, size: 20, bold: true),
          ),
          Text(
            "R\$ ${order.deliveryCost.toStringAsFixed(2)}",
            textAlign: TextAlign.left,
            style: fontMessage(context, size: 20, bold: true),
          ),
        ],
      ),
    );
  }

  Widget cardCupon() {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.receipt,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Cupom de desconto",
                        textAlign: TextAlign.left,
                        style: fontMessage(context, size: 22, bold: true),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: cuponWidget(order.cupon),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cuponWidget(Cupon cupon) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(0),
      child: Container(
        child: Row(
          children: [
            Container(
              width: 50,
              alignment: Alignment.center,
              child: FaIcon(
                FontAwesomeIcons.fileInvoiceDollar,
                color: Colors.black45,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cupon.code,
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Válido até ${DateUtil.formatDateMouthHour(cupon.dateLimit)}h",
                  style: fontMessage(context, size: 18),
                ),
                Text(
                  "Desconto: ${cupon.getDiscount()}",
                  style: fontMessage(
                    context,
                    size: 15,
                    color: Colors.red,
                    bold: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentTypeWidget(TypePayment payment) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(top: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 15, 10, 15),
        child: Row(
          children: [
            Container(
              width: 50,
              alignment: Alignment.center,
              child: FaIcon(
                findIcon(payment.paymentType),
                color: Colors.green,
              ),
            ),
            // Expanded(
            //   child: AutoSizeText(
            //     payment.getType(),
            //     maxLines: 1,
            //     textAlign: TextAlign.left,
            //     style: TextStyle(
            //       fontSize: 20,
            //       color: Colors.black45,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            Text(
              order.changeMoney == null
                  ? "Sem troco"
                  : "Troco: ${order.changeMoney}",
              textAlign: TextAlign.left,
              style: fontMessage(context, size: 19, bold: true),
            ),
          ],
        ),
      ),
    );
  }

  IconData findIcon(Type type) {
    IconData icon;
    switch (type) {
      case Type.MONEY:
        icon = FontAwesomeIcons.moneyBill;
        break;
      case Type.CARD:
        icon = FontAwesomeIcons.creditCard;
        break;
      case Type.APP_PAYMENT:
        icon = FontAwesomeIcons.mobileAlt;
        break;
      case Type.CASHBACK:
        icon = FontAwesomeIcons.handHoldingUsd;
        break;
    }
    return icon;
  }

  Widget orderCanceled() {
    return Text(
      "Esse pedido foi cancelado",
      style: fontMessage(
        context,
        size: 22,
        color: Colors.red,
        bold: true,
      ),
    );
  }

  Widget orderItem(OrderItem item) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "${item.amount}x ${item.name}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "R\$ ${item.getTotal().toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: item.choicesSelected.map((choice) {
              return Text(
                "* $choice",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                  //fontWeight: FontWeight.bold,
                ),
              );
            }).toList(),
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: item.additionalSelected.map((additional) {
              return Text(
                "+ ${additional.amount} ${additional.name} R\$ ${(additional.amount * additional.cost).toStringAsFixed(2)}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                  //fontWeight: FontWeight.bold,
                ),
              );
            }).toList(),
          ),
          item.note.isNotEmpty
              ? Text(
                  item.note,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    //fontWeight: FontWeight.bold,
                  ),
                )
              : Container(),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.white,
            thickness: 1,
            height: 0,
          ),
        ],
      ),
    );
  }

  bool loading = false;
  Widget refreshBody() {
    return RefreshIndicator(
      key: GlobalKey<RefreshIndicatorState>(),
      onRefresh: () {
        setState(() => loading = true);
        return Future.delayed(Duration(seconds: 2)).whenComplete(() {
          setState(() => loading = false);
        });
      },
      child: loading ? Center(child: CircularProgressIndicator()) : body(),
    );
  }

  Widget body() {
    int index = 0;
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            order.status.values.map((e) {
              return timelineItem(e, index++);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget timelineItem(Status status, int index) {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width < 990
            ? MediaQuery.of(context).size.width < 600
                ? 10
                : MediaQuery.of(context).size.width / 9
            : MediaQuery.of(context).size.width / 5,
        right: MediaQuery.of(context).size.width < 990
            ? MediaQuery.of(context).size.width < 600
                ? 10
                : MediaQuery.of(context).size.width / 9
            : MediaQuery.of(context).size.width / 5,
      ),
      child: TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.1,
        isFirst: index == 0,
        isLast: index == (order.status.values.length - 1),
        indicatorStyle: IndicatorStyle(
          width: currentStatusIndex > index
              ? 15
              : currentStatusIndex == index
                  ? 25
                  : 15,
          color: currentStatusIndex > index
              ? Colors.green[200]
              : currentStatusIndex == index
                  ? Colors.green
                  : this.currentStatusIndex + 1 == index
                      ? Theme.of(context).textTheme.headline6.color
                      : Colors.grey[500],
          padding: EdgeInsets.all(6),
        ),
        endChild: Container(
          margin: EdgeInsets.only(left: 10, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SecondaryButton(
                child: Text(
                  status.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: this.currentStatusIndex > index
                        ? Colors.grey[500]
                        : this.currentStatusIndex == index
                            ? Colors.grey[500]
                            : this.currentStatusIndex + 1 == index
                                ? null
                                : Colors.grey[500],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (currentStatusIndex + 1 == index) {
                    setState(() {
                      currentStatusIndex++;
                      order.status.values[currentStatusIndex].date =
                          DateTime.now();
                      order.status.current =
                          order.status.values[currentStatusIndex];
                      //_loading = true;
                      //presenter.update(order);
                    });
                  }
                },
              ),
              SizedBox(height: 5),
              status.date != null
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        DateUtil.formatDateMouthHour(status.date),
                        textAlign: TextAlign.right,
                        style: fontMessage(
                          context,
                          size: 15,
                          color: Colors.grey[500],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleTextWidget(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: fontMessage(context, size: 25, bold: true),
      ),
    );
  }

  Widget dateTextWidget(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: fontMessage(context, size: 18),
      ),
    );
  }

  Widget totalTextWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Text(
        "Total",
        textAlign: TextAlign.left,
        style: fontMessage(context, size: 25, bold: true),
      ),
    );
  }

  Widget addressDataWidget(Address address) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: order.delivery
                      ? FaIcon(
                          FontAwesomeIcons.motorcycle,
                        )
                      : FaIcon(
                          FontAwesomeIcons.running,
                        ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5, right: 10),
                        child: Text(
                          order.delivery
                              ? "Endereço de entrega"
                              : "Endereço de retirada",
                          textAlign: TextAlign.left,
                          style: fontMessage(context, size: 20, bold: true),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 5, right: 10),
                      //   child: Text(
                      //     "${address.street}" +
                      //         (address.number == null
                      //             ? ""
                      //             : ", ${address.number}"),
                      //     textAlign: TextAlign.left,
                      //     style: fontMessage(context, size: 20),
                      //   ),
                      // ),
                      // address.neighborhood != null
                      //     ? Padding(
                      //         padding: EdgeInsets.only(top: 5, right: 10),
                      //         child: Text(
                      //           address.neighborhood,
                      //           textAlign: TextAlign.left,
                      //           style: fontMessage(context, size: 20),
                      //         ),
                      //       )
                      //     : Container(),
                      // address.reference != null
                      //     ? Padding(
                      //         padding: EdgeInsets.only(top: 5, right: 10),
                      //         child: Text(
                      //           address.reference,
                      //           textAlign: TextAlign.left,
                      //           style: fontMessage(context, size: 20),
                      //         ),
                      //       )
                      //     : Container(),
                      order.note != null && order.note.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(top: 5, right: 10),
                              child: Text(
                                order.note,
                                style: fontMessage(
                                  context,
                                  size: 16,
                                  bold: true,
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  // order.deliveryAddress.location == null
                  //     ? NO_LOCATION
                  //     : OPEN_MAP,
                  "",
                  style: fontMessage(
                    context,
                    size: 20,
                    color: Colors.white,
                    bold: true,
                  ),
                ),
              ),
              onTap: () async {
                if (order.deliveryAddress != null) {
                  var address = order.deliveryAddress;
                  if (address != null) {
                    // MapsLauncher.launchCoordinates(
                    //   address.location.latitude,
                    //   address.location.longitude,
                    // );
                  } else {
                    // ScaffoldSnackBar.failure(
                    //     context, _scaffoldKey, SOME_ERROR);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget costTextWidget(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: fontMessage(context, size: 25, bold: true),
      ),
    );
  }

  Widget avaliationTextWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Text(
        "Avaliação",
        textAlign: TextAlign.left,
        style: fontMessage(context, size: 25, bold: true),
      ),
    );
  }

  Widget avaliationComenteTextWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Text(
        order.evaluation.comment,
        textAlign: TextAlign.center,
        style: fontMessage(context, size: 25),
      ),
    );
  }
}
