package com.ndevstudios.gamescout.entity;

import com.ndevstudios.gamescout.enums.PlatformType;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Platform {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    private String slug;

    @Enumerated(EnumType.STRING)
    private PlatformType type;
}
