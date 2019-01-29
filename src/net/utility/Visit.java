package net.utility;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.PrintWriter;
import java.net.URL;

public class Visit {

	private int visitCount;

	private String path;

	public Visit() {

		BufferedReader br = null;

		try {
			URL url = getClass().getResource("/");
			path = url.getPath().substring(1) + "counter.txt";

			br = new BufferedReader(new FileReader(path));
			String strCounter = br.readLine();
			visitCount = Integer.parseInt(strCounter);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {

			if (br != null) {
				try {
					br.close();
				} catch (Exception e) {
					;//error
				}
			}
			
		}
	}

	@Override

	protected void finalize() throws Throwable {
		setFile();
	}

	void setFile() {

		PrintWriter pw = null;

		try {
			pw = new PrintWriter(path);
			pw.println(visitCount);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			if (pw != null) {
				try {
					pw.close();
				} catch (Exception e) {
					;//error
				}
			}			
		}
	}
	

	public void ipCheck(String ip) {		// ip 확인 (방문자 확인용)
		System.out.print("방문자 IP Check중... ");
		System.out.println("IP: "+ip);
	} // ipCheck() end ////////////////////////////////////////////

	
	
	public void setCounter(int num) {
		visitCount++;
		setFile();
	}

	public int getCounter() {
		return visitCount;
	}

}
