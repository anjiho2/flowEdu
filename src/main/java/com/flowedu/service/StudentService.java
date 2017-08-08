package com.flowedu.service;

import com.flowedu.define.datasource.SchoolType;
import com.flowedu.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by jihoan on 2017. 8. 8..
 */
@Service
public class StudentService {

    @Autowired
    private StudentMapper studentMapper;

    public List<HashMap<String, Object>> getSchoolTypeList() {
        List<HashMap<String, Object>> Arr = new ArrayList<>();

        for (int i=0; i<SchoolType.size(); i++) {
            HashMap<String, Object> map = new HashMap<>();
            map.put(SchoolType.getSchoolTypeCode(i).toString(), SchoolType.getSchoolTypeName(i));
            Arr.add(map);
        }
        return Arr;
    }
}
