package com.test.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.test.entity.Board;

@Mapper
public interface BoardMapper {
	public <List>Board selectAllList();
}
