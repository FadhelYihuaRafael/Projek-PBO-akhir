<%-- 
    Document   : login
    Created on : 22 Dec 2025, 08.55.23
    Author     : fadhe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page | Modern UI</title>
        <style>
            /* Mengatur latar belakang halaman */
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                height: 100vh;
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            /* Kotak Login */
            .login-container {
                background-color: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.2);
                width: 350px;
                text-align: center;
            }

            .login-container h2 {
                margin-bottom: 25px;
                color: #333;
            }

            /* Desain Input Field */
            .input-group {
                margin-bottom: 20px;
                text-align: left;
            }

            .input-group label {
                display: block;
                margin-bottom: 5px;
                color: #666;
                font-size: 14px;
            }

            .input-group input {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-sizing: border-box; /* Agar padding tidak merusak lebar */
                outline: none;
                transition: border-color 0.3s;
            }

            .input-group input:focus {
                border-color: #764ba2;
            }

            /* Tombol Login */
            .btn-login {
                width: 100%;
                padding: 12px;
                background-color: #764ba2;
                border: none;
                border-radius: 5px;
                color: white;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: background 0.3s;
            }

            .btn-login:hover {
                background-color: #5a3782;
            }

            /* Pesan Error */
            .error-msg {
                color: #e74c3c;
                margin-bottom: 15px;
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <h2>Login</h2>

            <%-- Menampilkan pesan error jika login gagal --%>
            <% if (request.getParameter("error") != null) { %>
            <div class="error-msg">Username atau Password salah!</div>
            <% }%>

            <form action="LoginServlet" method="POST">
    <div class="input-group">
        <label>Username</label>
        <input type="text" name="user" required> </div>

    <div class="input-group">
        <label>Password</label>
        <input type="password" name="pass" required> </div>

    <div class="input-group">
        <label>Login Sebagai</label>
        <select name="role"> <option value="admin">Administrator</option>
            <option value="staff">Staff Karyawan</option>
        </select>
    </div>

    <button type="submit" class="btn-login">Masuk Sekarang</button>
</form>
