/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author fitahiana
 */
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.Timer;
import java.util.TimerTask;

@WebListener
public class NotificationContextListener implements ServletContextListener {

    private Timer timer;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        timer = new Timer(true); // Timer en mode daemon
        timer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                NotificationRetardataires.main(null);
            }
        }, 0, 60000); // Exécute toutes les 60 secondes (60000 millisecondes)
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (timer != null) {
            timer.cancel();
        }
    }
}
