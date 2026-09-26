package com.ndevstudios.gamescout.repository;

import com.ndevstudios.gamescout.entity.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TagRepository extends JpaRepository<Tag, Long> {

    Optional<Tag> findByNameIgnoreCase(String name);

    Optional<Tag> findBySlug(String slug);

    boolean existsBySlug(String slug);
}