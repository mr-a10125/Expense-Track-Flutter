# Flutter core
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# MainActivity — adjust package as needed
-keep class com.ajay.expense_track.MainActivity { *; }

# Provider (state management)
-keepclassmembers class * {
    public <init>(...);
}
-keepclassmembers class * {
    public <init>(...);
}

# Firebase core/auth/firestore
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

-keep class androidx.lifecycle.** { *; }
-dontwarn androidx.lifecycle.**

# FlutterToast (uses Android Toast)
-keep class io.github.ponnamkarthik.toast.** { *; }

# Flutter Slidable — no ProGuard issues known, but safe fallback
-keep class com.hokaslibs.slidable.** { *; }
-dontwarn com.hokaslibs.slidable.**

# Annotations & reflection
-keepattributes *Annotation*

# Prevent shrinking of Kotlin metadata (for compatibility)
-keep class kotlin.Metadata { *; }

# Optional: Keep all Flutter plugin registrant classes
-keep class io.flutter.plugins.** { *; }