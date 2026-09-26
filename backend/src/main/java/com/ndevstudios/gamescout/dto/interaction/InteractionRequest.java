package com.ndevstudios.gamescout.dto.interaction;

import com.ndevstudios.gamescout.enums.InteractionType;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class InteractionRequest {

    @NotNull(message = "Game ID is required")
    private Long gameId;

    @NotNull(message = "Interaction type is required")
    private InteractionType interactionType;
}
