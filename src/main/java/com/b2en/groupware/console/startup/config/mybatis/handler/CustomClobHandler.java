package com.b2en.groupware.console.startup.config.mybatis.handler;

import java.io.StringReader;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

public class CustomClobHandler extends BaseTypeHandler<String> {

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, String parameter, JdbcType jdbcType) throws SQLException {
        StringReader reader = new StringReader(parameter);
        ps.setCharacterStream(i, reader, parameter.length());

    }

    @Override
    public String getNullableResult(ResultSet rs, String columnName) throws SQLException {
        String value = "";
        Clob clob = (Clob)rs.getClob(columnName);
        if (clob != null) {
            int size = (int) clob.length();
            value = clob.getSubString(1, size);
        }
        return value;
    }

    @Override
    public String getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        String value = "";
        Clob clob = (Clob)rs.getClob(columnIndex);
        if (clob != null) {
            int size = (int) clob.length();
            value = clob.getSubString(1, size);
        }
        return value;
    }

    @Override
    public String getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        String value = "";
        Clob clob = (Clob)cs.getClob(columnIndex);
        if (clob != null) {
            int size = (int) clob.length();
            value = clob.getSubString(1, size);
        }
        return value;
    }

}
