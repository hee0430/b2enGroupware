package com.b2en.groupware.console;

import java.io.File;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import com.b2en.groupware.console.util.PropertyUtil;

public class Const {
    private Const() {

    }

    public static final String CONSOLE_HOME = System.getProperty("consoleHome");
    public static final String LIBRARY_STORAGE_PATH = CONSOLE_HOME + File.separatorChar + "distribute" + File.separatorChar;
    public static final String BROKER_NAME = "jms-console";
    public static final String BROKER_NAME_AGENT = "jms-agent";

    public static final String DATABASE_POOL_NAME_DEFAULT = "defaultSession";
    public static final String DATABASE_POOL_NAME_SECOND = "secondSession";

    public static final String TRANSACTION_MANAGER_DEFAULT = "defaultTransactionManager";
    public static final String TRANSACTION_MANAGER_SECOND = "secondTransactionManager";

    public static final String WEBSOCKET_SERVICE_NAME = "console-ws";
    public static final String WEBSOCKET_REQUEST_CHANNEL = "/console/request";
    public static final String WEBSOCKET_RESPONSE_CHANNEL = "/console/response";

    public static final String REQUEST_PROCESS_STATUS_KEY = "STATUS";
    public static final String REQUEST_PROCESS_STATUS_VALUE_OK = "OK";
    public static final String REQUEST_PROCESS_STATUS_VALUE_FAIL = "FAIL";
    public static final String REQUEST_PROCESS_STATUS_MSG = "MESSAGE";
    public static final String REQUEST_PROCESS_STATUS_AUTH_MSG = "AUTH_MESSAGE";

    public static final String AGENT_SE_AGENT = "AGENT";
    public static final String AGENT_SE_RELAY = "RELAY";

    public static final String PROCESS_MODE_INSERT = "I";
    public static final String PROCESS_MODE_UPDATE = "U";
    public static final String PROCESS_MODE_VIEW = "V";
    public static final String PROCESS_MODE_DELETE = "D";

    public static final String ROUTE_DIRECT_FROM = "F";
    public static final String ROUTE_DIRECT_TO = "T";

    public static final int COUNT_PER_LIST = 15;

    //Property.xml의 정보를 가져올 key
    public static final String PROP_CONSOLE_IP = PropertyUtil.get("console.ip");
    public static final String PROP_CONSOLE_HTTP_PORT = PropertyUtil.get("console.http.port");
    public static final String PROP_CONSOLE_BROKER_PORT = PropertyUtil.get("console.broker.port");
    public static final String PROP_CONSOLE_JMX_PORT = PropertyUtil.get("console.jmx.port");

    //CONSOLE TRANSACTION 모니터링 정보 수신 QUEUE NAME
    public static final String QUEUE_NAME_LOG = "console.system.log";
    public static final String QUEUE_NAME_RESOURCE = "console.system.resource";
    public static final String QUEUE_NAME_NOTIFICATION = "console.system.notification";
    public static final String QUEUE_NAME_INIT = "console.system.init";
    public static final String QUEUE_NAME_MBEAN = "agent.system.mbean";

    public static final String MSG_OPERATION_ID = "aster/operationId";

    public static final String MSG_OPERATION_AGENT_PUT = "agent/put";
    public static final String MSG_OPERATION_AGENT_DELETE = "agent/delete";
    public static final String MSG_OPERATION_DATASOURCE_PUT = "dataSource/put";
    public static final String MSG_OPERATION_DATASOURCE_DELETE = "dataSource/delete";
    public static final String MSG_OPERATION_HBASE_PUT = "hbase/put";
    public static final String MSG_OPERATION_HBASE_DELETE = "hbase/delete";
    public static final String MSG_OPERATION_HTTP_PUT = "http/put";
    public static final String MSG_OPERATION_HTTP_DELETE = "http/delete";
    public static final String MSG_OPERATION_FTP_PUT = "ftp/put";
    public static final String MSG_OPERATION_FTP_DELETE = "ftp/delete";
    public static final String MSG_OPERATION_JMS_PUT = "jms/put";
    public static final String MSG_OPERATION_JMS_DELETE = "jms/delete";
    public static final String MSG_OPERATION_ROUTE_PUT = "route/put";
    public static final String MSG_OPERATION_ROUTE_DELETE = "route/delete";
    public static final String MSG_OPERATION_SCHEDULE_PUT = "schedule/put";
    public static final String MSG_OPERATION_SCHEDULE_DELETE = "schedule/delete";
    public static final String MSG_OPERATION_ROUTE_START = "route/start";
    public static final String MSG_OPERATION_ROUTE_STOP = "route/stop";
    public static final String MSG_OPERATION_PROXY_PUT = "proxy/put";
    public static final String MSG_OPERATION_PROXY_DELETE = "proxy/delete";
    public static final String MSG_OPERATION_PROXY_START = "proxy/start";
    public static final String MSG_OPERATION_PROXY_STOP = "proxy/stop";

    public static final String MSG_OPERATION_TYPE = "aster/operationType";

    public static final String MSG_OPERATION_TYPE_INITIAL = "init";
    public static final String MSG_OPERATION_TYPE_USER = "user";

    /* queue data file 저장 위치 */
    public static final String REPOSITORY_AMQ_DIR = ".repo" + File.separatorChar + "amq-data";

    public static final String TRANSACTION_PROCESSING = "P";
    public static final String TRANSACTION_ERROR = "E";
    public static final String TRANSACTION_SUCCESS = "S";

    public static final String SEQUENCE_RUTE_INFO = "SEQ_RUTE_INFO";
    public static final String SEQUENCE_INTRFC_INFO = "SEQ_INTRFC_INFO";
    public static final String SEQUENCE_AGENT_INFO = "SEQ_AGENT_INFO";

    public static final String SEQUENCE_DSTB_HIST_MANAGE = "SEQ_DSTB_HIST_MANAGE";
    public static final String SEQUENCE_DSTB_HIST_MANAGE_DETAIL = "SEQ_DSTB_HIST_MANAGE_DETAIL";
    public static final String SEQUENCE_DELETE_DSTB_TRGT_MANAGE = "SEQ_DELETE_DSTB_TRGT_MANAGE";
    public static final String SEQUENCE_USER_MANAGE = "SEQ_USER_MANAGE";
    public static final String SEQUENCE_INSTT_MANAGE = "SEQ_INSTT_MANAGE";
    public static final String SEQUENCE_SYS_MANAGE = "SEQ_SYS_MANAGE";
    public static final String SEQUENCE_CHARGER_MANAGE = "SEQ_CHARGER_MANAGE";
    public static final String SEQUENCE_CTGRY_CL = "SEQ_CTGRY_CL";
    public static final String SEQUENCE_PATCH_HIST = "SEQ_PATCH_HIST";
    public static final String SEQUENCE_ALARM = "SEQ_ALARM_MANAGE";
    public static final String SEQUENCE_COMPN_SEQ = "SEQ_COMPN_SEQ"; /* 컴포넌트끼리는 UNIQUE KEY */
    public static final String SEQUENCE_DATABASE_TBL_INFO = "SEQ_DATABASE_TBL_INFO";

    /* ROUTE_FROM_TO map 객체에서 사용할 키 */
    public static final String FROM_AGENT = "FROM_AGENT";
    public static final String TO_AGENT = "TO_AGENT";
    //public static final String RELAY_AGENT = "RELAY_AGENT";

    public static final String UPPER_MENU_CODE = "UPPER_MENU_CODE";
    public static final String MENU_CODE = "MENU_CODE";

    public static final String AGENT_ID = "agentId";
    public static final String AGENT_NO = "agentNo";
    public static final String AGENT_SE = "agentSe";

    public static final String RESULT = "result";
    public static final String WORK_TABLE_POST_FIX = "_WORK";

    public static final String YMDHMS = "yyyy-MM-dd HH:mm:ss";
    public static final String MDHMS = "MM-dd HH:mm:ss";
    public static final String MDHM = "MM-dd HH:mm";
    public static final String YMD = "yyyy-MM-dd";

    public static final String Y_NO_HYPHEN = "yyyy";
    public static final String YM_NO_HYPHEN = "yyyyMM";
    public static final String YMD_NO_HYPHEN = "yyyyMMdd";
    public static final String YMDH_NO_HYPHEN = "yyyyMMddHH";

    public static Map<String, LinkedHashMap<String, Object>> TEMP_ROUTE_CONFIG_MAP = new HashMap<>();

    //public static final Map<String, List<String>> SUBSCRIPTION = new HashMap<>();

    /* 각 ROUTE 정보별 from-to agent 정보를 담아놓는다. */
    private static final Map<String, Map<String, String>> routeFromTo = new HashMap<>();

    /* 각 아이디별 대시보드에서 모니터링 대상으로 선정한 interfaceId 목록을 관리한다. */
    private static final Map<String, Object> interfaceMonitoringTargetList = new HashMap<>();

    public static Map<String, Map<String, String>> getRoutefromto() {
        return routeFromTo;
    }

    public static Map<String, Object> getInterfacemonitoringtargetlist() {
        return interfaceMonitoringTargetList;
    }
}
