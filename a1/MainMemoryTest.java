package arch.sm213.machine.student;

import machine.AbstractMainMemory.InvalidAddressException;
import org.junit.Test;
import org.omg.CosNaming.NamingContextExtPackage.InvalidAddress;


import static org.junit.Assert.*;

/**
 * Created by zl on 2016-09-23.
 */
public class MainMemoryTest {
    // This test is for testing whether the method is working or not, with different cases.
    @Test
    public void isAccessAligned() {
        MainMemory memory = new MainMemory(256);
        assertTrue(memory.isAccessAligned(6,3));
        assertFalse(memory.isAccessAligned(10,4));
        assertTrue(memory.isAccessAligned(14,7));
        assertFalse(memory.isAccessAligned(6,4));
    }

    // This test is for testing whether the method working or not, with different cases.
    @Test
    public void bytesToInteger() {
        MainMemory memory = new MainMemory(256);
        byte[] fourBytes = new byte[4];
        fourBytes[0] = (byte) 0xFF;
        fourBytes[1] = (byte) 0xFF;
        fourBytes[2] = (byte) 0xFF;
        fourBytes[3] = (byte) 0xFF;
        assertEquals(-1, memory.bytesToInteger(fourBytes[0], fourBytes[1], fourBytes[2], fourBytes[3]));

        fourBytes = new byte[4];
        fourBytes[0] = 10;
        fourBytes[1] = 0;
        fourBytes[2] = 0;
        fourBytes[3] = 0;
        assertEquals(167772160, memory.bytesToInteger(fourBytes[0], fourBytes[1], fourBytes[2], fourBytes[3]));

        fourBytes = new byte[4];
        fourBytes[0] = - 38;
        fourBytes[1] = 12;
        fourBytes[2] = 47;
        fourBytes[3] = - 20;
        assertEquals(-636735508,memory.bytesToInteger(fourBytes[0], fourBytes[1], fourBytes[2], fourBytes[3]));
    }

    // This test is for testing whether the method is working or not, with different cases.
    @Test
    public void integerToBytes() {
        MainMemory memory = new MainMemory(256);
        byte[] biMem = memory.integerToBytes(0);
        assertEquals(0, biMem[0]);
        assertEquals(0, biMem[1]);
        assertEquals(0, biMem[2]);
        assertEquals(0, biMem[3]);

        biMem = memory.integerToBytes(125);
        assertEquals(0,biMem[0]);
        assertEquals(0,biMem[1]);
        assertEquals(0,biMem[2]);
        assertEquals(125,biMem[3]);

        biMem = memory.integerToBytes(-892371);
        assertEquals(-1,biMem[0]);
        assertEquals(-14,biMem[1]);
        assertEquals(98,biMem[2]);
        assertEquals(45,biMem[3]);

        biMem = memory.integerToBytes(4529880);
        assertEquals(0,biMem[0]);
        assertEquals(69,biMem[1]);
        assertEquals(30,biMem[2]);
        assertEquals(-40,biMem[3]);



    }

    // Test the case where address given is less than 0.
    @Test (expected = InvalidAddressException.class)
    public void getWithException0() throws InvalidAddressException {
        MainMemory memory = new MainMemory(256);
        memory.get(-1,4);
    }

    // Test the case where address + length - 1 is bigger or equal to mem.length.
    @Test (expected = InvalidAddressException.class)
    public void getWithException1() throws InvalidAddressException {
        MainMemory memory = new MainMemory(4);
        memory.get(3,2);
    }

    // Test the case where there is no exception to be thrown expected.
    @Test
    public void get() throws InvalidAddressException{
        MainMemory memory = new MainMemory(256);
        byte[] getBys = new byte[4];
        getBys[0] = 19;
        getBys[1] = -76;
        getBys[2] = 32;
        getBys[3] = 8;
        memory.set(8, getBys);
        byte[] result = memory.get(8, 4);
        assertEquals(result[0], getBys[0]);
        assertEquals(result[1], getBys[1]);
        assertEquals(result[2], getBys[2]);
        assertEquals(result[3], getBys[3]);
    }

    // Test the case where the address given is 0.
    @Test(expected = InvalidAddressException.class)
    public void setWithException0() throws InvalidAddressException {
        MainMemory memory = new MainMemory(256);
        byte[] setBys = new byte [4];
        setBys[0] = 19;
        setBys[1] = -76;
        setBys[2] = 32;
        setBys[3] = 8;
        memory.set(-19, setBys);
    }

    // Test the case where the address + value.length - 1 is bigger or equal to memory.length
    @Test(expected = InvalidAddressException.class)
    public void setWithException1() throws InvalidAddressException {
        MainMemory memory = new MainMemory(256);
        byte[] setBys = new byte[4];
        setBys[0] = 0;
        setBys[1] = 0;
        setBys[2] = 0;
        setBys[3] = 0;
        memory.set(253, setBys);
    }

    // Test the case where the method is working.
    public void set() throws InvalidAddressException {
        MainMemory memory = new MainMemory(256);
        byte[] setBys = new byte[4];
        setBys[0] = 0;
        setBys[1] = 0;
        setBys[2] = 0;
        setBys[3] = 0;
        memory.set(200, setBys);
        byte[] getBys = memory.get(200, 4);
        assertEquals(getBys[0], setBys[0]);
        assertEquals(getBys[1], setBys[1]);
        assertEquals(getBys[2], setBys[2]);
        assertEquals(getBys[3], setBys[3]);
    }

}