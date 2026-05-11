<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") != null) {
        if ("admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("admin.jsp");
        } else {
            response.sendRedirect("books.jsp");
        }
    } else {
        response.sendRedirect("login.jsp");
    }
%>
