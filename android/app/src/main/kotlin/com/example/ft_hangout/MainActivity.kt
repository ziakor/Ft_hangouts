package com.example.ft_hangout

import android.Manifest
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Telephony
import android.telephony.SmsManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.app.FlutterApplication
import io.flutter.embedding.android.FlutterActivity

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private val _channelName = "com.ft_hangouts/sms";
    private val rationaleJustShown = false
    var messages = listOf<HashMap<String, Any>>()
    private val PERMISSION_ID = 42

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
         val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, _channelName)
        methodChannel.setMethodCallHandler { call, result ->
            if (call.method == "requestSmsPermission"){
                result.success(handlePermissions())
            }
            if (call.method == "setupSmsReceived")
            {
                if (handlePermissions()){
                    var br = object :BroadcastReceiver(){
                        override fun onReceive(context: Context?, intent: Intent?) {
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT){
                                for (sms in Telephony.Sms.Intents.getMessagesFromIntent(intent)){
                                    println(sms.displayOriginatingAddress)
                                    println(sms.displayMessageBody)
                                    methodChannel.invokeMethod("smsReceived", hashMapOf("from" to sms.displayOriginatingAddress, "message" to sms.displayMessageBody));
                                }
                            }
                        }
                    }
                    registerReceiver(br, IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
                }
                result.success(messages)
            }
            if (call.method == "sendSms"){
                if (handlePermissions()){

                    val smsManager = SmsManager.getDefault() as SmsManager;
                    smsManager.sendTextMessage(call.argument<String>("phone"), null, call.argument<String>("message"), null, null)
//                val sendIntent = Intent(Intent.ACTION_VIEW)
//                sendIntent.putExtra("sms_body", "default content")
//                sendIntent.type = "vnd.android-dir/mms-sms"
//                startActivity(sendIntent)
                }
            }

        }
    }

    private fun  handlePermissions(): Boolean {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECEIVE_SMS)
                == PackageManager.PERMISSION_GRANTED)
                    return true
        else
        {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.RECEIVE_SMS, Manifest.permission.SEND_SMS, Manifest.permission.BROADCAST_SMS), PERMISSION_ID)
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECEIVE_SMS)
                    == PackageManager.PERMISSION_GRANTED)
                return true
        }
        return false
    }

    private fun receiveMessage (){
        var br = object :BroadcastReceiver(){
            override fun onReceive(context: Context?, intent: Intent?) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT){
                    for (sms in Telephony.Sms.Intents.getMessagesFromIntent(intent)){
                        println(sms.displayOriginatingAddress)
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
