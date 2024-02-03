import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/trade.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/presentation/pages/user_profile_page.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/widgets/trade_tile.dart';


class TradesListPage extends StatelessWidget {

  final User user;
  final Function changeBodyWidget;
  const TradesListPage({ super.key, required this.user, required this.changeBodyWidget });
  
  Future<List<Trade>> _loadTrades() async {
    return await FirebaseCloudServices().getAllUserTrades(user.username);
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: _loadTrades(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) { return const AuthLoadingBar(); }
        else if (snapshot.hasError) { return const Center(child: Text("An error occurred while loading trades"),); }
        else  {
          List<Trade> trades = snapshot.data!;
          return Container(
            color: Color(int.parse(user.favouriteColor)),
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Stack(
                    children: [
                      Center(
                        child: Text(
                          "Trades List",
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
                          onPressed: () { changeBodyWidget(UserProfile(changeBodyWidget: changeBodyWidget)); },
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
                          onPressed: () { _openFilterDialog(); },
                          icon: Icon(
                            Icons.settings,
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

                  const SizedBox(height: 10,),

                  if(trades.isEmpty)
                    Center(
                      child: Text(
                        "You have no trades yet",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  if(trades.isNotEmpty)
                    Column(
                      children: trades.map(
                              (trade) => TradeTile(
                                user: user,
                                trade: trade,
                                changeBodyWidget: changeBodyWidget,
                              )
                      ).toList(),
                    ),
                  ],
                ),
            ),
          );
        }
        
      },
    );
  }

  void _openFilterDialog() {  }
}
