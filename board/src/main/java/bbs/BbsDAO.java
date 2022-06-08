package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO() {
		
		try {
				String dbURL = "jdbc:mysql://localhost:3306/TEST?useSSL=false&characterEncoding=UTF-8&serverTimezone=UTC";
				String dbId = "kwon";
				String dbPassword = "rnjstpdms0115";
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection(dbURL, dbId, dbPassword);
				System.out.println(">>>>>> DB연결 성공 ");
				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 게시판 글쓰기를 위해 총 3개의 함수가 필요하다.
	// 현재의 시간을 가져오는 함수, 게시판에 글을 쓸 때 현재 서버의 시간을 표시해주는 역할 
	public String getDate() {
		String SQL = "SELECT NOW()";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL = "SELECT bbsId FROM BBS ORDER BY bbsId DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; // 첫번째 게시물인 경우 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
	
	public int write(String bbsTitle, String userId, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//1번은 게시물 번호여야 하니까 getNext()를 사용한다. 
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userId);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1); //available 삭제됐는지 아닌지 확인 
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터 베이스 오류 
	}
	
}
