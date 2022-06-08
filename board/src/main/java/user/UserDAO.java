package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	public UserDAO() {
		
			try {
					String dbURL = "jdbc:mysql://localhost:3306/TEST?useSSL=false&characterEncoding=UTF-8&serverTimezone=UTC";
					String dbId = "kwon";
					String dbPassword = "rnjstpdms0115";
					
					Class.forName("com.mysql.cj.jdbc.Driver");
					conn = DriverManager.getConnection(dbURL,dbId, dbPassword);
					
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	
	// 하나의 계정에 대한 로그인 시도를 해주는 함수
	public int login(String userId, String userPw) {
		String SQL = "SELECT userPw FROM USER_B WHERE userId= ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(userPw)) {
					return 1; // 로그인 성공 
				}else 
					return 0;
			}
			return -1; //아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}	
}
