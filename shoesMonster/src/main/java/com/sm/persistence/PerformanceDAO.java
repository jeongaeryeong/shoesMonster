package com.sm.persistence;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.sm.domain.LineVO;
import com.sm.domain.ProductVO;

@Repository
public interface PerformanceDAO {
	
	// 품목관리 목록 불러오기
	public List<ProductVO> readProdList() throws Exception;
	
	// 품목관리 검색리스트 불러오기
		public List<ProductVO> readProdList(ProductVO vo) throws Exception;
		
	// 품목관리 정보 다중 저장
	public void insertProdList(ProductVO product); 
		
	//==========================================================================
	
	// 라인 조회 - getLineList
	public List<LineVO> getLineList() throws Exception;
	
	// 라인 검색 - getSearchLine
	public List<LineVO> getSearchLine(LineVO lvo) throws Exception;
	
	
}
