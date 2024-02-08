import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/trade.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/images/icons/poke_dima_icons.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/trade_info_page.dart';

class TradeTile extends StatelessWidget {

  final User user;
  final Trade trade;
  final Function changeBodyWidget;
  final bool isTablet;
  const TradeTile({ super.key, required this.trade, required this.changeBodyWidget, required this.user, this.isTablet = false });

  @override
  Widget build(BuildContext context) {
    var userUsernames = _getStatusText();
    return TextButton(
      onPressed: () {
        changeBodyWidget(
            TradeInfoPage(
              user: user,
              trade: trade,
              changeBodyWidget: changeBodyWidget,
              isTablet: isTablet,
            )
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey[800]!,
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 0,),

                Container(
                  alignment: Alignment.center,
                  width: 80,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey[900]!,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    trade.tradeId,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 10,),

                Row(
                  children: [
                    Text(
                      userUsernames[0],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 10,),

                    Icon(
                      PokeDima.exchange_round,
                      size: 24,
                      color: Colors.grey[800],
                    ),

                    const SizedBox(width: 10,),

                    Text(
                      userUsernames[1],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                ),

                const SizedBox(width: 10,),

                Align(
                  alignment: Alignment.centerRight,
                  child: _getStatusIcon(),
                ),

                const SizedBox(width: 0,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    // return Color(int.parse(user.favouriteColor));
    switch(trade.status) {
      case "accepted":
        return Colors.green[200]!;
      case "rejected":
        return Colors.red[200]!;
      case "pending" || "visualized":
        return Colors.blue[100]!;
      default:
        return Colors.red[300]!;
    }
  }

  Icon _getStatusIcon() {
    switch(trade.status) {
      case "accepted":
        return Icon(Icons.check_box_outlined, size: 40, color: Colors.green[600],);
      case "rejected":
        return Icon(Icons.close, size: 40, color: Colors.red[700],);
      case "visualized":
        return Icon(Icons.remove_red_eye, size: 40, color: Colors.blue[700],);
      case "pending":
        return Icon(PokeDima.clock_thin, size: 36, color: Colors.grey[900],);
      default:
        return Icon(Icons.error, size: 40, color: Colors.red[700],);
    }
    // switch(trade.status) {
    //   case "accepted":
    //     return Icons.check_box_outlined;
    //   case "rejected":
    //     return Icons.close;
    //   case "visualized":
    //     return Icons.remove_red_eye;
    //   case "pending":
    //     return Icons.lock_clock;
    //   default:
    //     return Icons.error;
    // }
  }

  List<String> _getStatusText() {
    var sender = trade.senderUsername == user.username ? "You" : trade.senderUsername;
    var receiver = trade.receiverUsername == user.username ? "you" : trade.receiverUsername;
    return [sender, receiver];
  }
}
