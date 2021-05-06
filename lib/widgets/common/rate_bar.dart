import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RateBar extends StatelessWidget {
  double maxHeight;
  double barHeight;

  int positiveVotes;
  int negativeVotes;
  bool wasVotedPositively;
  bool wasVotedNegatively;
  Function() negativeVoteFunction;
  Function() positiveVoteFunction;

  RateBar(
      this.positiveVotes,
      this.negativeVotes,
      this.wasVotedPositively,
      this.wasVotedNegatively,
      this.positiveVoteFunction,
      this.negativeVoteFunction);

  void _initDimensions() {
    maxHeight = 22.0;
    barHeight = maxHeight * 0.7;
  }

  @override
  Widget build(BuildContext context) {
    _initDimensions();
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          GestureDetector(
            onTap: positiveVoteFunction,
            behavior: HitTestBehavior.translucent,
            child: Container(
              margin: const EdgeInsets.only(right: 4.0),
              alignment: Alignment.centerLeft,
              child: Icon(
                CupertinoIcons.hand_thumbsup,
                size: 18,
                color: wasVotedPositively ? Colors.black : Colors.black38,
              ),
            ),
          ),
          Expanded(
            child: Flex(
              mainAxisSize: MainAxisSize.min,
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: flexRateForBar(true),
                  child: Container(
                    margin: const EdgeInsets.only(right: 1.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          color: positiveVotes > negativeVotes
                              ? MyColorsProvider.GREEN_SHADY
                              : MyColorsProvider.LIGHT_GRAY,
                        ),
                        alignment: Alignment.centerLeft,
                        height: barHeight,
                        child: _partOfAll(true) > 0.3
                            ? Center(
                                child: Text(
                                  positiveVotes.toString(),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: flexRateForBar(false),
                  child: Container(
                    margin: const EdgeInsets.only(left: 1.5),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 3.0),
                      child: Container(
                        height: barHeight,
                        decoration: BoxDecoration(
                          // color: lightGray,
                          color: negativeVotes > positiveVotes
                              ? MyColorsProvider.RED_SHADY
                              : MyColorsProvider.LIGHT_GRAY,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: _partOfAll(false) > 0.3
                            ? Center(
                                child: Text(
                                  negativeVotes.toString(),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.fade,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: negativeVoteFunction,
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: const EdgeInsets.only(left: 4.0),
              alignment: Alignment.centerLeft,
              child: Icon(
                CupertinoIcons.hand_thumbsdown,
                size: 18,
                color: wasVotedNegatively ? Colors.black : Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int flexRateForBar(bool isPositive) {
    return (_partOfAll(isPositive) * 10000).round();
  }

  double _partOfAll(bool isPositive) {
    final numOfVotes = isPositive ? positiveVotes : negativeVotes;
    if (positiveVotes == 0 && negativeVotes == 0) {
      return 0.5;
    }
    return numOfVotes == 0 ? 0.0 : numOfVotes / (positiveVotes + negativeVotes);
  }
}
