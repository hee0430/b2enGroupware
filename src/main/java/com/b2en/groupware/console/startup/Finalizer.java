package com.b2en.groupware.console.startup;

import java.io.File;

import org.apache.camel.CamelContext;
import org.apache.camel.Exchange;
import org.apache.camel.ProducerTemplate;
import org.apache.camel.impl.DefaultCamelContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.b2en.groupware.console.util.PropertyUtil;


public class Finalizer {

    public static void main(String[] args) throws Exception {
	Logger logger = LoggerFactory.getLogger(Finalizer.class);
	String homeDir = System.getProperty("user.dir");
	homeDir = homeDir.replace(File.separatorChar + "bin", "");
	System.setProperty("user.dir", homeDir);

	// 설정 LOAD
	logger.info("Finalizer : " + String.format("%-12s%-10s%-5s", "Property", "Load", "Start"));
	PropertyUtil.load();

	String serverPort = PropertyUtil.get("console.http.port");

	shutdown(serverPort);
    }

    private static void shutdown(String port){
	CamelContext context = new DefaultCamelContext();
	String endPoint = "http://127.0.0.1:"+port+"/shutdown";
	ProducerTemplate template = context.createProducerTemplate();
	template.sendBodyAndHeader(endPoint, null, Exchange.HTTP_METHOD, "POST");
    }
}
