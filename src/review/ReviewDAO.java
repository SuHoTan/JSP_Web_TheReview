package review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import review.ReviewDTO;
import util.DatabaseUtil;

public class ReviewDAO {
	
	public int write(ReviewDTO reviewDTO) {
		String SQL = "INSERT INTO review VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?,0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, reviewDTO.getUserID().replace("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(2, reviewDTO.getCategory().replace("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3, reviewDTO.getReviewTitle().replace("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(4, reviewDTO.getReviewContent().replace("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(5, reviewDTO.getTotalScore().replace("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(6, reviewDTO.getDesignScore().replace("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(7, reviewDTO.getPriceScore().replace("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(8, reviewDTO.getEtcScore().replace("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		} 
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<ReviewDTO> getList (String category, String searchType, String search, int pageNumber) {
		if(category.equals("전체")) {
			category = "";
		}
		ArrayList<ReviewDTO> reviewList = null;
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(searchType.equals("최신순")) {
				SQL = "SELECT * FROM REVIEW WHERE category LIKE ? AND CONCAT(reviewTitle, reviewContent) LIKE " +
						"? ORDER BY reviewID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}else if(searchType.equals("추천순")) {
				SQL = "SELECT * FROM REVIEW WHERE category LIKE ? AND CONCAT(reviewTitle, reviewContent) LIKE " +
						"? ORDER BY recommendCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + category + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			reviewList = new ArrayList<ReviewDTO>();
			while(rs.next()) {
				ReviewDTO review = new ReviewDTO(
						rs.getInt(1), // 리뷰 아이디
						rs.getString(2), // 유저 아이디
						rs.getString(3), // 카테고리
						rs.getString(4), // 리뷰 타이틀
						rs.getString(5),// 리뷰 내용
						rs.getString(6), // 종합 점수
						rs.getString(7), // 디자인 점수
						rs.getString(8), // 가격 점수
						rs.getString(9), // 기타 점수
						rs.getInt(10) // 추천
						);
					reviewList.add(review);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		} 
		return reviewList; 
	}
	
	public int recommend(String reviewID) {
		String SQL = "UPDATE REVIEW SET recommendCount = recommendCount + 1 WHERE reviewID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(reviewID));
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // 회원가입 실패
	}
	public int delete(String reviewID) {
		String SQL = "DELETE FROM review WHERE reviewID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(reviewID));
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // 회원가입 실패
	}
	public String getUserID(String reviewID) {
		String SQL = "SELECT userID FROM review WHERE reviewID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(reviewID));
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}  finally {
		try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
		try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
		try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return null; // 존재하지않는 아이디
	
	}
}
