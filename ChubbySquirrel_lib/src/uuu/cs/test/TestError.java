package uuu.cs.test;

import java.util.logging.Level;
import java.util.logging.Logger;


//程式人員不可以處理Error (try-catch)
public class TestError {
	public static void main(String[] args) {
		Logger logger = Logger.getLogger("");
		try{
			main(null); //StackOverflowError
		}finally {
			logger.log(Level.INFO, "TestError 結束");
		}
	}
}
