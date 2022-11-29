package com.mealmaker.babiyo.review.dao;

import java.util.List;
import java.util.Map;

import com.mealmaker.babiyo.review.model.ReviewDto;

public interface ReviewDao {
	//목록
	List<ReviewDto> reviewList();
	//목록-리뷰 수
	public int reviewQuantity(int productNo);
	//상세
	List<ReviewDto> reviewDetail();
	//이미지 첨삭
	public void insertFile(Map<String, Object> map);
	List<Map<String, Object>> fileSelectList(int no);
	public Map<String, Object> fileSelectStoredFileName(int parentSeq);
	public int fileDelete(int parentSeq);
}
