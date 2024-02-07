import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/trade.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/trades_list_page.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/single_card_show.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/user_profile_square.dart';

class TradeInfoPage extends StatelessWidget {

  final User user;
  final Trade trade;
  final Function changeBodyWidget;
  const TradeInfoPage({super.key, required this.user, required this.trade, required this.changeBodyWidget});

  Future<User> _getTradeUser(String username) async {
    return (await FirebaseCloudServices().getUserUsingUsername(username))!;
  }

  @override
  Widget build(BuildContext context) {
    var isUserSender = trade.senderUsername == user.username;
    var isTradeStillPendingAndUserOffered = (!isUserSender && (trade.status == "pending" || trade.status == "visualized"));
    return FutureBuilder(
      future: _getTradeUser(isUserSender ? trade.receiverUsername : trade.senderUsername),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AuthLoadingBar();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("An error occurred while loading trades"),
          );
        } else {
          var friend = snapshot.data!;
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _getBackgroundColor(),
                  Colors.grey[200]!,
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Text(
                          "Trade ${trade.tradeId}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 40,
                        top: -5,
                        child: IconButton(
                          onPressed: () {
                            changeBodyWidget(TradesListPage(user: user, changeBodyWidget: changeBodyWidget));
                          },
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.grey[800],
                            size: 32,
                          ),
                        ),
                      ),

                      Positioned(
                        right: 40,
                        top: -5,
                        child: IconButton(
                          onPressed: () async {
                            await FirebaseCloudServices().deleteTrade(trade);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Center(
                                  child: Text(
                                    "The trade has been deleted",
                                    style: TextStyle(
                                      color: Colors.grey[200],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                            changeBodyWidget(TradesListPage(user: user, changeBodyWidget: changeBodyWidget));
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey[800],
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  Divider(
                    color: Colors.grey[800],
                    thickness: 2,
                    indent: 50,
                    endIndent: 50,
                  ),

                  _putTextIfTradeIsAcceptedOrRejected(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey[700]!,
                          width: 2,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 20,),
                                  UserProfileSquare(user: isUserSender ? user : friend, backgroundColor: Colors.transparent),

                                  const SizedBox(width: 10,),
            
                                  Icon(
                                    Icons.compare_arrows_rounded,
                                    size: 48,
                                    color: Colors.grey[800],
                                  ),

                                  const SizedBox(width: 10,),
            
                                  UserProfileSquare(user: !isUserSender ? user : friend, backgroundColor: Colors.transparent),
                                  const SizedBox(width: 20,),
                              ]
                            ),

                            const SizedBox(height: 20,),
            
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Cards offered:",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
            
                            // const SizedBox(height: 5,),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                              child: Container(
                                // width: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey[700]!,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:
                                      trade.pokemonCardsOffered.map((card) =>
                                          SingleCardShowImage(card: card, changeBodyWidget: changeBodyWidget)
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
            
                            const SizedBox(height: 20,),
            
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Cards requested:",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
            
                            // const SizedBox(height: 10,),
            
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                              child: Container(
                                // width: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey[700]!,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:
                                      trade.pokemonCardsRequested.map((card) =>
                                          SingleCardShowImage(card: card, changeBodyWidget: changeBodyWidget)
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  if(isTradeStillPendingAndUserOffered)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: 340,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red[500],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey[900]!,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseCloudServices().updateTradeStatus(trade, "rejected");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 2),
                                        content: Center(
                                          child: Text(
                                            "The trade has been rejected",
                                            style: TextStyle(
                                              color: Colors.grey[200],
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                    changeBodyWidget(TradesListPage(user: user, changeBodyWidget: changeBodyWidget));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  child: Text(
                                    "Reject trade",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 20,),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green[500],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey[900]!,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseCloudServices().updateTradeStatus(trade, "accepted", email: user.email, context: context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 2),
                                        content: Center(
                                          child: Text(
                                            "The trade has been accepted",
                                            style: TextStyle(
                                              color: Colors.grey[200],
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                    changeBodyWidget(TradesListPage(user: user, changeBodyWidget: changeBodyWidget));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  child: Text(
                                    "Accept trade",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Color _getBackgroundColor() {
    switch (trade.status) {
      case "pending" || "visualized":
        return Color(int.parse(user.favouriteColor));
      case "accepted":
        return Colors.green[200]!;
      case "rejected":
        return Colors.red[200]!;
      default:
        return Colors.white;
    }
  }

  Widget _putTextIfTradeIsAcceptedOrRejected() {
    switch(trade.status) {
      case "accepted":
        return Column(
          children: [
            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.center,
              child: Text(
                "The trade was accepted",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10,),
          ],
        );
      case "rejected":
        return Column(
          children: [
            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.center,
              child: Text(
                "The trade was rejected",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
    switch(trade.status) {

    }
  }
}
