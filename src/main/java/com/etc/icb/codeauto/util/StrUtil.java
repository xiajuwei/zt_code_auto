package com.etc.icb.codeauto.util;



import org.apache.commons.lang3.StringUtils;

import javax.xml.bind.DatatypeConverter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;

public class StrUtil extends StringUtils {

	/**
	 * <p>处理从Map中取出的Null值,默认返回空字符串</p>
	 * <pre>
	 * Map: {name=sinba,age=11}
	 * StrUtil.fixNull( map.get("noSuchKey") )  =  ""
	 * StrUtil.fixNull( map.get("name") )       =  ""
	 * StrUtil.fixNull( map.get("age") )        =  "11"
	 * @param o
	 * @return
	 * </pre>
	 */
	public static String fixNull(Object o) {
		return o == null ? "" : o.toString().trim();
	}

	/**
	 * 处理空值
	 * @param o
	 * @param defaulStr
	 * @return
	 */
	public static String fixNull(Object o, String defaulStr) {
		return o == null ? defaulStr : o.toString().trim();
	}

	/**
	 * 去掉字符串前面的空格
	 * @param original
	 * @return
	 */
	public static String beforeTrim(String original) {
		if (original == null || original.trim().length() == 0)
			return original;
		int len = original.length();
		int st = 0;
		int off = 0; /* avoid getfield opcode */
		char[] originalValue = original.toCharArray();
		char[] val = Arrays.copyOfRange(originalValue, off, off + len);
		; /* avoid getfield opcode */

		while ((st < len) && (val[off + st] <= ' ')) {
			st++;
		}
		return ((st > 0) || (st < len)) ? original.substring(st, len) : "";
	}

	/**
	 * 去掉字符串后面的空格
	 * @param original
	 * @return
	 */
	public static String afterTrim(String original) {
		if (original == null || original.trim().length() == 0)
			return original;
		int len = original.length();
		int st = 0;
		int off = 0; /* avoid getfield opcode */
		char[] originalValue = original.toCharArray();
		char[] val = Arrays.copyOfRange(originalValue, off, off + len); /* avoid getfield opcode */

		while ((st < len) && (val[off + len - 1] <= ' ')) {
			len--;
		}
		return ((st > 0) || (st < len)) ? original.substring(st, len) : "";
	}

	/**
	 * 字符串转list
	 * @param str
	 * @param splitBy
	 * @return
	 */
	public static List<String> splitToList(String str, String splitBy) {
		if (StringUtils.isBlank(str))
			return null;
		String[] arrays = str.split(splitBy);
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < arrays.length; i++) {
			list.add(arrays[i].trim());
		}
		return list;
	}

	public static boolean isAllNotBlank(String... text) {
		if (text != null && text.length != 0) {
			for (int i = 0; i < text.length; i++) {
				if (!isNotBlank(text[i])) {
					return false;
				}
			}
			return true;
		}
		return false;
	}

	/**
	 * 将数据库表字段转化为实体类属性
	 * e.g. user_info --> userInfo
	 * @param columnName
	 * @return
	 */
	public static String toCamelStyle(String columnName) {
	    columnName = columnName.toLowerCase();
		StringBuffer sb = new StringBuffer();
		boolean match = false;
		for (int i = 0; i < columnName.length(); i++) {
			char ch = columnName.charAt(i);
			if (match && ch >= 97 && ch <= 122)
				ch -= 32;
			if (ch != '_') {
				match = false;
				sb.append(ch);
			} else {
				match = true;
			}
		}
		return sb.toString();
	}

	/**
	 * 将驼峰命名法转化为下划线的形式
	 * e.g.  UserInfo --> user_info     loginId --> login_id
	 * @param name
	 * @return
	 */
	public static String addUnderscores(String name) {
		StringBuffer buf = new StringBuffer(name.replace('.', '_'));
		for (int i = 1; i < buf.length() - 1; i++) {
			if (Character.isLowerCase(buf.charAt(i - 1)) && Character.isUpperCase(buf.charAt(i)) && Character.isLowerCase(buf.charAt(i + 1))) {
				buf.insert(i++, '_');
			}
		}
		return buf.toString().toLowerCase();
	}

	
	
	public static String encode(String text) {
		if (StrUtil.isNotBlank(text)) {
			return Base64.getEncoder().encodeToString(text.getBytes(StandardCharsets.UTF_8));
		} else {
			return "";
		}
	}

	
	public static String decode(String text) {
		if (StrUtil.isNotBlank(text)) {
			try {
				return new String(DatatypeConverter.parseBase64Binary(text), "UTF-8");
			} catch (Exception e) {
				return text;
			}
		} else {
			return "";
		}
	}

}
