<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Результаты викторины</title>
    <link rel="stylesheet" href="<c:url value='/css/main-style.css' />">
    <link rel="stylesheet" href="<c:url value='/css/knowledge-quiz-style.css' />">
</head>
<body class="${not empty sessionScope.backgroundClass ? sessionScope.backgroundClass : 'bg-default'}">

<div class="game-select-container">
    <h2>Вікторина завершена!</h2>
    <p>Гравець: <b>${sessionScope.player.playerName}</b></p>
    <hr style="border-color: #444;">
    <h3>Загальна статистика:</h3>
    <p>Всього очків за всі ігри: <b>${sessionScope.player.score}</b></p>
    <p>Всього ігор зіграно: <b>${sessionScope.player.gamesPlayed}</b></p>

    <c:if test="${not empty requestScope.incorrectQuestions}">
        <div class="errors-container">
            <h3>Робота над помилками:</h3>
            <c:forEach var="q" items="${requestScope.incorrectQuestions}">
                <div class="error-question">
                    <p class="question-text">${q.text}</p>
                    <p>Правильна відповідь:
                        <span class="correct-answer">
                            <c:forEach var="answer" items="${q.correctAnswers}" varStatus="loop">
                                ${answer}${!loop.last ? ', ' : ''}
                            </c:forEach>
                        </span>
                    </p>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <div style="margin-top: 30px;">
        <a href="<c:url value='/knowledge-quiz' />" class="logout-link">Зіграти ще раз</a><br><br>
        <a href="<c:url value='/selectGame' />" class="logout-link">Вибрати іншу игру</a><br><br>
        <a href="<c:url value='/logout' />" class="logout-link">Почати з іншим гравцем</a>
    </div>
</div>
</body>
</html>