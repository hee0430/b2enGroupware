package com.b2en.groupware.console.util;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

import com.opencsv.CSVWriter;

@SuppressWarnings("rawtypes")
public class CSVExportUtil implements ResultHandler {

    private String[] header = null;
    private String[] nextLine = null;

    private CSVWriter writer;

    public CSVExportUtil(HttpServletResponse response, String[] header) throws Exception {
	this.writer = new CSVWriter(response.getWriter(), CSVWriter.DEFAULT_SEPARATOR, CSVWriter.DEFAULT_QUOTE_CHARACTER, CSVWriter.DEFAULT_ESCAPE_CHARACTER, CSVWriter.DEFAULT_LINE_END);
	this.writer.writeNext(header);
	this.header = header;
	this.nextLine = new String[this.header.length];
    }

    @Override
    public void handleResult(ResultContext context) {

	@SuppressWarnings("unchecked")
	Map<String, Object> row = (Map<String, Object>) context.getResultObject();

	Object value = null;
	for (int i = 0; i < nextLine.length; i++) {
	    value = row.get(header[i]);
	    if (value == null) {
		nextLine[i] = null;
	    } else if (value instanceof String) {
		nextLine[i] = (String) value;
	    } else {
		nextLine[i] = String.valueOf(value);
	    }
	}
	this.writer.writeNext(nextLine);
    }

    public void close() throws Exception {
	if (this.writer != null) {
	    try {
		this.writer.close();
	    } catch (Exception e) {
		throw e;
	    }
	}
    }
}
