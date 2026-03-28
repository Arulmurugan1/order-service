package com.order.scm.order_service.service;

import com.order.scm.order_service.dao.OrderEntity;
import com.order.scm.order_service.dto.OrderDTO;
import com.order.scm.order_service.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Order Service Implementation backed by JPA repository
 */
@Service
public class OrderService implements IOrderService {

    @Autowired
    private OrderRepository orderRepository;

    private OrderDTO mapToDto(OrderEntity entity) {
        if (entity == null) return null;
        OrderDTO dto = new OrderDTO();
        dto.setId(entity.getId());
        dto.setOrderNumber(entity.getOrderNumber());
        dto.setCustomerName(entity.getCustomerName());
        dto.setStatus(entity.getStatus());
        dto.setTotalAmount(entity.getTotalAmount());
        dto.setCreatedAt(entity.getCreatedAt());
        dto.setUpdatedAt(entity.getUpdatedAt());
        return dto;
    }

    private OrderEntity mapToEntity(OrderDTO dto) {
        if (dto == null) return null;
        OrderEntity entity = new OrderEntity();
        entity.setId(dto.getId());
        entity.setOrderNumber(dto.getOrderNumber());
        entity.setCustomerName(dto.getCustomerName());
        entity.setStatus(dto.getStatus());
        entity.setTotalAmount(dto.getTotalAmount());
        entity.setCreatedAt(dto.getCreatedAt());
        entity.setUpdatedAt(dto.getUpdatedAt());
        return entity;
    }

    @Override
    public List<OrderDTO> getAllOrders() {
        return orderRepository.findAll().stream().map(this::mapToDto).collect(Collectors.toList());
    }

    @Override
    public OrderDTO getOrderById(Long id) {
        return orderRepository.findById(id).map(this::mapToDto).orElse(null);
    }

    @Override
    public OrderDTO createOrder(OrderDTO orderDTO) {
        if (orderDTO == null) {
            throw new IllegalArgumentException("Order payload is required");
        }

        if (orderDTO.getOrderNumber() == null || orderDTO.getOrderNumber().trim().isEmpty()) {
            throw new IllegalArgumentException("Order number is required");
        }

        if (orderDTO.getCustomerName() == null || orderDTO.getCustomerName().trim().isEmpty()) {
            throw new IllegalArgumentException("Customer name is required");
        }

        orderDTO.setOrderNumber(orderDTO.getOrderNumber().trim());
        orderDTO.setCustomerName(orderDTO.getCustomerName().trim());

        if (orderDTO.getStatus() == null || orderDTO.getStatus().trim().isEmpty()) {
            orderDTO.setStatus("PENDING");
        } else {
            orderDTO.setStatus(orderDTO.getStatus().trim());
        }

        orderDTO.setCreatedAt(LocalDateTime.now());
        orderDTO.setUpdatedAt(LocalDateTime.now());

        OrderEntity entity = mapToEntity(orderDTO);
        OrderEntity saved = orderRepository.save(entity);
        return mapToDto(saved);
    }

    @Override
    public OrderDTO updateOrder(Long id, OrderDTO orderDTO) {
        if (orderDTO == null) {
            throw new IllegalArgumentException("Order payload is required");
        }

        return orderRepository.findById(id).map(existing -> {
            if (orderDTO.getOrderNumber() != null && !orderDTO.getOrderNumber().trim().isEmpty()) {
                existing.setOrderNumber(orderDTO.getOrderNumber().trim());
            }
            if (orderDTO.getCustomerName() != null && !orderDTO.getCustomerName().trim().isEmpty()) {
                existing.setCustomerName(orderDTO.getCustomerName().trim());
            }
            if (orderDTO.getStatus() != null && !orderDTO.getStatus().trim().isEmpty()) {
                existing.setStatus(orderDTO.getStatus().trim());
            }
            if (orderDTO.getTotalAmount() != null) {
                existing.setTotalAmount(orderDTO.getTotalAmount());
            }
            existing.setUpdatedAt(LocalDateTime.now());
            return mapToDto(orderRepository.save(existing));
        }).orElse(null);
    }

    @Override
    public boolean deleteOrder(Long id) {
        if (orderRepository.existsById(id)) {
            orderRepository.deleteById(id);
            return true;
        }
        return false;
    }
}

