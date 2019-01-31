/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nl.valenberg.cdu;

import java.util.ArrayList;

/**
 *
 * @author Damy
 */
public class DCSSwitch {
    private final String key;
    private final int idleValue;
    private int value;
    private DCSSwitchUpdateListener listener;
    
    private CDUButton physicalButtons[];

    public DCSSwitch(String key, int idleValue, CDUButton[] buttons) {
        this.key = key;
        this.idleValue = idleValue;
        this.value = idleValue;
        this.listener = DCSSwitchPacketBuilder.getInstance();
        
        physicalButtons = buttons;
    }
    
    public void Update(byte[] cduButtons) {
        int newValue = idleValue;
        for (CDUButton b : physicalButtons) {
            if (b.getButtonState(cduButtons)) {
                newValue = b.getDCSValue();
            }
        }
        if (newValue != value) {
            value = newValue;
            listener.OnSwitchUpdate(key, value);
        }
    }
    
    public interface DCSSwitchUpdateListener {
        public void OnSwitchUpdate(String key, int newValue);
    }
}
