package com.ndevstudios.gamescout.controller;

import com.ndevstudios.gamescout.dto.game.GameMediaResponse;
import com.ndevstudios.gamescout.dto.game.GameResponse;
import com.ndevstudios.gamescout.dto.game.GameSummaryResponse;
import com.ndevstudios.gamescout.entity.Game;
import com.ndevstudios.gamescout.entity.Genre;
import com.ndevstudios.gamescout.entity.Platform;
import com.ndevstudios.gamescout.entity.Tag;
import com.ndevstudios.gamescout.response.ApiResponse;
import com.ndevstudios.gamescout.service.GameService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/games")
@RequiredArgsConstructor
public class GameController {

    private final GameService gameService;

    @GetMapping
    public ResponseEntity<ApiResponse<Page<GameSummaryResponse>>> getGames(
            @RequestParam(required = false) String search,
            @PageableDefault(size = 20) Pageable pageable
    ) {
        Page<Game> games;
        if (search != null && !search.trim().isEmpty()) {
            games = gameService.searchByName(search.trim(), pageable);
        } else {
            games = gameService.findAll(pageable);
        }

        Page<GameSummaryResponse> responses = games.map(this::toSummaryResponse);
        return ResponseEntity.ok(ApiResponse.success(responses));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<GameResponse>> getGameById(@PathVariable Long id) {
        return gameService.findById(id)
                .map(this::toGameResponse)
                .map(response -> ResponseEntity.ok(ApiResponse.success(response)))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(ApiResponse.error("Game not found with ID: " + id)));
    }

    @GetMapping("/slug/{slug}")
    public ResponseEntity<ApiResponse<GameResponse>> getGameBySlug(@PathVariable String slug) {
        return gameService.findBySlug(slug)
                .map(this::toGameResponse)
                .map(response -> ResponseEntity.ok(ApiResponse.success(response)))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(ApiResponse.error("Game not found with slug: " + slug)));
    }

    @GetMapping("/{id}/media")
    public ResponseEntity<ApiResponse<List<GameMediaResponse>>> getGameMedia(@PathVariable Long id) {
        List<GameMediaResponse> media = gameService.getMediaByGameId(id).stream()
                .map(m -> GameMediaResponse.builder()
                        .id(m.getId())
                        .type(m.getType())
                        .url(m.getUrl())
                        .thumbnailUrl(m.getThumbnailUrl())
                        .title(m.getTitle())
                        .build())
                .collect(Collectors.toList());

        return ResponseEntity.ok(ApiResponse.success(media));
    }

    @GetMapping("/genres")
    public ResponseEntity<ApiResponse<List<Genre>>> getAllGenres() {
        return ResponseEntity.ok(ApiResponse.success(gameService.findAllGenres()));
    }

    @GetMapping("/platforms")
    public ResponseEntity<ApiResponse<List<Platform>>> getAllPlatforms() {
        return ResponseEntity.ok(ApiResponse.success(gameService.findAllPlatforms()));
    }

    @GetMapping("/tags")
    public ResponseEntity<ApiResponse<List<Tag>>> getAllTags() {
        return ResponseEntity.ok(ApiResponse.success(gameService.findAllTags()));
    }

    private GameSummaryResponse toSummaryResponse(Game game) {
        return GameSummaryResponse.builder()
                .id(game.getId())
                .name(game.getName())
                .slug(game.getSlug())
                .coverImageUrl(game.getCoverImageUrl())
                .rating(game.getRating())
                .ratingCount(game.getRatingCount())
                .releaseDate(game.getReleaseDate())
                .developer(game.getDeveloper())
                .genres(game.getGenres() != null ? game.getGenres().stream().map(Genre::getName).collect(Collectors.toList()) : List.of())
                .platforms(game.getPlatforms() != null ? game.getPlatforms().stream().map(Platform::getName).collect(Collectors.toList()) : List.of())
                .build();
    }

    private GameResponse toGameResponse(Game game) {
        return GameResponse.builder()
                .id(game.getId())
                .name(game.getName())
                .slug(game.getSlug())
                .description(game.getDescription())
                .coverImageUrl(game.getCoverImageUrl())
                .releaseDate(game.getReleaseDate())
                .rating(game.getRating())
                .ratingCount(game.getRatingCount())
                .developer(game.getDeveloper())
                .publisher(game.getPublisher())
                .minPlayer(game.getMinPlayer())
                .maxPlayer(game.getMaxPlayer())
                .multiPlayer(game.getMultiPlayer())
                .crossPlay(game.getCrossPlay())
                .genres(game.getGenres() != null ? game.getGenres().stream().map(Genre::getName).collect(Collectors.toList()) : List.of())
                .tags(game.getTags() != null ? game.getTags().stream().map(Tag::getName).collect(Collectors.toList()) : List.of())
                .platforms(game.getPlatforms() != null ? game.getPlatforms().stream().map(Platform::getName).collect(Collectors.toList()) : List.of())
                .media(game.getMedia() != null ? game.getMedia().stream()
                        .map(m -> GameMediaResponse.builder()
                                .id(m.getId())
                                .type(m.getType())
                                .url(m.getUrl())
                                .thumbnailUrl(m.getThumbnailUrl())
                                .title(m.getTitle())
                                .build())
                        .collect(Collectors.toList()) : List.of())
                .lastSyncedAt(game.getLastSyncedAt())
                .build();
    }
}
