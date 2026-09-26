package com.ndevstudios.gamescout.controller;

import com.ndevstudios.gamescout.dto.discovery.DiscoveryResponse;
import com.ndevstudios.gamescout.dto.game.GameMediaResponse;
import com.ndevstudios.gamescout.entity.Game;
import com.ndevstudios.gamescout.entity.Genre;
import com.ndevstudios.gamescout.entity.Platform;
import com.ndevstudios.gamescout.response.ApiResponse;
import com.ndevstudios.gamescout.service.DiscoveryService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/discovery")
@RequiredArgsConstructor
public class DiscoveryController {

    private final DiscoveryService discoveryService;

    @GetMapping("/feed")
    public ResponseEntity<ApiResponse<Page<DiscoveryResponse>>> getDiscoveryFeed(
            @RequestParam(required = false) Long userId,
            @PageableDefault(size = 10) Pageable pageable
    ) {
        Page<Game> feedPage = discoveryService.getDiscoveryFeed(userId, pageable);
        Page<DiscoveryResponse> responsePage = feedPage.map(this::toDiscoveryResponse);
        return ResponseEntity.ok(ApiResponse.success(responsePage));
    }

    private DiscoveryResponse toDiscoveryResponse(Game game) {
        return DiscoveryResponse.builder()
                .id(game.getId())
                .name(game.getName())
                .slug(game.getSlug())
                .description(game.getDescription())
                .coverImageUrl(game.getCoverImageUrl())
                .rating(game.getRating())
                .genres(game.getGenres() != null ? game.getGenres().stream().map(Genre::getName).collect(Collectors.toList()) : List.of())
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
                .build();
    }
}
