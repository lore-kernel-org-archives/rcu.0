Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2831EB64DA
	for <rcu@archiver.kernel.org>; Sat, 24 Jun 2023 03:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjFXDNk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 23 Jun 2023 23:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFXDNj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 23 Jun 2023 23:13:39 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217F3E47;
        Fri, 23 Jun 2023 20:13:38 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56312517201so666701eaf.2;
        Fri, 23 Jun 2023 20:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576417; x=1690168417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kof3tILyq2QWhgxlTTivqlLH4+fHohvvsiUKB9n1vWI=;
        b=S1comwnLUtmnAvnLv3hzcDQSyUIyyg5wG2/oq/Y2zZNp5JarR1R/UDK+kkCda06cRl
         4cBHROk6I0t33tEWAIWwYDG5FUP5hWtWgRcKdbatHQk9NDZ9/kcMbJXL2i7DLCi2YVEb
         JscRJOahSHuvy5O/MV9vpaQ/GnRctQwbvGoQPFrafBr3gPhpJWA+hDLkoUPrTQiSiVSp
         t4j1LXMYTuouEBU3SmyeOa6fjHh91QFsun88yVY82rk7fVfVFrqw+FFU/LC8UFGmZl1R
         aKW/qpUsJSB4txBLXltPEhrXmzq/pHm5H8odHhfWk1gju0I29xLeUf+Z0hZr9YDDU+pu
         aoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576417; x=1690168417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kof3tILyq2QWhgxlTTivqlLH4+fHohvvsiUKB9n1vWI=;
        b=OOcEog0LlnuRu22Q+fMzdYQiL6pUHHD86XD89lFGaPiNipVaRepH+X+DQbVdsU3Qam
         nxyPyLe82ytn2XI+gyFKRs3WPo0YGkMY3LMQ3e7p6Lf5n6FsBK/Ga0rbhqsGlxWo+gLa
         rtyGHbJJyFct9ojmWcpAr5w6fQUUXBPaLx6Qy94+LD7t6UK5DWgyduZ2dkie1vCSzSQK
         KtOdKERhF0KI9nB2xIf5CvKm2BTWwTILbTNz0OCFsI31Ea82tHG5wTcmCfF8ksmK268a
         kwdLO9FM8GaL18qKQ5ivhIi/opGlAqR5cbsXQEeoi9v6nRorMk2eGAL3mCIz9u4jXEr8
         5U4Q==
X-Gm-Message-State: AC+VfDw49IMj03fwZNlfmF3mLIencmLpr1dBjhk+GwNOHm/xj7Q5JmRr
        Uyfa5nYAgBK7ULcZ+CW945nXzVvBzyU=
X-Google-Smtp-Source: ACHHUZ5uq01H/9Q9NyAJ2gSugYagFtF95Hk+ct2uOPVUwDja9WarvunUL67+GNtg7+bsklaRSk/KYQ==
X-Received: by 2002:a05:6359:60f:b0:130:e1d1:36d8 with SMTP id eh15-20020a056359060f00b00130e1d136d8mr16611708rwb.20.1687576417179;
        Fri, 23 Jun 2023 20:13:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id m24-20020a170902bb9800b001aaed55aff3sm239954pls.137.2023.06.23.20.13.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:13:36 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 00/13] bpf: Introduce bpf_mem_cache_free_rcu().
Date:   Fri, 23 Jun 2023 20:13:20 -0700
Message-Id: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

v1->v2:
- Fixed race condition spotted by Hou. Patch 7.

v1:

Introduce bpf_mem_cache_free_rcu() that is similar to kfree_rcu except
the objects will go through an additional RCU tasks trace grace period
before being freed into slab.

Patches 1-9 - a bunch of prep work
Patch 10 - a patch from Paul that exports rcu_request_urgent_qs_task().
Patch 12 - the main bpf_mem_cache_free_rcu patch.
Patch 13 - use it in bpf_cpumask.

bpf_local_storage, bpf_obj_drop, qp-trie will be other users eventually.

With additional hack patch to htab that replaces bpf_mem_cache_free with bpf_mem_cache_free_rcu
the following are benchmark results:
- map_perf_test 4 8 16348 1000000
drops from 800k to 600k. Waiting for RCU GP makes objects cache cold.

- bench htab-mem -a -p 8
20% drop in performance and big increase in memory. From 3 Mbyte to 50 Mbyte. As expected.

- bench htab-mem -a -p 16 --use-case add_del_on_diff_cpu
Same performance and better memory consumption.
Before these patches this bench would OOM (with or without 'reuse after GP')
Patch 8 addresses the issue.

At the end the performance drop and additional memory consumption due to _rcu()
were expected and came out to be within reasonable margin.
Without Paul's patch 10 the memory consumption in 'bench htab-mem' is in Gbytes
which wouldn't be acceptable.

Patch 8 is a heuristic to address 'alloc on one cpu, free on another' issue.
It works well in practice. One can probably construct an artificial benchmark
to make heuristic ineffective, but we have to trade off performance, code complexity,
and memory consumption.

The life cycle of objects:
alloc: dequeue free_llist
free: enqeueu free_llist
free_llist above high watermark -> free_by_rcu_ttrace
free_rcu: enqueue free_by_rcu -> waiting_for_gp
after RCU GP waiting_for_gp -> free_by_rcu_ttrace
free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab

Alexei Starovoitov (12):
  bpf: Rename few bpf_mem_alloc fields.
  bpf: Simplify code of destroy_mem_alloc() with kmemdup().
  bpf: Let free_all() return the number of freed elements.
  bpf: Refactor alloc_bulk().
  bpf: Further refactor alloc_bulk().
  bpf: Optimize moving objects from free_by_rcu_ttrace to
    waiting_for_gp_ttrace.
  bpf: Change bpf_mem_cache draining process.
  bpf: Add a hint to allocated objects.
  bpf: Allow reuse from waiting_for_gp_ttrace list.
  selftests/bpf: Improve test coverage of bpf_mem_alloc.
  bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().
  bpf: Convert bpf_cpumask to bpf_mem_cache_free_rcu.

Paul E. McKenney (1):
  rcu: Export rcu_request_urgent_qs_task()

 include/linux/bpf_mem_alloc.h                 |   2 +
 include/linux/rcutiny.h                       |   2 +
 include/linux/rcutree.h                       |   1 +
 kernel/bpf/cpumask.c                          |  20 +-
 kernel/bpf/memalloc.c                         | 322 +++++++++++++-----
 kernel/rcu/rcu.h                              |   2 -
 .../testing/selftests/bpf/progs/linked_list.c |   2 +-
 7 files changed, 251 insertions(+), 100 deletions(-)

-- 
2.34.1

