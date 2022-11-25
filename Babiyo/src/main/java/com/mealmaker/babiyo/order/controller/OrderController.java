package com.mealmaker.babiyo.order.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mealmaker.babiyo.cart.model.CartDto;
import com.mealmaker.babiyo.cart.service.CartService;
import com.mealmaker.babiyo.member.model.MemberDto;
import com.mealmaker.babiyo.order.model.OrderDetailDto;
import com.mealmaker.babiyo.order.model.OrderDto;
import com.mealmaker.babiyo.order.service.OrderService;
import com.mealmaker.babiyo.util.Paging;
import com.mealmaker.babiyo.util.SearchOption;

// 어노테이션 드리븐
@Controller
@SessionAttributes("_memberDto_")
public class OrderController {

	private static final Logger logger 
		= LoggerFactory.getLogger(OrderController.class);
	
	private final OrderService orderService;
	
	@Resource
	private CartService cartService;
	
	@Autowired
	public OrderController(OrderService orderService) {
		this.orderService = orderService;
	}
	
	@RequestMapping(value = "/order/order.do", method = RequestMethod.POST)
	public String order(OrderDetailDto orderDetailDto, CartDto cartDto, Model model) {
		logger.info("주문화면 {}", orderDetailDto.getOrderDetailList());

		List<OrderDetailDto> orderDetailList = orderDetailDto.getOrderDetailList();
		
		model.addAttribute("orderDetailList", orderDetailList);
		model.addAttribute("cartDto", cartDto);
		
		return "order/orderForm";
	}
	
	@RequestMapping(value = "/order/orderCtr.do", method = RequestMethod.POST)
	public String orderCtr(@ModelAttribute("_memberDto_") MemberDto memberDto
			,OrderDto orderDto, OrderDetailDto orderDetailDto, Model model) {
		logger.info("Welcome OrderController orderCtr! " + orderDto);
		
		String memberId = memberDto.getId();
		orderDto.setMemberId(memberId);
		
		orderService.order(orderDto, orderDetailDto);
		
		return "redirect:/order/complete.do";
	}
	
	@RequestMapping(value = "/order/complete.do", method = RequestMethod.GET)
	public String orderComplete(@ModelAttribute("_memberDto_") MemberDto memberDto
			,HttpSession session, Model model) {
		logger.info("Welcome OrderController orderComplete! ");
		
		String memberId = memberDto.getId();
		OrderDto orderDto = orderService.lastOrder(memberId);
		
		model.addAttribute("orderDto", orderDto);
		
		return "order/orderComplete";
	}
	
	
	
	@RequestMapping(value="/order/detail.do", method = RequestMethod.GET)
	public String memberOrderDetail(int orderNo, HttpSession session, Model model) {
		
		Map<String, Object> orderMap = orderService.orderView(orderNo);
		
		model.addAttribute("orderMap", orderMap);
		
		return "/order/orderDetail";
	}
	
	@RequestMapping(value="/order/cancel.do", method = RequestMethod.POST)
	public String orderCancel(@ModelAttribute("_memberDto_") MemberDto memberDto,
			int orderNo, HttpSession session, Model model) {
		
		orderService.orderCancel(orderNo);
		
		int grade = memberDto.getGrade();
		
		String url = "";
		
		if(grade == 1) {
			url += "redirect:/admin/orderList.do?orderNo=";
		} else {
			url += "redirect:/member/orderList.do?orderNo=";
		}
		
		url += orderNo;
		
		return url;
	}
	
	@RequestMapping(value="/order/accept.do", method = RequestMethod.POST)
	public String orderAccept(int orderNo, HttpSession session, Model model) {
		
		orderService.orderAccept(orderNo);
		
		String url = "redirect:/order/detail.do?orderNo=" + orderNo;
		
		return url;
	}
	
	
	@RequestMapping(value = "/admin/orderList.do", method = RequestMethod.GET)
	public String adminOrderList(@RequestParam(defaultValue = "1") int curPage
			,SearchOption searchOption, HttpSession session, Model model) {
		logger.info("Welcome OrderController memberOrderList! ");
		
		int totalCount = orderService.adminOrderCount(searchOption);
		
		Paging paging = new Paging(totalCount, curPage);
		
		int begin = paging.getPageBegin();
		int end = paging.getPageEnd();
		
		List<OrderDto> orderList = orderService.adminOrderList(begin, end, searchOption);
		
		List<Map<String, Object>> stateList = orderService.orderStateList();
		
		model.addAttribute("paging", paging);
		model.addAttribute("orderList", orderList);
		model.addAttribute("stateList", stateList);
		model.addAttribute("searchOption", searchOption);
		
		return "order/adminOrderList";
	}
	
	@RequestMapping(value = "/member/orderList.do", method = RequestMethod.GET)
	public String memberOrderList(@RequestParam(defaultValue = "1") int curPage, SearchOption searchOption
			, HttpSession session, Model model) {
		logger.info("Welcome OrderController memberOrderList! ");
		
		MemberDto memberDto = (MemberDto) session.getAttribute("_memberDto_");		
		String memberId = memberDto.getId();
		int totalCount = orderService.memberOrderCount(memberId, searchOption);
		
		Paging paging = new Paging(totalCount, curPage);
		
		int begin = paging.getPageBegin();
		int end = paging.getPageEnd();
		
		List<OrderDto> orderList = orderService.orderList(memberId, begin, end, searchOption);
		List<Map<String, Object>> stateList = orderService.orderStateList();
		
		model.addAttribute("paging", paging);
		model.addAttribute("orderList", orderList);
		model.addAttribute("stateList", stateList);
		model.addAttribute("searchOption", searchOption);
		
		return "order/memberOrderList";
	}
	
	@RequestMapping(value = "/testLogin.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String memberOrderList(String memberId, HttpSession session, Model model) {
		logger.info("테스트 로그인");
		
		MemberDto memberDto = orderService.testLogin(memberId);
		
		model.addAttribute("_memberDto_", memberDto);
		
		return "redirect:/index.do";
	}
	
	@RequestMapping(value = "/index.do", method = RequestMethod.GET)
	public String memberOrderList(HttpSession session, Model model) {
		logger.info("테스트 로그인");

		return "index";
	}
	
}
