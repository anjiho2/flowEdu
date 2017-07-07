package com.flowedu.dto;

import lombok.Data;

@Data
public class PagingDto {
	private int start;
	private int end;

	public PagingDto() {}
	
	public PagingDto(int start, int end) {
		this.start = start;
		this.end = end;
	}
}
