package com.memo.user.dao;

import com.memo.user.model.User;

public interface UserMapper {
	public User selectUserByLoginId(String loginId);
}
