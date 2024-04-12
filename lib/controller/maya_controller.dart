
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mayaweather/apiServices/api_caller.dart';
import 'package:mayaweather/model/weather_model.dart';


class MayaController extends GetxController{
  final RxBool _isLoading = true.obs;

  final RxDouble latitude=0.0.obs;
  final RxDouble longitude=0.0.obs;
  final RxString names="avinash".obs;

//   instance for them to be called
  RxBool checkLoading()=> _isLoading;
  RxDouble getLatitude()=> latitude;
  RxDouble getLongitude()=> longitude;

  // final Rx<WeatherModel?> weatherModel= Rx<WeatherModel?>(null);
  final Rx<WeatherModel> weatherModel = WeatherModel(
    coord: Coord(lon: 0.0, lat: 0.0),
    weather: [],
    base: "",
    main: Main(temp: 0.0, feelsLike: 0.0, tempMin: 0.0, tempMax: 0.0, pressure: 0, humidity: 0),
    visibility: 0,
    wind: Wind(speed: 0.0, deg: 0),
    clouds: Clouds(all: 0),
    dt: 0,
    sys: Sys(type: 0, id: 0, country: "", sunrise: 0, sunset: 0),
    timezone: 0,
    id: 0,
    name: "",
    cod: 0,
  ).obs;


  @override
  void onInit(){
    super.onInit();
    if(_isLoading.isTrue){
      getLocation();
      print("Value : ${weatherModel.value}");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  getLocation()async{
    bool isServiceEnabled;
    LocationPermission locationPermission;
    // LocationAccuracy locationAccuracy=LocationAccuracy.best;

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
      
      // call Api Caller
      return ApiCaller().getData(value.latitude, value.longitude).then((value) {
        weatherModel.value=value;
        _isLoading.value=false;
      });
      

    });

  }



}