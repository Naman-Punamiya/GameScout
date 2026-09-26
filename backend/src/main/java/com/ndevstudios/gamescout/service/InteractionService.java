package com.ndevstudios.gamescout.service;

import com.ndevstudios.gamescout.entity.Game;
import com.ndevstudios.gamescout.entity.User;
import com.ndevstudios.gamescout.entity.UserGameInteraction;
import com.ndevstudios.gamescout.enums.InteractionType;
import com.ndevstudios.gamescout.repository.GameRepository;
import com.ndevstudios.gamescout.repository.UserGameInteractionRepository;
import com.ndevstudios.gamescout.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class InteractionService {

    private final UserGameInteractionRepository interactionRepository;
    private final UserRepository userRepository;
    private final GameRepository gameRepository;

    public Optional<UserGameInteraction> findByUserIdAndGameId(Long userId, Long gameId) {
        return interactionRepository.findByUserIdAndGameId(userId, gameId);
    }

    public boolean existsByUserIdAndGameId(Long userId, Long gameId) {
        return interactionRepository.existsByUserIdAndGameId(userId, gameId);
    }

    public List<UserGameInteraction> findByUserId(Long userId) {
        return interactionRepository.findByUserId(userId);
    }

    public List<UserGameInteraction> findByUserIdAndType(Long userId, InteractionType interactionType) {
        return interactionRepository.findByUserIdAndInteractionType(userId, interactionType);
    }

    @Transactional
    public UserGameInteraction saveOrUpdateInteraction(Long userId, Long gameId, InteractionType interactionType) {
        Optional<UserGameInteraction> existing = interactionRepository.findByUserIdAndGameId(userId, gameId);

        if (existing.isPresent()) {
            UserGameInteraction interaction = existing.get();
            interaction.setInteractionType(interactionType);
            return interactionRepository.save(interaction);
        }

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found with id: " + userId));
        Game game = gameRepository.findById(gameId)
                .orElseThrow(() -> new IllegalArgumentException("Game not found with id: " + gameId));

        UserGameInteraction interaction = new UserGameInteraction();
        interaction.setUser(user);
        interaction.setGame(game);
        interaction.setInteractionType(interactionType);

        return interactionRepository.save(interaction);
    }

    @Transactional
    public void deleteByUserIdAndGameId(Long userId, Long gameId) {
        interactionRepository.deleteByUserIdAndGameId(userId, gameId);
    }
}
