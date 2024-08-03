package uuu.cs.test;
import java.util.Random;
import java.util.Scanner;

public class TestGuessTheNumber_do_while {
	public static void main(String[] args) {
		
		//1.抽出1個1~10之間的整數theNumber
		//2.使用者輸入1個1~10之間的整數guessNumber
		//3.當theNumber==guessNumber就猜對了，否則就猜錯了
		
		//1.抽出1個1~10之間的整數theNumber
		//double randomNumber = Math.random()*10+1; //產生0~1之間，所以如果要1~10的數字應該*9+1，不是*10
		Random random = new Random();	//用Random機制產生亂數	
		int theNumber = random.nextInt(10)+1;
		//System.out.println(theNumber); //for test
		
		//2.使用者輸入1個1~10之間的整數guessNumber
		Scanner scanner = new Scanner(System.in); //建立Scanner類別物件來對應鍵盤輸入
		
		//設定只能猜三次
//		int maxTimes = 3;
//		int count = 0;
//		int guessNumber;//用之前要給初值，但因為guessNumber在第32行才使用，而28行就會給值，所以這邊可以先不用給初值
//	
//		do{ //true無窮迴圈 //也可以寫guessNumber!=theNumber->這樣guessNumber變數就不用放在外面宣告
//			
//			System.out.print("請輸入1個1~10之間的整數:");
//			guessNumber = scanner.nextInt(); //讀取輸入的整數
//			//System.out.println(guessNumber); //for test
//			
//			// 3.當theNumber==guessNumber就猜對了，否則就猜錯了
//			if(theNumber == guessNumber) {
//				System.out.printf("猜對了!!\n");
//				return; 
//				//break;
//			} else if(guessNumber<1 || guessNumber>10) {
//				System.err.printf("輸入範圍不正確\n");
//			} else {
//				System.out.printf("猜錯了~~~\n",theNumber);
//				count++;
//				if(count>=maxTimes) {
//					System.out.println("已經猜三次了!Game Over!");
//					break;
//				}
//			}
//			
//		}while(theNumber!=guessNumber);
//		scanner.close();
		
		int maxTimes = 3;
		int count = 1;
		int guessNumber = -1;
		System.out.println("猜數字~可以猜3次");
		do{ //true無窮迴圈 //也可以寫guessNumber!=theNumber->這樣guessNumber變數就不用放在外面宣告
			System.out.print("請輸入1個1~10之間的整數:");
			String guessDate = scanner.next(); 
			//System.out.println(guessNumber); //for test
			
			// 3.當theNumber==guessNumber就猜對了，否則就猜錯了
			if(guessDate!=null && guessDate.matches("\\d+")) {
				guessNumber = Integer.parseInt(guessDate);
				if(theNumber == guessNumber) {
					System.out.printf("猜對了!!\n");
					return; 
				}  else {
					System.out.printf("猜錯了~~~\n",theNumber);
					}
			} else {
				System.out.printf("請輸入1~10之間的整數數字，%s並非整數\n",guessDate);
				guessNumber = -1;
			}
			if(count>=maxTimes) {
				System.out.println("已經猜三次了!Game Over!");
				break;
			}
			count++;
			
		}while(theNumber!=guessNumber);
		scanner.close();
	}
}
