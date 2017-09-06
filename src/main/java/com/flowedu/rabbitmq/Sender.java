package com.flowedu.rabbitmq;

import com.rabbitmq.client.Channel;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by jihoan on 2017. 9. 4..
 */
public class Sender {
    public final static String QUEUE_NAME = "hello_que2";

    public static void main(String[] argv) throws IOException, Exception {
        RabbitmqClient client = new RabbitmqClient();
        Channel channel = client.getChannel();

        channel.queueDeclare(QUEUE_NAME, true, false, false, null);

        // create messages.
        /*
        List<Message> messages = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            messages.add(new Message(QUEUE_NAME, "Hello World! " + i));
        }

        System.out.println("ready to send.");
        for (Message m : messages) {
            channel.basicPublish(m.exchange, m.routingKey, null,
                    m.body.getBytes());
            System.out.println(" [x] Sent " + m.toString());
        }
        */
        String message = "Hello World22";
        channel.basicPublish("", QUEUE_NAME, null, message.getBytes("UTF-8"));
        System.out.println(" [x] Sent '" + message + "'");

        client.close();

    }
}
