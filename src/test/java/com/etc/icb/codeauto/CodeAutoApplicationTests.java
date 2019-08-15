package com.etc.icb.codeauto;

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

}
