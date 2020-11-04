package com.ms.common.domain;

import lombok.Data;

import java.util.List;

/**
 * AdminRedisUserVo --
 *
 * @author XiaoBing
 * @version v1.0.0
 * @date 2020/10/23
 * @Description Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/10/23             XiaoBing          v1.0.0           Created
 */
@Data
public class AdminRedisUserVo {
    private Long id;

    private String username;

    private List<Long> role;

}
