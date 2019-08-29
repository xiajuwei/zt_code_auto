package ${cfg.beanMapperPackage};

@RestController
@RequestMapping("")
public class ${table.beanName}FacadeImpl {
@Resource
private ${table.beanName}Service ${table.lowerBeanName}Service;

    @PostMapping("/add")
        public Integer add(@RequestBody ${table.beanName}Dto ${table.lowerBeanName}Dto) throws BaseException{
        return ${table.lowerBeanName}Service.add(${table.lowerBeanName}Dto);
    }

    @PutMapping("/updateById")
        public Integer updateById(@RequestBody ${table.beanName}Dto ${table.lowerBeanName}Dto) throws BaseException{
        return ${table.lowerBeanName}Service.updateById(${table.lowerBeanName}Dto);
    }

    @DeleteMapping("/deleteById")
        public Integer deleteById(@RequestParam("id") Long id, @RequestParam("operatorId") String operatorId) throws BaseException{
        return ${table.lowerBeanName}Service.deleteById(id, operatorId);
    }

    @PostMapping("listByPage")
        public PageData listByPage(@RequestBody ${table.beanName}ReqDto ${table.lowerBeanName}ReqDto) throws BaseException{
        return ${table.lowerBeanName}Service.listByPage(${table.lowerBeanName}ReqDto);
    }

}