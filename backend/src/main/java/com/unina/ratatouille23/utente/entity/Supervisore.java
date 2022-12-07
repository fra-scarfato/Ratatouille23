package com.unina.ratatouille23.utente.entity;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("Supervisore")
public class Supervisore extends Utente{
    
    public Supervisore() {
    }

}
