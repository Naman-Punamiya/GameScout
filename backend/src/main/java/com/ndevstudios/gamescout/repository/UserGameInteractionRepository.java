package com.ndevstudios.gamescout.repository;

import com.ndevstudios.gamescout.entity.UserGameInteraction;
import com.ndevstudios.gamescout.enums.InteractionType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserGameInteractionRepository
        extends JpaRepository<UserGameInteraction, Long> {

    Optional<UserGameInteraction> findByUserIdAndGameId(
            Long userId,
            Long gameId
    );

    boolean existsByUserIdAndGameId(
            Long userId,
            Long gameId
    );

    List<UserGameInteraction> findByUserId(
            Long userId
    );

    List<UserGameInteraction> findByUserIdAndInteractionType(
            Long userId,
            InteractionType interactionType
    );

    void deleteByUserIdAndGameId(
            Long userId,
            Long gameId
    );
}