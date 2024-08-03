package uuu.cs.service;

import java.util.Random;

import uuu.cs.entity.Customer;
import uuu.cs.exception.CSException;
import uuu.cs.exception.LoginFailedException;

//商業邏輯檢查
public class CustomerService {
	
	private CustomersDAO dao = new CustomersDAO();
	
	public Customer login(String id, String password) throws CSException  {
		if(id==null || id.length()==0 || password==null || password.length()==0) {
			throw new IllegalArgumentException("登入會員必須輸入帳號及密碼!");
		}
		
		Customer c = dao.selectCustomerById(id);
		
		if(c!=null && password.equals(c.getPassword())) {
			return c;
		}else {
			//throw new RuntimeException("登入失敗,帳號或密碼錯誤!"); //throw new LoginFailedException
			throw new LoginFailedException("登入失敗,帳號或密碼錯誤!"); //這邊不能用try-catch是因為要讓錯誤訊息拋到前端
		}
	}
	
	public void register(Customer c) throws CSException{
		if(c==null) throw new IllegalArgumentException("註冊會員時，customer物件不得為null");
		
		dao.insert(c);
		
	}
	
	public void update(Customer c) throws CSException{
		if(c==null) throw new IllegalArgumentException("修改會員時，customer物件不得為null");
		
		dao.update(c);
		
	}
	
	/**
	 * 忘記密碼功能，根據提供的信箱或手機號碼進行密碼重設並發送新密碼至註冊信箱。
	 * 
	 * @param id 帳號(信箱或手機號碼)
	 * @return 若帳號為空或查無此帳號，則返回相應的錯誤訊息；否則返回密碼已發送至註冊信箱的成功訊息。
	 * @throws CSException 若發生錯誤，則拋出 CSException。
	 */
	public Customer forgetPassword(String id) throws CSException{
		if(id==null || id.length()==0) 	throw new IllegalArgumentException("查詢會員必須輸入帳號!");
		
		Customer c = dao.selectCustomerById(id); //查詢是否有此客戶
		
		//若為空，返回查無帳號
		if (c != null) 	{
			MailService mail = new MailService();
	        //生成新的隨機密碼
	        String newPassword = getRandomPassword();
	        //更新客戶的密碼
	        c.setPassword(newPassword);
	        dao.updatePassword(c);
	        
			//信件標題
			String mailTitle = "胖松鼠-會員中心";
			//信件內容
			String mailContent = c.getName() + " 您好<br><br>密碼已經重設成功！<br><br>您的新密碼: " + c.getPassword() + "<br><br>此信件為系統發信，請勿直接回覆";
			//發送信件
			mail.SendMail(c.getEmail(),mailTitle,mailContent);
			return c;
		}else {
			throw new CSException("查無此帳號!");
		}
	}
	/**
	 * 生成一個長度為6的隨機英數字密碼
	 * @return 隨機密碼字串
	 */
	private String getRandomPassword() {
	    String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	    StringBuilder newPwd = new StringBuilder();
	    Random random = new Random();
	    for (int i = 0; i < 8; i++) {
	        int index = random.nextInt(chars.length()); //從0-chars的長度,隨機取一個數作為index
	        newPwd.append(chars.charAt(index)); //用字串相加把剛剛產生的index加入newPwd字串
	    }
	    return newPwd.toString(); //這邊用toString是因為不能直接返回newPwd因為他是一個可變字串
	}
	
}
