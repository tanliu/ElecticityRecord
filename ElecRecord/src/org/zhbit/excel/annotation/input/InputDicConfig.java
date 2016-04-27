/*
 * Copyright 2015 www.hyberbin.com.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * Email:hyberbin@qq.com
 */
package org.zhbit.excel.annotation.input;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * User: Hyberbin
 * Date: 13-12-3
 * Time: 下午5:27
 */
@Target(ElementType.FIELD)//该注解只能用在成员变量上
@Retention(RetentionPolicy.RUNTIME)
public @interface InputDicConfig {
    /***数据字典值*/
    String dicCode();
    /**导入数据转换器执行的方法*/
    String method() default "inputDicCodeAdapter";
    /**是否允许为空*/
    boolean nullAble() default true;
    /**是否默认继承上一行的值*/
    boolean defaultByUp() default false;
    /**是否完全匹配*/
    boolean allMatch() default true;
}
