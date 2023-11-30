import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


// Flutter code sample for [DropdownMenu]s. The first dropdown menu
// has the default outlined border and demos using the
// [DropdownMenuEntry] style parameter to customize its appearance.
// The second dropdown menu customizes the appearance of the dropdown
// menu's text field with its [InputDecorationTheme] parameter.

void main() {
  runApp(const DropdownMenuExample());

}

// DropdownMenuEntry labels and values for the first dropdown menu.

enum SingingCharacter { lafayette, jefferson }

enum PlantLabel {
  plant1('001'),
  plant2('002'),
  plant3('003'),
  plant4('004'),
  plant0('000');


  const PlantLabel(this.label);
  final String label;

}

// DropdownMenuEntry labels and values for the second dropdown menu.
enum IconLabel {
  L1('L1'),
  L2(
    'L2',
  ),
  L3('L3'),
  L4('L4');

  const IconLabel(this.label);
  final String label;
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});


  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  PlantLabel? selectedColor;
  IconLabel? selectedIcon;
  int activeIndex = 0;
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        activeIndex++;

        if (activeIndex == 2)
          activeIndex = 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Material Readings',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                height: 400,
                  child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 0 ? 1 : 0,
                            duration: Duration(seconds: 1,),
                            curve: Curves.linear,
                            child: Image.asset('assets/images/cute_robot_1_1-1560x1560.jpg', height: 50,),
                          ),
                        ),

                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 1 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.asset('assets/images/cute-robot-open-the-box-6374847-5272693.png', height: 50,),
                          ),
                        )
                      ]
                  ),
                ),
                SizedBox(height: 40,),
          Container(
            height: 50,
            width: 1000.0,
            // width: MediaQuery.of(context).size.width,
            child: Expanded(
              child:
                DropdownMenu<PlantLabel>(

                        menuHeight: 100.0,
                        width: 1000,
                        controller: colorController,
                        // requestFocusOnTap is enabled/disabled by platforms when it is null.
                        // On mobile platforms, this is false by default. Setting this to true will
                        // trigger focus request on the text field and virtual keyboard will appear
                        // afterward. On desktop platforms however, this defaults to true.
                        requestFocusOnTap: true,
                        hintText: 'Plant',
                        label: const Text('Plant', style: TextStyle(color: Colors.indigo, fontSize: 14.0, fontWeight: FontWeight.w400),),


                        onSelected: (PlantLabel? label) {
                          setState(() {
                            selectedColor = label;
                          });
                        },
                        dropdownMenuEntries: PlantLabel.values
                            .map<DropdownMenuEntry<PlantLabel>>(
                                (PlantLabel color) {
                              return DropdownMenuEntry<PlantLabel>(

                                value: color,
                                label: color.label,
                                enabled: color.label != '000',

                              );
                            }).toList(),

                      ),
                ),),
                      const SizedBox(height: 30),
              DropdownMenu<IconLabel>(
                        controller: iconController,
                        menuHeight: 100.0,
                        width: 1000,
                        enableFilter: true,
                        requestFocusOnTap: true,
                        hintText: 'Truck No',
                        label: const Text('Truck Number', style: TextStyle(color: Colors.indigo, fontSize: 14.0, fontWeight: FontWeight.w400),),
                        onSelected: (IconLabel? icon) {
                          setState(() {
                            selectedIcon = icon;
                          });
                        },
                        dropdownMenuEntries:
                        IconLabel.values.map<DropdownMenuEntry<IconLabel>>(
                              (IconLabel icon) {
                            return DropdownMenuEntry<IconLabel>(
                              value: icon,
                              label: icon.label,

                            );
                          },
                        ).toList(),
                      ),

                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Radio<SingingCharacter>(
                                value: SingingCharacter.lafayette,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text('In'),
                              )
                            ],
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Radio<SingingCharacter>(
                                value: SingingCharacter.jefferson,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                              Expanded(child: Text('Out'))
                            ],
                          ),
                          flex: 1,
                        ),

                      ],
                    ),

                SizedBox(height: 50),


              TextField(
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Meter Readings',
                  hintText: 'Enter Readings of the Meter',
                  labelStyle: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14.0,
                  ),
                  prefixIcon: Icon(Iconsax.user, color: Colors.blue, size: 18, ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.lightBlue[700],
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              SizedBox(height: 30,),

                      MaterialButton(
                        onPressed: (){},
                        height: 45,
                        color: Colors.blue,
                        child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 16.0),),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),

                    ],
                  ),
              ),

    ),
    );


  }
}
