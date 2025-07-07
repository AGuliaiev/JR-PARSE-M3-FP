<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Лісовий квест</title>
    <link rel="stylesheet" href="<c:url value='/css/main-style.css' />">
    <link rel="stylesheet" href="<c:url value='/css/quest-style.css' />">
</head>
<body>
<div class="player-stats">
    <strong>${sessionScope.player.playerName}</strong><br>
    Здоров'я (HP): ${playerHp}
    <div class="hp-bar-container">
        <div class="hp-bar" style="width: ${playerHp}%;"></div>
    </div>
</div>

<div class="quest-container">
    <c:if test="${not empty currentStep.imageUrl}">
        <c:url var="questImageUrl" value="${currentStep.imageUrl}"/>
        <img class="quest-image" src="${questImageUrl}" alt="Иллюстрация квеста">
    </c:if>

    <p class="quest-text">${currentStep.text}</p>

    <hr style="border-color: #444;">

    <c:choose>
        <c:when test="${currentStep.terminal}">
            <div class="final-screen">
                <c:choose>
                    <c:when test="${currentStep.win}">
                        <h2>ПЕРЕМОГА!</h2>
                    </c:when>
                    <c:when test="${playerHp <= 0}">
                        <h2 style="color: #d9534f;">ТИ ПРОГРАВ!</h2>
                    </c:when>
                    <c:otherwise>
                        <h2>Гру завершено!</h2>
                    </c:otherwise>
                </c:choose>
                <form method="post" action="<c:url value='/game' />" style="margin-top: 20px;">
                    <button type="submit" name="restart" value="true" class="game-button">Зіграти ще</button>
                </form>
                <a href="<c:url value='/selectGame' />" class="logout-link" style="font-size: 18px;">Вибрати іншу
                    гру</a>
            </div>
        </c:when>

        <c:otherwise>
            <form method="post" action="<c:url value='/game' />" class="quest-options">
                <c:forEach var="option" items="${currentStep.options}" varStatus="loop">
                    <button type="submit" name="optionIndex" value="${loop.index}">${option.text}</button>
                </c:forEach>
            </form>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>