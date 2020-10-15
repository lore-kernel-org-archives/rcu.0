Return-Path: <SRS0=9/AT=DW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF97C433E7
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 01:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 650EA22254
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 01:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KHZxHPt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbgJOBjr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389192AbgJOBjj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Oct 2020 21:39:39 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7719DC0F26DE
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 17:23:13 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q1so2058600ilt.6
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r29xpTf6pvYM7gD58XVxOmq2IxwCczlKKPsLjfq0wY8=;
        b=KHZxHPt6wIS2EIC6+g6Kc2+u9s6sj9IprZGUn/lUToLDA0H9JPuf68sgMH615RcYV5
         2KPQ53rnHBPMIyEcqXIwDoAqJAoUwR6YvYeTUsmqwh8Trv4v5MYa+KBCJrJtYp4Qd8DO
         7xQqxM2quYkYjDou9hx3Gc0fm2RcgCe5XSlmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r29xpTf6pvYM7gD58XVxOmq2IxwCczlKKPsLjfq0wY8=;
        b=NC1/pspcWnJCjCegAshhj4s9uyezNunFp2UZB9Eq6nRB61Z80OtIG1tU8uWJBDky1L
         YzhJz2H39GQT3yHnC2eVt7LV691zi0YOJSGIILhM662DPzqBUiSGZP6e7SUEZK9kDuPN
         2QuWqxHDAg1lIu5V/KIWpvAgRihv7T0gfFFBvM7qQjdePBrFqHcgy1V4mbMDNKxp4Ah5
         99ZEI9OBokQMybFa082sma9Tjg4oMURH63fOpgqoyLIiIAavTfa+v+YBpQQxMMmUUiyR
         C8xeAnd43DaDBZN6vaqm2be77J40l0JNeX+OuNjkftYibg6xedUojddjs9FtZrKJZJ/9
         5Swg==
X-Gm-Message-State: AOAM5307HrxgWWNGuKv2kPC4bxWKYfX90WvL7gAdWd57cN3omry+PJoV
        LSDFiEwoTlp+2FIUe1qpN+2tmQ==
X-Google-Smtp-Source: ABdhPJzpXsMpawpBva537F45BAEL+dWfZtKhDdPmyxDV30In3qYw4avOkfAgI8DUhD6kF+BknXSCyg==
X-Received: by 2002:a92:c213:: with SMTP id j19mr1288001ilo.205.1602721392906;
        Wed, 14 Oct 2020 17:23:12 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r4sm1075622ilc.32.2020.10.14.17.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:23:12 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v7 5/6] rcu/tree: Remove redundant smp_mb() in rcu_do_batch
Date:   Wed, 14 Oct 2020 20:23:00 -0400
Message-Id: <20201015002301.101830-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201015002301.101830-1-joel@joelfernandes.org>
References: <20201015002301.101830-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This memory barrier is not needed as rcu_segcblist_add_len() already
includes a memory barrier.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 346a05506935..6c6d3c7036e6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2525,7 +2525,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
-	smp_mb(); /* List handling before counting for rcu_barrier(). */
 	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
-- 
2.28.0.1011.ga647a8990f-goog

