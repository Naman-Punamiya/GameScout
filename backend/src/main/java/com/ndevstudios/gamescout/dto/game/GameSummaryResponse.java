package com.ndevstudios.gamescout.dto.game;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GameSummaryResponse {

    private Long id;
    private String name;
    private String slug;
    private String coverImageUrl;
    private Double rating;
    private Integer ratingCount;
    private LocalDate releaseDate;
    private String developer;
    private List<String> genres;
    private List<String> platforms;
}
