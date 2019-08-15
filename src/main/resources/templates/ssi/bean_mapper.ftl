package ${cfg.beanMapperPackage};

import ${cfg.beanDbBeanPackage}.${table.beanName};

public interface ${table.beanName}Mapper{
/**
 * 添加
 */
int add(${table.beanName} ${table.lowerBeanName});
/**
 * 根据主键查询
 */
${table.beanName} getById(Long id);
/**
 * 根据主键更新
 */
int updateById(Long id);
/**
 * 根据主键删除
 */
int deleteById(Long id);
}