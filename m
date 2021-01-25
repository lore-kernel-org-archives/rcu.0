Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A57DC433E0
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 07:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C969C22C9C
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 07:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbhAYHm5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 Jan 2021 02:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbhAYHmj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 Jan 2021 02:42:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F83C061573;
        Sun, 24 Jan 2021 23:41:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e15so9803748wme.0;
        Sun, 24 Jan 2021 23:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vln43mgwMFNDI3htKB1T6Ag4DsdFzHSSzpUsFqeuEV8=;
        b=YlaF8EV+p5Ys4CIcJ/awJ+DIh+YHGs0ojO7kNgf5NVTd1GUFrTzrKgcfJnF3YZdxbK
         12HO+dRwrrUjsnrLVZe5XOeV8nMb/HHgZUaVi5JFUPsqA+znS+yEOpFcn0MBdIMb/fqd
         cmnATcaeSsU33Rhvx0jKRxRI+gUxMzuYZwzZ+vwCmpYUu1zQ5XedTnPiQnGMLACIb+hH
         0/YF2qcdsHiVdA/jc2gERu0N80amkCwowGYbXuAm79GdnjJ50oBCjmXG2M4JMju5KLDI
         SlfkYlw/GMpcsZSS2ypShNs2pM3JSlsjTnk4QuGeag28F2bgzkKDNAKnX2PRKkbj6Isp
         pHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vln43mgwMFNDI3htKB1T6Ag4DsdFzHSSzpUsFqeuEV8=;
        b=tUHQVCaanErQLdsFg7toccq41KqCWrkQQ2dQ8vsNyskQZxbx0EIReXSbzzd0c7c02U
         3Fw4mElDaR09TcElaC6vDRnBHY51Xx6zDB1AwSjCrTb2/Lfwzj2PMXGqy+MgaoJ6GvXc
         VTXEP6XPaW7Tr64ZPAMbymx1aiNnObm21XdqPR+MnOGT6/aV9Sq3LO2rN3InfOVpZGEB
         +2/AACDbDIQbijV8wubNTW+3aWV0CnxaoXsGdYzApHSO7bqgQBs98Dm4gWVcGezCBgb+
         OMAiqx29gCFoHgDGBE4mAn/rq5yk7YSFFPyMScBziLZHU7Wg8NlZkw8F5Kw1rsncaI9T
         O4jA==
X-Gm-Message-State: AOAM532vbpeAWwywsyrXu6zlD9GFV9NT0+oZrx9FRjBomUV1RMh2b9fj
        tc0hQWk9Vil5P9EGCZBNZW8=
X-Google-Smtp-Source: ABdhPJwXDtvsM++m/Iu0HjPfin1IyRtsUt7YkR5bDCzhG+W+2LKjpn8dGLlWVJOVwl6RYJr/z94avA==
X-Received: by 2002:a1c:1b44:: with SMTP id b65mr1202189wmb.188.1611560475444;
        Sun, 24 Jan 2021 23:41:15 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4b:4500:649e:f82b:bf2d:2571])
        by smtp.gmail.com with ESMTPSA id s25sm23313994wrs.49.2021.01.24.23.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 23:41:14 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] rcu-tasks: rectify kernel-doc for struct rcu_tasks
Date:   Mon, 25 Jan 2021 08:41:05 +0100
Message-Id: <20210125074105.29038-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The command 'find ./kernel/rcu/ | xargs ./scripts/kernel-doc -none'
reported an issue with the kernel-doc of struct rcu_tasks.

Rectify the kernel-doc, such that no issues remain for ./kernel/rcu/.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on v5.11-rc5 and next-20210122

Paul, please pick this minor kerneldoc cleanup.

 kernel/rcu/tasks.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index af7c19439f4e..17c8ebe131af 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -20,7 +20,7 @@ typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
 typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
 
 /**
- * Definition for a Tasks-RCU-like mechanism.
+ * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
  * @cbs_head: Head of callback list.
  * @cbs_tail: Tail pointer for callback list.
  * @cbs_wq: Wait queue allowning new callback to get kthread's attention.
@@ -38,7 +38,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @pregp_func: This flavor's pre-grace-period function (optional).
  * @pertask_func: This flavor's per-task scan function (optional).
  * @postscan_func: This flavor's post-task scan function (optional).
- * @holdout_func: This flavor's holdout-list scan function (optional).
+ * @holdouts_func: This flavor's holdout-list scan function (optional).
  * @postgp_func: This flavor's post-grace-period function (optional).
  * @call_func: This flavor's call_rcu()-equivalent function.
  * @name: This flavor's textual name.
-- 
2.17.1

