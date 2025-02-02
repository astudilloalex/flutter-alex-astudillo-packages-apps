package com.example.time_config_checker_android

import android.provider.Settings
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** TimeConfigCheckerAndroidPlugin */
class TimeConfigCheckerAndroidPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var contentResolver: ContentResolver

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "time_config_checker_android")
        channel.setMethodCallHandler(this)
        contentResolver = binding.applicationContext.contentResolver
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "getTimeConfig" -> {
                val timeConfig = getTimeConfig()
                result.success(timeConfig)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getTimeConfig(): Map<String, Boolean> {
        val isAutomaticTime =
            Settings.Global.getInt(contentResolver, Settings.Global.AUTO_TIME, 0) == 1
        val isAutomaticTimeZone =
            Settings.Global.getInt(contentResolver, Settings.Global.AUTO_TIME_ZONE, 0) == 1
        return mapOf(
            "isAutomaticTime" to isAutomaticTime,
            "isAutomaticTimeZone" to isAutomaticTimeZone,
        )
    }
}
