package com.ruddy.model;

//crééer un objet en JSON
public class Transaction {
    private double amount;
    private String status;

    
    public Transaction(){}
    
    public Transaction(double amount, String status){
        this.amount = amount;
        this.status = status;
    }

    public double getAmount(){
        return this.amount;
    }
    public void setAmount(double amount){
        this.amount = amount;
    }

    public String getStatus(){
        return this.status;
    }

    public void setStatus(String status){
        this.status = status;
    }
}