package com.flowedu.rabbitmq;

import com.rabbitmq.client.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;

/**
 * Created by jihoan on 2017. 9. 5..
 */
public class Receive {

    public static void main(String[] args) throws Exception {
        RabbitmqClient rabbitmqClient = new RabbitmqClient();
        Channel channel = rabbitmqClient.getChannel();

        channel.queueDeclare(Sender.QUEUE_NAME, true, false, false, null);
        System.out.println(" [*] Waiting for messages. To exit press CTRL+C");

        Consumer consumer = new DefaultConsumer(channel) {
            public void handleDelivery(String consumerTag, Envelope envelope, AMQP.BasicProperties properties, byte[] body) throws IOException {
                String message = new String(body, "UTF-8");
                System.out.println(" [x] Received '" + message + "'");
            }
        };
        channel.basicConsume(Sender.QUEUE_NAME, true, consumer);
    }
}
