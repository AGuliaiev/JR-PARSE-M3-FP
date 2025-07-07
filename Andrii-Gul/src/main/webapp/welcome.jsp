<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Ласкаво просимо до квесту</title>
    <link rel="stylesheet" href="<c:url value='/css/main-style.css' />">
</head>
<body>
<div class="header">
    <h1>Привіт, мандрівнику!</h1>
    <h2>Твої пригоди починаються тут. Обери свій шлях і нехай він приведе тебе до перемоги!</h2>

    <form method="post" action="<c:url value='/welcome' />">
        <label for="playerName">Назви себе, щоб я міг вести лік твоїм подвигам:</label>
        <input type="text" id="playerName" name="playerName" required placeholder="Твоє ім'я">
        <button type="submit">Почати пригоду</button>
    </form>
</div>
</body>
</html>
