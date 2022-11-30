Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB50EC4321E
	for <rcu@archiver.kernel.org>; Wed, 30 Nov 2022 08:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiK3Ijb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Nov 2022 03:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiK3Ija (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Nov 2022 03:39:30 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399D729355
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 00:39:29 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f9so15403145pgf.7
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 00:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CbRpmc4p8ahyz+NjaP0qC3hsE75f12l/2LXlt3YTn3w=;
        b=CzGoTYlDBnNdc0RtpLuCCN4ECvBsTVMof3e/O9wsATEs0Ouf54gTCFGjhnOBCNu32x
         AolvcMeOCfpjOvxiQpI40JtNoNj5pQW8sj/y9uk4ZRVrXvoZXinJ95tfQLB9vN3YegNr
         FpEvpPh5hAHu9VATIrGZV98bzltYC70akh4jDjTOcKLgNWKjADEr+hy+3qmHr1dLQT7k
         SUzj9tQPQ+wGfPv8t2bN/4TJwBPqQnzEsx0V4os9Tv9/ljj5fYe9bauOHj1YH049uLZp
         bsPOveIbFBEZi74ati/RhauyHXu+c/jmUTbE8mXlM0qdGxi96yhaD2trn8LJg+VkRsW+
         RGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbRpmc4p8ahyz+NjaP0qC3hsE75f12l/2LXlt3YTn3w=;
        b=YqL+tFEKU5JmWoHuhRQYYdKlofKh4rAHFGByuBI4529uNree65s2MiuL+tt/qeKqXZ
         9YHh9a3txENPanpKDeeYyG4MDTPDcQDlrVFT7Guj4Q2ti9GJ9ohC6LsaVEerYOlmNKXT
         YT69zS49upJ5oPK0qzHS74MVaOc39p3luoFj9IHPmjuQqywh8BRJwdyz7zvJq0WYmwvE
         xSaLgOe5Ro1VscC5mlngRzF50z832nUuoI8XFOjH6p7GblK4MKQm3069851RVQURPQdJ
         fbpzQYMllIGuWDeeUTGhNHnDm2V9paK99EidlfO6MWKeQ1arBJ6ByjuRANgg3Q9KBMSJ
         gqwQ==
X-Gm-Message-State: ANoB5plxt05ZjEhQo0982H/o/Qvi00y8/l4/wgG+vSN12orcSgAXxLy0
        L5jhHgA9SOfQGtrI7t5V1JJkpAkAyQBMbuo=
X-Google-Smtp-Source: AA0mqf771Y81SxWDUY7aCbaBOlGVtdyyuw4bvNq4vKNz0h4ymDZ7lgJLdI0rQKp8Tckw9gOD2OSMUA==
X-Received: by 2002:a05:6a00:2403:b0:572:698b:5f69 with SMTP id z3-20020a056a00240300b00572698b5f69mr45400005pfh.54.1669797568263;
        Wed, 30 Nov 2022 00:39:28 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b00176b3c9693esm773717pls.299.2022.11.30.00.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:39:27 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH] srcu: switch work func to allow concurrent gp
Date:   Wed, 30 Nov 2022 16:39:02 +0800
Message-Id: <20221130083902.31577-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

ssp->srcu_cb_mutex is introduced to allow the other srcu state machine
to advance as soon as possible. But according to the implement of
workqueue, the same work_struct is serialized and can not run
concurrently in fact.

Quoting from Documentation/core-api/workqueue.rst
"
Non-reentrance Conditions
=========================

Workqueue guarantees that a work item cannot be re-entrant if the following
conditions hold after a work item gets queued:

        1. The work function hasn't been changed.
        2. No one queues the work item to another workqueue.
        3. The work item hasn't been reinitiated.
"

To allow the concurrence to some extent, it can be achieved by changing
the work function to break the conditions. As a result, when
srcu_gp_end() releases srcu_gp_mutex, a new state machine can begin.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/srcutree.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..56dd9bb2c8b8 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -75,6 +75,7 @@ static bool __read_mostly srcu_init_done;
 static void srcu_invoke_callbacks(struct work_struct *work);
 static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
 static void process_srcu(struct work_struct *work);
+static void process_srcu_wrap(struct work_struct *work);
 static void srcu_delay_timer(struct timer_list *t);
 
 /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(). */
@@ -763,6 +764,11 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 		cbdelay = 0;
 
 	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
+	/* Change work func so work can be concurrent */
+	if (ssp->work.work.func == process_srcu_wrap)
+		ssp->work.work.func = process_srcu;
+	else
+		ssp->work.work.func = process_srcu_wrap;
 	rcu_seq_end(&ssp->srcu_gp_seq);
 	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
@@ -1637,6 +1643,19 @@ static void process_srcu(struct work_struct *work)
 	srcu_reschedule(ssp, curdelay);
 }
 
+/*
+ * The ssp->work is expected to be concurrent to some extent, but the current
+ * workqueue does not support the concurrence on the same work. (Refer to the
+ * section "Non-reentrance Conditions" in the file workqueue.rst)
+ * Resolving it by changing the work func.
+ *
+ * Prevent compilering from optimizing out it.
+ */
+static __used void process_srcu_wrap(struct work_struct *work)
+{
+	process_srcu(work);
+}
+
 void srcutorture_get_gp_data(enum rcutorture_type test_type,
 			     struct srcu_struct *ssp, int *flags,
 			     unsigned long *gp_seq)
-- 
2.31.1

