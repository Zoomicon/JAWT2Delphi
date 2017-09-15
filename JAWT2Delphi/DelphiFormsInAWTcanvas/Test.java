import java.awt.*;
import javax.swing.*;

public class Test extends Canvas {

  public Test(){
   add(new Button("tstbtn"));
   add(new Label("tstlbl"));
   Panel p=new Panel();
   add(p);
   p.add(new Button("b2"));
   p.add(new Panel());
   p.setBackground(Color.gray);
  }

	public static void main( String[] argv ){
		Frame f = new Frame();
		f.setSize(300,400);

		JWindow w = new JWindow(f);
		w.setBackground(new Color(0,0,0,255));
		w.getContentPane().setBackground(new Color(0,0,0,255));
            Test wb;
		w.getContentPane().add(wb=new Test());
		w.setBounds(300,300,300,300);
		w.setVisible(true);
	}
}
