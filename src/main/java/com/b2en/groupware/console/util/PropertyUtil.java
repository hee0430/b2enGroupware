package com.b2en.groupware.console.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Iterator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.b2en.groupware.console.Const;
import com.b2en.groupware.console.util.aria.AriaDataFormat;

/**
 *
 * vm 변수 configPath 에 지정된 경로에서 Property.xml파일의 프로퍼티 내용을 읽어온다.
 *
 * @author hhlee
 *
 */
public class PropertyUtil {

    private static Logger log = LoggerFactory.getLogger(PropertyUtil.class);
    private static LinkedProperties prop = new LinkedProperties();
    private static final String CONFIG_FILE_NAME = "property.xml";
    private static AriaDataFormat af = new AriaDataFormat();

    public static String get(String key) {

        if (prop.size() == 0) {
            log.debug("{}", "Load Property in GetMethod");
            try {
                load();
            } catch (Exception e) {
                log.error("{}", e);
            }
        }
        String returnValue = "";
        try {
            returnValue = dec(prop.get(key));
        } catch (Exception e) {
            log.error("{}", e);
        }
        return returnValue;
    }

    public synchronized static void load() throws Exception {
        FileInputStream fis = null;
        try {

            fis = new FileInputStream(getConfigPath());
            prop.loadFromXML(fis);
            enc();

        } catch (Exception e) {
            log.error("Property 로딩 실패", e);
            throw e;
        } finally {
            if (fis != null)
                fis.close();
        }
    }

    private static String dec(String encStr) throws Exception {
        String plain = "";
        if (encStr != null) {
            if (encStr.startsWith("{enc}")) {
                plain = af.decStr(encStr.replace("{enc}", ""));
            } else {
                plain = encStr;
            }
        } else {
            plain = "";
        }
        return plain;
    }

    private static void enc() throws Exception {

        Iterator<String> it = prop.keySet().iterator();
        while (it.hasNext()) {
            String key = it.next();
            String value = prop.get(key);

            if (key.toLowerCase().indexOf("password") > -1) {
                if (!value.startsWith("{enc}")) {
                    String encValue = af.encStr(value);
                    set(key, "{enc}" + encValue);
                }
            }
        }
    }

    private static String getConfigPath() throws Exception {
        String configPath = "";

        configPath = System.getProperty("configPath");

        if (configPath == null || "".equals(configPath)) {
            String home = Const.CONSOLE_HOME;

            if (home == null) {
                home = System.getProperty("user.dir");
            }
            configPath = home + File.separatorChar + "conf" + File.separatorChar + CONFIG_FILE_NAME;
        }

        return configPath;
    }

    public synchronized static void set(String key, String value) throws Exception {
        prop.setProperty(key, value);
        FileOutputStream fos = new FileOutputStream(getConfigPath());
        prop.storeToXML(fos);
    }

}
