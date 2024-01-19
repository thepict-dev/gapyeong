/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package pict_admin.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Class Name : EgovSampleService.java
 * @Description : EgovSampleService Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */
public interface PictService {
	List<PictVO> api_get_badge(PictVO pictVO) throws Exception;

	List<PictVO> api_get_coin(PictVO pictVO) throws Exception;

	PictVO api_get_avata(PictVO pictVO) throws Exception;

	void insert_avata(PictVO pictVO) throws Exception;

	void update_avata(PictVO pictVO) throws Exception;

	List<?> lecture_list(PictVO pictVO) throws Exception;

	PictVO lecture_select_one(PictVO pictVO) throws Exception;

	void lecture_update(PictVO pictVO) throws Exception;
	
	void lecture_insert(PictVO pictVO) throws Exception;

	List<?> lecture_attendance(PictVO pictVO) throws Exception;

	void attendance_save(PictVO pictVO) throws Exception;

	PictVO select_attendance(PictVO pictVO) throws Exception;

	List<PictVO> api_lecture_list(PictVO pictVO) throws Exception;

	List<?> lecture_category_list(PictVO pictVO) throws Exception;

	PictVO lecture_cate_select_one(PictVO pictVO) throws Exception;

	void lecture_cate_update(PictVO pictVO) throws Exception;

	void lecture_cate_insert(PictVO pictVO) throws Exception;

	List<?> connection_user(PictVO pictVO) throws Exception;

	PictVO attendance_select_one(PictVO pictVO) throws Exception;

	void attendance_save_update(PictVO vo) throws Exception;

	void connection_user_del(PictVO pictVO) throws Exception;

	List<?> board_list(PictVO pictVO) throws Exception;

	PictVO board_list_one(PictVO pictVO) throws Exception;

	void board_update(PictVO pictVO) throws Exception;

	void board_insert(PictVO pictVO) throws Exception;

	List<?> lecture_userinfo_list(PictVO pictVO) throws Exception;

	List<PictVO> lecture_attendance_api(PictVO pictVO) throws Exception;

	void board_delete(PictVO pictVO) throws Exception;

	List<?> board_list_latest(PictVO pictVO) throws Exception;
	//void attendance_update(PictVO pictVO) throws Exception;

	void bill_insert(PictVO pictVO) throws Exception;

	PictVO bill_select(PictVO pictVO)throws Exception;

	void bill_update(PictVO pictVO) throws Exception;

	List<PictVO> test_list(PictVO pictVO) throws Exception;

	PictVO test_list_one(PictVO pictVO) throws Exception;

	List<PictVO> non_list(PictVO pictVO) throws Exception;

	List<PictVO> confirm_num_list(PictVO pictVO) throws Exception;

	void confirm_update(PictVO pictVO) throws Exception;

	PictVO select_user(PictVO vo) throws Exception;

	void insert_user_info(PictVO pictVO) throws Exception;

	void update_user_info(PictVO pictVO) throws Exception;

	List<PictVO> non_hospital(PictVO pictVO) throws Exception;

	PictVO test_user_one(PictVO pictVO) throws Exception;

	List<PictVO> test_user_list(PictVO pictVO) throws Exception;

	PictVO center_get_user_info(PictVO pictVO) throws Exception;

	void center_address_update(PictVO pictVO) throws Exception;

	void center_address_insert(PictVO pictVO) throws Exception;

	PictVO user_bill_accept(PictVO pictVO) throws Exception;

	List<PictVO> user_bill_list(PictVO pictVO) throws Exception;

	PictVO bill_info(PictVO pictVO) throws Exception;

	List<PictVO> bill_img_list(PictVO pictVO) throws Exception;

	void bill_print(PictVO pictVO) throws Exception;

	Map<String, Object> print_person(PictVO pictVO) throws Exception;


}
