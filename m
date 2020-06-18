Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF260C433DF
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF5F5206D7
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PVkJdZ6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgFRUaQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731049AbgFRUaL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 16:30:11 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3199CC0613EE
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 13:30:11 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b4so6884100qkn.11
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXOY80zP5DTGa2P2cTJCL50OXE5o8dCDlUAXQJxFT40=;
        b=PVkJdZ6QZnZUy/fzn7hdZKM5iI/5Fj6ZIzrQ6FadjCLVkfYPf3mmiY1xvEqPhjllOn
         DlE2bMr5BZlJCA9/XG4gRfGOxy1zQpW6qhwQ7yYxibBBrlQiyDzT642aw2VkgHpqCceh
         Qb5mK8WNToXUGxya5bNMeuEoXhxGbsjHH/MwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXOY80zP5DTGa2P2cTJCL50OXE5o8dCDlUAXQJxFT40=;
        b=rFr7TpB8VLqBoMmqNoYYRZicis6lfRoEih+Y6GLO3iNZOrOjuReR/WSo3UqcI8k5s2
         3i+NVxkahzYVNMz6jKwaiLs+LxD2puZa3bV0PIMyPlNK7KBPx0W4WkE9TRZZkcEi0Ijf
         JtDRMYyi7FjEIK/LEWhXiiUuHuJWroihq+gB7axdQIrFeikPkW0P8q7Cks5bRJd3zJEG
         9TPnPLS4OjTeKCmumWgrl9dWDWc2SESb4ABgjIzxl+aZ7hbR0y86peh7yrKO3NQhsf7J
         A98HIPMc8lpij4zKzCd4uRZ0QLGyTUJTWzHxbjtt4GgPeYv6fmmyboTRhVRVWvUzwizt
         xltA==
X-Gm-Message-State: AOAM5309wvYKqZsACndoOnVqd6vWOrTvmMVOWXZtT54ph4MAIYVCv4EF
        cG0nLbfjiNxUJchokyxRpfAFqA==
X-Google-Smtp-Source: ABdhPJzOFsxJVE25GfsTuz09IIseeDgxFpt3VptEBshXz/ZlPaN37uZCUluuLZlUoQ1/t5Wjejn/OQ==
X-Received: by 2002:a37:6c2:: with SMTP id 185mr205227qkg.95.1592512210427;
        Thu, 18 Jun 2020 13:30:10 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v3sm4027503qkh.130.2020.06.18.13.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:30:10 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 7/7] rcutorture: Add number of GP information to reports
Date:   Thu, 18 Jun 2020 16:29:55 -0400
Message-Id: <20200618202955.4024-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200618202955.4024-1-joel@joelfernandes.org>
References: <20200618202955.4024-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add 2 things to get visiblity around number of grace periods.
1. Add number of GPs to End-state print.
2. Just like End-state, add GP state to Start-state.

This helps determine how many GPs elapsed during a run of rcutorture and
what the initial state was.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 959a1f84d6904..c80725ddd9030 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -186,6 +186,7 @@ static long n_barrier_successes; /* did rcu_barrier test succeed? */
 static unsigned long n_read_exits;
 static struct list_head rcu_torture_removed;
 static unsigned long shutdown_jiffies;
+static unsigned long start_gp_seq;
 
 static int rcu_torture_writer_state;
 #define RTWS_FIXED_DELAY	0
@@ -2508,8 +2509,9 @@ rcu_torture_cleanup(void)
 
 	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
 	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
-	pr_alert("%s:  End-test grace-period state: g%lu f%#x\n",
-		 cur_ops->name, gp_seq, flags);
+	pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
+		 cur_ops->name, (long)gp_seq, flags,
+		 rcutorture_seq_diff(gp_seq, start_gp_seq));
 	torture_stop_kthread(rcu_torture_stats, stats_task);
 	torture_stop_kthread(rcu_torture_fqs, fqs_task);
 	if (rcu_torture_can_boost())
@@ -2633,6 +2635,8 @@ rcu_torture_init(void)
 	long i;
 	int cpu;
 	int firsterr = 0;
+	int flags = 0;
+	unsigned long gp_seq = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
 		&busted_srcud_ops, &tasks_ops, &tasks_rude_ops,
@@ -2675,6 +2679,11 @@ rcu_torture_init(void)
 			nrealreaders = 1;
 	}
 	rcu_torture_print_module_parms(cur_ops, "Start of test");
+	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
+	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
+	start_gp_seq = gp_seq;
+	pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
+		 cur_ops->name, (long)gp_seq, flags);
 
 	/* Set up the freelist. */
 
-- 
2.27.0.111.gc72c7da667-goog

