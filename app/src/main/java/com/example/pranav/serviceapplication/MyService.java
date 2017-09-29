package com.example.pranav.serviceapplication;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.os.RemoteException;
import android.util.Log;
import com.example.pranav.myapplication.IMyAidlInterface;

public class MyService extends Service{

    @Override
    public void onCreate() {
        super.onCreate();
        Log.d("flow","oncreate service");
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.d("flow","onstart command");
        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public IBinder onBind(Intent intent) {
        // TODO: Return the communication channel to the service.
        return myInterface;
    }

    private IMyAidlInterface.Stub myInterface = new IMyAidlInterface.Stub() {
        @Override
        public int add(int num1, int num2) throws RemoteException {
            Log.d("flow","add method called");
            return num1+num2;
        }
    };



}
