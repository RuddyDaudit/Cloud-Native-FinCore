package com.ruddy.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.ruddy.model.Transaction;

@RestController
public class ValidationController {

    @PostMapping("/api/validation")
    Transaction validate(@RequestBody Transaction transaction){
        if(transaction.getAmount() > 1000){
            transaction.setStatus("REJECTED");
        }
        else{
            transaction.setStatus("VALIDATED");
        }
        return transaction;
    }
}
