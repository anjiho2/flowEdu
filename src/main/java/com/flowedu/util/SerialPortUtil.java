package com.flowedu.util;

import gnu.io.CommPortIdentifier;

import java.util.Enumeration;

/**
 * Created by jihoan on 2017. 11. 13..
 */
public class SerialPortUtil {

    public static int getSerialPortNumber() {
        int portNumber = 0;
        Enumeration enumeration = CommPortIdentifier.getPortIdentifiers();

        if (enumeration.hasMoreElements() == true) {
            while (enumeration.hasMoreElements()) {
                CommPortIdentifier first = (CommPortIdentifier) enumeration.nextElement();
                String str = first.getName().substring(3, 4);
                portNumber = Integer.parseInt(str);
            }
        }
        return portNumber;
    }

}
