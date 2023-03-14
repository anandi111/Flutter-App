package com.weapplinse.anandi.training_app

import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.net.wifi.WifiManager
import android.telephony.TelephonyManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

//class MainActivity: FlutterFragmentActivity() {
//
//}

class MainActivity: FlutterActivity() {
    private val CHANNEL = "changeBoolean"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "changeBooleanFunction") {
                val res = call.argument("res") ?: true
                result.success(!res)
            }else if(call.method == "bluetoothConnection"){
                val mBluetoothAdapter: BluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
                result.success(mBluetoothAdapter.isEnabled())

//                val connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
//
//                val network = connectivityManager.activeNetwork ?: return false
//
//                val activeNetwork = connectivityManager.getNetworkCapabilities(network) ?: return false
//
//                activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> true

            }else if(call.method == "wifiConnection"){
                val wifi = applicationContext.getSystemService(WIFI_SERVICE) as WifiManager

                result.success(wifi.isWifiEnabled)
            }else if(call.method == "mobileDataConnection"){
                val tm: TelephonyManager =
                    getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

                result.success(tm.isDataEnabled())
            }
        }

        // TODO: Register the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "listTile", ListTileNativeAdFactory(context)
        )

        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "video", NativeAdFactory(context)
        )
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        // TODO: Unregister the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile")

        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "video")
    }
}