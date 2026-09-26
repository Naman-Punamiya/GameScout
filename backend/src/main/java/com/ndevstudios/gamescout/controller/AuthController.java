package com.ndevstudios.gamescout.controller;

import com.ndevstudios.gamescout.dto.auth.AuthResponse;
import com.ndevstudios.gamescout.dto.auth.LoginRequest;
import com.ndevstudios.gamescout.dto.auth.RegisterRequest;
import com.ndevstudios.gamescout.dto.user.UserResponse;
import com.ndevstudios.gamescout.entity.User;
import com.ndevstudios.gamescout.response.ApiResponse;
import com.ndevstudios.gamescout.service.AuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/register")
    public ResponseEntity<ApiResponse<UserResponse>> register(@Valid @RequestBody RegisterRequest request) {
        if (authService.existsByUsername(request.getUsername())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(ApiResponse.error("Username is already taken"));
        }
        if (authService.existsByEmail(request.getEmail())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(ApiResponse.error("Email is already registered"));
        }

        User user = new User();
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        user.setPasswordHash(request.getPassword()); // Handled by password encoder in security layer

        User savedUser = authService.registerUser(user);

        UserResponse userResponse = UserResponse.builder()
                .id(savedUser.getId())
                .username(savedUser.getUsername())
                .email(savedUser.getEmail())
                .createdAt(savedUser.getCreatedAt())
                .build();

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success("User registered successfully", userResponse));
    }

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<AuthResponse>> login(@Valid @RequestBody LoginRequest request) {
        return authService.findByUsernameOrEmail(request.getUsernameOrEmail())
                .map(user -> {
                    UserResponse userResponse = UserResponse.builder()
                            .id(user.getId())
                            .username(user.getUsername())
                            .email(user.getEmail())
                            .createdAt(user.getCreatedAt())
                            .build();

                    AuthResponse authResponse = AuthResponse.builder()
                            .accessToken("jwt_token_placeholder")
                            .refreshToken("refresh_token_placeholder")
                            .user(userResponse)
                            .build();

                    return ResponseEntity.ok(ApiResponse.success("Login successful", authResponse));
                })
                .orElseGet(() -> ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(ApiResponse.error("Invalid credentials")));
    }

    @GetMapping("/check-username/{username}")
    public ResponseEntity<ApiResponse<Boolean>> checkUsername(@PathVariable String username) {
        boolean exists = authService.existsByUsername(username);
        return ResponseEntity.ok(ApiResponse.success(!exists));
    }

    @GetMapping("/check-email/{email}")
    public ResponseEntity<ApiResponse<Boolean>> checkEmail(@PathVariable String email) {
        boolean exists = authService.existsByEmail(email);
        return ResponseEntity.ok(ApiResponse.success(!exists));
    }
}
