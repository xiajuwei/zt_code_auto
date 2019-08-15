package com.etc.icb.codeauto;

import com.etc.icb.codeauto.service.CodeGenService;
import com.etc.icb.codeauto.util.SpringBeanUtil;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication

public class CodeAutoApplication {

    public static void main(String[] args) throws Exception {
//        SpringApplication.run(CodeAutoApplication.class, args);
        SpringBeanUtil.context = SpringApplication.run(CodeAutoApplication.class, args);
        CodeGenService codeGenService = SpringBeanUtil.getBean(CodeGenService.class);

        codeGenService.genCode();

    }

}
