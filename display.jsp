<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Display User Information</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>

    <h2 style="text-align:center">Submitted User Information</h2><br>
    <table border="1px">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Age</th>
        </tr>
        <%
            String url = "jdbc:mysql://localhost:3306/srp";
            String user = "root";
            String password = "root";
            String driver = "com.mysql.cj.jdbc.Driver";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName(driver);
                conn = DriverManager.getConnection(url, user, password);
                stmt = conn.createStatement();
                String sql = "SELECT * FROM xyz";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getInt("age") %></td>
                    </tr>
              <%
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>
    </div>
</body>
</html>