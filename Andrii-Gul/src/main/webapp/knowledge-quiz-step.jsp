<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Вікторина: Знаток світу</title>
    <link rel="stylesheet" href="<c:url value='/css/main-style.css' />">
    <link rel="stylesheet" href="<c:url value='/css/knowledge-quiz-style.css' />">
</head>
<body class="${not empty sessionScope.backgroundClass ? sessionScope.backgroundClass : 'bg-default'}">

<c:if test="${not empty currentQuestion.imageUrl}">
    <c:url var="questionImageUrl" value="${currentQuestion.imageUrl}"/>
</c:if>

<div class="quiz-container"
     style="${not empty questionImageUrl ? 'background-image: url('.concat(questionImageUrl).concat(');') : ''}">

    <h2>Вопрос ${step} из ${totalSteps}</h2>
    <div class="progress-bar">
        <div class="progress" style="width: ${100 * (step) / totalSteps}%">${step} / ${totalSteps}</div>
    </div>

    <hr style="border-color: #444;">

    <form method="post" action="<c:url value='/game-knowledge' />" id="quizForm">
        <fieldset style="border: none; padding: 0;">
            <legend class="question-text">${currentQuestion.text}</legend>

            <div class="options">
                <c:forEach var="opt" items="${currentQuestion.options}">
                    <label>
                        <input type="checkbox" name="q${currentQuestion.id}" value="${opt}"> ${opt}
                    </label>
                </c:forEach>
            </div>
        </fieldset>

        <button type="submit" class="submit-button">Відповісти</button>
    </form>

</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const quizForm = document.getElementById('quizForm');

        quizForm.addEventListener('submit', function (event) {
            const checkedCheckboxes = quizForm.querySelectorAll('input[type="checkbox"]:checked');

            if (checkedCheckboxes.length === 0) {
                event.preventDefault();

                alert('Будь ласка, виберіть хоча б один варіант відповіді!');
            }
        });
    });
</script>

</body>
</html>