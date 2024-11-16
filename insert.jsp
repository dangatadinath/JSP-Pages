<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Insert User Information</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Insert User Information</h2>
    <%
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String ageStr = request.getParameter("age");

        // Validate inputs
        if (name == null || email == null || ageStr == null) {
            out.println("<p>Please fill out all fields.</p>");
            out.println("<a href='index.html'>Go back to form</a>");
            return;
        }

        int age;
        try {
            age = Integer.parseInt(ageStr);
        } catch (NumberFormatException e) {
            out.println("<p>Please enter a valid age.</p>");
            out.println("<a href='index.html'>Go back to form</a>");
            return;
        }

        String url = "jdbc:mysql://localhost:3306/srp";
        String user = "root";
        String password = "root";
        String driver = "com.mysql.cj.jdbc.Driver";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, user, password);
            String sql = "INSERT INTO xyz (name, email, age) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setInt(3, age);
            pstmt.executeUpdate();

            out.println("<p>Record inserted successfully!</p>");
            out.println("<a href='index.html'>Go back to form</a>");
        } catch (SQLException e) {
            out.println("<p>Database error: " + e.getMessage() + "</p>");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            // Close resources in the finally block to ensure they are closed even if an error occurs
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    out.println("<p>Error closing PreparedStatement: " + e.getMessage() + "</p>");
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    out.println("<p>Error closing Connection: " + e.getMessage() + "</p>");
                }
            }
        }
    %>
</body>
</html>
