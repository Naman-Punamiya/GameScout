package com.ndevstudios.gamescout.repository;

import com.ndevstudios.gamescout.entity.Platform;
import com.ndevstudios.gamescout.enums.PlatformType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PlatformRepository extends JpaRepository<Platform, Long> {

    Optional<Platform> findByNameIgnoreCase(String name);

    Optional<Platform> findByType(PlatformType type);

    boolean existsByNameIgnoreCase(String name);
}