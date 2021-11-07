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
		return -1; // �����ͺ��̽� ����
	}
	
	public ArrayList<ReviewDTO> getList (String category, String searchType, String search, int pageNumber) {
		if(category.equals("��ü")) {
			category = "";
		}
		ArrayList<ReviewDTO> reviewList = null;
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(searchType.equals("�ֽż�")) {
				SQL = "SELECT * FROM REVIEW WHERE category LIKE ? AND CONCAT(reviewTitle, reviewContent) LIKE " +
						"? ORDER BY reviewID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}else if(searchType.equals("��õ��")) {
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
						rs.getInt(1), // ���� ���̵�
						rs.getString(2), // ���� ���̵�
						rs.getString(3), // ī�װ�
						rs.getString(4), // ���� Ÿ��Ʋ
						rs.getString(5),// ���� ����
						rs.getString(6), // ���� ����
						rs.getString(7), // ������ ����
						rs.getString(8), // ���� ����
						rs.getString(9), // ��Ÿ ����
						rs.getInt(10) // ��õ
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
		return -1; // ȸ������ ����
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
		return -1; // ȸ������ ����
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
		return null; // ���������ʴ� ���̵�
	
	}
}
