/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nl.valenberg.usb_hid;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.util.Arrays;
import java.util.Scanner;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.logging.Level;
import java.util.logging.Logger;
import nl.valenberg.cdu.DCSSwitchCollection;
import nl.valenberg.cdu.DCSSwitchPacketBuilder;
import nl.valenberg.cdu.PacketParser;

/**
 *
 * @author Damy
 */
public class Main {
    
    public static final int VENDOR_ID = 0x1FC9;
    public static final int PRODUCT_ID = 0x0085;
    
    private static boolean finish = false;
    
    private static byte[] buttonArray = new byte[9];
    
    private static MulticastSocket exportSocket = null;
    private static DatagramSocket importSocket = null;
    
    private static InetAddress group = null;
    
    private static byte[] data = new byte[240];
    
    private static Lock lock = new ReentrantLock(true);
    
    public static void main(String args[]) {
        System.out.println("A-10C CDU Emulator software V1.0\nPress enter to quit this program.");
        
        Arrays.fill(data, (byte) 0x00);
        
        USB lpc = new USB(VENDOR_ID, PRODUCT_ID);
        
        try {
            importSocket = new DatagramSocket();
            exportSocket = new MulticastSocket(5010);
            exportSocket.setReuseAddress(true);
            group = InetAddress.getByName("239.255.50.10");
            exportSocket.joinGroup(group);
            
        } catch (IOException ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }

// -------------------------- Read button states --------------------------------------        
        new Thread(new Runnable() {
            @Override
            public void run() {
                while (!finish) {
                    if (lpc.isOpen()) {
                        lpc.read(buttonArray);
                        
//                        System.out.println();
//                        for (int i = 0; i < buttonArray.length; i++) {
//                            System.out.println(buttonArray[i]);
//                        }
                        
                        DCSSwitchCollection.getInstance().updateSwitches(buttonArray);
                        
                        String command = DCSSwitchPacketBuilder.getInstance().getPacket();
                        if (command.length() == 0) continue;
                        
//                        System.out.print(command);
                        
                        try {
                            DatagramPacket packet = new DatagramPacket(command.getBytes(), command.length(), InetAddress.getLocalHost(), 7778);
                            importSocket.send(packet);
                        } catch (IOException ex) {
                            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    
                    try {
                        Thread.sleep(50);
                    } catch (InterruptedException ex) {
                    }
                }
            }
        }).start();
        
// ---------------------------- Set LED's to button states ----------------------------
//        new Thread(new Runnable() {
//            @Override
//            public void run() {
//                while (!finish) {
//                    if (lpc.isOpen()) {
//                        Arrays.fill(data, 0, 240, (byte)0);
//                        
//                        for (int j = 0; j < 9; j++) {
//                            for (int i = 0; i < 8; i++) {
//                                data[j*24+i] = (byte) ((((byte)(buttonArray[j]) >> i) & 1) + 1);
//                            }
//                        }
//                        
//                        lpc.write(data);
//                    }
//                }
//            }
//        }).start();

// ------------------------- Process UDP packets from DCS-bios ------------------------
        new Thread(new Runnable() {
            @Override
            public void run() {
                while (!finish) {
                    DatagramPacket packet;
                    byte[] buf = new byte[1024];
                    packet = new DatagramPacket(buf, buf.length);
                    
                    lock.lock();
                    try {
                        exportSocket.receive(packet);
                        PacketParser.parsePacket(packet, data);
                    } catch (Exception ex) {
                        Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                    } finally {
                        lock.unlock();
                    }
                }
            }
        }).start();
        
// --------------------------------- Update CDU screen --------------------------------
        new Thread(new Runnable() {
            @Override
            public void run() {
                while (!finish) {
                    lock.lock();
                    try {
                        lpc.write(data);
                    } finally {
                        lock.unlock();
                    }
                    
                    try {
                        Thread.sleep(100);
                    } catch (InterruptedException ex) {
                    }
                }
            }
        }).start();
        
        Scanner scanner = new Scanner(System.in);
        scanner.nextLine();
        finish = true;
    }
    
}
