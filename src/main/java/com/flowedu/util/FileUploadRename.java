package com.flowedu.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import com.oreilly.servlet.multipart.FileRenamePolicy;
import org.springframework.web.multipart.MultipartFile;

public class FileUploadRename implements FileRenamePolicy {

	public FileUploadRename() {
	}

	public File rename(File f) {
		if (createNewFile(f))
			return f;

		String name = f.getName();
		String body = null;
		String ext = null;

		int dot = name.lastIndexOf(".");
		if (dot != -1) {
			body = name.substring(0, dot);
			ext = name.substring(dot);
		} else {
			body = name;
			ext = "";
		}

		int count = 0;
		// 중복된 파일 있을때
		while (!createNewFile(f) && count < 9999) {
			count++;
			String newName = body + "_V" + count + ext;
			f = new File(f.getParent(), newName);
		}
		return f;
	}

	public static File multipartFileRename(MultipartFile multipartFile) throws IOException {
		File f = convertToFile(multipartFile);

		if (createNewFile(f))
			return f;

		String name = f.getName();
		String body = null;
		String ext = null;

		int dot = name.lastIndexOf(".");
		if (dot != -1) {
			body = name.substring(0, dot);
			ext = name.substring(dot);
		} else {
			body = name;
			ext = "";
		}

		int count = 0;
		// 중복된 파일 있을때
		while (!createNewFile(f) && count < 9999) {
			count++;
			String newName = body + "_V" + count + ext;
			f = new File(f.getParent(), newName);
		}
		return f;

	}

	private static boolean createNewFile(File f) {
		try {
			return f.createNewFile(); // 존재하는 파일이 아니면
		} catch (IOException e) {
			return false;
		}
	}

	public static File convertToFile(MultipartFile file) throws IOException {
		File convFile = new File(file.getOriginalFilename());
		convFile.createNewFile();
		FileOutputStream fos = new FileOutputStream(convFile);
		fos.write(file.getBytes());
		fos.close();
		return convFile;
	}

}
