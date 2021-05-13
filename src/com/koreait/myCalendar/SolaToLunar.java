package com.koreait.myCalendar;

import java.io.IOException;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class SolaToLunar {

//	월별 양력과 음력을 크롤링하고 양력, 음력 공휴일을 계산해서 리턴하는 메소드
	public static ArrayList<LunarDate> solaToLunar(int year, int month) {
		
		ArrayList<LunarDate> lunarList = new ArrayList<LunarDate>();	// 1월 ~ 12월의 양력과 대응되는 음력을 기억한다.
		ArrayList<LunarDate> list = new ArrayList<LunarDate>();			// 인수로 넘겨받은 month의 양력에 대조되는 음력을 저장해 리턴할 객체
		String targetSite = "";
		
//		인수로 넘겨받은 year에 해당되는 1월 ~ 12월 양력과 대응되는 음력을 크롤링해서 얻어온다.
		for (int i = 1; i <= 12; i++) {
			targetSite = String.format("https://astro.kasi.re.kr/life/pageView/5?search_year=%04d&search_month=%02d", year, i);
//			System.out.println(targetSite);
//			크롤링한 데이터를 기억할 org.jsoup.nodes 패키지의 Document 클래스 객체를 선언한다.
			Document document = null;
			
//			org.jsoup 패키지의 connect() 메소드로 크롤링 할 타겟 사이트에 접속하고 get() 메소드로 타겟 사이트의 정보를 얻어온다.
			try {
				document = Jsoup.connect(targetSite).get();
//				System.out.println(document);
				
//				Document 클래스 객체에 저장된 타겟 사이트의 정보 중에서 select() 메소드를 사용해 날짜(<tr>) 단위로 얻어온다.
				Elements elements = document.select("tbody > tr");
				for (Element element : elements) {
//					System.out.println(element);
					
//					날짜 단위로 얻어온 정보에서 양력, 음력, 간지 단위로 얻어온다.
					Elements ele = element.select("td");
//					System.out.println(ele);
//					System.out.println(ele.get(0));		// 양력
//					System.out.println(ele.get(1));		// 음력
//					text() 메소드로 태그 내부의 양력, 음력 텍스트만 얻어온다.
//					System.out.println(ele.get(0).text());
//					System.out.println(ele.get(1).text());
					String sola = ele.get(0).text();
					String lunar = ele.get(1).text();
					System.out.println("양력 " + sola + "일은 음력 " + lunar + "일 입니다.");
					
//					크롤링한 결과를 LunarDate 클래스 객체에 저장해서 ArrayLust에 넣어준다.
					
				}
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
		return list;
		
	}
	
}












