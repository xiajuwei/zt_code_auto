package com.etc.icb.codeauto.bean;

import com.etc.icb.codeauto.util.StrUtil;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Data
@Slf4j
public class Column {
    private String columnName;
    private String dataType;
    private String columnComment;
    private String propertyName;
    private String propertyType;
    private String oldPropertyType = "type";

    public String getPropertyName() {
        if (columnName.contains("_")) {
            propertyName = StrUtil.toCamelStyle(columnName);
        } else {
            propertyName = columnName;
        }
        return propertyName;
    }

    public String getPropertyType() {

        if ("varchar".equals(dataType) || "char".equals(dataType)) {
            propertyType = "String";
        }
        if ("text".equals(dataType) || "tinytext".equals(dataType) || "mediumtext".equals(dataType) || "longtext".equals(dataType)) {
            propertyType = "String";
        }
        if ("blob".equals(dataType) || "mediumblob".equals(dataType) || "tinyblob".equals(dataType)) {
            propertyType = "String";
        }
        if ("bigint".equals(dataType)) {
            propertyType = "Long";
        }
        if ("float".equals(dataType)) {
            propertyType = "Float";
        }
        if ("smallint".equals(dataType) || "mediumint".equals(dataType) || "tinyint".equals(dataType) || "int".equals(dataType)) {
            propertyType = "Integer";
        }
        if ("set".equals(dataType)) {
            propertyType = "Byte";
        }
        if ("decimal".equals(dataType)) {
            propertyType = "BigDecimal";
        }
        if ("timestamp".equals(dataType) || "date".equals(dataType) || "datetime".endsWith(dataType)) {
            propertyType = "Long";
            oldPropertyType = "Date";
        }

        if (StrUtil.isBlank(propertyType)) {
            log.error("Type Error=========> {}", dataType);
        }

        return propertyType;
    }

}
