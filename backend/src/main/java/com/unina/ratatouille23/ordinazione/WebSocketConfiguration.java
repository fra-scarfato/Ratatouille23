package com.unina.ratatouille23.ordinazione;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurationSupport;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfiguration extends WebSocketMessageBrokerConfigurationSupport {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        //Endpoint su cui sono in ascolto i client
        config.enableSimpleBroker("/order");
    }

    @Override
    protected void registerStompEndpoints(StompEndpointRegistry registry) {
        //Endpoint su cui i client si iscrivono
        registry.addEndpoint("/order/subscribe").withSockJS();
    }


}
