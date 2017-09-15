package com.flowedu.util;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by jihoan on 2017. 7. 24..
 */
public class FileUploadUtil {

    /**
     * <pre>
     * 1. Comment : 기본 경로에 파일 업로드 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 07. 24
     * </pre>
     * @param request
     * @param savePath
     * @return
     */
    public static String fileUpload(MultipartHttpServletRequest request, String savePath) {
        String fileName = "";

        Iterator<String> it = request.getFileNames();
        try {
            while (it.hasNext()) {
                String uploadFileName = it.next();

                if (uploadFileName != null || !"".equals(uploadFileName)) {
                    MultipartFile multipartFile = request.getFile(uploadFileName);
                    //한글 꺠짐 방지처리
                    String originalFileName = multipartFile.getOriginalFilename();
                    /** 파일명이 한글일때 에러 처리 **/
                    /*
                    if (StringUtil.isKorean(originalFileName)) {
                        return fileName;
                    }
                    */
                    //파일명 변경
                    //String finalFileName = FileUploadRename.multipartFileRename(multipartFile).toString();
                    String makeFileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
                    int filePos = originalFileName.lastIndexOf(".");
                    String fileExtension = originalFileName.substring(filePos+1);
                    String finalFileName = makeFileName + "_" + Util.returnNowDateByYyyymmddhhmmss() + "." + fileExtension;

                    if (originalFileName != null || !"".equals(originalFileName)) {
                        File serverFile = new File(FileUtil.concatPath(savePath, finalFileName));
                        multipartFile.transferTo(serverFile);
                        //root경로 파일 삭제
                        FileUtil.fileDelete(finalFileName);
                        FileUtil.fileDelete(originalFileName);

                        fileName = serverFile.getName();
                    }
                }
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fileName;
    }

    /**
     * <pre>
     * 1. Comment : /년/월-일/ 하위에 파일 업로드 저장
     * 2. 작성자 : 안지호
     * 3. 작성일 : 2017. 07. 24
     * </pre>
     * @param request
     * @param savePath
     * @return
     */
    public static Map<String, Object> fileUploadYmdLocation(MultipartHttpServletRequest request, String savePath) {
        Map<String, Object> map = new HashMap<>();
        String fileName = "";

        Iterator<String> it = request.getFileNames();
        try {
            while (it.hasNext()) {
                String uploadFileName = it.next();

                if (uploadFileName != null || !"".equals(uploadFileName)) {
                    MultipartFile multipartFile = request.getFile(uploadFileName);
                    //한글 꺠짐 방지처리
                    String originalFileName = multipartFile.getOriginalFilename();
                    /** 파일명이 한글일때 에러 처리 **/
                    /*
                    if (StringUtil.isKorean(originalFileName)) {
                        return fileName;
                    }
                    */
                    //파일명 변경
                    //String finalFileName = FileUploadRename.multipartFileRename(multipartFile).toString();
                    String makeFileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
                    int filePos = originalFileName.lastIndexOf(".");
                    String fileExtension = originalFileName.substring(filePos+1);
                    String finalFileName = makeFileName + "_" + Util.returnNowDateByYyyymmddhhmmss() + "." + fileExtension;

                    //년도 디렉토리 존재 확인
                    File yearDirectory = new File(FileUtil.concatPath(savePath, DateUtils.getNowYear()));
                    if (!yearDirectory.isDirectory()) {
                        yearDirectory.mkdirs();
                    }
                    //월일 디렉토리가 존재 확인
                    String mmdd = DateUtils.plusDay(Util.returnToDate("yyyy-MM-dd"), "MMDD", 0);
                    File todayDirectory = new File(FileUtil.concatPath(yearDirectory.toString(), mmdd));
                    if (!todayDirectory.isDirectory()) {
                        todayDirectory.mkdirs();
                    }
                    map.put("file_url", DateUtils.getNowYear()+"/"+mmdd);
                    if (originalFileName != null || !"".equals(originalFileName)) {
                        File serverFile = new File(FileUtil.concatPath(todayDirectory.toString(), finalFileName));
                        multipartFile.transferTo(serverFile);
                        //root경로 파일 삭제
                        FileUtil.fileDelete(finalFileName);
                        FileUtil.fileDelete(originalFileName);

                        fileName = serverFile.getName();
                    }
                    map.put("file_name", fileName);
                }
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return map;
    }
}
