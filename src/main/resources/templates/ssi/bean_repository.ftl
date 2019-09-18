package ${cfg.beanMapperPackage};

import ${cfg.beanDbBeanPackage}.${table.beanName};


public interface ${table.beanName}Repository{
    /**
     * 添加
     */
    Integer add(${table.beanName} ${table.lowerBeanName});
    /**
     * 根据主键更新
     */
    Integer updateById(${table.beanName} ${table.lowerBeanName});
    /**
     * 根据主键删除
     */
    Integer deleteById( Long id,  String operatorId);


}