package ${cfg.beanMapperPackage};


public interface ${table.beanName}Service{
    /**
     * 添加
     */
    Integer add(${table.beanName}Dto ${table.lowerBeanName}Dto);

    /**
     * 根据主键更新
     */
    Integer updateById(${table.beanName}Dto ${table.lowerBeanName}Dto);
    /**
     * 根据主键删除
     */
    Integer deleteById( Long id, String operatorId) throws BaseException;



}