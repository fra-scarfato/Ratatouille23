package com.unina.ratatouille23.utente.entity;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("addetto alla cucina")
public class AddettoAllaCucina extends Utente{
    
    public AddettoAllaCucina() {
    }

}
