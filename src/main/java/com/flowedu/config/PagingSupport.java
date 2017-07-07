package com.flowedu.config;

import com.flowedu.dto.PagingDto;

public abstract class PagingSupport {
	
	public final PagingDto getPagingInfo (int sPage, int pageInList) {
        int page_cnt = pageInList;
        int srow = page_cnt * (sPage - 1) + 1;

        int start = srow;
        int end = page_cnt * sPage;

        PagingDto paging = new PagingDto(start, end);
        return paging;
    }
}
