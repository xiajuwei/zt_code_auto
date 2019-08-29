package ${cfg.beanMapperPackage};

import org.springframework.cloud.openfeign.FeignClient;

@FeignClient(value = "icb2-manage", path = "", contextId = "")
public interface ${table.beanName}Facade{
    /**
     * 添加
     */
    @RequestMapping("/add")
    Integer add(@RequestBody ${table.beanName}Dto ${table.lowerBeanName}Dto) throws BaseException;

    /**
     * 根据主键更新
     */
    @PutMapping("/updateById")
    Integer updateById(@RequestBody ${table.beanName}Dto ${table.lowerBeanName}Dto) throws BaseException;
    /**
     * 根据主键删除
     */
    @DeleteMapping("/deleteById")
    Integer deleteById(@RequestParam("id") Long id, @RequestParam("operatorId") String operatorId) throws BaseException;
    /**
    * 分页查询
    */
    @RequestMapping("/listByPage")
    PageData<${table.beanName}Dto> listByPage(@RequestBody ${table.beanName}ReqDto ${table.lowerBeanName}ReqDto) throws BaseException;


}