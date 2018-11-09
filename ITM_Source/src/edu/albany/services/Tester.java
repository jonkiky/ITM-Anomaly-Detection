package edu.albany.services;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Tester {

	public static void main(String arg[]){
		
		String dateTime = "2016-09-27 16:20:32.248";
		
		String dateTime2 = "1 June, 2014";
		
		// Format for input
		// Parsing the date
		try {
			SimpleDateFormat dateParser = new SimpleDateFormat("dd MMMMM, yyyy");
			Date date = dateParser.parse(dateTime2);
			SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
			System.out.println(dateFormatter.format(date));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	
	}
}
