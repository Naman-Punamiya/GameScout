package com.ndevstudios.gamescout.repository;

import com.ndevstudios.gamescout.entity.Genre;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface GenreRepository extends JpaRepository<Genre, Long> {

    Optional<Genre> findByNameIgnoreCase(String name);

    Optional<Genre> findBySlug(String slug);

    boolean existsBySlug(String slug);
}
