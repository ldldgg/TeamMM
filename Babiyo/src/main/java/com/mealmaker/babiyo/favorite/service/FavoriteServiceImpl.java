package com.mealmaker.babiyo.favorite.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mealmaker.babiyo.favorite.dao.FavoriteDao;
import com.mealmaker.babiyo.favorite.model.FavoriteDto;
import com.mealmaker.babiyo.product.dao.ProductDao;
import com.mealmaker.babiyo.util.Paging;

@Service
public class FavoriteServiceImpl implements FavoriteService{

	private static final Logger log 
		= LoggerFactory.getLogger(FavoriteServiceImpl.class);
	
	private final FavoriteDao favoriteDao;
	
	@Resource
	private ProductDao productDao;
	
	@Autowired
	public FavoriteServiceImpl(FavoriteDao favoriteDao) {
		this.favoriteDao = favoriteDao;
	}
	
	@Override
	public List<Map<String, Object>> favoriteList(String memberId, int begin, int end) {
		// TODO Auto-generated method stub

		List<FavoriteDto> favoriteList = favoriteDao.favoriteList(memberId, begin, end);
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		for (FavoriteDto favoriteDto : favoriteList) {
			Map<String, Object> map = new HashMap<String, Object>();
			
			int productNo = favoriteDto.getProductNo();
			Map<String, Object> imgMap = productDao.fileSelectOne(productNo);
			
			map.put("favoriteDto", favoriteDto);
			map.put("imgMap", imgMap);
			
			list.add(map);
		}
		
		return list;
	}

	@Override
	public void favoriteDelete(FavoriteDto favoriteDto, String memberId) {
		// TODO Auto-generated method stub
		favoriteDto.setMemberId(memberId);
		
		favoriteDao.favoriteDelete(favoriteDto);
	}

	@Override
	public boolean favoriteBtn(String memberId, int productNo) {
		// TODO Auto-generated method stub
		
		FavoriteDto favoriteDto = new FavoriteDto();
		
		favoriteDto.setMemberId(memberId);
		favoriteDto.setProductNo(productNo);
		
		String memberIdCheck = favoriteDao.favoriteCheck(favoriteDto);
		
		// 즐겨찾기에 있으면 true 없으면 false
		boolean check = memberId.equals(memberIdCheck);
		
		if(check) {
			favoriteDao.favoriteDelete(favoriteDto);
		}else {
			favoriteDao.favoriteAdd(favoriteDto);
		}
		
		return check;
	}

	@Override
	public int totalCount(String memberId) {
		// TODO Auto-generated method stub
		return favoriteDao.totalCount(memberId);
	}

}
