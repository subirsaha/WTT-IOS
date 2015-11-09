/*
       Licensed to the Apache Software Foundation (ASF) under one
       or more contributor license agreements.  See the NOTICE file
       distributed with this work for additional information
       regarding copyright ownership.  The ASF licenses this file
       to you under the Apache License, Version 2.0 (the
       "License"); you may not use this file except in compliance
       with the License.  You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing,
       software distributed under the License is distributed on an
       "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
       KIND, either express or implied.  See the License for the
       specific language governing permissions and limitations
       under the License.
 */

package com.esolz.whatthetrucks;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.cordova.Config;
import org.apache.cordova.CordovaActivity;

import android.annotation.SuppressLint;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.Signature;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.webkit.CookieManager;
import android.webkit.WebView;

public class HelloCordova extends CordovaActivity {
	public WebView wbvw;

	@SuppressWarnings("deprecation")
	@SuppressLint("NewApi")
	@Override
	public void onCreate(Bundle savedInstanceState) {
		CookieManager.setAcceptFileSchemeCookies(true);
		super.onCreate(savedInstanceState);
		super.init();
		super.setIntegerProperty("splashscreen", R.drawable.splashmain);
		// Set by <content src="index.html" /> in config.xml
		// setContentView(R.layout.mainxmlfile);
		// wbvw=(WebView)findViewById(R.id.wbvw1);

		// new Handler().postDelayed(new Runnable() {
		//
		// @Override
		// public void run() {
		// // TODO Auto-generated method stub
		//
		// }
		// }, 5000);

		super.loadUrl(Config.getStartUrl(), 5000);
		// super.appView.addJavascriptInterface(new twitterbridge(), "b");
		try {
			PackageInfo info = getPackageManager().getPackageInfo(
					"com.esolz.whatthetrucks", PackageManager.GET_SIGNATURES);
			for (Signature signature : info.signatures) {
				MessageDigest md = MessageDigest.getInstance("SHA");
				md.update(signature.toByteArray());
				Log.i("KeyHash:",
						Base64.encodeToString(md.digest(), Base64.DEFAULT));
				Log.i("KeyHash:",
						Base64.encodeToString(md.digest(), Base64.DEFAULT));
				Log.i("KeyHash:",
						Base64.encodeToString(md.digest(), Base64.DEFAULT));
				Log.i("KeyHash:",
						Base64.encodeToString(md.digest(), Base64.DEFAULT));
			}
		} catch (NameNotFoundException e) {
			Log.i("ERROR", "" + e.toString());

		} catch (NoSuchAlgorithmException e) {
			Log.i("ERROR2", "" + e.toString());
		}
		// super.loadUrl("file:///android_asset/www/index.html")
		// super.loadUrl("file:///android_asset/www/index.html");
	}

	// class Bridge {
	//
	// @JavascriptInterface
	// public String a() {
	// //Log.i("Bridge", "This is from js");
	// return "This is a message";
	//
	// }
	// }

	@Override
	public void onBackPressed() {
		// super.onBackPressed();
	}
}
