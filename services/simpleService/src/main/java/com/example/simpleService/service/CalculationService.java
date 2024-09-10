package com.example.simpleService.service;

import com.example.simpleService.model.InputObject;
import com.example.simpleService.model.OutputObject;
import org.springframework.stereotype.Service;

@Service
public class CalculationService {

    public OutputObject calculateSquare(InputObject inputObject) {
        double result = inputObject.getNumber() * inputObject.getNumber();
        return new OutputObject(result);
    }
}