
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MayaController extends GetxController{
  final RxBool _isLoading = true.obs;

  final RxDouble latitude=0.0.obs;
  final RxDouble longitude=0.0.obs;

//   instance for them to be called
  RxBool checkLoading()=> _isLoading;
  RxDouble getLatitude()=> latitude;
  RxDouble getLongitude()=> longitude;

  @override
  void onInit(){
    super.onInit();
    if(_isLoading.isTrue){
      getLocation();
    }
  }

  @override
  void onClose() {
    super.onClose();


  }

  getLocation()async{
    bool isServiceEnabled;
    LocationPermission locationPermission;
    LocationAccuracy locationAccuracy=LocationAccuracy.best;

    // service is enabled or not
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isServiceEnabled){
      return Future.error("Location is not Enabled");
    }

    //   status of Location permission
    locationPermission=await Geolocator.checkPermission();
    if(locationPermission == LocationPermission.deniedForever){
      return Future.error("Location Permission are not denied forever");
    }else if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission==LocationPermission.denied){
        return Future.error("Location permission is denied");
      }
    }

  //   Currect position of user
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value){
      latitude.value=value.latitude;
      longitude.value=value.longitude;
      _isLoading.value=false;
      print("${latitude.value} and ${longitude.value}");
    });

  }



}