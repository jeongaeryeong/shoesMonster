package com.sm.persistence;

import java.util.List;

import com.sm.domain.ClientsVO;
import com.sm.domain.Raw_orderVO;

public interface Raw_orderDAO {

	
	// 발주 목록 조회
	public List<Raw_orderVO> Raw_order(int startRow,int pageSize) throws Exception;
	
	// 글 총 갯수
    public int count1() throws Exception;
    
    // 발주 등록(팝업)
    public List<Raw_orderVO> Popup() throws Exception;
    
    // 발주 등록
 	public void roInsert(Raw_orderVO vo) throws Exception;
    
 	// 거래처 상세(팝업)
 	public List<Raw_orderVO> getDetail() throws Exception;
    
}

