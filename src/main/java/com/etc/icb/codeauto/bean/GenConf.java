package com.etc.icb.codeauto.bean;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
@Data
public class GenConf {
    @Value("${output.dir}")
    private String outputDir;
    @Value("${table.include}")
    private String tableInclude;
    @Value("${table.ignored}")
    private String tableIgnored;
    @Value("${bean.db.bean.package}")
    private String beanDbBeanPackage;
    @Value("${bean.mapper.package}")
    private String beanMapperPackage;
    @Value("${schema}")
    private String schema;


}
