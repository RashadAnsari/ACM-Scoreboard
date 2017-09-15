<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="calculateAndData.TeamInformation"%>
<%@page import="calculateAndData.Problem"%>
<%@page import="calculateAndData.Data"%>
<%@page import="calculateAndData.ReadScoreBoard"%>
<%@page import="java.util.*"%>
<html>
    <!DOCTYPE html>
    <head>
        <%
            int teamID = -1;
            try {
                teamID = Integer.parseInt(request.getParameter("teamID"));
            } catch (Exception e) {
            }
            ReadScoreBoard read = new ReadScoreBoard();
            String json = read.readjsonString();
            TeamInformation scoreboard[] = read.getScoreboard(json);
        %>
        <title>ACM-ICPC Scoreboard</title>
        <link href="css/ScoreboardStyle.css" rel="stylesheet">
        <link rel="shortcut icon" href="img/acm.png" type="image/x-icon" />
        <script src="js/ajax.js" type="text/javascript"></script>
    </head>
    <body onload="init()">
        <header>
            <div style="position: absolute; top: 20;left: 20">
                <img src="img/acm2.png" width="190" height="120"/>
            </div>
            <h1 class="centertext">
                ACM ICPC Programming Contest
            </h1>
            <h2 class="centertext">
                Kharazmi University of Tehran, Iran
            </h2>
            <%
                Date date = new Date();
                out.println("<h4 class=\"centertext\">" + date.toString() + "</h4>");
            %>
            <div style="position: absolute; top: 20; right: 20">
                <img src="img/logo.PNG" width="120" height="120"/>
            </div>

        </header>
    <center>
        <table>
            <tr>
                <%
                    Data problems = new Data();
                %>
                <td class="tabletitle boldtext" rowspan="2">Rank</td>
                <td class="tabletitle boldtext teamnamecell" rowspan="2">Team name</td>
                <td class="tabletitle boldtext" rowspan="2">Solved</td>
                <td class="tabletitle boldtext" rowspan="2">Time</td>
                <%
                    out.println("<td class=\"tabletitle boldtext\" rowspan=\"1\" colspan=\"" + Data.pNumber + "\">Questions</td>");
                %>
                <td class="tabletitle boldtext" rowspan="2">Attm<br>Solv</td>
                    <%
                        out.println("<tr>");
                        for (int i = 0; i < Data.pNumber; i++) {
                            char c = (char) (65 + i);
                            out.println("<td><span class=\"balloon color-" + String.valueOf(c) + "\">" + String.valueOf(c) + "</span></td>");
                        }
                        out.println("</tr>");
                    %>
            </tr>
            <%
                for (int i = 0; i < scoreboard.length; i++) {
                    out.println("<tr>");
                    if (scoreboard[i].id == teamID) {
                        out.println("<td class=\"myrank\">" + scoreboard[i].rank + "</td>");
                        out.println("<td class=\"myrank\">" + scoreboard[i].name + "</td>");
                        out.println("<td class=\"myrank\">" + scoreboard[i].solved + "</td>");
                        out.println("<td class=\"myrank\">" + scoreboard[i].totalTime + "</td>");
                    } else {
                        if (i % 2 != 0) {
                            out.println("<td class=\"rowcolor\">" + scoreboard[i].rank + "</td>");
                            out.println("<td class=\"rowcolor\">" + scoreboard[i].name + "</td>");
                            out.println("<td class=\"rowcolor\">" + scoreboard[i].solved + "</td>");
                            out.println("<td class=\"rowcolor\">" + scoreboard[i].totalTime + "</td>");
                        } else {
                            out.println("<td>" + scoreboard[i].rank + "</td>");
                            out.println("<td>" + scoreboard[i].name + "</td>");
                            out.println("<td>" + scoreboard[i].solved + "</td>");
                            out.println("<td>" + scoreboard[i].totalTime + "</td>");
                        }
                    }
                    for (int j = 0; j < Data.pNumber; j++) {
                        if (scoreboard[i].problems[j].accept) {
                            if (scoreboard[i].problems[j].first) {
                                out.println("<td class=\"firstaccept\">" + scoreboard[i].problems[j].tryNumber + "<br>" + scoreboard[i].problems[j].time + "</td>");
                            } else {
                                out.println("<td class=\"accepted\">" + scoreboard[i].problems[j].tryNumber + "<br>" + scoreboard[i].problems[j].time + "</td>");
                            }
                        } else if (!scoreboard[i].problems[j].accept && scoreboard[i].problems[j].tryNumber > 0) {
                            out.println("<td class=\"wrong\">" + scoreboard[i].problems[j].tryNumber + "<br>" + "..." + "</td>");
                        } else {
                            if (scoreboard[i].id == teamID) {
                                out.println("<td class=\"myrank\">...</td>");
                            } else {
                                if (i % 2 != 0) {
                                    out.println("<td class=\"rowcolor\">...</td>");
                                } else {
                                    out.println("<td>...</td>");
                                }
                            }
                        }
                    }
                    if (scoreboard[i].id == teamID) {
                        out.println("<td class=\"myrank\">" + scoreboard[i].getAllSubmited() + "<br>" + scoreboard[i].solved + "</td>");
                    } else {
                        if (i % 2 != 0) {
                            out.println("<td class=\"rowcolor\">" + scoreboard[i].getAllSubmited() + "<br>" + scoreboard[i].solved + "</td>");
                        } else {
                            out.println("<td>" + scoreboard[i].getAllSubmited() + "<br>" + scoreboard[i].solved + "</td>");
                        }
                    }
                    out.println("</tr>");
                }
            %>
        </table>
    </center>
</body>
</html>
