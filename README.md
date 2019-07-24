# Traffic-Utilities-v2
A small set of tools for the Western Australian Policing community

Now fully rebuilt in Flutter/Dart

Firebase Realtime and Firestore databases. 

Firebase authentication with Google Authentication. 

Cloud Function handling create new users. 

Dart code integrated for the Breath Calculation. Some Background....
In Western Australia, we still use a count back for Alcohol Breath Tests using a formula which calculates the exact Blood Alcohol Content (BAC) when a person was stopped by Police and found to have alcohol in their system.

It is perceived the count back is fairer for the person being tested, however, that will soon change and whatever the final result will be at the Draeger Aclotest 9510 (eg 0.150) is what the person is charged with.

So, for now, if a person provided a sample of BAC as 0.150 Driving Under The Influence of Alcohol(DUI), in fairness there would be a calculation done resulting in a lesser penalty, dependeant on the the amount of lapsed time from the occurrecne time to the test time...

<h3>Example Breath Test</h3><br>
Occurence: 10:00 AM<br>
Test Time: 10:45 AM<br>
Elapsed time: -45 minutes<br>
Result from Draeger Alcotest 9510: 0.150<br>
Calculated BAC: 0.138000<br><br>
Then in even more fairness, we take off a further two minutes (0.000533) and obtain the final reading or charge.
Final reading: <b>0.137467</b><br>

The formula to achieve this is (-45 * 0.016) / 60 + 0.150<br><br>

Of course there are other types of tests, but the example is the most common.

<h2>Other Tools</h2>
Western Australian Specific Tools:<br>
<b>Offence Search System</b> - Approximately 700 of the most common used offences used on WA.<br>
<b>L.A.M.S.</B> - A comprehensive list of Learner Approved Motorcycles (Firestore Data).<br>
<b>Australian Registration Checks</b> - Vehicle registration Checks from each state and territiry in Australia. Enabling Law enforcement to conduct quick checks on visiting out of state vehicles.<br>
<b>Where Am I?</b> - Google Maps enabled to show where you are quickly. Useful when writing infringements and you need a cross street.<br>
<b>My Links</b> - Create your own links and display them in a card view. Tap the card to navigate to the built in web browser.</br>
