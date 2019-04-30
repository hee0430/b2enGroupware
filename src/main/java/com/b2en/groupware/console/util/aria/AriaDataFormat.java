package com.b2en.groupware.console.util.aria;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Serializable;
import java.security.SecureRandom;
import java.util.Base64;

import org.apache.camel.Exchange;
import org.apache.camel.converter.stream.OutputStreamBuilder;
import org.apache.camel.spi.DataFormat;
import org.apache.camel.spi.DataFormatName;
import org.apache.camel.support.ServiceSupport;
import org.apache.camel.util.IOHelper;
import org.apache.commons.lang3.SerializationUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * Key String + exchangeId 로 키 생성
 *
 * @author Shin.Jisun
 *
 */
public class AriaDataFormat extends ServiceSupport implements DataFormat, DataFormatName {

    private static Logger LOG = LoggerFactory.getLogger(AriaDataFormat.class);
 
    private static final int ARIA_BLOCK_SIZE = 16;
    private static final int ARIA_KEY_SIZE = 32;
    private static final byte BYTE_PADDING = 0x00;
    private static final byte[] KEY_PADDING = { (byte) 0xca, (byte) 0xe9, (byte) 0x77, (byte) 0x35,
            (byte) 0xab, (byte) 0x0c, (byte) 0xd7, (byte) 0x81,
            (byte) 0x48, (byte) 0x93, (byte) 0x02, (byte) 0x4f,
            (byte) 0x04, (byte) 0xea, (byte) 0xd9, (byte) 0xd5,
            (byte) 0xb9, (byte) 0x7e, (byte) 0x40, (byte) 0xec,
            (byte) 0x20, (byte) 0x8c, (byte) 0x80, (byte) 0xa0,
            (byte) 0xc9, (byte) 0x52, (byte) 0x91, (byte) 0x2e,
            (byte) 0x64, (byte) 0x37, (byte) 0x81, (byte) 0xa2
    };

    @Override
    public String getDataFormatName() {
        return "aria";
    }

    @Override
    public void marshal(Exchange exchange, Object graph, OutputStream stream) throws Exception {

        byte[] mk = makeKey();
//        exchange.getIn().setHeader(ARIA_KEY, mk);

        ARIAEngine instance = new ARIAEngine(256);
        instance.setKey(mk);
        instance.setupRoundKeys();

        InputStream plaintextStream = new ByteArrayInputStream(addPadding(SerializationUtils.serialize((Serializable) graph)));

        if (plaintextStream != null) {
            byte[] buffer = new byte[ARIA_BLOCK_SIZE];
            byte[] cipher = new byte[ARIA_BLOCK_SIZE];
            try {
//                stream.write(mk);
                while ((plaintextStream.read(buffer)) > 0) {

                    cipher = new byte[ARIA_BLOCK_SIZE];
                    instance.encrypt(buffer, 0, cipher, 0);
                    stream.write(cipher);
                    LOG.debug("plain:cipher:{}       {}", buffer, cipher);
                    buffer = new byte[ARIA_BLOCK_SIZE];
                }

            } finally {
                IOHelper.close(plaintextStream, "plaintext", LOG);
            }
        }
    }

    @Override
    public Object unmarshal(final Exchange exchange, final InputStream encryptedStream) throws Exception {

        ARIAEngine instance = new ARIAEngine(256);

        if (encryptedStream != null) {

            OutputStreamBuilder osb = null;
            try {

                byte[] mk = makeKey();// new byte[ARIA_KEY_SIZE];
//                int mkRead = encryptedStream.read(mk);
//                if (mkRead != ARIA_KEY_SIZE) {
//                    throw new IllegalArgumentException("Aria Key Byte Not Avaliable");
//                }

                instance.setKey(mk);
                instance.setupRoundKeys();

                osb = OutputStreamBuilder.withExchange(exchange);

                byte[] buffer = new byte[ARIA_BLOCK_SIZE];
                byte[] plain = new byte[ARIA_BLOCK_SIZE];
                int loop = 0;
                while ((encryptedStream.read(buffer)) >= 0) {

                    if (loop++ > 0) {
                        osb.write(plain);
                    }

                    plain = new byte[ARIA_BLOCK_SIZE];
                    instance.decrypt(buffer, 0, plain, 0);
                }

                osb.write(stripPadding(plain));

                Object result = osb.build();

                if (result instanceof byte[]) {
                    return SerializationUtils.deserialize((byte[]) result);
                }
                return result;

            } finally {
                IOHelper.close(encryptedStream, "cipher", LOG);
                IOHelper.close(osb, "plaintext", LOG);
            }
        }
        return null;
    }

    public static byte[] marshal(final Serializable body) throws Exception {

        byte[] mk = makeKey();

        ARIAEngine instance = new ARIAEngine(256);
        instance.setKey(mk);
        instance.setupRoundKeys();

        InputStream plaintextStream = new ByteArrayInputStream(addPadding(SerializationUtils.serialize(body)));
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        if (plaintextStream != null) {
            byte[] buffer = new byte[ARIA_BLOCK_SIZE];
            byte[] cipher = new byte[ARIA_BLOCK_SIZE];

            try {
                while (plaintextStream.read(buffer) > 0) {

                    cipher = new byte[ARIA_BLOCK_SIZE];
                    instance.encrypt(buffer, 0, cipher, 0);
                    stream.write(cipher);

                    buffer = new byte[ARIA_BLOCK_SIZE];
                }

            } finally {
                IOHelper.close(plaintextStream, "plaintext", LOG);
                IOHelper.close(stream, "encryptedOutStream", LOG);
            }
        }

        return stream.toByteArray();
    }

    public static <T> T unmarshal(final InputStream encryptedStream) throws Exception {

        ARIAEngine instance = new ARIAEngine(256);

        if (encryptedStream != null) {

            ByteArrayOutputStream osb = new ByteArrayOutputStream();
            try {

                byte[] mk = makeKey();// new byte[ARIA_KEY_SIZE];

                instance.setKey(mk);
                instance.setupRoundKeys();

                byte[] buffer = new byte[ARIA_BLOCK_SIZE];
                byte[] plain = new byte[ARIA_BLOCK_SIZE];
                int loop = 0;
                while ((encryptedStream.read(buffer)) >= 0) {

                    if (loop++ > 0) {
                        osb.write(plain);
                    }

                    plain = new byte[ARIA_BLOCK_SIZE];
                    instance.decrypt(buffer, 0, plain, 0);
                }

                osb.write(stripPadding(plain));

                return SerializationUtils.deserialize(osb.toByteArray());

            } finally {
                IOHelper.close(encryptedStream, "cipher", LOG);
                IOHelper.close(osb, "plaintext", LOG);
            }
        }
        return null;
    }

    @Override
    protected void doStart() throws Exception {
        // TODO Auto-generated method stub

    }

    @Override
    protected void doStop() throws Exception {
        // TODO Auto-generated method stub

    }

    private static byte[] makeKey() {
        byte[] bytes = new byte[ARIA_KEY_SIZE];
//        random.nextBytes(bytes);

        System.arraycopy(KEY_PADDING, 0, bytes, 0, ARIA_KEY_SIZE);
        return bytes;
    }

    private static SecureRandom random = new SecureRandom();

    private static byte[] addPadding(byte[] source) {
        int paddingCnt = ARIA_BLOCK_SIZE - (source.length % ARIA_BLOCK_SIZE);
        byte[] paddingResult = new byte[source.length + paddingCnt];

        System.arraycopy(source, 0, paddingResult, 0, source.length);

        byte[] paddingBytes = new byte[paddingCnt - 1];
        random.nextBytes(paddingBytes);

        System.arraycopy(paddingBytes, 0, paddingResult, source.length, paddingBytes.length);

        //padding의 마지막 byte에 padding count를 적어준다
        paddingResult[paddingResult.length - 1] = (byte) paddingCnt;

        return paddingResult;
    }

    private static byte[] stripPadding(byte[] source) {
        byte[] stripResult = null;

        int lastValue = source[source.length - 1];

        stripResult = new byte[source.length - lastValue];
        System.arraycopy(source, 0, stripResult, 0, stripResult.length);

        return stripResult;
    }

    /**
     * 암호화
     *
     * @param plain
     * @return
     * @throws Exception
     */
    public String encStr(String plain) throws Exception {
        String enc = Base64.getEncoder().encodeToString(marshal(plain.getBytes()));
        return enc;
    }

    /**
     * 복호화
     *
     * @param enc
     * @return
     * @throws Exception
     */
    public String decStr(String enc) throws Exception {
        byte[] data = Base64.getDecoder().decode(enc);
        Object plain = unmarshal(new ByteArrayInputStream(data));
        return new String((byte[]) plain);
    }

}
