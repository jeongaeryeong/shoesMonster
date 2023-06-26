package com.sm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sm.domain.LineVO;
import com.sm.domain.LineWhPageMaker;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.PagingVO;
import com.sm.domain.PerformanceVO;
import com.sm.domain.ProductList;
import com.sm.domain.ProductVO;
import com.sm.domain.WarehouseVO;
import com.sm.domain.Wh_prodVO;
import com.sm.service.PerformanceService;

@Controller
@RequestMapping(value = "/performance/*")
public class PerfomanceController {

	// 서비스 객체 주입
	@Autowired
	private PerformanceService service;

	private static final Logger logger = LoggerFactory.getLogger(PerfomanceController.class);

	// ======================================================================================

	// http://localhost:8088/performance/product
	@RequestMapping(value = "/product", method = RequestMethod.GET)
	public void productGET(Model model, ProductVO vo, PagingVO pvo,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage,
			@RequestParam(value = "input", required = false) String input) throws Exception {
		logger.debug("productGET() 호출");
		List<ProductVO> products = new ArrayList<ProductVO>();
		model.addAttribute("products", products);
		logger.debug("vo : " + vo);
		
		
		logger.debug(" @@@@@@@@@@ input: " + input + "@@@@@@@@@@@@@@@");
		
		
		
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "5";
		}

		if (vo.getProd_code() != null || vo.getProd_name() != null || vo.getProd_category() != null
				|| vo.getProd_unit() != null) {
			int total = service.countProd(vo);
			pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			List<ProductVO> list = service.getProdList(vo, pvo);
			model.addAttribute("prodList", list);
			model.addAttribute("paging", pvo);
			model.addAttribute("vo", vo);
			logger.debug("pvo : " + pvo);
			logger.debug("vo : " + vo);
			
			logger.debug("검색 리스트 가져감");
			
			
			
			if(input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@");
			}

			
			
			
		} else {
			int total = service.countProd();
			pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			logger.debug("pvo : " + pvo);
			List<ProductVO> list = service.getProdList(pvo);
			model.addAttribute("prodList", list);
			model.addAttribute("paging", pvo);
			logger.debug(" 모든 리스트 가져감");
		}

	}
  
  	////////////////////// 검색 ajax /////////////////////////
//	@ResponseBody
//	@RequestMapping(value = "/search", method = RequestMethod.POST)
//	public List<ProductVO> searchPOST(Model model,
//			PagingVO pvo,
//			@RequestBody ProductVO vo,
//			@RequestParam(value = "nowPage", required = false) String nowPage,
//			@RequestParam(value = "cntPerPage", required = false) String cntPerPage
//			) throws Exception {
//		logger.debug("searchPOST() 호출");
//		
//		if (nowPage == null && cntPerPage == null) {
//			nowPage = "1";
//			cntPerPage = "5";
//		} else if (nowPage == null) {
//			nowPage = "1";
//		} else if (cntPerPage == null) {
//			cntPerPage = "5";
//		}
//		
//		List<ProductVO> list = new ArrayList<>();
//		
//		if (vo.getProd_code() != null || vo.getProd_name() !=null || 
//			vo.getProd_category() !=null || vo.getProd_unit() !=null ) {
//			int total = service.countProd(vo);
//			pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
//			list = service.getProdList(vo,pvo);
//			logger.debug("검색 리스트 가져감");
//			model.addAttribute("paging", pvo);
//			model.addAttribute("vo",vo);
//		}
//		
//		return list;
//	} //searchPOST()
	////////////////////// 검색 ajax /////////////////////////
  
	// 품목관리 정보 추가 
	@RequestMapping(value = "product", method = RequestMethod.POST)
	public String productPOST(ProductList products) throws Exception {

		logger.debug("productPOST() 호출");
		logger.debug("prducts : " + products.getProducts());
		service.insertProd(products.getProducts());
//		service.insertProd(vo);

		return "redirect:/performance/product";
	}
	
	@RequestMapping(value = "/prodDelete", method = RequestMethod.POST)
	public String deleteProd(@RequestParam(value="checked[]") List<String> checked) throws Exception {
		logger.debug("@@@@@ CONTROLLER: deleteProd() 호출");
		logger.debug("@@@@@ CONTROLLER: checked = " + checked);
		
		//서비스 - 작업지시 삭제 
		service.removeProd(checked);
		
		return "redirect:/performance/product";
	} //deleteWorkOrder()

	// ======== 라인 - /line ================================
	// http://localhost:8088/performance/line
	// http://localhost:8088/performance/line?page=1
	@RequestMapping(value = "/line", method = RequestMethod.GET)
	public void lineGET(Model model, LineVO lvo, 
				        LineWhPageVO vo, LineWhPageMaker lwpm,
				        Map<String, Object> params) throws Exception {
		logger.debug("@@lineGET() 호출@@");
//		List<LineVO> boardList = service.getLineList();
//		model.addAttribute("boardList", boardList);
		
		logger.debug("lvo : " + lvo);
		
		List<LineVO> boardList = new ArrayList<>();
		

		// 검색
		if (lvo.getLine_code() != null || lvo.getLine_name() != null || lvo.getLine_place() != null
				|| lvo.getLine_use() != 0) {

			List<LineVO> searchlist = service.getSearchLine(lvo);
			model.addAttribute("boardList", searchlist);

			logger.debug("searchlist : " + searchlist);

			logger.debug("@@ 검색 리스트 호출 @@");
			
//			List<LineVO> searchListPage = service.getLineListPage(vo);
			
			// 페이징처리 + 검색
//			List<LineVO> searchListPage = service.getSearchLinePage(vo, lvo);
			boardList = service.getSearchLinePage(vo, lvo);
//			List<LineVO> searchListPage = service.getSearchLinePage(lvo); // 두번째 도전
			
//			model.addAttribute("searchlist", searchListPage);

			model.addAttribute("boardList", boardList); // 0626 10:43 도전중
			
//			logger.debug("searchListPage : "+searchListPage);
			
			logger.debug("@@!!@@ 검색 리스트 (페이징처리) 불러옴 @@!!@@");
			
			lwpm.setLwPageVO(vo);
			logger.debug("확니!!!!!!!!!!!!!!!!!!!!!용");
			lwpm.setTotalCount(service.getSearchTotalCount(lvo));
			logger.debug("lwpm (제발서치서치) : "+lwpm.getTotalCount());
			model.addAttribute("lwpm", lwpm);

		} else {
			// 페이징처리된 리스트정보로 수정함!
			boardList = service.getLineListPage(vo);
			model.addAttribute("boardList", boardList);

			logger.debug("@@ 모든 리스트 호출 @@");
			
			// 페이징처리 하단부 객체 저장
			lwpm.setLwPageVO(vo);
			lwpm.setTotalCount(service.getTotalCount());
			logger.debug("lwpm : "+lwpm.getTotalCount());
			model.addAttribute("lwpm",lwpm);
			
		}
		
	}

	@RequestMapping(value = "/line", method = RequestMethod.POST)
	public void linePOST(Model model)throws Exception{
		logger.debug("linePOST() 호출");
		
		List<LineVO> boardList = service.getLineList();
		logger.debug("boardList : "+boardList);
		
//		model.addAttribute("boardList", boardList);
		
	}

	// ======== 라인 - /line ================================

	// ======== 창고 - /warehouse ===========================
	// http://localhost:8088/performance/warehouse
	@RequestMapping(value = "/warehouse", method = RequestMethod.GET)
	public void warehouseGET(Model model, LineWhPageVO vo,
							 LineWhPageMaker lwpm) throws Exception {

		logger.debug("@@ warehouseGET() 호출 @@");
		
		List<WarehouseVO> whList = service.getWhList();
		model.addAttribute("whList", whList);

		logger.debug("whList : " + whList);

		// 모든 목록(+페이징)
//		List<Wh_prodVO> whListPage = service.getWh_prodListPage(vo);
		List<WarehouseVO> whListPage = service.getWh_prodListPage(vo);
		model.addAttribute("whList", whListPage);
		
		logger.debug("@@ 모든 리스트 호출 @@");
		
		// 페이징처리(하단부) 저장
		lwpm.setLwPageVO(vo);
		lwpm.setTotalCount(service.getWh_TotalCount());
		model.addAttribute("lwpm", lwpm);
	}

	// 코드 품번 창고명 검색
	// http://localhost:8088/performance/wh_search
//	@RequestMapping(value = "/wh_search", method = RequestMethod.GET)
//	public String whSearchGET(@RequestParam("type") String type, 
//							  Model model) throws Exception{
//		
//		logger.debug("@@ whSearchGET() 호출 @@");

//		if()

//		return "";
//	}
	// ======== 창고 - /warehouse ===========================
	
	
	
	
	//// ************************* 생산실적 ************************* ////
	
	//http://localhost:8088/performance/performList
	@RequestMapping(value = "/performList", method = RequestMethod.GET)
	public void performanceList(Model model) throws Exception {
		logger.debug("@@@@@ CONTROLLER: performanceList() 호출");
		
		//서비스 - 실적목록
		List<PerformanceVO> perfList = service.getAllPerf();
		logger.debug("@@@@@ CONTROLLER: perfList = " + perfList);
		
		model.addAttribute("perfList", perfList);
	} //performanceList()
	
	
	//작업지시 검색
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String workOrderGET(Model model, @RequestParam("type") String type,
								@RequestParam("input") String input, PagingVO pvo
			/*@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage*/
			) throws Exception {
		logger.debug("@@@@@ CONTROLLER: workOrderGET() 호출");
		logger.debug("@@@@@ CONTROLLER: type = " + type);
		
		/*
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "5";
		}
		*/
		
		if(type.equals("work")) {
			return "redirect:/workorder/workOrderList?input=" + input;
		}
		return "";
	} //workOrderGET()
	
	
	
	
	
	
	
	
	
	
	
	
	
}// PerfomanceController
