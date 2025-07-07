<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Вибір гри</title>
  <link rel="stylesheet" href="<c:url value='/css/main-style.css' />">
</head>
<body>
<div class="game-select-container">
  <h2>Привіт, ${sessionScope.player.playerName}!</h2>
  <p>Обери, яке випробування чекає на тебе сьогодні:</p>

  <form method="post" action="<c:url value='/selectGame' />">
    <button type="submit" name="game" value="forest" class="game-button">Лісовий квест на удачу</button>
  </form>

  <form method="get" action="<c:url value='/knowledge-quiz' />">
    <button type="submit" class="game-button">Вікторина "Знавець світу"</button>
  </form>

  <hr style="border-color: #444; margin-top: 20px;">

  <a href="<c:url value='/logout' />" class="logout-link">Почати з новим гравцем</a>
</div>
</body>
</html>
