package com.mealmaker.babiyo.order.service;

import java.util.List;

import com.mealmaker.babiyo.order.model.OrderDto;

public interface OrderService {
	
	public List<OrderDto> selectId();

	public void order(OrderDto orderDto);
	
}
