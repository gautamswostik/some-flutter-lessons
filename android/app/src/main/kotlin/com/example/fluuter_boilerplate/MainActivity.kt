package com.example.fluuter_boilerplate

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES



class MainActivity: FlutterActivity() {
  private val CHANNELONE = "samples.flutter.dev/hello"
  private val CHANNELTWO = "samples.flutter.dev/yourname"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNELONE).setMethodCallHandler {
      call, result ->
      if (call.method == "sendHelloFromTheOtherSide") {
        val hello = sendHelloToOtherSide()

        if (hello !="") {
          result.success(hello)
        } else {
          result.error("UNAVAILABLE", "Something went wrong.", null)
        }
      } else {
        result.notImplemented()
      }
    }
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNELTWO).setMethodCallHandler{
      call, result -> 
      if(call.method == "sendMyJoke"){
        var name = sendMyJoke();
        if (name !="") {
          result.success(name)
        } else {
          result.error("UNAVAILABLE", "Something went wrong.", null)
        }
      }
    }
  }

  private fun sendHelloToOtherSide(): String {
    val hello: String = "Hello From Android 👋";
    return hello;
  }

  private fun sendMyJoke() : String{
    val name : String = "Where do pirates get their hooks?\nSecond hand stores.🤣"
    return name;
  }
}