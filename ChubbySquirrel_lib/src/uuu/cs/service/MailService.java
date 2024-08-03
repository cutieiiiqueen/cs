package uuu.cs.service;

import java.util.Properties;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * 提供了寄送郵件的功能。 2024-06-16 v1.1: 寄送郵件由原本SSL改為TLS加密。
 */
public class MailService {
	// 寄件者的電子郵件地址
	private String userName = "chubbysquirrel662@gmail.com";
	// 寄件者密碼
	private String password = "ifsvbqxhhmhnkpwl";

	/**
	 * 使用指定的收件人地址、主題和內容寄送郵件。
	 *
	 * @param memberMail 收件人的電子郵件地址。
	 * @param subject    郵件的主題。
	 * @param txt        郵件的內容。
	 */
	public void SendMail(String memberMail, String subject, String txt) {

		// ---------------------------------------------------------連線設定
		Properties prop = new Properties();

		// 設定連線為smtp
		prop.setProperty("mail.transport.protocol", "smtp");
		
		// host主機:smtp.gmail.com
		prop.setProperty("mail.host", "smtp.gmail.com");
		
		// host port:587
		prop.put("mail.smtp.port", "587");
		
		// 寄件者帳號需要驗證：是
		prop.put("mail.smtp.auth", "true");
		
		// 啟動TLS加密
		prop.put("mail.smtp.starttls.enable", "true");

		// 信任smtp.gmail.com
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		// 不啟用SSL加密
		prop.put("mail.smtp.ssl.enable", "false");
		
		// 顯示連線資訊
		prop.put("mail.debug", "true");
		
		// ---------------------------------------------------------Auth驗證
		Session session = Session.getInstance(prop);

		// ---------------------------------------------------------Message郵件格式
		MimeMessage message = new MimeMessage(session);

		try {
			// class
			InternetAddress sender = new InternetAddress(userName);
			message.setSender(sender);

			// 收件者
			message.setRecipient(RecipientType.TO, new InternetAddress(memberMail));

			// 標題
			message.setSubject(subject);

			// 內容/格式
			message.setContent(txt, "text/html;charset = UTF-8");

			// ---------------------------------------------------------Transport傳送Message
			try (Transport transport = session.getTransport()) {
				transport.connect(userName, password);
				transport.sendMessage(message, message.getAllRecipients());
			}

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
