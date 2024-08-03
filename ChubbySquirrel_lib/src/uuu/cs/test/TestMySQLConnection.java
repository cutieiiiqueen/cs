package uuu.cs.test;

//import uuu.cs.service.MySQLConnection;

public class TestMySQLConnection {
	//private static MySQLConnection connection = new MySQLConnection();
	public static void main(String[] args) {
		//new MySQLConnection(); //強迫載入類別
		try {
			Class.forName("uuu.cs.service.MySQLConnection");//載入指定的Class //沒有建立物件純粹載入
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
