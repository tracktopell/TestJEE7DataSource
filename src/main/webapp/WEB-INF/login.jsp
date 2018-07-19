<%-- 
    Document   : login
    Created on : 18/07/2018, 05:24:56 PM
    Author     : Alfredo Estrada
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt'%>

<fmt:setBundle basename="messages/msgs"/>

<fmt:message key="security_domain_realm" var="security_domain_realm" />
<fmt:message key="jta_data_source"       var="jta_data_source" />
<fmt:message key="environment_stage"     var="environment_stage" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOGIN</title>
    </head>

	<h2>FORM BASED AUTHENTICATION</h2>
	
	<h2>security_domain_realm=[${security_domain_realm}]</h2>
	<h2>jta_data_source=[${security_domain_realm}]</h2>
	<h2>environment_stage=[${environment_stage}]</h2>

	<br><br>
<%
	String e=request.getParameter("e");
	if(e!=null && e.equals("a")){
%>	
	<h2>AUTHENTICATION ERROR</h2>
<%	}
%>
	<form action="j_security_check" method=post>
		<p><strong>j_username: </strong>
			<input type="text" name="j_username" size="25">
		<p><p><strong>j_password: </strong>
			<input type="password" size="15" name="j_password">
		<p><p>
			<input type="submit" value="Submit">
			<input type="reset" value="Reset">
	</form>
</html>