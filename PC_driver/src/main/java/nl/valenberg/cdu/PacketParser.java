/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nl.valenberg.cdu;

import java.io.UnsupportedEncodingException;
import java.net.DatagramPacket;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang3.ArrayUtils;

/**
 *
 * @author Damy
 */
public class PacketParser {
    
    private static final int LINES = 10;
    private static final int CHARS_PER_LINE = 24;
    
    private static final short ADDR_CDU_L1 = 0x11c0;
    private static final short ADDR_CDU_L2 = 0x11d8;
    private static final short ADDR_CDU_L3 = 0x11f0;
    private static final short ADDR_CDU_L4 = 0x1208;
    private static final short ADDR_CDU_L5 = 0x1220;
    private static final short ADDR_CDU_L6 = 0x1238;
    private static final short ADDR_CDU_L7 = 0x1250;
    private static final short ADDR_CDU_L8 = 0x1268;
    private static final short ADDR_CDU_L9 = 0x1280;
    private static final short ADDR_CDU_L10 = 0x1298;
    
    public static void parsePacket(DatagramPacket packet, byte[] CDUString) {
        int packetSize = packet.getLength();
        byte[] packetData = packet.getData();
        
        if (packetData[0] != 0x55 ||
            packetData[1] != 0x55 ||
            packetData[2] != 0x55 ||
            packetData[3] != 0x55)
            return;
        
        short address;
        short count;
//        byte[] data = null;
        short val;
        
        int i = 2;
        boolean receivedCDUUpdate = false;
        while (i < packetSize / 2) {
            // Get the address
            val = (short) ((0xFF & packetData[i*2+1]) << 8 | (0xFF & packetData[i*2]));
            address = val;
            i++;
            
            // Get the size in bytes
            val = (short) ((0xFF & packetData[i*2+1]) << 8 | (0xFF & packetData[i*2]));
            count = val;
            i++;
            
            
            if (address >= ADDR_CDU_L1 && address < ADDR_CDU_L10 + CHARS_PER_LINE) {
                try {
                    byte[] subArr = Arrays.copyOfRange(packetData, i*2, i*2+count);
                    String s = new String(subArr, "UTF8");
//                    System.out.println(s);
                    for (int j = 0; j < count; j++) {
                        int x = (address + j - ADDR_CDU_L1) % CHARS_PER_LINE;
                        int y = (address + j - ADDR_CDU_L1) / CHARS_PER_LINE;
                        byte transVal = translateChar(packetData[i*2+j]);
                        try {
                            CDUString[y*CHARS_PER_LINE + x] = transVal;
                        } catch (Exception e) {
//                            System.out.println("j: " + j + ", X: " + x + ", Y: " + y + ", address: " + address + ", count: " + count + ", raw: " + Arrays.toString(Arrays.copyOfRange(packetData, i*2, i*2+count)));
                        }
                        // Get the data
//                        System.out.printf("    Y:%d, X:%d, j:%d, char: %c, val: 0x%02X,\n", y, x, j, (char) packetData[i*2+x], packetData[i*2+x]);
                    }
//                    System.out.println("\n  }\n},");
                    
                    receivedCDUUpdate = true;
                } catch (UnsupportedEncodingException ex) {
                    Logger.getLogger(PacketParser.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            i+=count / 2;
        }
        if (receivedCDUUpdate) {
//            System.out.print("Raw: ");
//            for (i = 0; i < packetSize; i++) {
//                System.out.printf("0x%02x ", packetData[i]);
//            }
//            System.out.println();
//            System.out.println("==================================================");
        }
    }
    
    private static byte translateChar(byte currentChar) {
        if (currentChar >= '0' && currentChar <= '9') return currentChar += 1 - '0';
        if (currentChar >= 'A' && currentChar <= 'Z') return currentChar += 11 - 'A';
        if (currentChar == ' ') return 0x00;
        if (currentChar == '-') return 0x25;
        if (currentChar == '.') return 0x26;
        if (currentChar == '/') return 0x27;
        if (currentChar == '(') return 0x28;
        if (currentChar == ')') return 0x29;
        if (currentChar == '*') return 0x2A;
        if (currentChar == ':') return 0x2C;
        if (currentChar == '=') return 0x2D;
        if (currentChar == '[') return 0x2F;
        if (currentChar == ']') return 0x30;
        if (currentChar == '?') return 0x36;
        if (currentChar == '+') return 0x38;
        
        if (currentChar == (byte) 0xB0) return 0x2B; // Degrees symbol
        if (currentChar == (byte) 0xAE) return 0x2E; // Vertical double arrow
        if (currentChar == (byte) 0xA1) return 0x31; // Double brackets
        if (currentChar == (byte) 0xB6) return 0x32; // Scratchpad cursor
        if (currentChar == (byte) 0xBB) return 0x33; // Right arrow
        if (currentChar == (byte) 0xAB) return 0x34; // Left arrow
        if (currentChar == (byte) 0xA9) return 0x35; // Dotted circle
        if (currentChar == (byte) 0xB1) return 0x37; // +/- plus-minus
        
        System.out.println("Unknown char: " + (0xFF & currentChar) + ", char: " + (char) currentChar);
        
        return (byte) 0xFF;
    }
}
