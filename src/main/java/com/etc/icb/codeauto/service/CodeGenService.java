package com.etc.icb.codeauto.service;


import com.etc.icb.codeauto.bean.GenConf;
import com.etc.icb.codeauto.bean.Table;
import com.etc.icb.codeauto.util.FreemarkerUtil;
import com.etc.icb.codeauto.util.StrUtil;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileWriter;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class CodeGenService {
    @Resource
    private TableService tableService;
    @Resource
    private GenConf genConf;

    public void genCode() throws Exception {
        log.info("gen code,genConf={}", genConf);

        if (StrUtil.isBlank(genConf.getOutputDir())) {
            log.error("output dir can NOT be null");
            return;
        }
        File outputDir = new File(genConf.getOutputDir());
        if (!outputDir.exists()) {
            outputDir.mkdirs();
        } else {
            outputDir.delete();
            outputDir.mkdirs();
        }

        File beanDbBeanPackage = new File(genConf.getOutputDir());
        File beanMapperPackage = new File(genConf.getOutputDir());
        File beanMapperXmlPackage = new File(genConf.getOutputDir());

        beanDbBeanPackage.mkdirs();
        beanMapperPackage.mkdirs();
        beanMapperXmlPackage.mkdirs();

        List<Table> tableList = tableService.getTableInfoList();
        for (Table table : tableList) {
            log.info("gen code for table,tableName={}", table.getTableName());
            Map<String, Object> rootMap = Maps.newHashMap();
            rootMap.put("table", table);
            rootMap.put("cfg", genConf);

            File beanBeanTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean.ftl");
            File beanBeanDtoTemplate = ResourceUtils.getFile("classpath:templates/ssi/beanDto.ftl");
            File beanMapperTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_mapper.ftl");
            File beanMapperXmlTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_mapper_xml.ftl");

            FileWriter beanBeanWriter = new FileWriter(beanDbBeanPackage.getAbsolutePath() + "/" + table.getBeanName() + ".java");
            FileWriter beanBeanDtoWriter = new FileWriter(beanDbBeanPackage.getAbsolutePath() + "/" + table.getBeanName() + "Dto.java");
            FileWriter beanMapperWriter = new FileWriter(beanMapperPackage.getAbsolutePath() + "/" + table.getBeanName() + "Mapper.java");
            FileWriter beanMapperXmlWriter = new FileWriter(beanMapperXmlPackage.getAbsolutePath() + "/" + table.getBeanName() + "Mapper.xml");

            FreemarkerUtil.flushData(beanBeanTemplate.getAbsolutePath(), beanBeanWriter, rootMap);
            FreemarkerUtil.flushData(beanBeanDtoTemplate.getAbsolutePath(), beanBeanDtoWriter, rootMap);
            FreemarkerUtil.flushData(beanMapperTemplate.getAbsolutePath(), beanMapperWriter, rootMap);
            FreemarkerUtil.flushData(beanMapperXmlTemplate.getAbsolutePath(), beanMapperXmlWriter, rootMap);
        }

        dumpTableExcel(tableList);

    }


    private void dumpTableExcel(List<Table> tableList) {

    }

}
