package com.mealmaker.babiyo.inquiry.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mealmaker.babiyo.order.service.OrderService;

// 어노테이션 드리븐
@Controller
public class InquiryAdminController {

	private static final Logger logger 
		= LoggerFactory.getLogger(InquiryAdminController.class);
	
//	@Autowired
//	private InquiryService inquiryService;
	
	@RequestMapping(value = "/inquiry/admin.do", method = RequestMethod.GET)
	public String adminInquiry(HttpSession session, Model model) {
		logger.info("Welcome OrderController login! ");
		
		return "inquiry/admin/adminInquiry";
	}
		
	@RequestMapping(value = "/inquiry/admin/write.do", method = RequestMethod.GET)
	public String adminWrite(HttpSession session, Model model) {
		logger.info("Welcome OrderController login! ");
		
		return "inquiry/admin/adminInquiryWrite";
	}
	
	@RequestMapping(value = "/inquiry/admin/update.do", method = RequestMethod.GET)
	public String adminUpdate(HttpSession session, Model model) {
		logger.info("Welcome OrderController login! ");
		
		return "inquiry/admin/adminInquiryUpdate";
	}
	
}
