package com.ndevstudios.gamescout.entity;

import com.ndevstudios.gamescout.enums.ProviderType;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class GameProviderReference {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "game_id")
    private Game game;

    @Enumerated(EnumType.STRING)
    private ProviderType provider;

    private String providerGameId;
    private String providerUrl;
}
