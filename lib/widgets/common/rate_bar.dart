import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RateBar extends StatelessWidget {
  Color lightGray = Color.fromRGBO(224, 224, 224, 1.0);
  Color red = Color.fromRGBO(255, 128, 128, 1.0);
  Color green = Colors.green.shade400.withOpacity(0.8);
  static const double totalWidth = 80.0;
  static const double maxHeight = 22.0;
  static const double barHeight = maxHeight * 0.75;
  static const double safeWidth = 0.0;
  static const double maxWidth = totalWidth - safeWidth;

  int positiveVotes;
  int negativeVotes;
  bool wasVotedPositively;
  bool wasVotedNegatively;
  Function negativeVoteFunction;
  Function positiveVoteFunction;

  RateBar(this.positiveVotes, this.negativeVotes, this.wasVotedPositively,
      this.wasVotedNegatively, this.positiveVoteFunction, this.negativeVoteFunction);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: positiveVoteFunction,
          child: Container(
            margin: EdgeInsets.only(right: 2.0),
            alignment: Alignment.centerLeft,
            child: Icon(
              CupertinoIcons.hand_thumbsup,
              size: 16,
              color: wasVotedPositively ? Colors.black : lightGray,
            ),
          ),
        ),
        SizedBox(
          height: maxHeight,
          width: totalWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  // color: positiveVotes > negativeVotes ? green : lightGray,
                  color: positiveVotes > negativeVotes ? green : lightGray,
                  border: Border.all(
                    color: lightGray,
                    width: 0.2,
                  ),
                ),
                alignment: Alignment.centerLeft,
                height: barHeight,
                width: _getWidth(true),
                child: _partOfAll(true) > 0.3
                    ? Center(
                        child: Text(
                          positiveVotes.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            // color: wasVotedPositively
                            //     ? Colors.black87
                            //     : Colors.black54,
                          ),
                        ),
                      )
                    : null,
              ),
              Container(
                decoration: BoxDecoration(
                  // color: lightGray,
                  color: negativeVotes > positiveVotes ? red : lightGray,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(
                    color: lightGray,
                    width: 0.2,
                  ),
                ),
                // alignment: Alignment.centerRight,
                height: barHeight,
                width: _getWidth(false),
                child: _partOfAll(false) > 0.3
                    ? Center(
                        child: Text(
                          negativeVotes.toString(),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: negativeVoteFunction,
          child: Container(
            margin: EdgeInsets.only(left: 2.0),
            alignment: Alignment.centerLeft,
            child: Icon(
              CupertinoIcons.hand_thumbsdown,
              size: 16,
              color: wasVotedNegatively ? Colors.black : Colors.black38,
            ),
          ),
        ),
      ],
    );
  }

  double _getWidth(bool isPositive) {
    var calculatedWidth = (maxWidth + safeWidth / 2) *
        _partOfAll(isPositive);
    if (calculatedWidth < safeWidth / 2) {
      return safeWidth / 2;
    } else if (calculatedWidth > maxWidth - safeWidth) {
      return maxWidth - safeWidth / 4;
    } else {
      return calculatedWidth;
    }
  }

  double _partOfAll(bool isPositive) {
    var numOfVotes = isPositive ? positiveVotes : negativeVotes;
    if (positiveVotes == 0 && negativeVotes == 0) {
      return 0.5;
    }
    return numOfVotes == 0
        ? 0.0
        : numOfVotes / (positiveVotes + negativeVotes);
  }
}
