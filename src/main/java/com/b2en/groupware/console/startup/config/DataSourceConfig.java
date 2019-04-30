package com.b2en.groupware.console.startup.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.TypeHandler;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.b2en.groupware.console.Const;
import com.jolbox.bonecp.BoneCPDataSource;

/**
 * console 설정정보 저장용 Datasource
 *
 * @author hhlee
 *
 */   
@Configuration
@EnableTransactionManagement
public class DataSourceConfig {

    @Autowired
    private ApplicationContext context;

    @Value("${database.url}")
    private String jdbcUrl;

    @Value("${database.username}")
    private String jdbcUsername;

    @Value("${database.password}")
    private String jdbcPassword;

    @Value("${database.driverClass}")
    private String driverClass;

    @Value("${database.idleMaxAgeInMinutes}")
    private Integer idleMaxAgeInMinutes;

    @Value("${database.idleConnectionTestPeriodInMinutes}")
    private Integer idleConnectionTestPeriodInMinutes;

    @Value("${database.maxConnectionsPerPartition}")
    private Integer maxConnectionsPerPartition;

    @Value("${database.minConnectionsPerPartition}")
    private Integer minConnectionsPerPartition;

    @Value("${database.partitionCount}")
    private Integer partitionCount;

    @Value("${database.acquireIncrement}")
    private Integer acquireIncrement;

    @Value("${database.statementsCacheSize}")
    private Integer statementsCacheSize;

    @Bean
    @Primary
    public DataSource dataSource() {
        BoneCPDataSource dataSource = new BoneCPDataSource();
        dataSource.setDriverClass(driverClass);
        dataSource.setJdbcUrl(jdbcUrl);
        dataSource.setUsername(jdbcUsername);
        dataSource.setPassword(jdbcPassword);
        dataSource.setIdleConnectionTestPeriodInMinutes(idleConnectionTestPeriodInMinutes);
        dataSource.setIdleMaxAgeInMinutes(idleMaxAgeInMinutes);
        dataSource.setMaxConnectionsPerPartition(maxConnectionsPerPartition);
        dataSource.setMinConnectionsPerPartition(minConnectionsPerPartition);
        dataSource.setPartitionCount(partitionCount);
        dataSource.setAcquireIncrement(acquireIncrement);
        dataSource.setStatementsCacheSize(statementsCacheSize);
        //BoneCPDataSource에서 커넥션 끊어버리는 문제 해결을 위함
        dataSource.setDisableConnectionTracking(true);
        return dataSource;
    }

    @Bean
    public SqlSessionFactory defaultSessionFactory(@Autowired @Qualifier("dataSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
        factoryBean.setDataSource(dataSource);
        factoryBean.setConfiguration(getConfig());

        Resource[] mapperResource = context.getResources("classpath:mybatis/mappers/*.xml");

        factoryBean.setMapperLocations(mapperResource);
        factoryBean.setTypeHandlers(getTypeHandlers());
        return factoryBean.getObject();
    }

    @Bean(Const.TRANSACTION_MANAGER_DEFAULT)
    public DataSourceTransactionManager defaultTransactionManager(@Autowired @Qualifier("dataSource") DataSource dataSource) {
        DataSourceTransactionManager manager = new DataSourceTransactionManager(dataSource);
        //manager.setGlobalRollbackOnParticipationFailure(false);
        return manager;
    }

    @Bean
    public SqlSession defaultSession(@Autowired @Qualifier("defaultSessionFactory") SqlSessionFactory factory) {
        return new SqlSessionTemplate(factory);
    }

    /**
     * mybatis 공통 setting 정보
     *
     * @return
     */
    private org.apache.ibatis.session.Configuration getConfig() {
        org.apache.ibatis.session.Configuration configration = new org.apache.ibatis.session.Configuration();
        configration.setCacheEnabled(false);
        configration.setCallSettersOnNulls(true);
        configration.setMapUnderscoreToCamelCase(true);
        // configration.setDefaultEnumTypeHandler(EnumOrdinalTypeHandler.class);
        return configration;
    }

    /**
     * enum 사용 model에서 mbatis 오류 발생시 예외 처리를 위한 handler 클래스 등록
     *
     * @return
     */
    @SuppressWarnings("rawtypes")
    private TypeHandler[] getTypeHandlers() {
        return new TypeHandler[] {

        };
    }

}
