package com.ruddy.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.ruddy.model.Transaction;

@RestController
public class SettlementController {

    @PostMapping("/api/settlement")
    public Transaction processSettlement(@RequestBody Transaction transaction) {
        // Simulation d'un traitement bancaire
        System.out.println("Traitement du règlement pour la transaction : " + transaction.getAmount());
        
        // On met à jour le statut final
        transaction.setStatus("SETTLED"); 
        
        return transaction;
    }
}
