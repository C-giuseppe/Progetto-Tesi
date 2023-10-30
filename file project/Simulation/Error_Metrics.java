import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.rmi.server.RMIServerSocketFactory;
import java.util.HashMap;
import java.util.Map;

public class Error_Metrics {
    public static void main(String[] args) {
        BufferedReader br = null; 
        Map<Integer, String> Ris_Accu = new HashMap<>(); 
        Map<Integer, String> Ris_App8 = new HashMap<>();
        Map<Integer, String> Ris_App5 = new HashMap<>();
        Path path = Paths.get("C:", "intelFPGA", "20.1", "tesi", "file project", "Simulation" ,"prova.txt");
        try{
            int g = 0, h = 0, i = 0;          
            br = Files.newBufferedReader(path);
            while(br.ready()){
                String l = "";
                String m = "";
                String n = "";
                String line = br.readLine();
                String[] split = line.split(" ");
                for(String s : split){
                    if(s.equals("Ris_accu:")){
                        l = split[1];
                    }else if(s.equals("Ris_app8:")){
                        m = split[1];
                    }else if(s.equals("Ris_app5:")){
                        n = split[1];
                    }else{
                        continue;
                    }                 
                }
                if(!l.isEmpty()){
                    Ris_Accu.put(g, l);
                    g++;
                }else if(!m.isEmpty()){
                    Ris_App8.put(h, m);
                    h++;
                }else if(!n.isEmpty()){
                    Ris_App5.put(i, n);
                    i++;
                }else{
                    continue;
                }   
            }
        }catch(IOException e){
            System.out.println("1f");
        }finally{
            if(br!= null){
                try{
                    br.close();
                }catch (IOException ex){
                    System.out.println("2");
                }
            }
        }

        //MED = Mean error distance
        int A = Ris_Accu.size();
        int ED8 = 0, ED5 = 0;
        for(int i = 0; i < A; i++){
            ED8 = ED8 + calculateEditDistance(Ris_Accu.get(i), Ris_App8.get(i));
            ED5 = ED5 + calculateEditDistance(Ris_Accu.get(i), Ris_App5.get(i));
        } 
        double MED8 = (double) ED8 / A;
        double MED5 = (double) ED5 / A;
        
        //NMED = normalized mean error distance
        int B = 16;
        double NMED8 = MED8 / Math.pow(2, B);
        double NMED5 = MED5 / Math.pow(2, B);
        //MRED =  mean relative error distance
        double RED8 = 0;
        double RED5 = 0 ;

        for(int i = 0; i < A; i++){
            ED8 = calculateEditDistance(Ris_Accu.get(i), Ris_App8.get(i));
            double red = Math.abs(ED8/Double.parseDouble(Ris_Accu.get(i)));
            RED8 += red;

            ED5 = calculateEditDistance(Ris_Accu.get(i), Ris_App5.get(i));
            double red1 = Math.abs(ED5/Double.parseDouble(Ris_Accu.get(i)));
            RED5 += red1;
        } 

        double MRED8 = RED8 / A;
        double MRED5 = RED5 / A;

        System.out.println("MED8 = " + MED8);
        System.out.println("NMED8 = " + NMED8);
        System.out.println("MRED8 = " + MRED8);
        System.out.println();
        System.out.println("MED5 = " + MED5);
        System.out.println("NMED5 = " + NMED5);
        System.out.println("MRED5 = " + MRED5);
    }

/*
To calculate
I am using the Levenshtein algorithm, which is used to calculate the minimum number of insertion, 
deletion, and substitution operations required to transform one string into another. In other words, 
it measures the 'distance' between two strings, indicating how similar or dissimilar they are."
*/
public static int calculateEditDistance(String s1, String s2) {
        int m = s1.length();
        int n = s2.length();
        
        int[][] dp = new int[m + 1][n + 1];
        
        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {
                if (i == 0) {
                    dp[i][j] = j;
                } else if (j == 0) {
                    dp[i][j] = i;
                } else if (s1.charAt(i - 1) == s2.charAt(j - 1)) { 
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = 1 + Math.min(dp[i - 1][j], Math.min(dp[i][j - 1], dp[i - 1][j - 1]));
                }                                   
            }
        }
        return dp[m][n]; 
    }
}

