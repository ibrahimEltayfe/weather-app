import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:my_projects/reusable_components/custom_drawer.dart';

import '../../bloc/search_cubit.dart';
import '../web_view/web_view.dart';

class GoogleSearchPage extends StatelessWidget {
  GoogleSearchPage({Key? key}) : super(key: key);

  bool tapped = false;

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
                  return buildLottie(type:'loading.json');
                } else if (state is SearchErrorState) {
                  return buildError(state.message);
                } else if (state is SearchDataFetchedState) {
                  if (state.searchedResults.isEmpty) {
                    return const Center(
                      child: Text("Sorry, no data"),
                    );
                  } else {
                    return Expanded(
                      child: SizedBox(
                        height: ScreenUtil().screenHeight * 0.85,
                        width: ScreenUtil().screenWidth * 0.95,
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
                                  padding: EdgeInsets.only(left: 10.w, top: 10.h),
                                  child: SizedBox(
                                    width: ScreenUtil().screenWidth * 0.95,
                                    height: ScreenUtil().screenHeight * 0.2,
                                    child: Card(
                                      child: ListTile(

                                       title: Text(
                                          state.searchedResults[i].title ?? "",
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis)
                                       ),

                                       subtitle: Padding(
                                         padding: EdgeInsets.only(top:8.h),
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

  Widget buildTextField() {
    return StatefulBuilder(
      builder:(context, setState) =>
       Column(
         children: [
           AnimatedPadding(
             padding: EdgeInsets.only(
                 top: tapped
                     ? ScreenUtil().screenHeight * 0.04.h
                     : ScreenUtil().screenHeight * 0.10.h),
             duration: const Duration(milliseconds: 650),
           ),

           Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: ScreenUtil().screenWidth * 0.95,
              height: 50.h,
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
                  contentPadding: EdgeInsets.only(left: 10.w),
                  hintText: 'Google Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      borderSide: const BorderSide(width: 1, color: Colors.black)),
                ),
              ),
            ),
      ),
         ],
       ),
    );
  }

  Widget buildLottie({
    required String type,
    double widthPercent = 0.6,
    heightPercent = 0.6,
    BoxFit? boxFit,
    bool repeat = true
  }){
    return Center(
      child: SizedBox(
          width: ScreenUtil().screenWidth * widthPercent,
          height: ScreenUtil().screenHeight * heightPercent,
          child: Lottie.asset(
            'assets/lottie/$type',
            repeat: repeat,
            fit: boxFit
          )),
    );
  }

  Widget buildError(String errorMessage) {
    Fluttertoast.showToast(msg: errorMessage,fontSize: 17,textColor: Colors.white,backgroundColor: Colors.red.shade700,);
    return buildLottie(type: 'error.json',boxFit: BoxFit.contain,repeat: false);
  }
}
