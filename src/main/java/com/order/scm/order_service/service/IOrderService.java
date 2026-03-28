package com.order.scm.order_service.service;

import com.order.scm.order_service.dto.OrderDTO;
import java.util.List;

/**
 * Order Service Interface
 * Defines CRUD operations for orders
 */
public interface IOrderService {
    
    /**
     * Get all orders
     */
    List<OrderDTO> getAllOrders();
    
    /**
     * Get order by ID
     */
    OrderDTO getOrderById(Long id);
    
    /**
     * Create a new order
     */
    OrderDTO createOrder(OrderDTO orderDTO);
    
    /**
     * Update an order
     */
    OrderDTO updateOrder(Long id, OrderDTO orderDTO);
    
    /**
     * Delete an order
     */
    boolean deleteOrder(Long id);
}
