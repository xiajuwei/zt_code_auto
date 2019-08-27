package ${cfg.beanMapperPackage};


public interface ${table.beanName}Client{
    /**
     * 添加
     */
    Integer add(${table.beanName}Vo ${table.lowerBeanName}Vo);

    /**
     * 根据主键更新
     */
    Integer updateById(${table.beanName}Vo ${table.lowerBeanName}Vo);
    /**
     * 根据主键删除
     */
    Integer deleteById(@Param("id") Long id, @Param("operatorId") String operatorId);
    /**
    * 分页查询
    */
    PageData listByPage(${table.beanName}ReqVo ${table.lowerBeanName}ReqVo);


}