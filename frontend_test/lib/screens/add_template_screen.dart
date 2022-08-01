import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_test/api_constrain.dart';
import 'package:frontend_test/helpers/api_repositary.dart';
import 'package:frontend_test/helpers/api_service.dart';
import 'package:frontend_test/models/template.dart';

import '../bloc/addTemplate/add_template_cubit.dart';

class AddTemplateScreen extends StatefulWidget {
  const AddTemplateScreen({Key? key}) : super(key: key);

  @override
  State<AddTemplateScreen> createState() => _AddTemplateScreenState();
}

class _AddTemplateScreenState extends State<AddTemplateScreen> {
  final templatenameController = TextEditingController();
  final placeholderTextfieldController = TextEditingController();
  final labelTextfieldController = TextEditingController();
  final labeldropdownController = TextEditingController();
  final option1TextfieldController = TextEditingController();
  final option2TextfieldController = TextEditingController();
  bool? required;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<FormControls> totalfield = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Template"),
      ),
      bottomNavigationBar: TextButton(
          onPressed: () {
            if (totalfield.length != 0) {
              final data = Templates(
                  id: '123456789',
                  templateName: templatenameController.text,
                  token: API_TOKEN,
                  formControls: totalfield);
              final AddTemplateCubit addtemplateCubit =
                  BlocProvider.of<AddTemplateCubit>(context)..addTemplate(data);
            } else {
              const snackdemo = SnackBar(
                content: Text('Please Select Atleast One Field'),
                backgroundColor: Colors.green,
                elevation: 10,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(5),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackdemo);
            }
          },
          child: Text('Add Template')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: templatenameController,
                decoration: InputDecoration(
                  labelText: 'Template Name',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        showCustomModalBottomSheetTextField(context);
                      },
                      child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Text('TextField'))),
                  TextButton(
                      onPressed: () {
                        showCustomModalBottomSheetDropDown(context);
                      },
                      child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: const Text('DropDown'))),
                ],
              ),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: totalfield.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                  itemBuilder: (context, index) {
                    return totalfield[index].type == 'text-field'
                        ? addTextField(
                            totalfield[index].label ?? '',
                            totalfield[index].placeholder ?? '',
                            totalfield[index].required!)
                        : addDropDown(
                            totalfield[index].label ?? '',
                            totalfield[index].dropdownOptions![0],
                            totalfield[index].dropdownOptions![1],
                            totalfield[index].required!);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget addTextField(String label, String placeholder, bool required) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(66, 255, 108, 108),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: const Color.fromARGB(255, 255, 240, 240)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Text Field',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                readOnly: true,
                initialValue: label,
                decoration: InputDecoration(
                  labelText: 'label',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                readOnly: true,
                initialValue: placeholder,
                decoration: InputDecoration(
                  labelText: 'placeholder',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Required : ${required}")
            ],
          )
        ]),
      ),
    );
  }

  Widget addDropDown(
      String label, String option1, String option2, bool required) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(66, 255, 108, 108),
          ),
          borderRadius: const BorderRadius.all(const Radius.circular(20)),
          color: const Color.fromARGB(255, 255, 240, 240)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Drop Down',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                readOnly: true,
                initialValue: label,
                decoration: InputDecoration(
                  labelText: 'label',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                readOnly: true,
                initialValue: option1,
                decoration: InputDecoration(
                  labelText: 'option1',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                readOnly: true,
                initialValue: option2,
                decoration: InputDecoration(
                  labelText: 'option2',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Required : ${required}")
            ],
          )
        ]),
      ),
    );
  }

  showCustomModalBottomSheetTextField(BuildContext context) {
    bool? isrequired = false;
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter stateSetter) {
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: AnimatedPadding(
                      padding: MediaQuery.of(context).viewInsets,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.decelerate,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              "Add Text Field",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: labelTextfieldController,
                              decoration: InputDecoration(
                                labelText: "Label",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              validator: (val) {
                                if (val?.length == 0) {
                                  return "label cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: placeholderTextfieldController,
                              decoration: InputDecoration(
                                labelText: "Placeholder",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              validator: (val) {
                                if (val?.length == 0) {
                                  return "placeholder cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Checkbox(
                                  value: isrequired,
                                  onChanged: (value) {
                                    setState(() {
                                      stateSetter(() => isrequired = value);
                                    });
                                    required = isrequired;
                                  },
                                ),
                                Text("Required"),
                              ],
                            ),
                            const SizedBox(height: 30),
                            TextButton(
                                onPressed: () {
                                  final FormState? form = _formKey.currentState;
                                  if (form!.validate()) {
                                    totalfield.add(FormControls(
                                        type: 'text-field',
                                        label: labelTextfieldController.text,
                                        placeholder:
                                            placeholderTextfieldController.text,
                                        required: required));
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  }
                                },
                                child: Text("Add"))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  showCustomModalBottomSheetDropDown(BuildContext context) {
    bool? isrequired = false;
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter stateSetter) {
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: AnimatedPadding(
                      padding: MediaQuery.of(context).viewInsets,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.decelerate,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              "Add Drop Down",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: labeldropdownController,
                              decoration: InputDecoration(
                                labelText: "Label",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              validator: (val) {
                                if (val?.length == 0) {
                                  return "label cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: option1TextfieldController,
                                    decoration: InputDecoration(
                                      labelText: "Option 1",
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val?.length == 0) {
                                        return "option 1 cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: option2TextfieldController,
                                    decoration: InputDecoration(
                                      labelText: "Option 2",
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val?.length == 0) {
                                        return "option 2 cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Checkbox(
                                  value: isrequired,
                                  onChanged: (value) {
                                    setState(() {
                                      stateSetter(() => isrequired = value);
                                    });
                                    required = isrequired;
                                  },
                                ),
                                Text("Required"),
                              ],
                            ),
                            const SizedBox(height: 30),
                            TextButton(
                                onPressed: () {
                                  final FormState? form = _formKey.currentState;
                                  if (form!.validate()) {
                                    totalfield.add(FormControls(
                                        type: 'dropdown',
                                        label: labelTextfieldController.text,
                                        dropdownOptions: [
                                          option1TextfieldController.text,
                                          option2TextfieldController.text
                                        ],
                                        required: required));
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  }
                                },
                                child: Text("Add"))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
