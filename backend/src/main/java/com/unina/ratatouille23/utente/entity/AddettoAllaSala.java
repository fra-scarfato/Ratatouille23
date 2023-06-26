package com.unina.ratatouille23.utente.entity;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("Addetto alla sala")
public class AddettoAllaSala extends Utente{
    
    public AddettoAllaSala() {
    }

}
