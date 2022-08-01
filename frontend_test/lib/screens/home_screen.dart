import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_test/bloc/template/template_cubit.dart';
import 'package:frontend_test/screens/view_template.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final TemplateCubit templateCubit = BlocProvider.of<TemplateCubit>(context)
      ..FetchAllTemplates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Template List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTemplate');
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<TemplateCubit>(context).FetchAllTemplates();
        },
        child: BlocBuilder<TemplateCubit, TemplateState>(
          builder: (context, state) {
            if (state is TemplateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TemplateLoaded) {
              return ListView.separated(
                  itemCount: state.templates.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewTemplate(
                                id: state.templates[index].id ?? ''),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                            color: Color.fromARGB(255, 255, 239, 239),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                state.templates[index].templateName ?? '',
                                style: TextStyle(fontSize: 20),
                              ),
                            )),
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
