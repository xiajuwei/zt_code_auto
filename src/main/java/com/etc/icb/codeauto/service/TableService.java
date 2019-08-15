package com.etc.icb.codeauto.service;


import com.etc.icb.codeauto.bean.Column;
import com.etc.icb.codeauto.bean.GenConf;
import com.etc.icb.codeauto.bean.Table;
import com.etc.icb.codeauto.dao.TableDao;
import com.etc.icb.codeauto.util.ListUtil;
import com.etc.icb.codeauto.util.StrUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

@Service
@Slf4j
public class TableService {

    @Resource
    private TableDao tableDao;
    @Resource
    private GenConf genConf;

    public List<Table> getTableInfoList() {
        List<Table> dataList = tableDao.getTableList(genConf.getSchema(), genConf.getTableInclude());
        for (Table data : dataList) {
            data.setColumnList(tableDao.getColumnList(genConf.getSchema(), data.getTableName()));
            data.setPkColumnList(tableDao.getPKList(genConf.getSchema(), data.getTableName()));
            if (ListUtil.isEmpty(data.getPkColumnList())) {
                log.error("table has not PK, table = {}", data.getTableName());
            }
            List<String> pkPropertyList = Lists.newArrayList();
            for (String pk : data.getPkColumnList()) {
                pkPropertyList.add(StrUtil.toCamelStyle(pk));
            }

            Set<String> propertySet = Sets.newHashSet();
            Set<String> propertyTypeSet = Sets.newHashSet();
            for (Column column : data.getColumnList()) {
                propertySet.add(column.getPropertyName());
                propertyTypeSet.add(column.getPropertyType());
            }
            data.setPkPropertyList(pkPropertyList);

            if (propertyTypeSet.contains("BigDecimal")) {
                data.getImportBeanList().add("java.math.BigDecimal");
            }
            if (propertyTypeSet.contains("Date")) {
                data.getImportBeanList().add("java.util.Date");
            }




            data.setPropertyList(data.getColumnList());

        }
        return dataList;
    }

}
