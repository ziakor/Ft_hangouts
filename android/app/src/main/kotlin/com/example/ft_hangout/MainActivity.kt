package com.example.ft_hangout

import android.Manifest
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Telephony
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.app.FlutterApplication
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private val _CHANNEL = "com.ft_hangouts/sms";
    private val rationaleJustShown = false
    private val PERMISSION_ID = 42
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, _CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "requestSmsPermission"){
                result.success(handlePermissions())
            }
            if (call.method == "listenIncomingSms")
            {
                if (handlePermissions()){
                    receiveMessage();
                }
            }
            else{
                print("Salsifi not implemented")
            }
        }
    }

    private fun  handlePermissions(): Boolean {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECEIVE_SMS)
                == PackageManager.PERMISSION_GRANTED)
                    return true
        else
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.RECEIVE_SMS), PERMISSION_ID)
        return false
    }

    private fun receiveMessage(){
        var br = object :BroadcastReceiver(){
            override fun onReceive(context: Context?, intent: Intent?) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT){
                    for (sms in Telephony.Sms.Intents.getMessagesFromIntent(intent)){
                        println(sms.displayMessageBody)
                    }
                }
            }
        }
        registerReceiver(br, IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
    }
}



class MyApp: FlutterApplication(){

}
