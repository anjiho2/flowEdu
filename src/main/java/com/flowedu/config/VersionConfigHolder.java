package com.flowedu.config;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class VersionConfigHolder {

	private static VersionConfigHolder config;
	
	@Value("#{config['service.version']}")
	private String version;
	
	@PostConstruct
	private VersionConfigHolder init() {
		config = this;
		return this;
	}
	
	public static String gerVersion() {
		return config.version;
	}
}
