import 'package:flutter/material.dart';
import 'package:trafficutilities/components/custom_widgets.dart';

import 'web_rego_check.dart';

class RegoCheckScreen extends StatelessWidget {
  static const String id = 'rego_check_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Registration Checks'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.lightBlue[600],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          var title = 'New South Wales';
                          var url =
                              'https://my.service.nsw.gov.au/MyServiceNSW/index#/rms/freeRegoCheck/details';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebRegoCheck(url: url, title: title),
                            ),
                          );
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomImage(
                            image: AssetImage('images/small-map-nsw.gif'),
                            title: 'N.S.W.',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var title = 'Queensland';
                          var url =
                              'https://www.service.transport.qld.gov.au/checkrego/application/VehicleSearch.xhtml?windowId=b0d';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebRegoCheck(url: url, title: title),
                            ),
                          );
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomImage(
                            image: AssetImage('images/small-map-qld.gif'),
                            title: 'QLD',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var title = 'Tasmania';
                          var url =
                              'https://www.transport.tas.gov.au/MRSWebInterface/public/regoLookup/registrationLookup.jsf';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebRegoCheck(url: url, title: title),
                            ),
                          );
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomImage(
                            image: AssetImage('images/small-map-tas.gif'),
                            title: 'TAS',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var title = 'South Australia';
                          var url =
                              'https://www.ecom.transport.sa.gov.au/et/checkRegistrationExpiryDate.do';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebRegoCheck(url: url, title: title),
                            ),
                          );
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomImage(
                            image: AssetImage('images/small-map-sa.gif'),
                            title: 'S.A.',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var title = 'Western Australia';
                          var url =
                              'https://online.transport.wa.gov.au/webExternal/registration';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebRegoCheck(url: url, title: title),
                            ),
                          );
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomImage(
                            image: AssetImage('images/small-map-wa.gif'),
                            title: 'W.A.',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var title = 'Northern Territory';
                          var url =
                              'https://nt.gov.au/driving/registration/rego-check';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebRegoCheck(url: url, title: title),
                            ),
                          );
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomImage(
                            image: AssetImage('images/small-map-nt.gif'),
                            title: 'N.T.',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var title = 'Victoria';
                          var url =
                              'https://www.vicroads.vic.gov.au/registration/buy-sell-or-transfer-a-vehicle/check-vehicle-registration/vehicle-registration-enquiry';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebRegoCheck(url: url, title: title),
                            ),
                          );
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: new CustomImage(
                            image: AssetImage('images/small-map-vic.gif'),
                            title: 'VIC',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var title = 'Australian Capital Territory';
                          var url =
                              'https://rego.act.gov.au/regosoawicket/public/reg/FindRegistrationPage';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebRegoCheck(url: url, title: title),
                            ),
                          );
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomImage(
                            image: AssetImage('images/small-map-act.gif'),
                            title: 'A.C.T.',
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
      ),
    );
  }
}

//                  RoundedButton(
//                    color: Colors.blue,
//                    title: 'New South Wales',
//                    onPressed: () {

//                    },
//                  ),
//                  RoundedButton(
//                    color: Colors.blue,
//                    title: 'Queensland',
//                    onPressed: () {

//                    },
//                  ),
//                  RoundedButton(
//                    color: Colors.blue,
//                    title: 'Australian Capital Territory',
//                    onPressed: () {

//                    },
//                  ),
//                  RoundedButton(
//                    color: Colors.blue,
//                    title: 'Victoria',
//                    onPressed: () {

//                    },
//                  ),
//                  RoundedButton(
//                    color: Colors.blue,
//                    title: 'Tasmania',
//                    onPressed: () {

//                    },
//                  ),
//                  RoundedButton(
//                    color: Colors.blue,
//                    title: 'South Australia',
//                    onPressed: () {

//                    },
//                  ),
//                  RoundedButton(
//                    color: Colors.blue,
//                    title: 'Western Australia',
//                    onPressed: () {

//                    },
//                  ),
//                  RoundedButton(
//                    color: Colors.blue,
//                    title: 'Northern Territory',
//                    onPressed: () {

//                    },
//                  ),
