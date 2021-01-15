Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBF7C433E0
	for <rcu@archiver.kernel.org>; Fri, 15 Jan 2021 15:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1807423884
	for <rcu@archiver.kernel.org>; Fri, 15 Jan 2021 15:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbhAOPMc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Jan 2021 10:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbhAOPMc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Jan 2021 10:12:32 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D01C061757;
        Fri, 15 Jan 2021 07:11:52 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d4so4849882plh.5;
        Fri, 15 Jan 2021 07:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CwLGA2cCG2vj6fY/e8af6P7H8uDSOiHJ0pQ5MMrQAaI=;
        b=d1wLDA7g7vxMHuQUSygSZ6vmbf5xYW3y3MKpSygFK+xj1y2HqBJqeUvsfJWcG2VVKN
         0HK8LfWSxqwTNUeT9fxP4RbmoO9Dg2lZIxgnA2uKEkpsb1dqKc/+beomjFSZbquNsFIF
         ppH4kxm5cMzlfXuj09nXGt0YNFUlFbOKM47LTX/vzEDTkj4l6HAqrVFyVHQ274qSpmDT
         kE8tsrB270fMrb4jVkc7XcDdryrdxoJw2XSLGER/aV6ThTiXFjeiBCkcAj2WwbIcOH3K
         ak7REfEiOshM/QuPJqNfyJQTK+JyrLeoGmQEfbF7n70vtWJx15mHqdrM2eUzRGGodZmJ
         ZZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CwLGA2cCG2vj6fY/e8af6P7H8uDSOiHJ0pQ5MMrQAaI=;
        b=RTHXwomiMjyl/tyDO1odrxieLzxnOiqn44pQf7nDhW4QduSMWl/lQG74p/eUMuBzL+
         oD/cBRsKDyEzMUww8/doYf6Y9CVlxwtt+IoTk8IGBasccNKbyk0gKvXLEdZYN2vavy5A
         cyOgxLH3SD7vh9Z3I8PJhCC6wEP8vNiky88f1Ut9dcBbDGUi6YNKJJdwwYeGdv17jFfV
         l1d2/y5fIp5i+Nt3hcvDQsu1dL0iYYzD8KfIaCAUk51l1XyZH12kBByQJ9HhLk3C8hzV
         zpPcb36luYV9aQsV9OrtHqh/5QpAW6qTtjZqJBFhP3386Gm0u5HM8sx7co8+wmPXOBmW
         TGiQ==
X-Gm-Message-State: AOAM530JS3TXvNzu1vKmOlGW47QpKTPJ96qIB8DrdGdhGzql3Pb7K9qx
        oB6MDPyyf94NZEUDGEUWQVQ=
X-Google-Smtp-Source: ABdhPJxqFM19xmnW/U1A1oER51CAr2/zUENa+wg+UVR/ATu8d4XH04uLCqhmR6s4vtstBOQrxcLYxg==
X-Received: by 2002:a17:90a:bd12:: with SMTP id y18mr11171395pjr.146.1610723511789;
        Fri, 15 Jan 2021 07:11:51 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id iq3sm8323909pjb.57.2021.01.15.07.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 07:11:51 -0800 (PST)
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH -rcu] rculist: Replace reference to atomic_ops.rst
Message-ID: <94e4df15-770b-4944-f3c6-f2856fc49786@gmail.com>
Date:   Sat, 16 Jan 2021 00:11:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From f92cae321e9a42a1d4bc8a2d5d1a2cd62ab35410 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Fri, 15 Jan 2021 23:39:03 +0900
Subject: [PATCH -rcu] rculist: Replace reference to atomic_ops.rst

atomic_ops.rst was removed in commit f0400a77ebdc ("atomic: Delete
obsolete documentation").
Instead, reference a section in memory-barriers.txt discussing
the use of barrier() in loops.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 include/linux/rculist_nulls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index ff3e94779e73..d8afdb8784c1 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -161,7 +161,7 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
  *
  * The barrier() is needed to make sure compiler doesn't cache first element [1],
  * as this loop can be restarted [2]
- * [1] Documentation/core-api/atomic_ops.rst around line 114
+ * [1] Documentation/memory-barriers.txt around line 1533
  * [2] Documentation/RCU/rculist_nulls.rst around line 146
  */
 #define hlist_nulls_for_each_entry_rcu(tpos, pos, head, member)			\
-- 
2.17.1

