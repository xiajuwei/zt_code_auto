<#--package ${cfg.beanDbBeanPackage};-->

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;


@Data
@ApiModel("${table.tableComment}")
public class ${table.beanName}ReqVo{

    @ApiModelProperty(value = "当前页", example = "1", required = true)
    private Integer pageNum;
    @ApiModelProperty(value = "每页的数量", example = "15", required = true)
    private Integer pageSize;
    @ApiModelProperty("排序字段")
    private String sortColumn;
    @ApiModelProperty(value = "排序方式（'asc'： 正序，'desc'：倒序）")
    private String sortType;


}
