package ${cfg.beanMapperPackage};

import ${cfg.beanDbBeanPackage}.${table.beanName};

import java.util.List;

public interface ${table.beanName}Mapper{
    /**
     * 添加
     */
    Integer add(${table.beanName} ${table.lowerBeanName});
    /**
     * 根据主键查询
     */
    ${table.beanName} getById(Long id);
    /**
     * 根据主键更新
     */
    Integer updateById(Long id);
    /**
     * 根据主键删除
     */
    Integer deleteById(Long id);

    /**
    * 根据主键批量删除
    */
    Integer batchDeleteById(@Param("listId") List<Long> listId);



}