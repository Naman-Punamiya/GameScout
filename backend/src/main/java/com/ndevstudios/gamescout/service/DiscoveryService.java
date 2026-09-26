package com.ndevstudios.gamescout.service;

import com.ndevstudios.gamescout.entity.Game;
import com.ndevstudios.gamescout.entity.UserGameInteraction;
import com.ndevstudios.gamescout.repository.GameRepository;
import com.ndevstudios.gamescout.repository.UserGameInteractionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class DiscoveryService {

    private final GameRepository gameRepository;
    private final UserGameInteractionRepository interactionRepository;

    public Page<Game> getDiscoveryFeed(Long userId, Pageable pageable) {
        if (userId == null) {
            return gameRepository.findAll(pageable);
        }

        List<UserGameInteraction> interactions = interactionRepository.findByUserId(userId);
        Set<Long> interactedGameIds = interactions.stream()
                .map(i -> i.getGame().getId())
                .collect(Collectors.toSet());

        Page<Game> allGames = gameRepository.findAll(pageable);
        List<Game> filteredGames = allGames.getContent().stream()
                .filter(game -> !interactedGameIds.contains(game.getId()))
                .collect(Collectors.toList());

        return new PageImpl<>(filteredGames, pageable, allGames.getTotalElements());
    }
}
