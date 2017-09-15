package calculateAndData;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Comparator;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author Rashad Ansari
 */
public class ReadScoreBoard {

    public TeamInformation[] getScoreboard(String json) {
        try {
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(json);
            JSONArray array = (JSONArray) obj;
            TeamInformation scoreboard[] = new TeamInformation[array.size()];
            for (int i = 0; i < array.size(); i++) {
                try {
                    JSONObject obj2 = (JSONObject) array.get(i);
                    scoreboard[i] = new TeamInformation();
                    scoreboard[i].id = Integer.parseInt(String.valueOf(obj2.get("id")));
                    scoreboard[i].rank = Integer.parseInt(String.valueOf(obj2.get("rank")));
                    scoreboard[i].totalTime = Integer.parseInt(String.valueOf(obj2.get("points")));
                    scoreboard[i].solved = Integer.parseInt(String.valueOf(obj2.get("solved")));
                    scoreboard[i].name = String.valueOf(obj2.get("name"));
                    for (int j = 0; j < Data.pNumber; j++) {
                        char c = (char) (65 + j);
                        String cs = String.valueOf(c);
                        JSONObject obj3 = (JSONObject) obj2.get(cs);
                        if (obj3 != null) {
                            boolean access = false;
                            boolean first = false;
                            if (String.valueOf(obj3.get("s")).equals("first") || String.valueOf(obj3.get("s")).equals("solved")) {
                                access = true;
                            }
                            if (String.valueOf(obj3.get("s")).equals("first")) {
                                first = true;
                            }
                            int time = 0;
                            try {
                                time = Integer.parseInt(String.valueOf(obj3.get("t")));
                            } catch (Exception e) {
                            }
                            scoreboard[i].problems[j] = new Problem(Integer.parseInt(String.valueOf(obj3.get("a"))), access, time, first);
                        } else {
                            scoreboard[i].problems[j] = new Problem(0, false, 0, false);
                        }
                    }
                } catch (Exception e) {
                }
            }
            Arrays.sort(scoreboard, new Comparator<TeamInformation>() {
                @Override
                public int compare(TeamInformation a, TeamInformation b) {
                    return Integer.compare(a.rank, b.rank);
                }
            });
            return scoreboard;
        } catch (Exception e) {
            return null;
        }
    }

    public String readjsonString() {
        try {
            File f = new File(Data.jsonAddress);
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    new FileInputStream(f), "UTF8"));
            String line = "";
            String json = "";
            while ((line = br.readLine()) != null) {
                json += line;
            }
            br.close();
            return json;
        } catch (Exception e) {
            return "[]";
        }
    }

}
