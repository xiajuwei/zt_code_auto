<#--package ${cfg.beanDbBeanPackage};-->

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;


@Data
@ApiModel("${table.tableComment}")
public class ${table.beanName}ReqDto{

    @ApiModelProperty(value = "当前页", example = "1", required = true)
    private Integer pageNum;
    @ApiModelProperty(value = "每页的数量", example = "15", required = true)
    private Integer pageSize;


}
