package com.unina.ratatouille23.utente.entity;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("addetto alla sala")
public class AddettoAllaSala extends Utente{
    
    public AddettoAllaSala() {
    }

}
