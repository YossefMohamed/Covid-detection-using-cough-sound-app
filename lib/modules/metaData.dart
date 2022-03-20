import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:project_app/ChechBox_state.dart';
class MetaData extends StatefulWidget {
  const MetaData({Key? key}) : super(key: key);

  @override
  State<MetaData> createState() => _MetaData();
}

class _MetaData extends State<MetaData> {
  // final allChecked = CheckBoxState(title: 'all checked');
  //Q1
//  final checkBoxList = [
//    CheckBoxState(title: 'Cough'),
//    CheckBoxState(title: 'Cold'),
//    CheckBoxState(title: 'Fever'),
//    CheckBoxState(title: 'Diarrhoea'),
//    CheckBoxState(title: 'Sore Throat'),
//    CheckBoxState(title: 'None of the above'),
//  ];

// radio buttons choices
  int value1 = 1;
  int value2 = 1;
  int value3 = 1;
  int value4 = 1;
  int value5 = 1;

  bool? value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff28B463),
          systemOverlayStyle:
              SystemUiOverlayStyle.light, // status bar text to light :)
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Form(
                        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'In order to make test\nMetadata is essential to provide accurate test\nit\'s private and only takes about 1 min',
                  style:  TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                //are u smoke? value2
                const Text(
                  'Do you have smoking habits?',
                  style:  TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Row(children: [
                  Radio(
                    value: 1,
                    groupValue: value2,
                    onChanged: (_) {
                      setState(() {
                        value2 = 1;
                      });
                    },
                    activeColor: const Color(0xff27AE60),
                  ),
                  const Text(
                    'Yes',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    width: 90.0,
                  ),
                  Radio(
                    value: 2,
                    groupValue: value2,
                    onChanged: (_) {
                      setState(() {
                        value2 = 2;
                      });
                    },
                    activeColor: const Color(0xff27AE60),
                  ),
                  const Text(
                    'No',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 15.0,
                ),
                //vacssin value3
                const Text(
                  'Vaccination Status?',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Row(children: [
                  Radio(
                    value: 1,
                    groupValue: value3,
                    onChanged: (_) {
                      setState(() {
                        value3 = 1;
                      });
                    },
                    activeColor: const Color(0xff27AE60),
                  ),
                  const Text(
                    '2 doses',
                    style: TextStyle(
                      fontSize: 20.0,
                      ),
                  ),
                  const SizedBox(
                    width: 44.5,
                  ),
                  Radio(
                    value: 2,
                    groupValue: value3,
                    onChanged: (_) {
                      setState(() {
                        value3 = 2;
                      });
                    },
                    activeColor: const Color(0xff27AE60),
                  ),
                  const Text(
                    '1 doses',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),

                  Radio(
                    value: 5,
                    groupValue: value5,
                    onChanged: (_) {
                      setState(() {
                        value5 = 5;
                      });
                    },
                    activeColor: const Color(0xff27AE60),
                  ),
                  const Text(
                    '3 doses',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),

                ]
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: value3,
                      onChanged: (_) {
                        setState(() {
                          value3 = 3;
                        });
                      },
                      activeColor: const Color(0xff27AE60),
                    ),
                    const Text(
                      'Not done',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //health care
                const Text(
                  ' Health Care',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                //sympotes
                const Text(
                  'Do you have any of these symptoms?',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //cough
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Cough',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //cold
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Cold',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //fever
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Fever',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //diarrhoea
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Diarrhoea',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //sore throat
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Sore throat',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //none
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'None of the above',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 20.0,
                ),
                //conditions
                const Text(
                  'Do you have any of these conditions?',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //loss of smell
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Loss of Smell or Taste',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //breath
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Breathing Difficulties',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //muscle
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Muscle Pain',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //fatigue
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Fatigue',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //none
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'None of the above',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 20.0,
                ),
                //respiratory ailments
                const Text(
                  'Do you have any of these respiratory ailments?',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //Pneumonia
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Pneumonia',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //Asthma
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Asthma',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //Chronic Lung Disease
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Chronic Lung Disease',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //other
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Others',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //none
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'None of the above',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 20.0,
                ),
                //pre-existing conditions
                const Text(
                  'Do you have any of these pre-existing conditions?',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //Hypertension
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Hypertension',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                // Heart Disease
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Heart Disease',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //Diabetes
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Diabetes',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //other
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'Others',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                //none
                Row(children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    activeColor: const Color(0xff28B463),
                  ),
                  const Text(
                    'None of the above',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 15.0,
                ),
                //covid status value4
                const Text(
                  ' COVID test Status',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                // have u made the test
                const Text(
                  'Have you taken a covid-19 test?',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: value4,
                      onChanged: (_) {
                        setState(() {
                          value4 = 1;
                        });
                      },
                      activeColor: const Color(0xff27AE60),
                    ),
                    const Text(
                      'Waiting for report',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: value4,
                      onChanged: (_) {
                        setState(() {
                          value4 = 2;
                        });
                      },
                      activeColor: const Color(0xff27AE60),
                    ),
                    const Text(
                      'Tested positive',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: value4,
                      onChanged: (_) {
                        setState(() {
                          value4 = 3;
                        });
                      },
                      activeColor: const Color(0xff27AE60),
                    ),
                    const Text(
                      'Tested negative ',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 4,
                      groupValue: value4,
                      onChanged: (_) {
                        setState(() {
                          value4 = 4;
                        });
                      },
                      activeColor: const Color(0xff27AE60),
                    ),
                    const Text(
                      'Never taken a test',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'By click register you agree to the terms of service',
                    style: TextStyle(
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                //register button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: const Color(0xff28B463),
                  ),
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                       submitData();
                    },
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ))))));
  }

  // upload meta data
  void submitData() {}

  // record voice
  // when data is success submited , show dialog with a record button to take voice from user
  void recordCough() {}
}
