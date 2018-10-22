package com.bbs.utils;

import java.util.UUID;

/**
 * @author Shen
 * @version 1.0
 * 2018年6月16日下午1:32:23
 */
public final class Utils {
	public static String createUUID(){
		return UUID.randomUUID().toString().replace("-", "").toUpperCase();
	}

}
