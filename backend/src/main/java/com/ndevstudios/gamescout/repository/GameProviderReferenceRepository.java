package com.ndevstudios.gamescout.repository;

import com.ndevstudios.gamescout.entity.GameProviderReference;
import com.ndevstudios.gamescout.enums.ProviderType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface GameProviderReferenceRepository extends JpaRepository<GameProviderReference, Long> {

    Optional<GameProviderReference> findByProviderAndProviderGameId(
            ProviderType provider,
            String providerGameId
    );

    boolean existsByProviderAndProviderGameId(
            ProviderType provider,
            String providerGameId
    );

    Optional<GameProviderReference> findByGameIdAndProvider(
            Long gameId,
            ProviderType provider
    );
}