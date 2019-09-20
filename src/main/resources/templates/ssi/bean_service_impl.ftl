package ${cfg.beanMapperPackage};


@Service
public class ${table.beanName}ServiceImpl implements ${table.beanName}Service {
    @Resource
    private ${table.beanName}Repository ${table.lowerBeanName}Repository;
    @Resource
    private RedisDistributeLock redisDistributeLock;

    @Override
    public Integer add(${table.beanName}Dto ${table.lowerBeanName}Dto) throws BaseException{
    boolean lock = redisDistributeLock.tryLock(${table.lowerBeanName}Dto.getUuid(), "", 60, 1);
        if (lock) {
        ${table.beanName} ${table.lowerBeanName} = new ${table.beanName}();
        BeanUtils.copyProperties(${table.lowerBeanName}Dto, ${table.lowerBeanName});
        return ${table.lowerBeanName}Repository.add(${table.lowerBeanName});
        } else {
        return 0;
        }

    }

    @Override
    public Integer updateById(${table.beanName}Dto ${table.lowerBeanName}Dto) throws BaseException{
    ${table.beanName} ${table.lowerBeanName} = new ${table.beanName}();
    BeanUtils.copyProperties(${table.lowerBeanName}Dto, ${table.lowerBeanName});
    return ${table.lowerBeanName}Repository.updateById(${table.lowerBeanName});
    }

    @Override
    public Integer deleteById(Long id, String operatorId) {
    return ${table.lowerBeanName}Repository.deleteById(id, operatorId);
    }

    @Override
    public PageData listByPage(${table.beanName}ReqDto ${table.lowerBeanName}ReqDto) throws BaseException{
        ${table.beanName}Req ${table.lowerBeanName}Req = new ${table.beanName}Req();
        //请求dto 转换
        BeanUtils.copyProperties(${table.lowerBeanName}ReqDto, ${table.lowerBeanName}Req);
        //设置分页参数
        Page page = PageMethod.startPage(${table.lowerBeanName}Req.getPageNum(), ${table.lowerBeanName}Req.getPageSize());
        //排序字段驼峰转下划线
        if (StringUtils.isNotBlank(${table.lowerBeanName}Req.getSortColumn()) && StringUtils.isNotBlank(${table.lowerBeanName}Req.getSortType())) {
            String sortColumn = ToolUtils.humpToLine(${table.lowerBeanName}Req.getSortColumn());
            ${table.lowerBeanName}Req.setSortColumn(sortColumn);
        }
        List<${table.beanName}> ${table.lowerBeanName}List = ${table.lowerBeanName}Repository.listByPage(${table.lowerBeanName}Req);
        List<${table.beanName}Dto> ${table.lowerBeanName}DtoList = new ArrayList<>();
            ${table.lowerBeanName}List.stream().forEach(${table.lowerBeanName} -> {
            ${table.beanName}Dto ${table.lowerBeanName}Dto = new ${table.beanName}Dto();
            BeanUtils.copyProperties(${table.lowerBeanName}, ${table.lowerBeanName}Dto);
            ${table.lowerBeanName}DtoList.add(${table.lowerBeanName}Dto);
        });
        PageData pageData = new PageData();
        pageData.setPageNum(${table.lowerBeanName}Req.getPageNum());
        pageData.setPageSize(${table.lowerBeanName}Req.getPageSize());
        pageData.setTotal(page.getTotal());
        pageData.setList(${table.lowerBeanName}DtoList);
        return pageData;
    }
}
