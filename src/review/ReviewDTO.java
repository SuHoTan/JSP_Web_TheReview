package review;

public class ReviewDTO {
	
	int reviewID;
	String userID;
	String category;
	String reviewTitle;
	String reviewContent;
	String totalScore;
	String designScore;
	String priceScore;
	String etcScore;
	int recommendCount;
	

	public ReviewDTO(int reviewID, String userID, String category, String reviewTitle, String reviewContent,
			String totalScore, String designScore, String priceScore, String etcScore, int recommendCount) {
		super();
		this.reviewID = reviewID;
		this.userID = userID;
		this.category = category;
		this.reviewTitle = reviewTitle;
		this.reviewContent = reviewContent;
		this.totalScore = totalScore;
		this.designScore = designScore;
		this.priceScore = priceScore;
		this.etcScore = etcScore;
		this.recommendCount = recommendCount;
	}
	public int getReviewID() {
		return reviewID;
	}
	public void setReviewID(int reviewID) {
		this.reviewID = reviewID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getReviewTitle() {
		return reviewTitle;
	}
	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getDesignScore() {
		return designScore;
	}
	public void setDesignScore(String designScore) {
		this.designScore = designScore;
	}
	public String getPriceScore() {
		return priceScore;
	}
	public void setPriceScore(String priceScore) {
		this.priceScore = priceScore;
	}
	public String getEtcScore() {
		return etcScore;
	}
	public void setEtcScore(String etcScore) {
		this.etcScore = etcScore;
	}
	public int getRecommendCount() {
		return recommendCount;
	}
	public void setRecommendCount(int recommendCount) {
		this.recommendCount = recommendCount;
	}
	
	

}
