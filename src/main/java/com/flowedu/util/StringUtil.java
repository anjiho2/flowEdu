package com.flowedu.util;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class StringUtil {
	
	/**
	 * arrayList -> string[] 변환
	 * @param arrayList
	 * @return
	 */
	public static String[] listToStringArray(List<String> arrayList) {
		String[] stringArray = arrayList.toArray(new String[arrayList.size()]);
		return stringArray;
	}

    public static String[] listToStringArrayTypeLong(List<Long> arrayList) {
        String[] stringArray = arrayList.toArray(new String[arrayList.size()]);
        return stringArray;
    }
	
	/**
	 * stringArray -> arrayList 변환
	 * @param stringArray
	 * @return
	 */
	public static List<String> stringArrayToList(String[] stringArray) {
		ArrayList<String> Arr = new ArrayList<>();
		Arr = new ArrayList<String>(Arrays.asList(stringArray));
		return Arr;
	}
	
	/**
	 * 구분자로 문자 합치기
	 * @param array
	 * @param regx
	 * @return
	 */
	public static String stringJoin(String array[], String regx) {
		String str = "";
		
		for (int i=0; i<array.length; i++) {
			str += array[i];
			if (i < array.length-1) str += regx;
		}
		return str;
	}
	
	/**
	 * 구분자로 문자열 자르기
	 * @param str
	 * @param regx
	 * @return
	 */
	public static String[] stringSplit(String str, String regx) {
		String[] array = null;
		if (!"".equals(str)) array = str.split(regx);
		return array;
	}
	
	/**
	 * 콤마 split
	 * @param srcStr
	 * @return
	 */
	public static String[] splitComma(String srcStr) {
		String splitStr[] = null;
		if (!"".equals(srcStr)) {
			splitStr = srcStr.split("\\.");
		}
		return splitStr;
	}
	
	/**
	 * 문자열에 한글이 포함되어있는지 확인
	 * @param korStr
	 * @return
	 */
	public static boolean isKorean(String korStr) {
		boolean bl = false;
		if (!"".equals(korStr)) {
			try {
				korStr = new String(korStr.getBytes("utf-8"),"euc-kr");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(korStr.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")) bl = true; 
		}
		return bl;
	}
	
	/**
	 * 천단위 콤마찍기
	 * @param num
	 * @return
	 */
	public static String addThousandSeparatorCommas(String num) {
		String resultInt = "";
		if (!num.equals("")) {
			 int intValue = Integer.parseInt(num);
			 DecimalFormat commas = new DecimalFormat("#,###");
			 resultInt = (String)commas.format(intValue);
		}
		return resultInt;
	}
	
	/**
	 * 좌측 "0" 제거
	 * @param str
	 * @return
	 */
	public static String leaveLeftZero(String str) {
		String leavedStr = "";
		if (!"".equals(str)) {
			leavedStr = str.replace("0", "");
		}
		return leavedStr;
	}
	
	public static String leaveLastStr(String str) {
		String leavedStr = "";
		if (!"".equals(str)) {
			leavedStr = str.substring(0, str.length()-1);
		}
		return leavedStr;
	}
	
	public static String leaveStartStrNum(String str, int num) {
		String leavedStr = "";
		if (!"".equals(str)) {
			leavedStr = str.substring(0, str.length() - num);
		}
		return leavedStr;
	}

	public static String leaveLastStrNum(String str, int num) {
		String leavedStr = "";
		if (!"".equals(str)) {
			leavedStr = str.substring(str.length() - num, str.length());
		}
		return leavedStr;
	}
	
	/**
	 * 문자배열 만들기
	 * @param strings
	 * @return
	 */
	public static String[] getStringArray(String... strings) {
		String[] stringArray = null;
		List<String>Array = new ArrayList<String>();
		
		if (strings.length > 0) {
			for (String string : strings) {
				Array.add(string);
			}
		}
		stringArray = Array.toArray(new String[Array.size()]);
		return stringArray;
	}

	
	/**
	 * nPageSize만큼 잘라서 가져오기
	 * @param arrList
	 * @param nPageSize
	 * @return
	 */
	public static ArrayList gerArrayList(ArrayList<String>arrList, int nPageSize) {
		ArrayList<ArrayList<String>> arrToList = new ArrayList<ArrayList<String>>();
		
		int nTotalPage = 0;
		if (arrList.size() % nPageSize == 0) {
			nTotalPage = arrList.size() / nPageSize;
		} else {
			nTotalPage = arrList.size() / nPageSize + 1;
		}
		int nPage = 1;
		ArrayList<String> arrListTmp = new ArrayList<String>();
		for (int i=0; i<arrList.size(); i++) {
			arrListTmp.add(arrList.get(i));
			if (nPage < nTotalPage && arrListTmp.size() == nPageSize) {
				arrToList.add(arrListTmp);
				nPage++;
				arrListTmp = new ArrayList<String>();
			} else if (nPage == nTotalPage && i == (arrList.size() - 1)) {
				arrToList.add(arrListTmp);
				arrListTmp = new ArrayList<String>();
			}
		}
		return arrToList;
	}

	public static ArrayList getArrayListAtMap(ArrayList<HashMap<String, Object>> arrList, int nPageSize) {
		ArrayList<ArrayList<HashMap<String, Object>>> arrToList = new ArrayList<>();

		int nTotalPage = 0;
		if (arrList.size() % nPageSize == 0) {
			nTotalPage = arrList.size() / nPageSize;
		} else {
			nTotalPage = arrList.size() / nPageSize + 1;
		}
		int nPage = 1;

		ArrayList<HashMap<String, Object>> arrListTmpMap = new ArrayList<>();
		for (int i=0; i<arrList.size(); i++) {
			arrListTmpMap.add(arrList.get(i));
			if (nPage < nTotalPage && arrListTmpMap.size() == nPageSize) {
				arrToList.add(arrListTmpMap);
				nPage++;
				arrListTmpMap = new ArrayList<>();
			} else if (nPage == nTotalPage && i == (arrList.size() - 1)) {
				arrToList.add(arrListTmpMap);
				arrListTmpMap = new ArrayList<>();
			}
		}
		return arrListTmpMap;
	}
	
	public static boolean isSpecialCharacter(String str) {
		if (!str.matches("[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힝]*")) {
			return true;
		}
		return false;
	}

	public static String StringReplace(String str){
		String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
		str =str.replaceAll(match, " ");
		return str;
	}

	public static String convertParmeterStr(String str, String encoding) throws UnsupportedEncodingException {
		String convertStr = "";
		if (!"".equals(str)) {
			convertStr = new String(str.getBytes("8859_1"), encoding);
		}
		return convertStr;
	}

	public static boolean isEmpty(String txt) {
		if (txt == null || "".equals(txt.trim())) {
			return true;
		}
		return false;
	}

	/**
	 * 문자열안에 특정 문자가 몇개인지 확인하기
	 * @param val
	 * @param val2
	 * @return
	 */
	public static int strMatchCount(String val, String val2) {
		Pattern p = Pattern.compile(val2);
		Matcher m = p.matcher(val);
		int count  = 0;
		for( int i = 0; m.find(i); i = m.end()){
			if(count < 4){
				count++;
			}
		}
		return count;
	}



	public static void main(String[] args) {
		List<String>list = new ArrayList<>();
		list.add("1");
		list.add("2");
        String[] strings = list.stream().toArray(String[]::new);
		System.out.println(strings.toString());
	}

}
