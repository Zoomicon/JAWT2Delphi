import java.awt.*;
import javax.swing.*;

public class MyWindow extends Canvas
{

	static {
		// Load the library that contains the paint code.
		System.loadLibrary("MyWindow");
	}

	// native entry point for Painting
	public native void paint(Graphics g);

	public static void main( String[] argv ){
		JFrame f = new JFrame();
		f.setSize(300,400);
 
            Container w=f.getContentPane();

		w.setBackground(new Color(0,100,0,255));
            w.setLayout(null);

            JPanel p;
		w.add(p=new JPanel());

            p.add(new JButton("test")); //the first added will show on topr
            p.setBounds(10,10,50,50);

            MyWindow wb;
            p.add(wb=new MyWindow());
            //wb.setBounds(0,0,0,0); //invisible canvas, use just to get its hwnd and find its parent hwnd
            //wb.setVisible(false);
            wb.setBounds(0,0,200,200);

		f.setVisible(true);

            wb.paint(null); //force call of native paint method (to add the form inside the parent window) since canvas has zero size and is invisible
	}
}
