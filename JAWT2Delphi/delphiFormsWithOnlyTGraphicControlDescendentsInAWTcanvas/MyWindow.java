import java.awt.*;
import javax.swing.*;

public class MyWindow extends Canvas {
	static {
		// Load the library that contains the paint code.
		System.loadLibrary("MyWindow");
	}
	
	// native entry point for Painting
	public native void paint(Graphics g);

	public static void main( String[] argv ){
		Frame f = new Frame();
		f.setSize(300,400);

		JWindow w = new JWindow(f);
		w.setBackground(new Color(0,0,0,255));
		w.getContentPane().setBackground(new Color(0,0,0,255));

            w.getContentPane().setLayout(null);

            w.getContentPane().add(new JButton());

            MyWindow wb;
		w.getContentPane().add(wb=new MyWindow());

            w.getContentPane().add(new JButton());

		w.setBounds(300,300,300,300);
		w.setVisible(true);
            
           wb.repaint();

 }
}
