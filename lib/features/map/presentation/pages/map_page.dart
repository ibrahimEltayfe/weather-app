import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_projects/constants/app_colors.dart';
import 'package:my_projects/constants/app_strings.dart';
import 'package:my_projects/reusable_components/custom_drawer.dart';
import 'package:my_projects/services/geo_service.dart';
import '../../../../constants/app_constants.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final MapController mapController;

  @override
  void initState() {
    mapController = MapController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: FutureBuilder(
          future: GEOService.determinePosition(),
          builder: (context,AsyncSnapshot<Position> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }else{
              if(snapshot.error!=null){
                final List<String?> error = snapshot.error as List<String?>;
                bool isLocationSettings = error[1] == GEOSettings.openLocationSettings.name;
                return _buildErrorWidget(error,isLocationSettings,theme.textTheme.headline1!);
              }else if(snapshot.data != null){
                return Stack(
                      children: [
                        FlutterMap(
                          mapController: mapController,
                          options: MapOptions(
                              minZoom: 5,
                              maxZoom: 18.5,
                              zoom:13,
                              center: LatLng(snapshot.data!.latitude,snapshot.data!.longitude),
                          ),
                          layers: [
                            TileLayerOptions(
                              urlTemplate: AppStrings.styleUrl,
                            ),
                            MarkerLayerOptions(
                                markers: [
                                  Marker(
                                      point: LatLng(snapshot.data!.latitude,snapshot.data!.longitude),
                                      builder:(context) => Container(
                                        width: 50.w,
                                        height: 50.h,
                                        child: FittedBox(
                                          child: Icon(Icons.location_on_outlined,color: AppColors.blackBlue,),
                                        ),
                                      )
                                  )
                                ]
                            ),
                          ],
                        )
                      ],
                    );
              }else{
                return const SizedBox.shrink();
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildErrorWidget(List<String?> error,bool isLocationSettings,TextStyle txtTheme){
    return SizedBox(
      width: 1.sw,
      height: 0.95.sh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error[0]??'error',style: txtTheme.copyWith(fontSize: 20.sp)),

          SizedBox(height: 14.h,),

          ElevatedButton(
              style:ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(0.45.sw,0.07.sh)
                  )
              ) ,
              onPressed: () async{
                if(isLocationSettings){
                  await Geolocator.openLocationSettings();
                }else{
                  await Geolocator.openAppSettings();
                }
              },

              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  isLocationSettings?'Open Location Settings':'Open App Settings',
                  style:txtTheme.copyWith(color: AppColors.bgColor),
                ),
              )
          )
        ],
      ),
    );
  }
}
