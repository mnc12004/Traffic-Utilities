import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trafficutilities/components/rounded_button.dart';

var testTitle;

class BreathCalcScreen extends StatefulWidget {
  static const String id = 'breath_calc_screen';

  @override
  _BreathCalcScreenState createState() => _BreathCalcScreenState();
}

class _BreathCalcScreenState extends State<BreathCalcScreen> {
  DateTime ld;
  DateTime occ;
  DateTime tt;

  String calcRes;

  var inpLD;
  var inpOcc;
  var inpTT;
  var inpRes;

  var occDiff;
  var ttDiff;
  var calcDiff;

  var diff;
  var draegerRes;
  var dRes;
  var finalCalc;

  bool resultReceived = false;

  @override
  void initState() {
    super.initState();
  }

  Future doCalc(ld, occ, tt, draegerRes) async {
    // Variables form the form Fields

    ld = await ld;
    occ = await occ; //DateTime(2019, 07, 06, 11, 00);
    tt = await tt; //DateTime(2019, 07, 06, 11, 10);
    // Peak time of 2 hours after either teh occurrence time or if known, the last drink time.
    var peakTime;
    // The result after the subject has provided a breath sample to the Draeger Alcotest 9510
    var dRes = double.parse(draegerRes);
    assert(dRes is double); //await draegerRes;
    // The initial calculation
    var initCalc;
    // The calculate BAC
    //var calcRes;
    // The final Calculation after subtracting a further 0.000533 or 2 minutes
    //var finalCalc;
    // When the last drink is known, this is the results of adding the test time to peak and the occurrence time to peak.
    var totalDiff;
    // When the last drink time is known, and the test time is after the peak
    var peakDiff;
    // When the last drink time is know, and the occurrence time is before the peak time.
    var occDiff;
    // This is used to check if the breath test has either been conducted too early, or too late.
    var chkDiff;

    // Just making sure we got the variables from the form.
    print('Got Values: $ld, $occ, $tt, $dRes');

    // Used for switch/case clause
    int brTest;

    // Determines how the test is calculated and for chkDiff to know when to fire correctly.
    bool ldKnown = false;

    if (ld != null) {
      peakTime = ld.add(Duration(minutes: 120));
      ldKnown = true;
//      chkDiff = occ.difference(tt);
//      if (chkDiff.inMinutes >= -14) {
//        brTest = 4;
//      }
    } else {
      peakTime = occ.add(Duration(minutes: 120));
      ldKnown = false;
      chkDiff = occ.difference(tt);
      if (chkDiff.inMinutes >= -14) {
        brTest = 4;
      } else if (chkDiff.inMinutes <= -240) {
        brTest = 5;
      }
    }

    // LD Known. Occ Before Peak and Test after
    if (ldKnown == true) {
      if (occ.isBefore(peakTime) && tt.isAfter(peakTime)) {
        brTest = 2;
      } else if (occ.isAfter(peakTime) && tt.isAfter(peakTime)) {
        brTest = 3;
      }
      chkDiff = tt.difference(occ);
      if (chkDiff.inMinutes > 240) {
        brTest = 5;
      }
      print('BRTest: $brTest');
    }

    // Switch/Case. 5 choices. Normal Test(1). LD Known, occ before peak and test after peak(2). LD Known, occ and test after(3), invlaid test, too early(4). Invalid test, too late. peak(5).
    switch (brTest) {
      case 2: //Last Drink Known. Occurrence Before peak time and Test after Peak time.

        testTitle =
            'Last Drink Known. Occurrence Before peak time and Test after Peak time.';
        peakDiff = tt.difference(peakTime);
        occDiff = occ.difference(peakTime);
        totalDiff = peakDiff + occDiff;
        var diff = totalDiff;
        initCalc = ((diff.inMinutes * 0.016) / 60 + dRes);
        calcRes = initCalc.toStringAsPrecision(6);
        finalCalc = (initCalc - 0.000533).toStringAsPrecision(6);
        //Print results
        setState(() {
          showDialog(
              context: context,
              builder: (BuildContext context) => BreathResultsDialog(
                ld: ld,
                occ: occ,
                tt: tt,
                diff: diff,
                dRes: dRes,
                calcRes: calcRes,
                finalCalc: finalCalc,
              ));
        });
        break;
      case 3: // Last Drink Known. Occ & Test after Peak (Should always be a positive time difference)

        testTitle =
            'Last Drink Known. Occ & Test after Peak (Should always be a positive time difference)';
        print(testTitle);
        Duration diff = tt.difference(occ);
        //Calculate results
        var tCalc = (diff.inMinutes * 0.016) / 60 + dRes;
        var calcRes = tCalc.toStringAsPrecision(6);
        var finalCalc = (tCalc - 0.000533).toStringAsPrecision(6);

        setState(() {
          showDialog(
              context: context,
              builder: (BuildContext context) => BreathResultsDialog(
                ld: ld,
                occ: occ,
                tt: tt,
                diff: diff,
                dRes: dRes,
                calcRes: calcRes,
                finalCalc: finalCalc,
              ));
        });

        break;
      case 4:
        print('invalid test. Too Early');
        setState(() {
          showDialog(context: context, builder: (context) => InvalidTest(),);
        });
        break;
      case 5:
        setState(() {
          showDialog(context: context, builder: (context) => InvalidTest(),);
        });
        break;
      default: // Normal Test
        // Gather variables and do the calculation
        testTitle = 'Normal Test';
        Duration diff = occ.difference(tt);
        initCalc = ((diff.inMinutes * 0.016) / 60 + dRes);
        calcRes = initCalc.toStringAsPrecision(6);
        finalCalc = (initCalc - 0.000533).toStringAsPrecision(6);
        // Print out the results
        setState(() {
          showDialog(
              context: context,
              builder: (BuildContext context) => BreathResultsDialog(
                ld: ld,
                occ: occ,
                tt: tt,
                diff: diff,
                dRes: dRes,
                calcRes: calcRes,
                finalCalc: finalCalc,
              ));
        });
        print(
            '$testTitle\nCalculated time: ${diff.inMinutes}\nCalculated result: $calcRes\nFinal Calculation: $finalCalc');

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formats = {
      InputType.both: DateFormat("dd-MM-yyyy, HH:mm"),
      InputType.date: DateFormat('dd-MM-yyyy'),
      InputType.time: DateFormat("HH:mm"),
    };

    InputType inputType = InputType.both;
    bool editable = true;

    return Scaffold(
      appBar: AppBar(
        title: Text('Breath Calculator'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    'images/9510.webp',
                    height: 200.0,
                    width: 200.0,
                  ),
                  DateTimePickerFormField(
                    format: formats[inputType],
                    inputType: inputType,
                    editable: editable,
                    key: inpLD,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Drink Time',
                        hasFloatingPlaceholder: false),
                    onChanged: (value) {
                      ld = value;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  DateTimePickerFormField(
                    format: formats[inputType],
                    inputType: inputType,
                    editable: editable,
                    key: inpOcc,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Time of Occurrence',
                        hasFloatingPlaceholder: false),
                    onChanged: (value) {
                      occ = value;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  DateTimePickerFormField(
                    key: inpTT,
                    format: formats[inputType],
                    inputType: inputType,
                    editable: editable,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Time of Draeger Test',
                        hasFloatingPlaceholder: false),
                    onChanged: (value) {
                      tt = value;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    key: inpRes,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Draeger Result',
                    ),
                    onChanged: (value) {
                      draegerRes = value;
                    },
                  ),
                  SizedBox(height: 10.0),
                  RoundedButton(
                    color: Colors.red,
                    title: 'Calculate Breath Reading',
                    onPressed: () {
                      doCalc(ld, occ, tt, draegerRes);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InvalidTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Column(
        children: <Widget>[
          Image(
            image: AssetImage(
              'images/logo.png',
            ),
            height: 150.0,
            width: 150.0,
          ),
          Center(
              child: Text(
            'Invalid Test',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          )),
        ],
      ),
      content: Text(
        'This test has either been conducted too early or too late.',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BreathResultsDialog extends StatelessWidget {
  const BreathResultsDialog({
    Key key,
    @required this.ld,
    @required this.occ,
    @required this.tt,
    @required this.diff,
    @required this.dRes,
    @required this.calcRes,
    @required this.finalCalc,
  }) : super(key: key);

  final DateTime ld;
  final DateTime occ;
  final DateTime tt;
  final Duration diff;
  final double dRes;
  final calcRes;
  final finalCalc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage(
                'images/logo.png',
              ),
              height: 150.0,
              width: 150.0,
            ),
            Text('Breath Test Result Received'),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          height: 250.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                testTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Last Drink Time (if known): $ld',
                textAlign: TextAlign.start,
              ),
              Text('Occurrence: $occ'),
              Text('Test Time: $tt'),
              Text('Calculated Minutes: ${diff.inMinutes}'),
              SizedBox(
                height: 10.0,
              ),
              Text('Draeger result: $dRes'),
              Text('Calculated Result: $calcRes'),
              Text(
                  'Final Calculation (less mandatory 2 minutes 0.000533): $finalCalc',style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}
