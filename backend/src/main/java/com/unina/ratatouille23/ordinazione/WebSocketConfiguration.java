package com.unina.ratatouille23.ordinazione;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfiguration implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        //Endpoint su cui si iscrivono i client e sono in ascolto dopo la connessione
        config.enableSimpleBroker("/ws/order");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        //Endpoint su cui i client si connettono (Prima connessione)
        registry.addEndpoint("/ws").setAllowedOrigins("*");
    }


}
