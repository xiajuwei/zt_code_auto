package ${cfg.beanMapperPackage};


@Service
@Slf4j
public class ${table.beanName}ClientImpl implements ${table.beanName}Client {
    @Resource
    private ${table.beanName}Facade ${table.lowerBeanName}Facade;

    @Override
    public Integer add(${table.beanName}Vo ${table.lowerBeanName}Vo){
        ${table.beanName}Dto ${table.lowerBeanName}Dto = new ${table.beanName}Dto();
        BeanUtils.copyProperties(${table.lowerBeanName}Vo, ${table.lowerBeanName}Dto);
        ${table.lowerBeanName}Dto.setUuid(UUID.randomUUID().toString());
        return ${table.lowerBeanName}Facade.add(${table.lowerBeanName}Dto);
    }

    @Override
    public Integer updateById(${table.beanName}Vo ${table.lowerBeanName}Vo){
        ${table.beanName}Dto ${table.lowerBeanName}Dto = new ${table.beanName}Dto();
        BeanUtils.copyProperties(${table.lowerBeanName}Vo, ${table.lowerBeanName}Dto);
        return ${table.lowerBeanName}Facade.updateById(${table.lowerBeanName}Dto);
    }

    @Override
    public Integer deleteById(Long id, String operatorId){
        return ${table.lowerBeanName}Facade.deleteById(id, operatorId);
    }

    @Override
    public PageData<${table.beanName}Dto> listByPage(${table.beanName}ReqVo ${table.lowerBeanName}ReqVo){
        ${table.beanName}ReqDto ${table.lowerBeanName}ReqDto = new ${table.beanName}ReqDto();
        BeanUtils.copyProperties(${table.lowerBeanName}ReqVo, ${table.lowerBeanName}ReqDto);
        return ${table.lowerBeanName}Facade.listByPage(${table.lowerBeanName}ReqDto);
    }
}