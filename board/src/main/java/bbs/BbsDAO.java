package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	
	// 글 목록창 불러오는 함수 
	public ArrayList<Bbs> getList(int pageNumber){
		// 특정한 숫자보다 작고 삭제가 되지 않아서 AVAILABLE이 1인 글만 가져오고, 위에서 10개의 
		// 글자까지만 가져오고 글 번호를 내림차순 하는 쿼리문 
		String SQL = "SELECT * FROM BBS WHERE bbsId < ? and bbsAvailable = 1 ORDER BY bbsId DESC LIMIT 10";
	
		// bbs클래스에서 나오는 인스턴스를 보관하는 리스트를 하나 만든다.
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// 글 출력 개수
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsId(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserId(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//10개 밖에 없다면 다음 페이지가 없다는걸 알려주는 거에요. 페이지 처리를 위해서 존재하는 함수에요
		public boolean nextPage(int pageNumber) {
			// 특정한 숫자보다 작고 삭제가 되지 않아서 AVAILABLE이 1인 글만 가져오고 위에서 10개의 글까지만 가져오고 글 번호를 내림차순 하는 쿼리문입니다.
					String SQL = "SELECT * FROM BBS WHERE bbsID < ? and bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
					// Bbs클래스에서 나오는 인스턴스를 보관하는 리스트를 하나 만듭니다.
					ArrayList<Bbs> list = new ArrayList<Bbs>();
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						// 글 출력 개수
						pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
						rs = pstmt.executeQuery();
						//결과가 하나라도 존재하면 다음페이지로 넘어갈 수 있다고 알려주고
						if (rs.next()) {
							return true;						
						}
						
					} catch (Exception e) {
						e.printStackTrace();
					}
					//아니라면 false
					return false;
		}
		
		//글 내용을 불러오는 함수
		public Bbs getBbs(int bbsId) {
			//특정 게시글 번호에 모든 정보를 가져오는 쿼리문입니다.
			String SQL = "SELECT * FROM BBS WHERE bbsId =?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1,  bbsId);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					//글에 대한 정보를 담을 객체를 생성하고
					Bbs bbs = new Bbs();
					bbs.setBbsId(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserId(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					return bbs;
					
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			//정보가 없으면 null값을 반환
			return null;
		}
		
		// 글 수정하는 함수
		public int update(int bbsId, String bbsTitle, String bbsContent) {
			String SQL = "UPDATE BBS SET bbsTitle =?, bbtContent = ? WHERE bbsId = ?";
			
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, bbsTitle);
				pstmt.setString(2, bbsContent);
				pstmt.setInt(3, bbsId);
				return pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //database error
		}
		
		//bbsAvailable 을 0으로 바꿈으로써 화면에 표시하지 않게 한다
		public int delete(int bbsId) {
			String SQL = "DELETE BBS SET bbsAvailable = 0 WHERE bbsId = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, bbsId);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //db error
		}
	}