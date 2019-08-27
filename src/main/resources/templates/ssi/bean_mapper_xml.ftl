<#assign crud_columns = [] />
<#assign columns = table.columnList />
<#list columns as col>
    <#if !(col.columnName =='id' || col.columnName == 'create_date' || col.columnName == 'modify_date')>
        <#assign crud_columns = crud_columns + [col] />
    </#if>
</#list>
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${cfg.beanMapperPackage}.${table.beanName}Mapper">
    <!--查询字段-->
    <sql id="columns">
        <#list columns as col>
        <#if col.columnName!='del_flag'>
        <#if col.oldPropertyType =='Date'>
        UNIX_TIMESTAMP(a.${col.columnName}) ${col.columnName}<#if col_has_next>,</#if>
        </#if>
        <#if col.oldPropertyType !='Date'>
        a.${col.columnName}<#if col_has_next>,</#if>
        </#if>
        </#if>
        </#list>
    </sql>

    <!--查询结果集-->
    <resultMap id="beanMap" type="${cfg.beanDbBeanPackage}.${table.beanName}">
        <#list columns as col>
            <#if col.columnName!='del_flag'>
        <result property="${col.propertyName}" column="${col.columnName}"/>
            </#if>
        </#list>
    </resultMap>

    <!--根据主键获取实体-->
    <select id="getById" resultMap="beanMap">
        SELECT
        <include refid="columns"/>
        FROM
        ${table.tableName} a
        WHERE
        <#list table.pkColumnList as pk><#if pk_index gt 0> AND</#if>${pk} = <#noparse>#{</#noparse>${table.pkPropertyList[pk_index]}<#noparse>}</#noparse></#list>
        <#list columns as col>
            <#if col.columnName=='del_flag'>
        AND ${col.columnName} !='D'
            </#if>
        </#list>
    </select>

    <!-- 新增记录 -->
    <insert id="add" useGeneratedKeys="true" keyProperty="id"
            parameterType="${cfg.beanDbBeanPackage}.${table.beanName}">
        INSERT INTO ${table.tableName}
            (
        <#list crud_columns as col>
            <#if col.columnName!='del_flag'>
        <if test="${col.propertyName} != null">
            `${col.columnName}`<#sep>,
        </if>
            </#if>
            <#if col.columnName =='del_flag'>
            `${col.columnName}`<#sep>,
            </#if>
        </#list>

            )
        VALUES
            (
        <#list crud_columns as col>
            <#if col.columnName!='del_flag'>
        <if test="${col.propertyName} != null">
            <#if col.oldPropertyType =='Date'>
            FROM_UNIXTIME(<#noparse>#{</#noparse>${col.propertyName}<#noparse>}</#noparse>)<#sep>,
            </#if>
            <#if col.oldPropertyType !='Date'>
           <#noparse>#{</#noparse>${col.propertyName}<#noparse>}</#noparse><#sep>,
            </#if>
        </if>
            </#if>
            <#if col.columnName =='del_flag'>
            'A'<#sep>,
            </#if>
        </#list>

            )
    </insert>

    <!--根据主键更新实体信息-->
    <update id="updateById" parameterType="${cfg.beanDbBeanPackage}.${table.beanName}">
        UPDATE ${table.tableName}
        <set>
        <#list crud_columns as col>
            <#if col.columnName!='del_flag'>
            <if test="${col.propertyName} != null">
            <#if col.oldPropertyType =='Date'>
                `${col.columnName}` = FROM_UNIXTIME(<#noparse>#{</#noparse>${col.propertyName}<#noparse>}</#noparse>)<#sep>,
            </#if>
            <#if col.oldPropertyType !='Date'>
                `${col.columnName}` = <#noparse>#{</#noparse>${col.propertyName}<#noparse>}</#noparse>,
            </#if>
            </if>
            </#if>
        </#list>
        <#list crud_columns as col>
            <#if col.columnName =='del_flag'>
                `${col.columnName}` = 'U'
            </#if>
        </#list>
        </set>
        WHERE <#list table.pkColumnList as pk><#if pk_index gt 0> AND</#if> ${pk} = <#noparse>#{</#noparse>${table.pkPropertyList[pk_index]}<#noparse>}</#noparse></#list>
        <#list columns as col>
            <#if col.columnName=='del_flag'>
        AND ${col.columnName} != 'D'
            </#if>
        </#list>
    </update>

    <!--根据主键删除实体-->
    <delete id="deleteById">
        UPDATE ${table.tableName}
        <set>
        <#list crud_columns as col>
        <#if col.columnName =='operator_id'>
        <if test="${col.propertyName} != null">
            `${col.columnName}` = <#noparse>#{</#noparse>${col.propertyName}<#noparse>}</#noparse>,
        </if>
        </#if>
        <#if col.columnName =='del_flag'>
            `${col.columnName}` = <#noparse>'D'</#noparse>
        </#if>
        </#list>
        </set>
        WHERE <#list table.pkColumnList as pk><#if pk_index gt 0> AND</#if> ${pk} = <#noparse>#{</#noparse>${table.pkPropertyList[pk_index]}<#noparse>}</#noparse></#list>
    </delete>
    <!--根据主键删除批量实体-->
    <delete id="batchDeleteById" parameterType="java.util.List">
        UPDATE ${table.tableName}
        <set>
        <#list crud_columns as col>
        <#if col.columnName =='operator_id'>
            <if test="${col.propertyName} != null">
                `${col.columnName}` = <#noparse>#{</#noparse>${col.propertyName}<#noparse>}</#noparse>,
            </if>
        </#if>
        <#if col.columnName =='del_flag'>
            `${col.columnName}` = <#noparse>'D'</#noparse>
        </#if>
        </#list>
        </set>
        WHERE <#list table.pkColumnList as pk><#if pk_index gt 0> AND</#if> ${pk} IN
        <foreach collection="listId" index="index" item="item" open="(" separator="," close=")">
            <#noparse>#{item}</#noparse>
        </foreach>
        </#list>
    </delete>
    <!--分页查询-->
    <select id="listByPage" resultMap="beanMap">
        SELECT
        <include refid="columns"/>
        FROM
        ${table.tableName} a
        <where>
            <#list columns as col>
            <#if col.columnName =='del_flag'>
            del_flag != 'D'
            </#if>
            <#if col.columnName =='create_date'>
            <if test="${col.propertyName}Start !=null and ${col.propertyName}End ==null">
            and date_format(${col.columnName},'%Y-%m-%d')&gt;= date_format(FROM_UNIXTIME(<#noparse>#{</#noparse>${col.propertyName}Start<#noparse>}</#noparse>),'%Y-%m-%d')
            </if>
            <if test="${col.propertyName}Start ==null and ${col.propertyName}End !=null">
            and date_format(create_date,'%Y-%m-%d')&lt;= date_format(FROM_UNIXTIME(<#noparse>#{</#noparse>${col.propertyName}End<#noparse>}</#noparse>),'%Y-%m-%d')
            </if>
            <if test="${col.propertyName}Start !=null and ${col.propertyName}End !=null">
            and date_format(create_date,'%Y-%m-%d')&gt;= date_format(FROM_UNIXTIME(<#noparse>#{</#noparse>${col.propertyName}Start<#noparse>}</#noparse>),'%Y-%m-%d')
            and date_format(create_date,'%Y-%m-%d')&lt;= date_format(FROM_UNIXTIME(<#noparse>#{</#noparse>${col.propertyName}End<#noparse>}</#noparse>),'%Y-%m-%d')
            </if>
            </#if>
            </#list>
        </where>

        ORDER BY id DESC
    </select>
</mapper>