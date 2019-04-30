package com.b2en.groupware.console.util;

import java.util.HashMap;

@SuppressWarnings("rawtypes")
public class UpperKeyMap extends HashMap {
    //com.b2en.integration.aster.console.util.UpperKeyMap
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    public Object put(Object key, Object value) {
	return super.put(((String) key).toUpperCase(), value);
    }

}
