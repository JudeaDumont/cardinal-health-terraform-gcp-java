package com.example.simpleService.controller;

import com.example.simpleService.model.InputObject;
import com.example.simpleService.model.OutputObject;
import com.example.simpleService.service.CalculationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/calculate")
public class CalculationController {

    private final CalculationService calculationService;

    @Autowired
    public CalculationController(CalculationService calculationService) {
        this.calculationService = calculationService;
    }

    @PostMapping("/square")
    public ResponseEntity<OutputObject> calculateSquare(@RequestBody InputObject inputObject) {
        // The controller is "dumb" and just passes the request to the service
        OutputObject outputObject = calculationService.calculateSquare(inputObject);
        return ResponseEntity.ok(outputObject);
    }
}