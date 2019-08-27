package ${cfg.beanMapperPackage};

import ${cfg.beanDbBeanPackage}.${table.beanName};


@Component
public class ${table.beanName}RepositoryImpl implements${table.beanName}Repository {
    @Resource
    private${table.beanName}Mapper ${table.lowerBeanName}Mapper;

    @Override
    public Integer add(${table.beanName} ${table.lowerBeanName}) {
    return ${table.lowerBeanName}Mapper.add(${table.lowerBeanName});
    }

    @Override
    public Integer updateById(${table.beanName} ${table.lowerBeanName}) {
    return ${table.lowerBeanName}Mapper.updateById(${table.lowerBeanName});
    }

    @Override
    public Integer deleteById(Long id, String operatorId) {
    return ${table.lowerBeanName}Mapper.deleteById(id, operatorId);
    }

    @Override
    public List<Announcement> listByPage(${table.beanName}Req ${table.lowerBeanName}Req) {
    return ${table.lowerBeanName}Mapper.listByPage(${table.lowerBeanName}Req);
    }

}
