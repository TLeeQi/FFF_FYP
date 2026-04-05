# Keep Stripe classes to prevent R8 from removing them
-keep class com.stripe.** { *; }
-keep class com.stripe.android.** { *; }
-keepclassmembers class com.stripe.** { *; }

# Keep the classes related to PushProvisioningActivity
-keep class com.stripe.android.pushProvisioning.** { *; }

# Keep the EphemeralKeyProvider
-keep class com.reactnativestripesdk.pushprovisioning.** { *; }
-keep class com.stripe.android.pushProvisioning.EphemeralKeyUpdateListener { *; }
-keep class com.reactnativestripesdk.pushprovisioning.** { *; }


# Existing rules in your proguard-rules.pro file

# Add the following rules to suppress warnings
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider
-dontwarn com.stripe.android.pushProvisioning.**


