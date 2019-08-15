<#assign crud_columns = [] />
<#assign columns = table.columnList />
<#list columns as col>
    <#if !(col.columnName =='id' || col.columnName == 'created' || col.columnName == 'modified')>
        <#assign crud_columns = crud_columns + [col] />
    </#if>
</#list>
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${cfg.beanMapperPackage}.${table.beanName}Mapper">
    <!--查询字段-->
    <sql id="columns">
        <#list columns as col>
            <#if col.columnName!='is_delete'>
        a.${col.columnName}<#if col_has_next>,</#if>
            </#if>
        </#list>
    </sql>

    <!--查询结果集-->
    <resultMap id="beanMap" type="${cfg.beanDbBeanPackage}.${table.beanName}">
        <#list columns as col>
            <#if col.columnName!='is_delete'>
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
        <#list columns as col>
            <#if col.columnName!='del_flag'>
            `${col.columnName}`<#sep>,
            </#if>
            <#if col.columnName =='del_flag'>
            `${col.columnName}`<#sep>,
            </#if>
        </#list>

            )
            VALUES
            (
        <#list columns as col>
            <#if col.columnName!='del_flag'>
            <#noparse>#{</#noparse>${col.propertyName}<#noparse>}</#noparse><#sep>,
            </#if>
            <#if col.columnName =='del_flag'>
            'A',
            </#if>
        </#list>

            )
    </insert>


   <#-- <!--更新实体信息&ndash;&gt;
    <update id="update" parameterType="${cfg.beanDbBeanPackage}.${table.beanName}">
        UPDATE ${table.tableName}
        <set>
            <#list crud_columns as col>
                <#if col.columnName!='is_delete'>
                    <if test="${col.propertyName} != null">
                `${col.columnName}` = <#noparse>#{</#noparse>${col.propertyName}<#noparse>}</#noparse>,
                    </if>
                </#if>
            </#list>
        </set>
        WHERE <#list table.pkColumnList as pk><#if pk_index gt 0> AND</#if> ${pk} = <#noparse>#{</#noparse>${table.pkPropertyList[pk_index]}<#noparse>}</#noparse></#list>
        <#list columns as col>
            <#if col.columnName=='is_delete'>
                AND ${col.columnName} = 0
            </#if>
        </#list>
    </update>-->

    <!--根据主键更新实体信息-->
    <update id="updateById" parameterType="${cfg.beanDbBeanPackage}.${table.beanName}">
        UPDATE ${table.tableName}
        <set>
        <#list crud_columns as col>
            <#if col.columnName!='del_flag'>
            <if test="${col.propertyName} != null">
                `${col.columnName}` = <#noparse>#{</#noparse>${col.propertyName}<#noparse>}</#noparse>,
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
        UPDATE ${table.tableName} set del_flag = 'D' WHERE <#list table.pkColumnList as pk><#if pk_index gt 0> AND</#if> ${pk} = <#noparse>#{</#noparse>${table.pkPropertyList[pk_index]}<#noparse>}</#noparse></#list>
    </delete>
    <!--分页查询-->
    <select id="listByPage" resultMap="beanMap">
        SELECT
        <include refid="columns"/>
        FROM
        ${table.tableName} a
        <#list columns as col>
            <#if col.columnName=='del_flag'>
        <where>
            del_flag != 'D'
        </where>
            </#if>
        </#list>
        ORDER BY id DESC
    </select>
</mapper>