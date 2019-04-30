package com.b2en.groupware.console.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class LinkedProperties extends LinkedHashMap<String, String> {

    protected String comment;

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    protected LinkedProperties defaults;

    /**
     * Creates an empty property list with no default values.
     */
    public LinkedProperties() {
        this(null);
    }

    /**
     * Creates an empty property list with the specified defaults.
     *
     * @param defaults
     *            the defaults.
     */
    public LinkedProperties(LinkedProperties defaults) {
        this.defaults = defaults;
    }

    public synchronized Object setProperty(String key, String value) {
        return put(key, value);
    }

    public String getProperty(String key) {
        return get(key);
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public synchronized void loadFromXML(FileInputStream is) throws Exception {
        Document doc;
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        try {

            DocumentBuilder builder = factory.newDocumentBuilder();
            doc = builder.parse(is);

            XPathFactory xPathFactory = XPathFactory.newInstance();
            XPath xpath = xPathFactory.newXPath();
            XPathExpression exp1 = xpath.compile("/properties/comment");

            XPathExpression exp2 = xpath.compile("/properties/entry");

            comment = ((Element) exp1.evaluate(doc, XPathConstants.NODE)).getTextContent();

            NodeList nodeList = (NodeList) exp2.evaluate(doc, XPathConstants.NODESET);

            for (int i = 0; i < nodeList.getLength(); i++) {
                Node item = (Node) nodeList.item(i);
                String key = item.getAttributes().getNamedItem("key").getTextContent();
                String value = item.getTextContent();
                setProperty(key, value);
            }

        } catch (Exception e) {
            throw e;
        }
    }

    public synchronized void storeToXML(FileOutputStream os) throws IOException {
        String content = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n";
        content += "<properties>\n";
        content += "\t<comment>" + this.comment + "</comment>\n";
        Iterator<String> it = keySet().iterator();
        while (it.hasNext()) {
            String key = it.next();
            String value = get(key);
            content += "\t<entry key=\"" + key + "\">" + value + "</entry>\n";
        }
        content += "</properties>";
        os.write(content.getBytes());
        os.close();

    }

}
