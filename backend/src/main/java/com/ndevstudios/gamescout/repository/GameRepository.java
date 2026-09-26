package com.ndevstudios.gamescout.repository;

import com.ndevstudios.gamescout.entity.Game;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface GameRepository extends JpaRepository<Game, Long> {

    Optional<Game> findBySlug(String slug);

    boolean existsBySlug(String slug);

    Page<Game> findByNameContainingIgnoreCase(
            String name,
            Pageable pageable
    );
}