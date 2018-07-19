<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt'%>

<fmt:setBundle basename="messages/msgs"/>

<fmt:message key="security_domain_realm" var="security_domain_realm" />
<fmt:message key="jta_data_source"       var="jta_data_source" />
<fmt:message key="environment_stage"     var="environment_stage" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TEST DATASOURCE</title>
		<style type="text/css">
			table {
			border-collapse: collapse;
			}

			table, th, td {
				border: 1px solid black;
			}
		</style>
    </head>
	
    <body>
        <h1>DATASOURCE PARAMS</h1>
		<h2>security_domain_realm=[${security_domain_realm}]</h2>
		<h2>jta_data_source=[${security_domain_realm}]</h2>
		<h2>environment_stage=[${environment_stage}]</h2>

		<h2><a href="portal/home.jsp">portal/home.jsp</a></h2>
		
		<form action="connect.jsp">
			<table>
				<tr>
                    <td>JNDI:</td>                    
                    <td>[java:comp/env<input type="checkbox" name="appendPrefixCompEnv" value="true"/>]<input name="jndi" type="text" size="35"/></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="CONNECT"/></td>					
				</tr>
			</table>
		</form>
    </body>
</html>
