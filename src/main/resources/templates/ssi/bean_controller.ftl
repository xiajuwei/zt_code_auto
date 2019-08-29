package ${cfg.beanMapperPackage};

@RestController
@RequestMapping("")
@Api(tags = "")
public class ${table.beanName}Facade{
    @Resource
    private ${table.beanName}Client ${table.lowerBeanName}Client;

    @PostMapping("/add")
    @ApiOperation("")
    public ResultData<Integer> add(@ApiParam(value = "", required = true) @RequestBody ${table.beanName}Vo ${table.lowerBeanName}Vo) throws BaseException{
    ${table.lowerBeanName}Vo.setOperatorId(ShiroUtils.getUserId());
    return new ResultData<>(${table.lowerBeanName}Client.add(${table.lowerBeanName}));
    }

    @PutMapping("/updateById")
    @ApiOperation("")
    public ResultData<Integer> updateById(@ApiParam(value = "", required = true) @RequestBody ${table.beanName}Vo ${table.lowerBeanName}Vo) throws BaseException{
    ${table.lowerBeanName}Vo.setOperatorId(ShiroUtils.getUserId());
    return new ResultData<>(${table.lowerBeanName}Client.updateById(${table.lowerBeanName}Vo));
    }

    @DeleteMapping("/deleteById")
    @ApiOperation("")
    public ResultData<Integer> deleteById(@ApiParam(value = "", required = true) @RequestParam("id") Long id) throws BaseException{
        return new ResultData<>(${table.lowerBeanName}Client.deleteById(id, ShiroUtils.getUserId()));
    }

    @PostMapping("/listByPage")
    @ApiOperation("分页查询")
    public ResultData<PageData<${table.beanName}Dto>> listByPage(@RequestBody ${table.beanName}ReqVo ${table.lowerBeanName}ReqVo) throws BaseException{
        return new ResultData<>(${table.lowerBeanName}Client.listByPage(${table.lowerBeanName}ReqVo));
    }



}