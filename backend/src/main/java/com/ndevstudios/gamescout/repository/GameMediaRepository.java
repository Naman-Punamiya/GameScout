package com.ndevstudios.gamescout.repository;

import com.ndevstudios.gamescout.entity.GameMedia;
import com.ndevstudios.gamescout.enums.MediaType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GameMediaRepository extends JpaRepository<GameMedia, Long> {

    List<GameMedia> findByGameId(Long gameId);

    List<GameMedia> findByGameIdAndType(
            Long gameId,
            MediaType type
    );

    void deleteByGameId(Long gameId);
}