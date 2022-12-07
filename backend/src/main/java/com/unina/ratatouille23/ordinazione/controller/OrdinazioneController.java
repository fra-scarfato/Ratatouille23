package com.unina.ratatouille23.ordinazione.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.unina.ratatouille23.ordinazione.services.OrdinazioneService;


@RestController
@RequestMapping("/order")
public class OrdinazioneController {
    @Autowired
    private OrdinazioneService servizioOrdinazioni;

    
}
