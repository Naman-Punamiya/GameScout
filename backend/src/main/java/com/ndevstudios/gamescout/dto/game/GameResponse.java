package com.ndevstudios.gamescout.dto.game;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GameResponse {

    private Long id;
    private String name;
    private String slug;
    private String description;
    private String coverImageUrl;
    private LocalDate releaseDate;
    private Double rating;
    private Integer ratingCount;
    private String developer;
    private String publisher;
    private Integer minPlayer;
    private Integer maxPlayer;
    private Boolean multiPlayer;
    private Boolean crossPlay;
    private List<String> genres;
    private List<String> tags;
    private List<String> platforms;
    private List<GameMediaResponse> media;
    private LocalDateTime lastSyncedAt;
}
