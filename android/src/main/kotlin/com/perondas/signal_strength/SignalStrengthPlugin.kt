package com.perondas.signal_strength

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.wifi.WifiManager
import android.os.Build
import android.telephony.CellInfoGsm
import android.telephony.CellSignalStrength
import android.telephony.TelephonyManager
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.security.Permissions

/** SignalStrengthPlugin */
class SignalStrengthPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "signal_strength")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    @RequiresApi(Build.VERSION_CODES.M)
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getIsOnCellular" -> {
                val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

                val currentNetwork = cm.activeNetwork
                val capabilities = cm.getNetworkCapabilities(currentNetwork)
                result.success(capabilities?.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)
                        ?: false)
            }
            "getIsOnWifi" -> {
                val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

                val currentNetwork = cm.activeNetwork
                val capabilities = cm.getNetworkCapabilities(currentNetwork)
                result.success(capabilities?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)
                        ?: false)
            }
            "getCellSignalStrengths" -> {
                val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
                val strengths: List<CellSignalStrength> = when {
                    Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q -> {
                        telephonyManager.signalStrength?.cellSignalStrengths
                                ?: return result.success(null)
                    }
                    else -> {
                        return result.success(null)
                    }
                }
                val res: java.util.ArrayList<Int> = ArrayList(strengths.map { it.level }.toList())
                result.success(res)
            }
            "getWifiSignalStrength" -> {
                val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

                val currentNetwork = cm.activeNetwork
                val capabilities = cm.getNetworkCapabilities(currentNetwork)
                if (capabilities?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) != true) {
                    result.success(null)
                } else {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                        result.success(capabilities.signalStrength)
                    } else {
                        val wifiManager = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
                        val numberOfLevels = 5
                        val wifiInfo = wifiManager.connectionInfo
                        result.success(WifiManager.calculateSignalLevel(wifiInfo.rssi, numberOfLevels))
                    }
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
