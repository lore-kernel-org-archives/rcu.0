Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE460C2D0EE
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E1A2078B
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="e/QROEfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgC3Cdt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:33:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34011 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgC3Cdt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id 10so13937334qtp.1
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nfe8DrKWUp4DznQJ7QwjX25sDztlI0Q1Kzc2EbjhIfI=;
        b=e/QROEfb5RGTR9IB9T4I6da+BeTQWc1g0g4Y4IB6QTSmalMQrHGbXLRXYVq0YbVzhs
         tP2sTlESNLvrtJivJplrhzgd3CeNe5CxFhf+jkbqQ4hFWDiT7AJDlWveUX3cErsFRXs6
         BxPFwUArDnqMXIc2Ozny0JZzGurm8NA5J/8uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nfe8DrKWUp4DznQJ7QwjX25sDztlI0Q1Kzc2EbjhIfI=;
        b=VDVUKSiDXoIv2z7RohE/oOCWCLM+y6Op+rOr1HFgohFS+pP4GDqrvFPMANZ25VI/g3
         RvnW+8jPh05sgnvVv/52PZFIopfJ+3jacYVsxEJo18CPjlLu5PjlUEpZwZTzktNcY7mw
         VQGHy4mzszTn3FVLdf84FpLtnSMCp9sULjkW+CCBA5hDR8CAV79NyJsMpRwUFMCwNTk+
         yigOGhsAkb4ApATdUQQ4iw5mkofA1bmXXUcQFvdHlch7HnWA9vTvQ/iJbolWfG+ZQnSc
         oUJOT5kw6ss4SiyZV4KcT1rC5uEMyF0v9+hWIB9Hvwvc0clNclS3LKm1oJS4e1o4h5+S
         8EFg==
X-Gm-Message-State: ANhLgQ0smKz7jnvegrHslt92P0LxlWHIxA1zMnZQnMQQPuDjTWLgjkW+
        7Qxz5sjBKeQEwVBC9ns2dMm7kQ==
X-Google-Smtp-Source: ADFU+vte8V+MFLpGv25SbcL8/a36+3V3dZDn+RHDRlNYMBkkicXPxgyi30CKdwoHh7ULy/2SwK0YqQ==
X-Received: by 2002:ac8:922:: with SMTP id t31mr9208234qth.95.1585535628345;
        Sun, 29 Mar 2020 19:33:48 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:48 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 17/18] rcu/tree: Simplify is_vmalloc_addr expression
Date:   Sun, 29 Mar 2020 22:32:47 -0400
Message-Id: <20200330023248.164994-18-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

No code change, small refactor.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 56c9e102a901d..311d216c7faa7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3104,7 +3104,7 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 		return false;
 
 	lockdep_assert_held(&krcp->lock);
-	idx = !is_vmalloc_addr(ptr) ? 0:1;
+	idx = !!is_vmalloc_addr(ptr);
 
 	/* Check if a new block is required. */
 	if (!krcp->bkvhead[idx] ||
-- 
2.26.0.rc2.310.g2932bb562d-goog

