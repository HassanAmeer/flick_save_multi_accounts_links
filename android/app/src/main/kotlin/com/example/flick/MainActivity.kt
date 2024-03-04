package com.example.flick

// import io.flutter.embedding.android.FlutterActivity
// class MainActivity: FlutterActivity() {
// }

import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.net.Uri

class MainActivity: FlutterActivity() {
    private var channelName = "shareChannel"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                if(call.method == "shareOnInstagaram") {
                    val shareText = call.argument<String>("shareText")
                    copyToClipboard(shareText)
                    openInstaF(shareText)
                    Toast.makeText(this, shareText, Toast.LENGTH_SHORT).show()
                    result.success(null)
                }else if(call.method == "shareOnGmail"){
                    val subject = call.argument<String>("subject")
                    val body = call.argument<String>("body")
                    shareOnGmail(subject, body)
                    result.success(null)
                }else if(call.method == "shareOnMessagingApp"){
                    val message = call.argument<String>("message")
                    openMessagingApp(message)
                    result.success(null)
                }else if(call.method == "shareByChooseApp"){
                        val message = call.argument<String>("message")
                    shareByChooseApp(message)
                        result.success(null)
                }else if(call.method == "shareOnWhatsApp"){
                    val message = call.argument<String>("message")
                    shareOnWhatsApp(message)
                    result.success(null)
                }else if(call.method == "copText"){
                    val textForCopy = call.argument<String>("textForCopy")
                    copyToClipboard(textForCopy)
                    Toast.makeText(this, "Copied !", Toast.LENGTH_SHORT).show()
                    result.success(null)
                }else{
                    result.notImplemented()
                }
            }
    }
    ////////////////////
    private fun copyToClipboard(text: String?) {
        val clipboardManager =
            getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
        val clipData = ClipData.newPlainText("text", text)
        clipboardManager.setPrimaryClip(clipData)
    }
    ////////////////////
    private fun openInstaF(shareText: String?) {
        val intent = Intent(Intent.ACTION_SEND)
        intent.type = "text/plain"
        intent.putExtra(Intent.EXTRA_TEXT, shareText)

        // Check if Instagram is installed
        if (isInstagramInstalled(intent)) {
            intent.setPackage("com.instagram.android")
            intent.putExtra("caption", shareText)
            startActivity(intent)
        } else {
            // Open Instagram in the browser if the app is not installed
            val browserIntent = Intent(Intent.ACTION_VIEW, Uri.parse("https://www.instagram.com/"))
            startActivity(browserIntent)
        }
    }

    private fun isInstagramInstalled(intent: Intent): Boolean {
        val pm = packageManager
        return try {
            pm.getPackageInfo("com.instagram.android", PackageManager.GET_ACTIVITIES)
            true
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }
    ////////////////////
    private fun shareOnGmail(subject: String?, body: String?) {
        val intent = Intent(Intent.ACTION_SENDTO)
        intent.data = Uri.parse("mailto:")

        intent.putExtra(Intent.EXTRA_SUBJECT, subject)
        intent.putExtra(Intent.EXTRA_TEXT, body)

        // Check if there's an app to handle the intent
        if (intent.resolveActivity(packageManager) != null) {
            startActivity(intent)
        } else {
            // Handle the case where no app is available to handle the intent
        }
    }
    //////////////////

    private fun openMessagingApp(message: String?) {
        val intent = Intent(Intent.ACTION_SENDTO)
        intent.data = Uri.parse("smsto:")  // This opens the messaging app without specifying a number

        intent.putExtra("sms_body", message)

        // Check if there's an app to handle the intent
        if (intent.resolveActivity(packageManager) != null) {
            startActivity(intent)
        } else {
            // Handle the case where no app is available to handle the intent
        }
    }
    /////////
    private fun shareOnWhatsApp(message: String?) {
        val intent = Intent(Intent.ACTION_SEND)
        intent.type = "text/plain"
        intent.`package` = "com.whatsapp"  // Specify WhatsApp package

        intent.putExtra(Intent.EXTRA_TEXT, message)

        // Check if there's an app to handle the intent
        if (intent.resolveActivity(packageManager) != null) {
            startActivity(intent)
        } else {
            // Handle the case where no app is available to handle the intent
        }
    }
    ////////////////////
    private fun shareByChooseApp(message: String?) {
        val intent = Intent(Intent.ACTION_SEND)
        intent.type = "text/plain"
        intent.putExtra(Intent.EXTRA_TEXT, message)

        // Create a chooser to allow the user to select an app
        val chooserIntent = Intent.createChooser(intent, "Share with")

        // Check if there's an app to handle the intent
        if (intent.resolveActivity(packageManager) != null) {
            startActivity(chooserIntent)
        } else {
            // Handle the case where no app is available to handle the intent
        }
    }


}


///// gmail
///// whats app
///// to message
///// all