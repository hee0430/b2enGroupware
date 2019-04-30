package com.b2en.groupware.console.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.InetSocketAddress;
import java.nio.channels.SocketChannel;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.spec.RSAPublicKeySpec;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.crypto.Cipher;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.ImageIcon;

import org.apache.commons.beanutils.MethodUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;

public class ConsoleUtil {

    private static Logger logger = LoggerFactory.getLogger(ConsoleUtil.class);

    private static final String rsaPrivateKey = "__rsaPrivateKey__";

    public static String lpad(String text, int length, String paddingText) {
        if (text.length() < length) {
            for (int i = text.length(); i < length; i++) {
                text = paddingText + text;
            }
        }
        return text;
    }

    /**
     * Model 클래스에 공통으로 설정해야 하는 값들 설정
     *
     * @param model
     * @param id
     * @param ip
     * @return
     * @throws Exception
     * @throws NoSuchMethodException
     * @throws IllegalAccessException
     * @throws InvocationTargetException
     */
    public static <T> T setCommonValue(T model, String id, String ip) throws Exception {
        try {
            MethodUtils.invokeMethod(model, "setRegistDt", new Timestamp(System.currentTimeMillis()));
            MethodUtils.invokeMethod(model, "setUpdtDt", new Timestamp(System.currentTimeMillis()));
            MethodUtils.invokeMethod(model, "setRegistId", id);
            MethodUtils.invokeMethod(model, "setUpdtId", id);
            MethodUtils.invokeMethod(model, "setRegistIp", ip);
            MethodUtils.invokeMethod(model, "setUpdtIp", ip);
        } catch (Exception e) {
            throw new Exception("로그인 정보가 없습니다.");
        }
        return model;
    }

    public static List<Map<String, String>> enumToList(Class<?> clazz) {

        List<Map<String, String>> list = new ArrayList<Map<String, String>>();
        if (clazz.isEnum()) {
            Method nameMethod = null;
            Method valueMethod = null;
            Method driverMethod = null;
            Method urlMethod = null;
            Field[] fields = clazz.getFields();
            for (Field field : fields) {
                try {
                    Map<String, String> data = new HashMap<>();
                    nameMethod = clazz.getMethod("name");
                    Object obj = field.get(null);
                    Object name = nameMethod.invoke(obj);
                    data.put("name", (String) name);

                    valueMethod = clazz.getMethod("getValue");
                    Object value = valueMethod.invoke(obj);
                    data.put("value", (String) value);
                    try {
                        driverMethod = clazz.getMethod("getDriver");
                        Object driverName = driverMethod.invoke(obj);
                        data.put("driver", (String) driverName);
                    } catch (Exception e) {
                        //ignore
                    }
                    try {
                        urlMethod = clazz.getMethod("getUrl");
                        Object urlName = urlMethod.invoke(obj);
                        data.put("url", (String) urlName);
                    } catch (Exception e) {
                        //ignore
                    }
                    list.add(data);
                } catch (Exception e) {
                    logger.error("{}", e);
                }
            }
        }
        return list;
    }

    public static String getRemoteIP(HttpServletRequest request) {
        String ip = request.getHeader("X-FORWARDED-FOR");

        //proxy 환경일 경우
        if (ip == null || ip.length() == 0) {
            ip = request.getHeader("Proxy-Client-IP");
        }

        //웹로직 서버일 경우
        if (ip == null || ip.length() == 0) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }

        if (ip == null || ip.length() == 0) {
            ip = request.getRemoteAddr();
        }

        return ip;
    }

    /**
     *
     * @param input
     * @return
     */
    public static String nullToEmpty(String input) {
        return (input == null) ? "" : input;
    }

    public static String nullToReplace(String input, String repString) {
        return (input == null) ? repString : input;
    }

    /**
     * long 타입 시간 정보를 받아 경과 시간 text를 반환한다.
     *
     * @param time
     * @return
     */
    public static String getRunTimeText(long time) {
        long DAY = 1000 * 60 * 60 * 24L;
        long HOUR = 1000 * 60 * 60L;
        long MINUTE = 1000 * 60L;
        long SECOND = 1000L;

        long day = time / SECOND / 60 / 60 / 24;
        long hour = (time - (day * DAY)) / 1000 / 60 / 60;
        long minute = (time - (day * DAY) - (hour * HOUR)) / SECOND / 60;
        long second = (time - (day * DAY) - (hour * HOUR) - (minute * MINUTE)) / SECOND;
        return day + "일" + hour + "시간" + minute + "분" + second + "초 경과";
    }

    /**
     * TCP 테스트 연결
     *
     * @param ip
     * @param port
     * @return
     */
    public static int doCheckTcp(String ip, int port) {
        int result = -1;
        SocketChannel sc = null;
        long connectStart = 0;
        long connectFinish = 0;
        try {
            connectStart = System.currentTimeMillis();
            sc = SocketChannel.open();
            sc.socket().setSoTimeout(5000);
            sc.socket().connect(new InetSocketAddress(ip, port), 3000);
            connectFinish = System.currentTimeMillis();
            result = (int) (connectFinish - connectStart);
            logger.trace("[{} : {}] TCP Connection Check Success {}ms", ip, port, result);
        } catch (java.net.ConnectException e) {
            // 아이피로 접속은 되지만 방화벽 등으로 접속이 안되는 경우
            result = -1;
            logger.error("[{} : {}] TCP Connection Check Fail -1 : ConnectException {}", ip, port, e.getMessage());
        } catch (java.net.SocketTimeoutException e) {
            //연결 시도 아이피가 실제로 없는경우 발생
            result = -2;
            logger.error("[{} : {}] TCP Connection Check Fail -2 : SocketTimeoutException {}", ip, port, e.getMessage());
        } catch (Exception e) {
            result = -3;
            logger.error("[{} : {}] TCP Connection Check Fail -3: Exception {}", ip, port, e.getMessage());
        } finally {
            try {
                if (sc != null)
                    sc.close();
            } catch (IOException e) {
                logger.error("{}", e);
            }

        }
        return result;
    }

    /**
     * 이미지 크기 조절
     *
     * @param imageByte
     * @param targetW
     * @param targetH
     * @return
     * @throws Exception
     */
    public static byte[] resizeImage(byte[] imageByte, int targetW, int targetH) throws Exception {
        Image imgSource = new ImageIcon(imageByte).getImage();

        double scale = (double) targetH / (double) imgSource.getHeight(null);

        if (((double) imgSource.getWidth(null) < (double) targetW)
                && ((double) imgSource.getHeight(null) < (double) targetH)) {
            scale = 1;
        } else if (imgSource.getWidth(null) > imgSource.getHeight(null)) {
            scale = (double) targetW / (double) imgSource.getWidth(null);
        } else if (imgSource.getWidth(null) < imgSource.getHeight(null)) {
            scale = (double) targetH / (double) imgSource.getHeight(null);
        }

        int newW = (int) (scale * imgSource.getWidth(null));
        int newH = (int) (scale * imgSource.getHeight(null));

        Image imgTarget = imgSource.getScaledInstance(newW, newH, Image.SCALE_SMOOTH);

        int pixels[] = new int[newW * newH];

        PixelGrabber pg = new PixelGrabber(imgTarget, 0, 0, newW, newH, pixels, 0, newW);
        pg.grabPixels();

        BufferedImage bi = new BufferedImage(newW, newH, BufferedImage.TYPE_INT_RGB);
        bi.setRGB(0, 0, newW, newH, pixels, 0, newW);

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(bi, "jpg", baos);
        baos.flush();
        byte[] imageInByte = baos.toByteArray();
        baos.close();
        return imageInByte;
    }

    /**
     * Exception 종류 parsing
     *
     * @param errorMessageParam
     * @return
     */
    public static String parseErrorMessage(String errorMessageParam) {
        Pattern r = Pattern.compile("[\\w]+Exception");
        Pattern l = Pattern.compile("[\\w]+Error");
        String errorMessage = "";
        Matcher m = r.matcher(errorMessageParam);
        Matcher m2 = l.matcher(errorMessageParam);
        if (m.find()) {
            errorMessage = m.group(0);
        } else if (m2.find()) {
            errorMessage = m2.group(0);
        } else {
            errorMessage = "UnclassifiedException";
        }
        return errorMessage;
    }

    public static String encHtml(String target) {
        if (target != null) {
            target = target.replaceAll("&", "&amp;");
            target = target.replaceAll("<", "&lt;");
            target = target.replaceAll(">", "&gt;");
            target = target.replaceAll(",", "&quot;");
        }
        return target;
    }

    public static String decHtml(String target) {
        if (target != null) {
            target = target.replaceAll("&lt;", "<");
            target = target.replaceAll("&gt;", ">");
            target = target.replaceAll("&quot;", ",");
            target = target.replaceAll("&amp;", "&");
        }
        return target;
    }

    public static Object createObject(String className, String initargs) throws ClassNotFoundException, InstantiationException, IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchMethodException, SecurityException {
        Object instanceOfMyClass = Class.forName(className).getConstructor(String.class).newInstance(initargs);
        return instanceOfMyClass;
    }

    /**
     * 화면 script에서 암호화에 사용할 키를 생성하여 PublicKey를 ModelAndView에 담고, HttpSession에
     * PrivateKey를 담는다.
     *
     * @param session
     * @param mav
     * @throws Exception
     */
    public static void rsaKeyGen(HttpSession session, ModelAndView mav) throws Exception {
        SecureRandom random = new SecureRandom();
        KeyPairGenerator generator;
        generator = KeyPairGenerator.getInstance("RSA");
        generator.initialize(2048, random);

        KeyPair keyPair = generator.genKeyPair();
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PublicKey publicKey = keyPair.getPublic();
        PrivateKey privateKey = keyPair.getPrivate();

        // 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
        String keyName = session.getId() + rsaPrivateKey;
        session.setAttribute(keyName, privateKey);

        // 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
        RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);

        String publicKeyModulus = publicSpec.getModulus().toString(16);
        String publicKeyExponent = publicSpec.getPublicExponent().toString(16);

        mav.addObject("publicKeyModulus", publicKeyModulus);
        mav.addObject("publicKeyExponent", publicKeyExponent);
    }

    /**
     * 복호화에 사용할 privateKey를 HttpSession에서 찾아서 반환
     *
     * @param session
     * @return
     * @throws Exception
     */
    public static PrivateKey rsaKeyGet(HttpSession session) throws Exception {
        String keyName = session.getId() + rsaPrivateKey;
        PrivateKey privateKey = (PrivateKey) session.getAttribute(keyName);

        if (privateKey == null) {
            throw new RuntimeException("암호화 비밀키 정보를 찾을 수 없습니다.");
        }

        return privateKey;
    }

    /**
     * HttpSession에 저장된 privateKey정보 삭제
     *
     * @param session
     * @throws Exception
     */
    public static void rsaKeyRemove(HttpSession session) throws Exception {
        String keyName = session.getId() + rsaPrivateKey;
        session.removeAttribute(keyName);

    }

    /**
     * RAS 암호화 String을 받아 복호화한다.
     *
     * @param privateKey
     * @param securedValue
     * @return
     * @throws Exception
     */
    public static String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        byte[] encryptedBytes = hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
        return decryptedValue;
    }

    /**
     * 16진 문자열을 byte 배열로 변환한다.
     */
    private static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[] {};
        }

        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }

}
