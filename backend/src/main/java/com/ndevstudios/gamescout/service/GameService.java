package com.ndevstudios.gamescout.service;

import com.ndevstudios.gamescout.entity.*;
import com.ndevstudios.gamescout.enums.MediaType;
import com.ndevstudios.gamescout.enums.PlatformType;
import com.ndevstudios.gamescout.enums.ProviderType;
import com.ndevstudios.gamescout.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class GameService {

    private final GameRepository gameRepository;
    private final GenreRepository genreRepository;
    private final TagRepository tagRepository;
    private final PlatformRepository platformRepository;
    private final GameMediaRepository gameMediaRepository;
    private final GameProviderReferenceRepository gameProviderReferenceRepository;

    // Game Core methods
    public Optional<Game> findById(Long id) {
        return gameRepository.findById(id);
    }

    public Optional<Game> findBySlug(String slug) {
        return gameRepository.findBySlug(slug);
    }

    public boolean existsBySlug(String slug) {
        return gameRepository.existsBySlug(slug);
    }

    public Page<Game> findAll(Pageable pageable) {
        return gameRepository.findAll(pageable);
    }

    public Page<Game> searchByName(String name, Pageable pageable) {
        return gameRepository.findByNameContainingIgnoreCase(name, pageable);
    }

    @Transactional
    public Game save(Game game) {
        return gameRepository.save(game);
    }

    @Transactional
    public void deleteById(Long id) {
        gameRepository.deleteById(id);
    }

    // Media methods
    public List<GameMedia> getMediaByGameId(Long gameId) {
        return gameMediaRepository.findByGameId(gameId);
    }

    public List<GameMedia> getMediaByGameIdAndType(Long gameId, MediaType type) {
        return gameMediaRepository.findByGameIdAndType(gameId, type);
    }

    @Transactional
    public GameMedia saveMedia(GameMedia media) {
        return gameMediaRepository.save(media);
    }

    @Transactional
    public void deleteMediaByGameId(Long gameId) {
        gameMediaRepository.deleteByGameId(gameId);
    }

    // Genre methods
    public Optional<Genre> findGenreByName(String name) {
        return genreRepository.findByNameIgnoreCase(name);
    }

    public Optional<Genre> findGenreBySlug(String slug) {
        return genreRepository.findBySlug(slug);
    }

    public boolean existsGenreBySlug(String slug) {
        return genreRepository.existsBySlug(slug);
    }

    public List<Genre> findAllGenres() {
        return genreRepository.findAll();
    }

    @Transactional
    public Genre saveGenre(Genre genre) {
        return genreRepository.save(genre);
    }

    // Tag methods
    public Optional<Tag> findTagByName(String name) {
        return tagRepository.findByNameIgnoreCase(name);
    }

    public Optional<Tag> findTagBySlug(String slug) {
        return tagRepository.findBySlug(slug);
    }

    public boolean existsTagBySlug(String slug) {
        return tagRepository.existsBySlug(slug);
    }

    public List<Tag> findAllTags() {
        return tagRepository.findAll();
    }

    @Transactional
    public Tag saveTag(Tag tag) {
        return tagRepository.save(tag);
    }

    // Platform methods
    public Optional<Platform> findPlatformByName(String name) {
        return platformRepository.findByNameIgnoreCase(name);
    }

    public Optional<Platform> findPlatformByType(PlatformType type) {
        return platformRepository.findByType(type);
    }

    public boolean existsPlatformByName(String name) {
        return platformRepository.existsByNameIgnoreCase(name);
    }

    public List<Platform> findAllPlatforms() {
        return platformRepository.findAll();
    }

    @Transactional
    public Platform savePlatform(Platform platform) {
        return platformRepository.save(platform);
    }

    // Provider Reference methods
    public Optional<GameProviderReference> findProviderReference(ProviderType provider, String providerGameId) {
        return gameProviderReferenceRepository.findByProviderAndProviderGameId(provider, providerGameId);
    }

    public boolean existsProviderReference(ProviderType provider, String providerGameId) {
        return gameProviderReferenceRepository.existsByProviderAndProviderGameId(provider, providerGameId);
    }

    public Optional<GameProviderReference> findProviderReferenceByGameId(Long gameId, ProviderType provider) {
        return gameProviderReferenceRepository.findByGameIdAndProvider(gameId, provider);
    }

    @Transactional
    public GameProviderReference saveProviderReference(GameProviderReference reference) {
        return gameProviderReferenceRepository.save(reference);
    }
}
