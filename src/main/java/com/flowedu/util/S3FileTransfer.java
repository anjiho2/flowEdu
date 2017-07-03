package com.flowedu.util;


import java.io.ByteArrayInputStream;
import java.io.IOException;

import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

/**
 * 
 * @author anjiho
 * 아마존(AWS) S3파일 저장 클래스
 */
public class S3FileTransfer {
	
//	private AmazonS3Client amazonS3Client;
	
	private String bucket = "birdletter-test";
	    
	public boolean save(String saveDir, String fileName, byte[] data) {
		boolean bl = true;
		BasicAWSCredentials bw = new BasicAWSCredentials("AKIAIGH3JVO7LQZHFZQQ", "z/WKJawXXkxtWZ4aYBd97/N1pLkjePYa7AvIiD7R");
		AmazonS3Client cl = new AmazonS3Client(bw);
		
		saveDir = saveDir.replaceFirst("/", "");
		fileName = fileName.replaceFirst("/", "");
		System.out.println("saveDir : " + saveDir);
		System.out.println("fileName : " + fileName);
		ByteArrayInputStream inputStream = new ByteArrayInputStream(data);
		PutObjectRequest putObjectRequest = new PutObjectRequest(
				bucket,
				FileUtil.concatPath(saveDir,fileName).replaceFirst("/", ""),
				inputStream,
				new ObjectMetadata()
		);
		cl.putObject(putObjectRequest);
		try {
			inputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
			//throw new BirdAdminException(500, e.getMessage());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			bl = false;
		}
		return true;
	}
}


