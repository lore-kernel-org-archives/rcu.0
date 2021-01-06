Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BF6C4332D
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF3723120
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbhAFRSe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbhAFRSe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:18:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 060D92313F;
        Wed,  6 Jan 2021 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953434;
        bh=w8IVjcpkGX23ZnvKB1fiGk04ow+NnO20l/fNzsdfXMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DyRG8lTxrWmfD1G11pUndjIHg+ibWVqWgBEQmWqvVDajw8N2coCZ201Ny0nZs6Lod
         49/ORk42meizal5UN4Xg1rVUGvtVfehQQcTntYB0tW0QGBkWUy73AUcWpvD2dVmTTd
         hXPZNhnajdCCuGPSy8OJQpewnls5pBxxuf+7qHhIuSMGCXpEm4yKiF4V9hEf9YWAd9
         1tEwWEF0DvqtA++lmRKMhtAnp5PPHoO2KIXwKAsz1Ktr/BUjw/O1ikMmFfHxVBo5Vn
         fZWbUF/n2JsAV7IB/WzfF4CSNGC5xUzyapLlmT7rXfpt6HsJaOsQUut+5yD1q1lAuH
         crhdWEc/DzKbA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/17] torture: Make refscale throttle high-rate printk()s
Date:   Wed,  6 Jan 2021 09:17:04 -0800
Message-Id: <20210106171710.22239-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a short delay for verbose_batched-throttled printk()s
to further decrease console flooding.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 3da246f..02dd976 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -52,8 +52,10 @@ static atomic_t verbose_batch_ctr;
 do {											\
 	if (verbose &&									\
 	    (verbose_batched <= 0 ||							\
-	     !(atomic_inc_return(&verbose_batch_ctr) % verbose_batched)))		\
+	     !(atomic_inc_return(&verbose_batch_ctr) % verbose_batched))) {		\
+		schedule_timeout_uninterruptible(1);					\
 		pr_alert("%s" SCALE_FLAG s, scale_type, ## x);				\
+	}										\
 } while (0)
 
 #define VERBOSE_SCALEOUT_ERRSTRING(s, x...) \
-- 
2.9.5

