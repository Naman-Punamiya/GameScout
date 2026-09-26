package com.ndevstudios.gamescout.dto.discovery;

import com.ndevstudios.gamescout.dto.game.GameMediaResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiscoveryResponse {

    private Long id;
    private String name;
    private String slug;
    private String description;
    private String coverImageUrl;
    private Double rating;
    private List<String> genres;
    private List<String> platforms;
    private List<GameMediaResponse> media;
}
