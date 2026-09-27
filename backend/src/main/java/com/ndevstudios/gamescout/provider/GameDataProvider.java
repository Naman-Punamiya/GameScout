package com.ndevstudios.gamescout.provider;

import com.ndevstudios.gamescout.entity.Game;

import java.util.List;
import java.util.Optional;

public interface GameDataProvider {

    List<Game> getPopularGames(int page, int pageSize);

    List<Game> searchGames(String query, int page, int pageSize);

    Optional<Game> getGameByProviderId(String providerGameId);
}