import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_test/bloc/viewTemplate/view_template_cubit.dart';

class ViewTemplate extends StatefulWidget {
  const ViewTemplate({required this.id, Key? key}) : super(key: key);
  final String id;

  @override
  State<ViewTemplate> createState() => _ViewTemplateState();
}

class _ViewTemplateState extends State<ViewTemplate> {
  @override
  void initState() {
    final ViewTemplateCubit viewtemplateCubit =
        BlocProvider.of<ViewTemplateCubit>(context)
          ..FetchSpecificTemplates(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Template'),
      ),
      body: BlocBuilder<ViewTemplateCubit, ViewTemplateState>(
        builder: (context, state) {
          if (state is ViewTemplateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ViewTemplateLoaded) {
            return Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                child: Column(
                  children: [
                    Card(
                        color: Color.fromARGB(255, 255, 239, 239),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            state.template.templateName ?? '',
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.template.formControls!.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemBuilder: (context, index) {
                          return state.template.formControls![index].type ==
                                  'text-field'
                              ? TextFormField(
                                  decoration: InputDecoration(
                                    labelText: state
                                        .template.formControls![index].label,
                                    hintText: state.template
                                        .formControls![index].placeholder,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                )
                              : DropdownButtonFormField2(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  isExpanded: true,
                                  hint: Text(
                                    state.template.formControls![index].label ??
                                        '',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 30,
                                  buttonHeight: 60,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: state.template.formControls![index]
                                      .dropdownOptions!
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select .';
                                    }
                                  },
                                  onChanged: (value) {},
                                  onSaved: (value) {},
                                );
                        })
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
