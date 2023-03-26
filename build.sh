echo "Building your app"
   
flutter build apk --split-per-abi

mkdir -p ./gen/

mv ./build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk ./gen/clothing-app.apk