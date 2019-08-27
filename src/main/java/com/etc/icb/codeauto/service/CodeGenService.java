package com.etc.icb.codeauto.service;


import com.etc.icb.codeauto.bean.GenConf;
import com.etc.icb.codeauto.bean.Table;
import com.etc.icb.codeauto.util.FreemarkerUtil;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
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

        if (StringUtils.isBlank(genConf.getOutputDir())) {
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
        File dtoBeanPackage = new File(genConf.getOutputDir() + "/dto");
        File interfacePackage = new File(genConf.getOutputDir() + "/interface");
        File implPackage = new File(genConf.getOutputDir() + "/impl");

        beanDbBeanPackage.mkdirs();
        beanMapperPackage.mkdirs();
        beanMapperXmlPackage.mkdirs();
        implPackage.mkdirs();
        dtoBeanPackage.mkdirs();
        interfacePackage.mkdirs();

        List<Table> tableList = tableService.getTableInfoList();
        for (Table table : tableList) {
            log.info("gen code for table,tableName={}", table.getTableName());
            Map<String, Object> rootMap = Maps.newHashMap();
            rootMap.put("table", table);
            rootMap.put("cfg", genConf);

            File beanBeanTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean.ftl");
            File beanMapperTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_mapper.ftl");
            File beanMapperXmlTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_mapper_xml.ftl");

            File beanBeanDtoTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_dto.ftl");
            File beanBeanVoTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_vo.ftl");
            File beanBeanReqDtoTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_req_dto.ftl");
            File beanBeanReqVoTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_req_vo.ftl");

            File beanFacadeTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_facade.ftl");
            File beanFacadeImplTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_facade_impl.ftl");
            File beanServiceTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_service.ftl");
            File beanServiceImplTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_service_impl.ftl");
            File beanRepositoryTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_repository.ftl");
            File beanRepositoryImplTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_repository_impl.ftl");
            File beanClientTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_client.ftl");
            File beanClientImplTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_client_impl.ftl");
            File beanControllerTemplate = ResourceUtils.getFile("classpath:templates/ssi/bean_controller.ftl");


            FileWriter beanBeanWriter = new FileWriter(beanDbBeanPackage.getAbsolutePath() + "/" + table.getBeanName() + ".java");
            FileWriter beanMapperWriter = new FileWriter(beanMapperPackage.getAbsolutePath() + "/" + table.getBeanName() + "Mapper.java");
            FileWriter beanMapperXmlWriter = new FileWriter(beanMapperXmlPackage.getAbsolutePath() + "/" + table.getBeanName() + "Mapper.xml");

            FileWriter beanBeanDtoWriter = new FileWriter(dtoBeanPackage.getAbsolutePath() + "/" + table.getBeanName() + "Dto.java");
            FileWriter beanBeanVoWriter = new FileWriter(dtoBeanPackage.getAbsolutePath() + "/" + table.getBeanName() + "Vo.java");
            FileWriter beanBeanReqDtoWriter = new FileWriter(dtoBeanPackage.getAbsolutePath() + "/" + table.getBeanName() + "ReqDto.java");
            FileWriter beanBeanReqVoWriter = new FileWriter(dtoBeanPackage.getAbsolutePath() + "/" + table.getBeanName() + "ReqVo.java");

            FileWriter beanFacadeWriter = new FileWriter(interfacePackage.getAbsolutePath() + "/" + table.getBeanName() + "Facade.java");
            FileWriter beanServiceWriter = new FileWriter(interfacePackage.getAbsolutePath() + "/" + table.getBeanName() + "Service.java");
            FileWriter beanRepositoryWriter = new FileWriter(interfacePackage.getAbsolutePath() + "/" + table.getBeanName() + "Repository.java");
            FileWriter beanClientWriter = new FileWriter(interfacePackage.getAbsolutePath() + "/" + table.getBeanName() + "Client.java");

            FileWriter beanFacadeImplWriter = new FileWriter(implPackage.getAbsolutePath() + "/" + table.getBeanName() + "FacadeImpl.java");
            FileWriter beanServiceImplWriter = new FileWriter(implPackage.getAbsolutePath() + "/" + table.getBeanName() + "ServiceImpl.java");
            FileWriter beanRepositoryImplWriter = new FileWriter(implPackage.getAbsolutePath() + "/" + table.getBeanName() + "RepositoryImpl.java");
            FileWriter beanClientImplWriter = new FileWriter(implPackage.getAbsolutePath() + "/" + table.getBeanName() + "ClientImpl.java");
            FileWriter beanControllerWriter = new FileWriter(implPackage.getAbsolutePath() + "/" + table.getBeanName() + "Controller.java");


            FreemarkerUtil.flushData(beanBeanTemplate.getAbsolutePath(), beanBeanWriter, rootMap);
            FreemarkerUtil.flushData(beanMapperTemplate.getAbsolutePath(), beanMapperWriter, rootMap);
            FreemarkerUtil.flushData(beanMapperXmlTemplate.getAbsolutePath(), beanMapperXmlWriter, rootMap);

            FreemarkerUtil.flushData(beanFacadeTemplate.getAbsolutePath(), beanFacadeWriter, rootMap);
            FreemarkerUtil.flushData(beanServiceTemplate.getAbsolutePath(), beanServiceWriter, rootMap);
            FreemarkerUtil.flushData(beanRepositoryTemplate.getAbsolutePath(), beanRepositoryWriter, rootMap);

            FreemarkerUtil.flushData(beanBeanDtoTemplate.getAbsolutePath(), beanBeanDtoWriter, rootMap);
            FreemarkerUtil.flushData(beanBeanVoTemplate.getAbsolutePath(), beanBeanVoWriter, rootMap);
            FreemarkerUtil.flushData(beanBeanReqDtoTemplate.getAbsolutePath(), beanBeanReqDtoWriter, rootMap);
            FreemarkerUtil.flushData(beanBeanReqVoTemplate.getAbsolutePath(), beanBeanReqVoWriter, rootMap);

            FreemarkerUtil.flushData(beanFacadeImplTemplate.getAbsolutePath(), beanFacadeImplWriter, rootMap);
            FreemarkerUtil.flushData(beanServiceImplTemplate.getAbsolutePath(), beanServiceImplWriter, rootMap);
            FreemarkerUtil.flushData(beanRepositoryImplTemplate.getAbsolutePath(), beanRepositoryImplWriter, rootMap);
            FreemarkerUtil.flushData(beanClientTemplate.getAbsolutePath(), beanClientWriter, rootMap);
            FreemarkerUtil.flushData(beanClientImplTemplate.getAbsolutePath(), beanClientImplWriter, rootMap);
            FreemarkerUtil.flushData(beanControllerTemplate.getAbsolutePath(), beanControllerWriter, rootMap);


        }

        dumpTableExcel(tableList);

    }


    private void dumpTableExcel(List<Table> tableList) {

    }

}
