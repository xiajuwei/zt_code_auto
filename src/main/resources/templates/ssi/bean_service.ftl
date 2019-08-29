package ${cfg.beanMapperPackage};


public interface ${table.beanName}Service{
    /**
     * 添加
     */
    Integer add(${table.beanName}Dto ${table.lowerBeanName}Dto) throws BaseException;

    /**
     * 根据主键更新
     */
    Integer updateById(${table.beanName} ${table.lowerBeanName}) throws BaseException;
    /**
     * 根据主键删除
     */
    Integer deleteById(@Param("id") Long id, @Param("operatorId") String operatorId) throws BaseException;



}