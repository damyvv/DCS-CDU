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
public class DCSSwitchCollection {
    
    private static DCSSwitchCollection instance = new DCSSwitchCollection();
    
    private ArrayList<DCSSwitch> switches;
    
    private DCSSwitchCollection() {
        switches = new ArrayList<>();
        
        switches.add(new DCSSwitch("PG", 1, new CDUButton[] {new CDUButton(0, 0, 0), new CDUButton(1, 0, 2)}));
        switches.add(new DCSSwitch("POINT", 0, new CDUButton[] {new CDUButton(2, 0, 1)}));
        switches.add(new DCSSwitch("7", 0, new CDUButton[] {new CDUButton(3, 0, 1)}));
        switches.add(new DCSSwitch("4", 0, new CDUButton[] {new CDUButton(4, 0, 1)}));
        switches.add(new DCSSwitch("1", 0, new CDUButton[] {new CDUButton(5, 0, 1)}));
        switches.add(new DCSSwitch("SYS", 0, new CDUButton[] {new CDUButton(6, 0, 1)}));
        switches.add(new DCSSwitch("LSK_9L", 0, new CDUButton[] {new CDUButton(7, 0, 1)}));
        
        switches.add(new DCSSwitch("MK", 0, new CDUButton[] {new CDUButton(0, 1, 1)}));
        switches.add(new DCSSwitch("NA1", 0, new CDUButton[] {new CDUButton(1, 1, 1)}));
        switches.add(new DCSSwitch("0", 0, new CDUButton[] {new CDUButton(2, 1, 1)}));
        switches.add(new DCSSwitch("8", 0, new CDUButton[] {new CDUButton(3, 1, 1)}));
        switches.add(new DCSSwitch("5", 0, new CDUButton[] {new CDUButton(4, 1, 1)}));
        switches.add(new DCSSwitch("2", 0, new CDUButton[] {new CDUButton(5, 1, 1)}));
        switches.add(new DCSSwitch("NAV", 0, new CDUButton[] {new CDUButton(6, 1, 1)}));
        switches.add(new DCSSwitch("LSK_7L", 0, new CDUButton[] {new CDUButton(7, 1, 1)}));
        
        switches.add(new DCSSwitch("NA2", 0, new CDUButton[] {new CDUButton(1, 2, 1)}));
        switches.add(new DCSSwitch("SLASH", 0, new CDUButton[] {new CDUButton(2, 2, 1)}));
        switches.add(new DCSSwitch("9", 0, new CDUButton[] {new CDUButton(3, 2, 1)}));
        switches.add(new DCSSwitch("6", 0, new CDUButton[] {new CDUButton(4, 2, 1)}));
        switches.add(new DCSSwitch("3", 0, new CDUButton[] {new CDUButton(5, 2, 1)}));
        switches.add(new DCSSwitch("WP", 0, new CDUButton[] {new CDUButton(6, 2, 1)}));
        switches.add(new DCSSwitch("LSK_5L", 0, new CDUButton[] {new CDUButton(7, 2, 1)}));
        
        switches.add(new DCSSwitch("BCK", 0, new CDUButton[] {new CDUButton(1, 3, 1)}));
        switches.add(new DCSSwitch("S", 0, new CDUButton[] {new CDUButton(2, 3, 1)}));
        switches.add(new DCSSwitch("M", 0, new CDUButton[] {new CDUButton(3, 3, 1)}));
        switches.add(new DCSSwitch("G", 0, new CDUButton[] {new CDUButton(4, 3, 1)}));
        switches.add(new DCSSwitch("A", 0, new CDUButton[] {new CDUButton(5, 3, 1)}));
        switches.add(new DCSSwitch("OSET", 0, new CDUButton[] {new CDUButton(6, 3, 1)}));
        switches.add(new DCSSwitch("LSK_3L", 0, new CDUButton[] {new CDUButton(7, 3, 1)}));
        
        switches.add(new DCSSwitch("SPC", 0, new CDUButton[] {new CDUButton(1, 4, 1)}));
        switches.add(new DCSSwitch("T", 0, new CDUButton[] {new CDUButton(2, 4, 1)}));
        switches.add(new DCSSwitch("N", 0, new CDUButton[] {new CDUButton(3, 4, 1)}));
        switches.add(new DCSSwitch("H", 0, new CDUButton[] {new CDUButton(4, 4, 1)}));
        switches.add(new DCSSwitch("B", 0, new CDUButton[] {new CDUButton(5, 4, 1)}));
        switches.add(new DCSSwitch("FPM", 0, new CDUButton[] {new CDUButton(6, 4, 1)}));
        switches.add(new DCSSwitch("LSK_3R", 0, new CDUButton[] {new CDUButton(7, 4, 1)}));
        
        switches.add(new DCSSwitch("CLR", 0, new CDUButton[] {new CDUButton(0, 5, 1)}));
        switches.add(new DCSSwitch("Y", 0, new CDUButton[] {new CDUButton(1, 5, 1)}));
        switches.add(new DCSSwitch("U", 0, new CDUButton[] {new CDUButton(2, 5, 1)}));
        switches.add(new DCSSwitch("O", 0, new CDUButton[] {new CDUButton(3, 5, 1)}));
        switches.add(new DCSSwitch("I", 0, new CDUButton[] {new CDUButton(4, 5, 1)}));
        switches.add(new DCSSwitch("C", 0, new CDUButton[] {new CDUButton(5, 5, 1)}));
        switches.add(new DCSSwitch("PREV", 0, new CDUButton[] {new CDUButton(6, 5, 1)}));
        switches.add(new DCSSwitch("LSK_5R", 0, new CDUButton[] {new CDUButton(7, 5, 1)}));
        
        switches.add(new DCSSwitch("FA", 0, new CDUButton[] {new CDUButton(0, 6, 1)}));
        switches.add(new DCSSwitch("Z", 0, new CDUButton[] {new CDUButton(1, 6, 1)}));
        switches.add(new DCSSwitch("V", 0, new CDUButton[] {new CDUButton(2, 6, 1)}));
        switches.add(new DCSSwitch("P", 0, new CDUButton[] {new CDUButton(3, 6, 1)}));
        switches.add(new DCSSwitch("J", 0, new CDUButton[] {new CDUButton(4, 6, 1)}));
        switches.add(new DCSSwitch("D", 0, new CDUButton[] {new CDUButton(5, 6, 1)}));
        switches.add(new DCSSwitch("BRT", 1, new CDUButton[] {new CDUButton(6, 6, 0), new CDUButton(6, 7, 2)}));
        switches.add(new DCSSwitch("LSK_7R", 0, new CDUButton[] {new CDUButton(7, 6, 1)}));
        
        switches.add(new DCSSwitch("DATA", 1, new CDUButton[] {new CDUButton(0, 7, 0), new CDUButton(1, 7, 2)}));
        switches.add(new DCSSwitch("W", 0, new CDUButton[] {new CDUButton(2, 7, 1)}));
        switches.add(new DCSSwitch("Q", 0, new CDUButton[] {new CDUButton(3, 7, 1)}));
        switches.add(new DCSSwitch("K", 0, new CDUButton[] {new CDUButton(4, 7, 1)}));
        switches.add(new DCSSwitch("E", 0, new CDUButton[] {new CDUButton(5, 7, 1)}));
        switches.add(new DCSSwitch("LSK_9R", 0, new CDUButton[] {new CDUButton(7, 7, 1)}));
        
        switches.add(new DCSSwitch("X", 0, new CDUButton[] {new CDUButton(2, 8, 1)}));
        switches.add(new DCSSwitch("R", 0, new CDUButton[] {new CDUButton(3, 8, 1)}));
        switches.add(new DCSSwitch("L", 0, new CDUButton[] {new CDUButton(4, 8, 1)}));
        switches.add(new DCSSwitch("F", 0, new CDUButton[] {new CDUButton(5, 8, 1)}));
    }
    
    public static DCSSwitchCollection getInstance() {
        return instance;
    }
    
    public void updateSwitches(byte[] buttons) {
        for (DCSSwitch s : switches) {
            s.Update(buttons);
        }
    }
}
