# Traffic-Utilities-v2
A small set of tools for the Western Australian Policing community

Now fully rebuilt in Flutter/Dart

Firebase Realtime and Firestore databases. 

Firebase authentication with Google Authentication. 

Cloud Function handling create new users. 

Dart code integrated for the Breath Calculation. Some Background....
In Western Australia, we still use a count back for Alcohol Breath Tests using a formula which calculates the exact Blood Alcohol Content (BAC) when a person was stopped by Police and found to have alcohol in their system.

It is perceived the count back is fairere for the person being tested, hoerver, that will soon change and whatever the final result willbe at the Draeger Aclotest 9510 (eg 0.150) is what the person is charged with.

So, for now if a person provided a sample of BAC as 0.150 (Driving Under The Influence of Alcohol(DUI), in fairness there would be a calculation done resulting in a lesser pemnalty dependeant on the the amount of lapsed time from the occurrecne time to the test time...

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
