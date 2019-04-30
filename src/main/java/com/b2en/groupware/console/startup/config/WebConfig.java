package com.b2en.groupware.console.startup.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

@Configuration
public class WebConfig {

    @Bean
    public TilesConfigurer getTilesConfigurer() {

        TilesConfigurer tilesConfigurer = new TilesConfigurer();
        tilesConfigurer.setCheckRefresh(true);
        tilesConfigurer.setDefinitionsFactoryClass(TilesConfig.class);

        // TILES.xml 대체 클래스
        TilesConfig.addDefinitions();

        return tilesConfigurer;
    }

    @Bean
    public TilesViewResolver tilesViewResolver() {
        final TilesViewResolver resolver = new TilesViewResolver();
        resolver.setViewClass(TilesView.class);
        return resolver;
    }
}
