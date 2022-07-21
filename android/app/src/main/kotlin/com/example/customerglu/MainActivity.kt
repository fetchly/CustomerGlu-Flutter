package com.example.customerglu

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import com.customerglu.customerglu_plugin.FLNativeFactoryBannerView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject


class MainActivity : FlutterActivity() {
    private var methodChannel: MethodChannel? = null
    var mMessageReceiver: BroadcastReceiver? = null
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("cgnativebanner", FLNativeFactoryBannerView())
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "CUSTOMERGLU_EVENTS")
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mMessageReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                try {
                    if (intent.action.equals("CUSTOMERGLU_DEEPLINK_EVENT", ignoreCase = true)) {
                        val data = intent.getStringExtra("data")
                        val jsonObject = JSONObject(data)
                        val message = jsonObject.getString("deepLink")

                        // Write your Logic to perform action
                        methodChannel!!.invokeMethod("CUSTOMERGLU_DEEPLINK_EVENT", message)


                        //    Toast.makeText(context, message, Toast.LENGTH_SHORT).show();
                    }
                    if (intent.action.equals("CUSTOMERGLU_ANALYTICS_EVENT", ignoreCase = true)) {
                        val data = intent.getStringExtra("data")
                        val jsonObject = JSONObject(data)
                        //  Toast.makeText(context, jsonObject.toString(), Toast.LENGTH_SHORT).show();
                        methodChannel!!.invokeMethod("CUSTOMERGLU_ANALYTICS_EVENT", jsonObject.toString())
                    }
                } catch (e: Exception) {
                    println(e)
                }
            }
        }
        applicationContext!!.registerReceiver(mMessageReceiver, IntentFilter("CUSTOMERGLU_DEEPLINK_EVENT"))
        applicationContext!!.registerReceiver(mMessageReceiver, IntentFilter("CUSTOMERGLU_ANALYTICS_EVENT"))
    }

    override fun onDestroy() {
        super.onDestroy()
        applicationContext!!.unregisterReceiver(mMessageReceiver)
    }
}