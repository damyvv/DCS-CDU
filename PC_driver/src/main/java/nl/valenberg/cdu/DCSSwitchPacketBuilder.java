/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nl.valenberg.cdu;

import nl.valenberg.cdu.DCSSwitch.DCSSwitchUpdateListener;

/**
 *
 * @author Damy
 */
public class DCSSwitchPacketBuilder implements DCSSwitchUpdateListener {
    
    private String packet = "";
    
    private static final DCSSwitchPacketBuilder instance = new DCSSwitchPacketBuilder();
    
    private DCSSwitchPacketBuilder() {}
    
    public static DCSSwitchPacketBuilder getInstance() {
        return instance;
    }

    @Override
    public void OnSwitchUpdate(String key, int newValue) {
        packet += "CDU_" + key + " " + newValue + "\n";
    }
    
    public String getPacket() {
        String s = packet;
        packet = "";
        return s;
    }
    
}
