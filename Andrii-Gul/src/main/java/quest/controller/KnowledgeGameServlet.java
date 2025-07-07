package quest.controller;

import quest.model.Continent;
import quest.model.Player;
import quest.model.Question;
import quest.model.QuestionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/game-knowledge")
public class KnowledgeGameServlet extends HttpServlet {

    private static final int EASY_LEVEL_QUESTIONS = 5;
    private static final int MEDIUM_LEVEL_QUESTIONS = 10;
    private static final int HARD_LEVEL_QUESTIONS = 15;
    private static final int POINTS_PER_QUESTION = 10;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("player") == null) {
            resp.sendRedirect(req.getContextPath() + "/welcome");
            return;
        }

        if (req.getParameter("continent") != null) {
            startNewGame(req, resp);
            return;
        }

        continueOrFinishGame(req, resp);
    }

    private void startNewGame(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        try {
            String continentStr = req.getParameter("continent");
            String country = req.getParameter("country");
            String level = req.getParameter("level");

            int questionsToGenerate = switch (level) {
                case "medium" -> MEDIUM_LEVEL_QUESTIONS;
                case "hard" -> HARD_LEVEL_QUESTIONS;
                default -> EASY_LEVEL_QUESTIONS;
            };

            Continent continent = Continent.fromString(continentStr);
            List<Question> questions = QuestionFactory.generateQuestions(continent, country, questionsToGenerate);

            String bgClassName = "bg-" + continent.name().toLowerCase().replace(" ", "");
            session.setAttribute("backgroundClass", bgClassName);

            if (questions.isEmpty()) {
                req.setAttribute("error", "Вибачте, до цього регіону поки немає запитань.");
                getServletContext().getRequestDispatcher("/knowledgeStart.jsp").forward(req, resp);
                return;
            }

            session.setAttribute("knowledgeQuestions", questions);
            session.setAttribute("knowledgeStep", 0);
            session.setAttribute("incorrectAnswers", new ArrayList<Question>());

            resp.sendRedirect(req.getContextPath() + "/game-knowledge");

        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            getServletContext().getRequestDispatcher("/knowledgeStart.jsp").forward(req, resp);
        }
    }

    private void continueOrFinishGame(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<Question> questions = (List<Question>) session.getAttribute("knowledgeQuestions");
        Integer step = (Integer) session.getAttribute("knowledgeStep");

        if (questions == null || step == null) {
            resp.sendRedirect(req.getContextPath() + "/knowledge-quiz");
            return;
        }

        if (step >= questions.size()) {
            Player player = (Player) session.getAttribute("player");
            player.incrementGamesPlayed();
            req.setAttribute("incorrectQuestions", session.getAttribute("incorrectAnswers"));
            getServletContext().getRequestDispatcher("/knowledge-result.jsp").forward(req, resp);
            return;
        }

        Question currentQuestion = questions.get(step);
        req.setAttribute("currentQuestion", currentQuestion);
        req.setAttribute("step", step);
        req.setAttribute("totalSteps", questions.size());

        getServletContext().getRequestDispatcher("/knowledge-quiz-step.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        Player player = (Player) session.getAttribute("player");
        List<Question> questions = (List<Question>) session.getAttribute("knowledgeQuestions");
        Integer step = (Integer) session.getAttribute("knowledgeStep");
        List<Question> incorrectAnswers = (List<Question>) session.getAttribute("incorrectAnswers");

        if (player == null || questions == null || step == null || incorrectAnswers == null || step >= questions.size()) {
            resp.sendRedirect(req.getContextPath() + "/welcome");
            return;
        }

        Question answeredQuestion = questions.get(step);
        String[] selectedAnswers = req.getParameterValues("q" + answeredQuestion.getId());

        if (answeredQuestion.isCorrect(selectedAnswers)) {
            player.addScore(POINTS_PER_QUESTION);
        } else {
            incorrectAnswers.add(answeredQuestion);
        }

        session.setAttribute("knowledgeStep", step + 1);
        resp.sendRedirect(req.getContextPath() + "/game-knowledge");
    }
}