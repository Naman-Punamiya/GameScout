package com.ndevstudios.gamescout.dto.game;

import com.ndevstudios.gamescout.enums.MediaType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GameMediaResponse {

    private Long id;
    private MediaType type;
    private String url;
    private String thumbnailUrl;
    private String title;
}
