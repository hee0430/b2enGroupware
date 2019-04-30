package com.b2en.groupware.console.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectOutputStream;

import org.springframework.core.ConfigurableObjectInputStream;

public class ObjectUtil {
    public byte[] serialize(Object target) throws Exception {
	byte[] result;
	try {
	    ByteArrayOutputStream baos = new ByteArrayOutputStream();
	    ObjectOutputStream oos = new ObjectOutputStream(baos);
	    oos.writeObject(target);
	    result = baos.toByteArray();
	} catch (Exception e) {
	    throw e;
	}
	return result;
    } 

    public Object deserialize(byte[] target) throws Exception {
	Object result;

	try {
	    ByteArrayInputStream bais = new ByteArrayInputStream(target);
	    ConfigurableObjectInputStream ois = new ConfigurableObjectInputStream(bais, this.getClass().getClassLoader());
	    result = ois.readObject();
	    if (ois != null) {
		ois.close();
	    }
	} catch (Exception e) {
	    throw e;
	}
	return result;
    }
}
