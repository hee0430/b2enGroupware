package com.b2en.groupware.console.startup;

import java.io.File;

import javax.servlet.MultipartConfigElement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.ApplicationPidFileWriter;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.util.unit.DataSize;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.i18n.AcceptHeaderLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;

import com.b2en.groupware.console.util.PropertyUtil;

@SpringBootApplication
@ComponentScan(basePackages = "com.b2en.groupware.console")
@EnableAutoConfiguration
@EnableScheduling
@EnableCaching
public class Initializer extends SpringBootServletInitializer {

    public static void main(String[] args) throws Exception {
        Logger logger = LoggerFactory.getLogger(Initializer.class);
        SpringApplication app = new SpringApplication(Initializer.class);

        String homeDir = System.getProperty("consoleHome");
        if (homeDir == null || "".equals(homeDir)) {
            homeDir = System.getProperty("user.dir");
            homeDir = homeDir.replace(File.separatorChar + "bin", "");
            
            homeDir = "D:\\DATA\\git\\b2enGroupware";
            System.setProperty("consoleHome", homeDir);
        }

        logger.info("=======================================================");
        logger.info("\t\t Console Start Process Begin");
        logger.info("=======================================================");

        // 설정 LOAD
        logger.info("Initializer : " + String.format("%-12s%-10s%-5s", "Property", "Load", "Start"));
        PropertyUtil.load();

        // Property.xml 파일을 읽어 시스템 프로퍼티로 등록한다.
        setProperty();

        // Application Start
        logger.info("Initializer : " + String.format("%-12s%-10s%-5s", "Application", "Engine", "Start"));
        File pidFile = new File(homeDir + File.separatorChar + "bin" + File.separatorChar + "console.pid");
        app.addListeners(new ApplicationPidFileWriter(pidFile));
        app.run(args);

        logger.info("=======================================================");
        logger.info("\t\t Console Start Process Completed");
        logger.info("=======================================================");
    }

    //파일 업로드 관련 설정
    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();

        factory.setMaxFileSize(DataSize.parse("20MB"));
        factory.setMaxRequestSize(DataSize.parse("20MB"));
        return factory.createMultipartConfig();
    }

    @Bean
    public MultipartResolver multipartResolver() {
        return new StandardServletMultipartResolver();
    }

    // 다국어 지원 설정
    @Bean
    public MessageSource messageSource() {
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasename("classpath:messages/messages");
        messageSource.setCacheSeconds(60); //reload messages every 10 seconds
        messageSource.setFallbackToSystemLocale(false);
        return messageSource;
    }

    @Bean(name = "localeResolver")
    public LocaleResolver sessionLocaleResolver() {
        //세션 기준으로 로케일을 설정 한다.
        AcceptHeaderLocaleResolver localeResolver = new AcceptHeaderLocaleResolver();
        //쿠키 기준(세션이 끊겨도 브라우져에 설정된 쿠키 기준으로)
        //CookieLocaleResolver localeResolver = new CookieLocaleResolver();

        //최초 기본 로케일을 강제로 설정이 가능 하다.
        //localeResolver.setDefaultLocale(new Locale("ko_KR"));
        return localeResolver;
    }

    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
        //request로 넘어오는 language parameter를 받아서 locale로 설정 한다.
        localeChangeInterceptor.setParamName("lang");
        return localeChangeInterceptor;
    }

    public void addInterceptors(InterceptorRegistry registry) {
        //Interceptor를 추가 한다.
        registry.addInterceptor(localeChangeInterceptor());
    }

    // Property.xml 파일을 읽어 시스템 프로퍼티로 등록한다.
    private static void setProperty() {

        System.setProperty("console.ip", PropertyUtil.get("console.ip"));
        System.setProperty("console.http.port", PropertyUtil.get("console.http.port"));

        //DATABASE
        System.setProperty("database.driverClass", PropertyUtil.get("database.driverClass"));
        System.setProperty("database.url", PropertyUtil.get("database.url"));
        System.setProperty("database.username", PropertyUtil.get("database.username"));
        System.setProperty("database.password", PropertyUtil.get("database.password"));
        System.setProperty("database.idleMaxAgeInMinutes", PropertyUtil.get("database.idleMaxAgeInMinutes"));
        System.setProperty("database.idleConnectionTestPeriodInMinutes", PropertyUtil.get("database.idleConnectionTestPeriodInMinutes"));
        System.setProperty("database.maxConnectionsPerPartition", PropertyUtil.get("database.maxConnectionsPerPartition"));
        System.setProperty("database.minConnectionsPerPartition", PropertyUtil.get("database.minConnectionsPerPartition"));
        System.setProperty("database.partitionCount", PropertyUtil.get("database.partitionCount"));
        System.setProperty("database.acquireIncrement", PropertyUtil.get("database.acquireIncrement"));
        System.setProperty("database.statementsCacheSize", PropertyUtil.get("database.statementsCacheSize"));

        // SSL 설정
        System.setProperty("server.ssl.enabled", PropertyUtil.get("server.ssl.enabled"));
        System.setProperty("server.ssl.key-store", PropertyUtil.get("server.ssl.key-store"));
        System.setProperty("server.ssl.key-store-password", PropertyUtil.get("server.ssl.key-store-password"));
        System.setProperty("server.ssl.key-password", PropertyUtil.get("server.ssl.key-password"));
        System.setProperty("server.ssl.key-alias", PropertyUtil.get("server.ssl.key-alias"));
        System.setProperty("server.ssl.trust-store", PropertyUtil.get("server.ssl.trust-store"));
        System.setProperty("server.ssl.trust-store-password", PropertyUtil.get("server.ssl.trust-store-password"));

        /**
         * ORACLE을 사용할때 Timestamp 컬럼을 변환하지 않고 그대로 가져오면 oracle.sql.Timestamp 타입으로
         * 가져오게된다. (ojdbc 떄문이라는 듯. )
         * 아래 property를 사용하면 java.sql.Timestamp로 반환해준다.
         */
        System.setProperty("oracle.jdbc.J2EE13Compliant", "true");
    }
}
