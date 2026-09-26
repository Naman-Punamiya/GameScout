package com.ndevstudios.gamescout.controller;

import com.ndevstudios.gamescout.dto.interaction.InteractionRequest;
import com.ndevstudios.gamescout.entity.UserGameInteraction;
import com.ndevstudios.gamescout.enums.InteractionType;
import com.ndevstudios.gamescout.response.ApiResponse;
import com.ndevstudios.gamescout.service.InteractionService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/interactions")
@RequiredArgsConstructor
public class InteractionController {

    private final InteractionService interactionService;

    @PostMapping
    public ResponseEntity<ApiResponse<UserGameInteraction>> recordInteraction(
            @RequestParam Long userId,
            @Valid @RequestBody InteractionRequest request
    ) {
        UserGameInteraction interaction = interactionService.saveOrUpdateInteraction(
                userId,
                request.getGameId(),
                request.getInteractionType()
        );
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success("Interaction recorded successfully", interaction));
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<ApiResponse<List<UserGameInteraction>>> getUserInteractions(@PathVariable Long userId) {
        List<UserGameInteraction> interactions = interactionService.findByUserId(userId);
        return ResponseEntity.ok(ApiResponse.success(interactions));
    }

    @GetMapping("/user/{userId}/type/{type}")
    public ResponseEntity<ApiResponse<List<UserGameInteraction>>> getUserInteractionsByType(
            @PathVariable Long userId,
            @PathVariable InteractionType type
    ) {
        List<UserGameInteraction> interactions = interactionService.findByUserIdAndType(userId, type);
        return ResponseEntity.ok(ApiResponse.success(interactions));
    }

    @GetMapping("/user/{userId}/game/{gameId}")
    public ResponseEntity<ApiResponse<UserGameInteraction>> getUserGameInteraction(
            @PathVariable Long userId,
            @PathVariable Long gameId
    ) {
        return interactionService.findByUserIdAndGameId(userId, gameId)
                .map(interaction -> ResponseEntity.ok(ApiResponse.success(interaction)))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(ApiResponse.error("No interaction found for user " + userId + " on game " + gameId)));
    }

    @DeleteMapping("/user/{userId}/game/{gameId}")
    public ResponseEntity<ApiResponse<Void>> deleteInteraction(
            @PathVariable Long userId,
            @PathVariable Long gameId
    ) {
        if (!interactionService.existsByUserIdAndGameId(userId, gameId)) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Interaction not found"));
        }
        interactionService.deleteByUserIdAndGameId(userId, gameId);
        return ResponseEntity.ok(ApiResponse.success("Interaction removed successfully", null));
    }
}
