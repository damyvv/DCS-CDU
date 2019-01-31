/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nl.valenberg.usb_hid;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import org.hid4java.HidDevice;
import org.hid4java.HidManager;
import org.hid4java.HidServices;
import org.hid4java.HidServicesListener;
import org.hid4java.event.HidServicesEvent;

/**
 *
 * @author Damy
 */
public class USB implements HidServicesListener {
    
    private final HidServices hidServices;
    
    private HidDevice hidDevice = null;
    
    private static final int SCREEN_CHAR_COUNT = 240;
    private static final int PACKET_SIZE = 60;
    
    private Lock lock = new ReentrantLock(true);
    
    private final int productID;
    private final int vendorID;
    
    private int packetID;
    
    public USB(int vendorID, int productID) {
        this.productID = productID;
        this.vendorID = vendorID;
        packetID = 0;
        
        hidServices = HidManager.getHidServices();
        hidServices.addHidServicesListener(this);
        
        hidDevice = hidServices.getHidDevice(vendorID, productID, null);
        if (hidDevice == null) {
            System.out.println("LPC not attached. Waiting...");
        }
    }
    
    public synchronized boolean isOpen() {
        if (hidDevice == null) return false;
        return hidDevice.isOpen();
    }
    
    public boolean write(byte[] data) {
        if (data.length != SCREEN_CHAR_COUNT) return false;
        if (!isOpen()) return false;
        
        byte[] packet = new byte[PACKET_SIZE + 2];
        for (int i = 0; i < 4; i++) {
            packet[PACKET_SIZE] = (byte) i;
            packet[PACKET_SIZE+1] = (byte) 0xFE;
            System.arraycopy(data, PACKET_SIZE*i, packet, 0, PACKET_SIZE);
            
            if (!isOpen()) return false;
            try {
                lock.lock();
                hidDevice.write(packet, PACKET_SIZE + 2, (byte) packetID++);
            }
            catch(NullPointerException ex) {
            } finally {
                lock.unlock();
            }
        }
        return true;
    }
    
    public boolean read(byte[] data) {
        if (data.length != 9) return false;
        if (!isOpen()) return false;
        
        try {
            lock.lock();
            hidDevice.read(data);
        } finally {
            lock.unlock();
        }
        return true;
    }

    @Override
    public void hidDeviceAttached(HidServicesEvent event) {
        if (hidDevice != null) return;
        HidDevice attachedDevice = event.getHidDevice();
        if (attachedDevice.isVidPidSerial(vendorID, productID, null)) {
            if (attachedDevice.open()) {
                hidDevice = attachedDevice;
            System.out.println("Connected");
            }
        }
    }

    @Override
    public void hidDeviceDetached(HidServicesEvent event) {
        if (hidDevice.equals(event.getHidDevice())) {
            hidDevice = null;
            System.out.println("Disconnected");
        }
    }

    @Override
    public void hidFailure(HidServicesEvent event) {
    }
}
