package scoreboardshortcutcreator;

import java.io.File;
import java.io.FileWriter;
import java.util.Scanner;

/**
 *
 * @author Rashad Ansari
 */
public class ScoreboardShortcutCreator {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter Number of team: ");
        int teamNumber = Integer.parseInt(sc.nextLine());
        System.out.print("Enter your server ip or domain: ");
        String ip = sc.nextLine();
        String address = "http://" + ip + ":8080";
        for (int i = 1; i <= teamNumber; i++) {
            String name = "Team " + i + " Scoreboard.url";
            String target = address + "?teamID=" + i;
            try {
                createInternetShortcut(name, target, "");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void createInternetShortcut(String name, String target, String icon)
            throws Exception {
        File thisJar = new File(scoreboardshortcutcreator.ScoreboardShortcutCreator.class.getProtectionDomain().getCodeSource().getLocation().toURI().getPath());
        File jarFile = new File(thisJar.toString().subSequence(0, thisJar.toString().lastIndexOf("\\")) + "");
        FileWriter fw = new FileWriter(new File(jarFile.toString() + "\\" + name));
        fw.write("[InternetShortcut]\n");
        fw.write("URL=" + target + "\n");
        if (!icon.equals("")) {
            fw.write("IconFile=" + icon + "\n");
        }
        fw.flush();
        fw.close();
    }
    
}
