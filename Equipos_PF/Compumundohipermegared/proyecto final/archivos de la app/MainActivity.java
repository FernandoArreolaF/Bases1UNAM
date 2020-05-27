package com.example.visor;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Bundle;
import android.webkit.JavascriptInterface;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    private WebView web;
    String url = "http://3.133.35.53/";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        WebView web = (WebView) findViewById(R.id.MiVisor);
            WebSettings websettings = web.getSettings();
            websettings.setJavaScriptEnabled(true);
            websettings.setBuiltInZoomControls(true);
            websettings.setSupportZoom(true);
            web.addJavascriptInterface(new WebAppInterface(this),"Android");
            web.setWebViewClient(new WebViewClient());
            web.loadUrl(url);

    }

    @Override
    public void onBackPressed() {
        WebView wv = (WebView) findViewById(R.id.MiVisor);
        if(wv.canGoBack()) {
            wv.goBack();
        }else {
            super.onBackPressed();
        }
    }

    public class WebAppInterface{
        Context mContext;
        WebAppInterface(Context c){
            mContext = c;
        }
        @JavascriptInterface
        public void showToast(String toast){
            Toast.makeText(mContext, toast, Toast.LENGTH_SHORT).show();
        }
    }


}
