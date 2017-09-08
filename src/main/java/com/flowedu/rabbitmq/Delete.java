package com.flowedu.rabbitmq;


import com.rabbitmq.client.Channel;

/**
 * Created by jihoan on 2017. 9. 7..
 */
public class Delete {

    public static void main(String[] args) throws Exception {
        RabbitmqClient rabbitmqClient = new RabbitmqClient();
        Channel channel = rabbitmqClient.getChannel();

        channel.queueDelete("hello_que");
    }
}
