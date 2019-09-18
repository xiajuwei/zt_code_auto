package com.etc.icb.codeauto;

import com.alibaba.fastjson.JSON;
import lombok.Data;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class CodeAutoApplicationTests {

    @Test
    public void contextLoads() {
        String s = "MechanismBill";
        if (Character.isLowerCase(s.charAt(0)))
            System.out.println(s);
        else
            System.out.println("===============");
        System.out.println((new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString());


    }

    @Test
    public void test1() {
        Student student = new Student();
        student.setNo("001");
        student.setName("test");
        student.setAge(10);

        byte[] b = JSON.toJSONString(student).getBytes();
        System.out.println(b);


    }


}

@Data
class Student {
    private String no;
    private String name;
    private Integer age;


}