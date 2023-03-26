#Weather App<br>
made with bloc,openweather api,geolocator.
<img src="https://user-images.githubusercontent.com/40795940/198162632-8d5ad6ba-1cb8-4ddc-bf82-7f8c8b560d33.png" width="300">   <img src="https://user-images.githubusercontent.com/40795940/198162635-951ab95c-24d6-4240-b75f-6aee0e0b3b83.png" width="300">

<h4> Project Structure </h4>
```.
├── constants
│   ├── app_colors.dart
│   ├── app_errors.dart
│   ├── app_images.dart
│   ├── app_routes.dart
│   ├── app_styles.dart
│   ├── app_themes.dart
│   └── end_points.dart
├── enums
│   └── geo_settings.dart
├── error
│   ├── failures.dart
│   └── network_checker.dart
├── features
│   └── weather_app
│       ├── data
│       │   ├── data_sources
│       │   │   └── weather_api.dart
│       │   ├── models
│       │   │   ├── air_pollution_model.dart
│       │   │   ├── current_weather_model.dart
│       │   │   └── fiveday_weather_forecast_model.dart
│       │   └── repositories
│       │       └── weather_repository_impl.dart
│       ├── domain
│       │   ├── entities
│       │   │   ├── air_pollution_entity.dart
│       │   │   ├── five_day_forecast.dart
│       │   │   └── weather_entity.dart
│       │   ├── repositories
│       │   │   └── weather_repository.dart
│       │   └── use_cases
│       │       ├── air_pollution_forecast_usecase.dart
│       │       ├── current_air_pollution_usecase.dart
│       │       ├── current_weather_usecase.dart
│       │       ├── fiveday_forecast_usecase.dart
│       │       └── historical_air_pollution_usecase.dart
│       └── presentation
│           ├── bloc
│           │   ├── current_weather_cubit
│           │   │   ├── current_weather_cubit.dart
│           │   │   └── current_weather_state.dart
│           │   ├── theme_manager
│           │   │   ├── theme_manager_bloc.dart
│           │   │   ├── theme_manager_event.dart
│           │   │   └── theme_manager_state.dart
│           │   └── weather_forecast_cubit
│           │       ├── weather_forecast_cubit.dart
│           │       └── weather_forecast_state.dart
│           ├── pages
│           │   └── current_weather
│           │       └── current_weather_page.dart
│           └── widgets
│               └── modal_bottom_sheet.dart
├── reusable_components
│   └── custom_page_route.dart
├── services
│   ├── bloc_observer.dart
│   ├── geo_service.dart
│   ├── injector.dart
│   └── shared_pref.dart
├── app_routers.dart
├── main.dart
└── test.dart```
