package com.etc.icb.codeauto.bean;

import com.etc.icb.codeauto.util.StrUtil;
import com.google.common.collect.Sets;
import lombok.Data;

import java.util.List;
import java.util.Set;

@Data
public class Table {
    private String tableName;
    private String tableComment;
    private String tableRows;
    private String dataLength;
    private String beanName;
    private String lowerBeanName;
    private List<Column> columnList;
    private List<Column> propertyList;
    private List<String> pkColumnList;
    private List<String> pkPropertyList;
    private Set<String> importBeanList = Sets.newHashSet();

    public String getBeanName() {
        if (tableName.contains("_")) {
            if (tableName.startsWith("r_") || tableName.startsWith("R_")) {
                beanName = StrUtil.toCamelStyle(StrUtil.substringAfter(tableName.toLowerCase(), "r_"));
            } else {
                beanName = StrUtil.toCamelStyle(tableName);
                lowerBeanName = beanName;
            }
        } else {
            beanName = tableName;
        }
        beanName = StrUtil.capitalize(beanName);
        return beanName;
    }


}
