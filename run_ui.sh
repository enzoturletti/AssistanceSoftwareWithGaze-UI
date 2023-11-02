rm /workspaces/AssistanceSoftwareWithGaze/graphics/assets/config.ini
cp /workspaces/AssistanceSoftwareWithGaze/config.ini /workspaces/AssistanceSoftwareWithGaze/graphics/assets/config.ini
flutter pub get
flutter run -d web-server --web-port=5000 #--no-sound-null-safety
clear
