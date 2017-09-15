package calculateAndData;

/**
 *
 * @author Rashad Ansari
 */
public class TeamInformation {

    public int id;
    public int rank;
    public int solved;
    public int totalTime;
    public String name;
    public Problem problems[] = new Problem[Data.pNumber];

    public TeamInformation() {
        for (int i = 0; i < problems.length; i++) {
            problems[i] = new Problem(0, false, 0, false);
        }
    }

    public int getAllSubmited() {
        int k = 0;
        for (int i = 0; i < problems.length; i++) {
            k += problems[i].tryNumber;
        }
        return k;
    }

}
