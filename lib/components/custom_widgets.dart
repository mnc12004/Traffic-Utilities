import 'package:flutter/material.dart';
import 'package:trafficutilities/constants.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.colour, this.cardChild, this.onPressed});
  final Color colour;
  final Widget cardChild;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: cardChild,
        height: 200.0,
        width: 170.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          color: colour,
        ),
      ),
    );
  }
}

class CustomIconContent extends StatelessWidget {
  const CustomIconContent(
      {@required this.iconColor, @required this.tileText, this.tileIcon});

  final Color iconColor;
  final String tileText;
  final IconData tileIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          tileIcon,
          size: 60.0,
          color: iconColor,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          tileText,
          style: kLabelTextStyle,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onPressed});
  final IconData icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 10.0,
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
      child: Icon(icon),
      onPressed: onPressed,
    );
  }
}

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    Key key,
//    @required this.selectedGender,
//    @required this.height,
//    @required this.age,
//    @required this.weight,
    @required this.onTap,
    @required this.buttonTitle,
  }) : super(key: key);

//  final Gender selectedGender;
//  final int height;
//  final int age;
//  final int weight;
  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBottomContainerColor,
      margin: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: kBottomContainerHeight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Center(
            child: Text(
              buttonTitle,
              style: kLargeButtonTextStyle,
            ),
          ),
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.only(bottom: 20.0),
          width: double.infinity,
          height: kBottomContainerHeight,
        ),
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  CustomImage({this.title, this.image});

  final String title;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: image,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          title,
          style: kLabelTextStyle,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
