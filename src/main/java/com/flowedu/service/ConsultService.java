package com.flowedu.service;

import com.flowedu.config.PagingSupport;
import com.flowedu.dto.EarlyConsultMemoDto;
import com.flowedu.dto.PagingDto;
import com.flowedu.error.FlowEduErrorCode;
import com.flowedu.error.FlowEduException;
import com.flowedu.mapper.ConsultMapper;
import com.flowedu.session.UserSession;
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by jihoan on 2017. 9. 29..
 */
@Service
public class ConsultService extends PagingSupport {

    @Autowired
    private ConsultMapper consultMapper;

    /**
     * <PRE>
     * 1. Comment : 초기 상담 내용 개수
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 10 .10
     * </PRE>
     * @return
     */
    @Transactional(readOnly = true)
    public int earlyConsultMemoCount() {
        return consultMapper.earlyConsultMemoCount();
    }

    /**
     * <PRE>
     * 1. Comment : 초기 상담 내용 리스트
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 10 .10
     * </PRE>
     * @param sPage
     * @param pageListCount
     * @return
     */
    @Transactional(readOnly = true)
    public List<EarlyConsultMemoDto> selectEarlyConsultMemoList(int sPage, int pageListCount) {
        PagingDto pagingDto = getPagingInfo(sPage, pageListCount);
        List<EarlyConsultMemoDto> earlyConsultMemoList = consultMapper.selectEarlyConsultMemoList(pagingDto.getStart(), pageListCount);
        return earlyConsultMemoList;
    }

    /**
     * <PRE>
     * 1. Comment : 초기 상담 내용 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 10 .10
     * </PRE>
     * @param phoneNumber
     * @param memoType
     * @param content
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveEarlyConsultMemo(String phoneNumber, String memoType, String content) {
        if ("".equals(phoneNumber)) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        Long memberId = UserSession.flowMemberId();
        consultMapper.saveEarlyConsultMemo(phoneNumber, memoType, content, memberId);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void updateEarlyConsultMemoCompleteYn(Long earlyConsultMemoId, Boolean completeYn) {
        if (earlyConsultMemoId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        consultMapper.updateEarlyConsultMemoCompleteYn(earlyConsultMemoId, completeYn);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteEarlyConsultMemo(Long earlyConsultMemoId) {
        if (earlyConsultMemoId == null) {
            throw new FlowEduException(FlowEduErrorCode.BAD_REQUEST);
        }
        consultMapper.deleteEarlyConsultMemo(earlyConsultMemoId);
    }

}
