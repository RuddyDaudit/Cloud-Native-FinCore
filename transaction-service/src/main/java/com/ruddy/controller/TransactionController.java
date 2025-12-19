package com.ruddy.controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.ruddy.model.Transaction;


@RestController
public class TransactionController {

    @PostMapping("/api/transaction")
    Transaction create(@RequestBody Transaction transaction){
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://validation-app:8081/api/validation";

        Transaction transactionValide = restTemplate.postForObject(url,transaction,Transaction.class);
        return  transactionValide;
    }

}
