package com.b2en.groupware.console.startup.config;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.tiles.Attribute;
import org.apache.tiles.Definition;
import org.apache.tiles.definition.DefinitionsFactory;
import org.apache.tiles.request.Request;
import org.apache.tiles.util.WildcardHelper;

/**
 * TILES.xml 대체
 *
 * @author hhlee
 *
 */
public class TilesConfig implements DefinitionsFactory {
    private static final Map<String, Definition> tilesDefinitions = new HashMap<>();
    private WildcardHelper wildcardHelper = new WildcardHelper();

    private static final Attribute BASE_TEMPLATE = new Attribute("/WEB-INF/tiles/Layout.jsp");
    private static final Attribute BASE_TEMPLATE_NOMENU = new Attribute("/WEB-INF/tiles/Layout_NoMenu.jsp");
    private static final Attribute FOOTER_TEMPLATE = new Attribute("/WEB-INF/tiles/Footer.jsp");
    private static final Attribute ERROR_500_TEMPLATE = new Attribute("/WEB-INF/jsp/Error_500.jsp");

    private static final String CONTENT_TEXT = "content";
    private static final String FOOTER_TEXT = "footer";

    public static void addDefinitions() {

        setBothLayout("/Summary", "/WEB-INF/jsp/Summary.jsp");
        addDefaultLayoutDef("/Command", "/WEB-INF/jsp/Command.jsp");

        //트랜잭션
        setBothLayout("/monitoring/TransactionList", "/WEB-INF/jsp/monitoring/TransactionList.jsp");
        setBothLayout("/monitoring/TransactionDetail", "/WEB-INF/jsp/monitoring/TransactionDetail.jsp");
        setBothLayout("/monitoring/TrackingList", "/WEB-INF/jsp/monitoring/TrackingList.jsp");

        //통계
        //TODO Rnd용이다 나중에 삭제하자
        setBothLayout("/statistics/HourTransactionRnd", "/WEB-INF/jsp/statistics/HourTransactionRnd.jsp");

        setBothLayout("/statistics/HourTransaction", "/WEB-INF/jsp/statistics/HourTransaction.jsp");
        setBothLayout("/statistics/DayTransaction", "/WEB-INF/jsp/statistics/DayTransaction.jsp");
        setBothLayout("/statistics/MonthTransaction", "/WEB-INF/jsp/statistics/MonthTransaction.jsp");

        setBothLayout("/statistics/Resource", "/WEB-INF/jsp/statistics/Resource.jsp");
        /*setBothLayout("/statistics/DayResource", "/WEB-INF/jsp/statistics/DayResource.jsp");
        setBothLayout("/statistics/MonthResource", "/WEB-INF/jsp/statistics/MonthResource.jsp");*/

        //콘솔
        //setBothLayout("/console/Manage", "/WEB-INF/jsp/console/Manage.jsp");
        setBothLayout("/console/UserList", "/WEB-INF/jsp/console/UserList.jsp");

        //에이전트
        setBothLayout("/agent/AgentConfigList", "/WEB-INF/jsp/agent/AgentConfigList.jsp");
        setBothLayout("/agent/AgentConfigForm", "/WEB-INF/jsp/agent/AgentConfigForm.jsp");

        //릴레이 에이전트
        setBothLayout("/agent/RelayAgentConfigList", "/WEB-INF/jsp/agent/RelayAgentConfigList.jsp");
        setBothLayout("/agent/RelayAgentConfigForm", "/WEB-INF/jsp/agent/RelayAgentConfigForm.jsp");

        //인터페이스
        setBothLayout("/route/InterfaceConfigList", "/WEB-INF/jsp/route/InterfaceConfigList.jsp");
        setBothLayout("/route/RouteConfigForm", "/WEB-INF/jsp/route/RouteConfigForm.jsp");

        //기준정보
        setBothLayout("/standard/CategoryManage", "/WEB-INF/jsp/standard/CategoryManage.jsp");
        setBothLayout("/standard/InstitutionManage", "/WEB-INF/jsp/standard/InstitutionManage.jsp");

        //라이브러리
        setBothLayout("/patch/Patch", "/WEB-INF/jsp/patch/Patch.jsp");

        //대시보드 : layout 없이 구동
        //토폴로지 : layout 없이 구동

        Map<String, Attribute> attributes = new HashMap<>();
        tilesDefinitions.put("error", new Definition("error", ERROR_500_TEMPLATE, attributes));
    }

    private static void setBothLayout(String Name, String content) {
        addDefaultLayoutDef(Name, content);
        addDefaultLayoutDefNoMenu(Name + "NoMenu", content);
    }

    private static void addDefaultLayoutDef(String name, String content) {
        Map<String, Attribute> attributes = new HashMap<>();
        attributes.put(CONTENT_TEXT, new Attribute(content));
        attributes.put(FOOTER_TEXT, new Attribute(FOOTER_TEMPLATE));
        tilesDefinitions.put(name, new Definition(name, BASE_TEMPLATE, attributes));
    }

    private static void addDefaultLayoutDefNoMenu(String name, String content) {
        Map<String, Attribute> attributes = new HashMap<>();
        attributes.put(CONTENT_TEXT, new Attribute(content));
        attributes.put(FOOTER_TEXT, new Attribute(FOOTER_TEMPLATE));
        tilesDefinitions.put(name, new Definition(name, BASE_TEMPLATE_NOMENU, attributes));
    }

    @SuppressWarnings("rawtypes")
    @Override
    public Definition getDefinition(String name, Request request) {
        Definition retVal = null;

        if (!tilesDefinitions.containsKey(name)) {
            for (Map.Entry item : tilesDefinitions.entrySet()) {
                int[] pattern = wildcardHelper.compilePattern((String) item.getKey());
                List<String> list = wildcardHelper.match(name, pattern);

                if (list != null) {
                    retVal = new Definition((Definition) item.getValue());

                    Map<Integer, String> vars = new HashMap<>();

                    for (String layout : list) {
                        vars.put(vars.size(), layout);
                    }

                    String contentAttr = (String) retVal.getAttribute(CONTENT_TEXT).getValue();
                    String content = WildcardHelper.convertParam(contentAttr, vars);

                    retVal.setName(name);
                    retVal.putAttribute(CONTENT_TEXT, new Attribute(content));

                    tilesDefinitions.put(name, retVal);

                    break;
                }
            }
        }

        return tilesDefinitions.get(name);
    }

}
