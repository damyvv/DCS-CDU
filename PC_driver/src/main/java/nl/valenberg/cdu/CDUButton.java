/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nl.valenberg.cdu;

/**
 *
 * @author Damy
 */
public class CDUButton {
    private final int row;
    private final int column;
    private final int DCSValue;
    
    public CDUButton(int row, int column, int DCSValue) {
        this.row = row & 0xFF;
        this.column = column;
        this.DCSValue = DCSValue;
    }
    
    public boolean getButtonState(byte[] buttonArray) {
        if (buttonArray.length < column) return false;
        byte colButtons = buttonArray[column];
        boolean state = (((colButtons >> row) & 0x1) == 1);
        return state;
    }
    
    public int getDCSValue() {
        return DCSValue;
    }
    
}
