import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:my_projects/reusable_components/custom_drawer.dart';

import '../../bloc/search_cubit.dart';
import '../web_view/web_view.dart';

class GoogleSearchPage extends StatelessWidget {
  GoogleSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField(),

            BlocBuilder<SearchCubit, SearchState>(
              builder: (c, state) {
                if (state is SearchInitialState) {
                  return const SizedBox.shrink();
                } else if (state is SearchLoadingState) {
                  return buildLottie(type:'loading.json',context: context);
                } else if (state is SearchErrorState) {
                  return buildError(state.message,context);
                } else if (state is SearchDataFetchedState) {
                  if (state.searchedResults.isEmpty) {
                    return const Center(
                      child: Text("Sorry, no data"),
                    );
                  } else {
                    return Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.85,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: ListView.builder(
                            itemCount: state.searchedResults.length,
                            itemBuilder: (_, i) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)
                                         => WebViewPage(link:state.searchedResults[i].link??""),)
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: SizedBox(
                                    width:  MediaQuery.of(context).size.width * 0.95,
                                    height:  MediaQuery.of(context).size.height * 0.2,
                                    child: Card(
                                      child: ListTile(

                                       title: Text(
                                          state.searchedResults[i].title ?? "",
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis)
                                       ),

                                       subtitle: Padding(
                                         padding: EdgeInsets.only(top:8),
                                         child: Text(state.searchedResults[i].description??""),
                                       ),

                                    )),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLottie({
    required String type,
    double widthPercent = 0.6,
    heightPercent = 0.6,
    BoxFit? boxFit,
    bool repeat = true,
    required BuildContext context
  }){
    return Center(
      child: SizedBox(
          width:  MediaQuery.of(context).size.width * widthPercent,
          height:  MediaQuery.of(context).size.height * heightPercent,
          child: Lottie.asset(
            'assets/lottie/$type',
            repeat: repeat,
            fit: boxFit
          )),
    );
  }

  Widget buildError(String errorMessage,BuildContext context) {
    Fluttertoast.showToast(msg: errorMessage,fontSize: 17,textColor: Colors.white,backgroundColor: Colors.red.shade700,);
    return buildLottie(type: 'error.json',boxFit: BoxFit.contain,repeat: false,context: context);
  }
}


class buildTextField extends StatefulWidget {
  const buildTextField({Key? key}) : super(key: key);

  @override
  State<buildTextField> createState() => _buildTextFieldState();
}

class _buildTextFieldState extends State<buildTextField> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedPadding(
          padding: EdgeInsets.only(
              top: tapped
                  ?  MediaQuery.of(context).size.height * 0.04
                  :  MediaQuery.of(context).size.height * 0.10),
          duration: const Duration(milliseconds: 650),
        ),

        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width:  MediaQuery.of(context).size.width * 0.95,
            child: TextField(
              onTap: (){
                setState(() {
                  tapped = true;
                });
              },
              onSubmitted: (txt) {
                if (txt.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'please enter something to search on');
                } else {
                  context.read<SearchCubit>().getSearchResults(txt.trim());
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10,top: 17,bottom: 17,right: 10),
                hintText: 'Google Search',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: const BorderSide(width: 1, color: Colors.black)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}