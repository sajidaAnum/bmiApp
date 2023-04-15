import 'package:bmi/components/reuseable_card.dart';
import 'package:flutter/material.dart';
import 'package:bmi/constatnts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'calculatorbrain.dart';
import 'result.dart';

enum Gender{
  male,
  female
}

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? sGender;
  int height = 170;
  int weight = 60;
  int age = 50;

  
  // Color malecardcolor=kInactiveCardColour;
  // Color femalecardcolor=kInactiveCardColour;


  // void updatecolor(Gender sGender){
  //   if (sGender==Gender.male){
  //     if (malecardcolor==kInactiveCardColour){
  //       malecardcolor=kActiveCardColour;
  //       femalecardcolor=kInactiveCardColour;
  //     }
  //     else{
  //       malecardcolor=kInactiveCardColour;
  //     }
  //   }
  //   if(sGender== Gender.female){
  //     if(femalecardcolor==kInactiveCardColour){
  //       femalecardcolor=kActiveCardColour;
  //       malecardcolor=kInactiveCardColour;
  //     }
  //     else{
  //       femalecardcolor=kInactiveCardColour;
  //     }
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('BMI CALCULATOR'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        sGender=Gender.male;
                      });
                    },
                    child: ReusableCard(
                      colour: sGender==Gender.male?kActiveCardColour:kInactiveCardColour,
                      cardChild: IconContent(icon: FontAwesomeIcons.mars,text: "Male",
                      ),
                      
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                       sGender=Gender.female;
                      });
                    },
                    child: ReusableCard(
                      colour: sGender==Gender.female?kActiveCardColour:kInactiveCardColour,
                      cardChild: IconContent(icon: FontAwesomeIcons.venus,text: "Female",),
                      
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ Text("Height",style:kLabelTextStyle,),
                   // Text("HEIGHT"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(height.toString() ,style:kNumberTextStyle,),
                      Text("cm",style: kLabelTextStyle,),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                    thumbShape:RoundSliderThumbShape(enabledThumbRadius: 20.0)
                    ),
                  
                    child: Slider(
                    min: 100, 
                    max: 220,
                    activeColor: kBottomContainerColour,
                    inactiveColor: kInactiveCardColour,
                    value: height.toDouble(), onChanged: (double newValue){
                      setState(() {
                        height= newValue.round();
                      });
                  
                    }
                    ),
                  ),
                ],
              ),
              colour: kActiveCardColour,
              onPress: () {},
            ), 
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Weight", 
                        style: kLabelTextStyle,),
                        SizedBox(height: 10.0,),
                        Text (  weight.toString(),
                          style: kNumberTextStyle,),
                          SizedBox(height: 10.0,), 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                              ),
                              SizedBox(
                              width: 20.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),   
                            ],
                          )
                      ],
                    ),
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Age",style: kLabelTextStyle,),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    onPress: () {},
                  ),
                ),
              ],
            ),
          ),


          BottomButton(
            buttonTitle: 'Calculate',
            onTap: () {
              CalculatorBrain cal =
                  CalculatorBrain(height: height, weight: weight);

                  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage (interpretation: cal.calculateBMI(),
                    resultText: cal.getResult(),
                    bmiResult: cal.getInterpretation(),
                  ),
                ),
              );
              
            },
          ),
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({required this.icon, required this.onPressed});
   final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton( 
      onPressed: onPressed,
      child: Icon(icon),
      constraints: BoxConstraints.tightFor(height: 60.0, width: 60.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0)
      ),
      fillColor: Color(0xFF4C4F5E),  
    );
  }
}

class IconContent extends StatelessWidget {
  IconContent({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Icon(
          icon,
          size: 70.0,
          ),
        SizedBox(
          height: 15.0,
        ),
        Text(text,style: kLabelTextStyle,),
      ],
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({required this.buttonTitle, required this.onTap});

  final String buttonTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            buttonTitle,
            style: kLargeButtonTextStyle,
          ),
        ),
        color: kBottomContainerColour,
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(bottom: 20.0),
        width: double.infinity,
        height: kBottomContainerHeight,
      ),
    );
  }
}
