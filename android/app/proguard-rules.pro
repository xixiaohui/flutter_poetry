# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Google Play Core (not used, suppress R8 warnings)
-dontwarn com.google.android.play.core.**

# Dio
-dontwarn okhttp3.**
-dontwarn okio.**

# SharedPreferences
-keep class androidx.preference.** { *; }
