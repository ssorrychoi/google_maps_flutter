# Adding Google Maps to a Flutter app

## 1. Introduction

`google_maps_flutter` [플러그인](https://pub.dev/packages/google_maps_flutter)을 이용해서 구글맵을 앱에 추가할 수 있다. 플러그인은 구글맵 서버, 맵 디스플레이에 접근이 자동적으로 가능하고, 클릭이나 드래그와 같은 유저의 제스처에 반응한다. 지도에 위치를 추가할 수 있다. 

### What you'll build

이번 코드랩에서는, FlutterSDK를 사용한 Google Map을 모바일앱에 빌드할 것이다. 

- 구글맵을 보여주기
- 웹 서비스에서 지도 데이터 검색
- 지도에서 markers(특정위치)를 표시

### What is Flutter?

Flutter is : 

- **빠른 개발** : Stateful Hot Reload로 안드로이드 및 iOS 애플리케이션을 밀리 초 단위로 구축할 수 있다.
- **표현력과 유연**성 : native와 end-user 경험에 중점을 둔 기능을 신속하게 제공.
- **iOS와 안드로이드 모두 네이티브 퍼포먼스** : Flutter의 위젯은 스크롤, 탐색, 아이콘 및 글꼴과 같은 모든 중요한 플랫폼 차이점을 통합하여 완전한 네이티브 성능을 제공한다.

Google maps has :

- **전 세계 99 % 적용 범위** : 200 개 이상의 국가 및 지역에 대한 신뢰할 수 있고 포괄적 인 데이터로 구축하십시오.
- **매일 2 천 5 백만 건의 업데이트** : 정확한 실시간 위치 정보를 사용합니다.
- **월간 10 억 명의 활성 사용자** : Google지도 인프라를 기반으로 자신있게 확장합니다.



## 2. Flutter 환경 설정

Flutter SDK와 Editor가 필요하다. 코드랩은 Android Studio로 진행하지만, 편한 에디터를 사용할 것.

다음과 같은 기기를 이용해 코드랩을 실행해볼 수 있다.

- 실제 iOS / 안드로이드 기기를 연결해서 developer mode로 설정할 것.
- iOS simulaotr
- Android emulator



## 3. Getting Started

- **새로운 플러터 프로젝트를 생성한다.**

```
$ flutter create google_maps_in_flutter
Creating project google_maps_in_flutter...
[Listing of created files elided]
Running "flutter pub get" in google_maps_in_flutter...
Wrote 72 files.

All done!
[✓] Flutter: is fully installed. (Channel stable, v1.17.1, on Mac OS X 10.15.4 19E287, locale en)
[✓] Android toolchain - develop for Android devices: is fully installed. (Android SDK version 29.0.3)
[✓] Xcode - develop for iOS and macOS: is fully installed. (Xcode 11.4.1)
[✓] Android Studio: is fully installed. (version 3.6)
[✓] IntelliJ IDEA Community Edition: is fully installed. (version 2019.2.4)
[✓] VS Code: is fully installed. (version 1.45.0)
[✓] Connected device: is fully installed. (2 available)

In order to run your application, type:

  $ cd google_maps_in_flutter
  $ flutter run

Your application code is in google_maps_in_flutter/lib/main.dart.
```

- **Adding Google Maps Flutter plugin as a dependency**

```yaml
name: google_maps_in_flutter
description: A new Flutter project.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev
version: 1.0.0+1

environment:
  sdk: ">=2.7.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  # Add the following line
  google_maps_flutter: ^0.5.27+3

flutter:
  uses-material-design: true
```

`flutter pub get` 명령어를 이용해 `google_maps_flutter` 를 추가한다.



## 4. Adding Google Maps to the app

구글맵을 플러터앱에서 사용하기 위해선, [Google Maps Platform](https://cloud.google.com/maps-platform/) 에서 API project를 확인해야할 필요가 있다. android는 `Maps SDK for Android's Get API key`를, iOS는 `Maps SDK for iOS's Get API key`를 확인해야 한다.

- **Android에 추가하기 ( [flutter app project] / android / app / src / main / AndroidManifest.xml)**

>  <!-- TODO: Add your API key here -->
>     <meta-data android:name="com.google.android.geo.API_KEY"
>                android:value="YOUR-KEY-HERE"/>
>
> 이 부분을 추가하면 된다.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          package="com.example.google_maps_in_flutter">
  <!-- io.flutter.app.FlutterApplication is an android.app.Application that
         calls FlutterMain.startInitialization(this); in its onCreate method.
         In most cases you can leave this as-is, but you if you want to provide
         additional functionality it is fine to subclass or reimplement
         FlutterApplication and put your custom class here. -->
  <application
               android:name="io.flutter.app.FlutterApplication"
               android:label="google_maps_in_flutter"
               android:icon="@mipmap/ic_launcher">

    <!-- TODO: Add your API key here -->
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR-KEY-HERE"/>

    <activity
              android:name=".MainActivity"
              android:launchMode="singleTop"
              android:theme="@style/LaunchTheme"
              android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
              android:hardwareAccelerated="true"
              android:windowSoftInputMode="adjustResize">
      <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
      <meta-data
                 android:name="io.flutter.embedding.android.NormalTheme"
                 android:resource="@style/NormalTheme"
                 />
      <!-- Displays an Android View that continues showing the launch screen
                 Drawable until Flutter paints its first frame, then this splash
                 screen fades out. A splash screen is useful to avoid any visual
                 gap between the end of Android's launch screen and the painting of
                 Flutter's first frame. -->
      <meta-data
                 android:name="io.flutter.embedding.android.SplashScreenDrawable"
                 android:resource="@drawable/launch_background"
                 />
      <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
      </intent-filter>
    </activity>
    <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
    <meta-data
               android:name="flutterEmbedding"
               android:value="2" />
  </application>
</manifest>
```

- **iOS에 api Key 추가하기**

  - AppDelegate.swift에 추가

  > import GoogleMaps
  >
  > ...
  >
  > // TODO: Add your API key
  >     GMSServices.provideAPIKey("YOUR-API-KEY")

```swift
import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // TODO: Add your API key
    GMSServices.provideAPIKey("YOUR-API-KEY")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

- Info.plist 에 추가하기

> <key>io.flutter.embedded_views_preview</key>
>         <true/>
>
> 두줄 추가하기

```plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
        <!-- Add the following two lines -->
        <key>io.flutter.embedded_views_preview</key>
        <true/>
        <key>CFBundleDevelopmentRegion</key>
        <string>$(DEVELOPMENT_LANGUAGE)</string>
        <key>CFBundleExecutable</key>
        <string>$(EXECUTABLE_NAME)</string>
        <key>CFBundleIdentifier</key>
        <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
        <key>CFBundleInfoDictionaryVersion</key>
        <string>6.0</string>
        <key>CFBundleName</key>
        <string>google_maps_in_flutter</string>
        <key>CFBundlePackageType</key>
        <string>APPL</string>
        <key>CFBundleShortVersionString</key>
        <string>$(FLUTTER_BUILD_NAME)</string>
        <key>CFBundleSignature</key>
        <string>????</string>
        <key>CFBundleVersion</key>
        <string>$(FLUTTER_BUILD_NUMBER)</string>
        <key>LSRequiresIPhoneOS</key>
        <true/>
        <key>UILaunchStoryboardName</key>
        <string>LaunchScreen</string>
        <key>UIMainStoryboardFile</key>
        <string>Main</string>
        <key>UISupportedInterfaceOrientations</key>
        <array>
                <string>UIInterfaceOrientationPortrait</string>
                <string>UIInterfaceOrientationLandscapeLeft</string>
                <string>UIInterfaceOrientationLandscapeRight</string>
        </array>
        <key>UISupportedInterfaceOrientations~ipad</key>
        <array>
                <string>UIInterfaceOrientationPortrait</string>
                <string>UIInterfaceOrientationPortraitUpsideDown</string>
                <string>UIInterfaceOrientationLandscapeLeft</string>
                <string>UIInterfaceOrientationLandscapeRight</string>
        </array>
        <key>UIViewControllerBasedStatusBarAppearance</key>
        <false/>
</dict>
</plist>
```

- 스크린에 나타내기 (lib / main.dart)

```dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
```

iOS

![image](https://user-images.githubusercontent.com/43080040/86026277-2ea3ae00-ba6a-11ea-9478-9e0b609dcddf.png)

android

![image](https://user-images.githubusercontent.com/43080040/86029069-a7583980-ba6d-11ea-95df-4b42e8ee6627.png)

끝!