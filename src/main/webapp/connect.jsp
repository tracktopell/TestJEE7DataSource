<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TEST DATASOURCE</title>
<%        
    
        Logger LOGGER = Logger.getLogger(this.getClass().getName());        
        
        LOGGER.info("-------------------------connect.jsp-------------------------------");
        String appendPrefixCompEnv = request.getParameter("appendPrefixCompEnv");
		String jndi = request.getParameter("jndi");
		String query = request.getParameter("query");
		Connection connection = null;
		Statement st = null;
		ResultSet rs = null;
		int updateCount = -1;
		try {
            LOGGER.info("->appendPrefixCompEnv="+appendPrefixCompEnv);
            LOGGER.info("->jndi="+jndi);
            LOGGER.info("->query="+query);
            //==================================================================
			InitialContext context = new InitialContext();
            
            LOGGER.info("=>InitialContext:"+context);
            
			Context    envContext = null;
			DataSource dataSource = null;
			
			if(!jndi.startsWith("java:/comp/env") && (appendPrefixCompEnv!=null && appendPrefixCompEnv.equals("true"))){
                
                LOGGER.info("=>context.lookup: java:/comp/env");                
				envContext = (Context) context.lookup("java:/comp/env");
                LOGGER.info("=>context.lookup: "+jndi);
				dataSource = (DataSource) envContext.lookup(jndi);			
			} else {
                LOGGER.info("=.=>context.lookup: "+jndi);
				dataSource = (DataSource) context.lookup(jndi);
			}
            LOGGER.info("=> open Connection.");
			connection = dataSource.getConnection();
            LOGGER.info("=> Prepare statement.");
			st = connection.createStatement();
			boolean typeResult = false;
			if (query != null && connection != null) {
                LOGGER.info("=> Execute:");
				typeResult = st.execute(query);
				if (typeResult) {
                    LOGGER.info("=> Get Result set:");
					rs = st.getResultSet();
				} else {
                    LOGGER.info("=> Get Update count:");
					updateCount = st.getUpdateCount();
                    LOGGER.info("=> Update count:"+updateCount);
				}
			}
		} catch (NamingException e) {			
            LOGGER.log(Level.SEVERE,"NamingException:",e);
		} catch (SQLException e) {
			LOGGER.log(Level.SEVERE,"SQLException:",e);
		}
%>
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
        <h1>RESULT:</h1>
		<div>
			connection = <%=connection%>
		</div>
<%
    if(connection != null){
%>        
		<form action="connect.jsp">
			<input type="hidden" name="jndi" value="<%=jndi%>"/>
			<table>
<%
	if(query != null){
%>	
				<tr>
					<td>PREVIOUS SQL:</td>
					<td>
						<textarea style="font-family: monospace; font-size: smaller;" 
								  name="prev_query"  rows="10" cols="80"><%=query%></textarea>
					</td>
				</tr>
<%
	}
%>
				<tr>
					<td>SQL:</td>
					<td>
						<textarea style="font-family: monospace; font-size: smaller;" name="query"  rows="10" cols="80"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="EXECUTE"/></td>					
				</tr>
			</table>			
		</form>
<%
        if(updateCount>0){
%>
			
			UPDATE COUNT=<%=updateCount%>
<%		
        } else if(rs != null){
%>
			<table style="width: 100;">
				<tr style="background: darkcyan;">
<%		
            ResultSetMetaData rsMD = rs.getMetaData();
            int nc = rsMD.getColumnCount();
            String label="-";
            for (int ic=1;ic<=nc;ic++){
                label = rsMD.getColumnLabel(ic);
%>
					<td><%=label%></td>
<%
            }
%>
				</tr>
<%		
            int rowCount=0;
            for(rowCount=0;rs.next();rowCount++){
%>
				<tr>
<%
                String value="";
                for (int ic=1;ic<=nc;ic++){
                    Object objCol = rs.getObject(ic);
                    value = objCol==null?"NULL":objCol.toString();
%>
					<td><%=value%></td>
<%		
                }
%>
				</tr>
<%
        	}				
%>
			</table>
<%	
            LOGGER.info("=> Rows:"+rowCount);
        }
        if( rs != null){
            rs.close();
        }
        if(st != null){
            st.close();
        }
        if(connection != null){
            connection.close();
            LOGGER.info("=> Connection closed.");
        }
    }
%>		
    </body>
</html>
