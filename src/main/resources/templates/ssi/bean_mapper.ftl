package ${cfg.beanMapperPackage};

import ${cfg.beanDbBeanPackage}.${table.beanName};
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ${table.beanName}Mapper{
    /**
     * 添加
     */
    Integer add(${table.beanName} ${table.lowerBeanName});
    /**
     * 根据主键查询
     */
    ${table.beanName} getById(@Param("id") Long id);
    /**
     * 根据主键更新
     */
    Integer updateById(${table.beanName} ${table.lowerBeanName});
    /**
     * 根据主键删除
     */
    Integer deleteById(@Param("id") Long id, @Param("operatorId") String operatorId);

    /**
    * 根据主键批量删除
    */
    Integer batchDeleteById(@Param("listId") List<Long> listId);



}