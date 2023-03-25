Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BECC6FD1F
	for <rcu@archiver.kernel.org>; Sat, 25 Mar 2023 17:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjCYReQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 25 Mar 2023 13:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjCYReH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:07 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C2EC52
        for <rcu@vger.kernel.org>; Sat, 25 Mar 2023 10:34:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id t19so4486356qta.12
        for <rcu@vger.kernel.org>; Sat, 25 Mar 2023 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6C53sn27NuA32AX3ykr9qVTka3YNyXyLo2FHjcHAPk=;
        b=yhQE5JitzdBNkzY0TYfTzuvOS/VKmMwn5KP2dPiUdYcgdHLPrmvZZ6Np/lG32lNBAd
         lt9VxOLDD0Yxnj/P9thYO1M/R2JLG12ggb55LdZcQNrb8ZOv8E4OD9ybmGmBVQE7U7t4
         vwfVjwDCDMeJ7G6L/7UIbp5+MZFMuw6ebBtYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6C53sn27NuA32AX3ykr9qVTka3YNyXyLo2FHjcHAPk=;
        b=D73FRGS1oKeBVVR9sHOqtuFC1zzt6pTI5yzeIjl9ldr8mUAT+Ok3qtyG+enBI7ztEP
         nWimAN+gX13qPlWn4BUpL073fVMIPtvacCbztv919Ch7i022vDyhJ/CYB4EgkTPmCgH7
         efqvNNB40aw+uuu+MAMYHk3tPD/4NsH/dclFx1aL87162FZsnRgjWykqMST2Xz2z5EdR
         89jOB9NsJOMR01BY+PCybvGTyQX0IcjVASNocBiyfDt8ABxiA4WuPVNiixJd43KRc1bo
         4oDtbjfhF4SNrqGlpzGTKnbdyDsKKQlrsDcOhBdYpbwU0deNxr6if/u1qM5jT1YcLVLJ
         PezQ==
X-Gm-Message-State: AO0yUKXqao/7bxT2qaft/0HQQXZtkuA2YaRrQzFkGPKeH1QdeyDAuk0Y
        gso6Miq3ee+0dpCCPIksGt9nfw==
X-Google-Smtp-Source: AK7set/kBRoccFhabLv3Raii1q34w76PXtiC0I5XZu7Br5sHC8TyaR8GiL2D8zsuukPc+azN0dL7kw==
X-Received: by 2002:ac8:5787:0:b0:3e3:98af:5de9 with SMTP id v7-20020ac85787000000b003e398af5de9mr12140109qta.63.1679765643455;
        Sat, 25 Mar 2023 10:34:03 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:34:03 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Cc:     rcu@vger.kernel.org
Subject: [PATCH v2 10/13] rcu: Permit start_poll_synchronize_rcu_expedited() to be invoked early
Date:   Sat, 25 Mar 2023 17:33:13 +0000
Message-Id: <20230325173316.3118674-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325173316.3118674-1-joel@joelfernandes.org>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

According to the commit log of the patch that added it to the kernel,
start_poll_synchronize_rcu_expedited() can be invoked very early, as
in long before rcu_init() has been invoked.  But before rcu_init(),
the rcu_data structure's ->mynode field has not yet been initialized.
This means that the start_poll_synchronize_rcu_expedited() function's
attempt to set the CPU's leaf rcu_node structure's ->exp_seq_poll_rq
field will result in a segmentation fault.

This commit therefore causes start_poll_synchronize_rcu_expedited() to
set ->exp_seq_poll_rq only after rcu_init() has initialized all CPUs'
rcu_data structures' ->mynode fields.  It also removes the check from
the rcu_init() function so that start_poll_synchronize_rcu_expedited(
is unconditionally invoked.  Yes, this might result in an unnecessary
boot-time grace period, but this is down in the noise.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c     | 5 ++---
 kernel/rcu/tree_exp.h | 5 +++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e80e8f128c57..90d54571126a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4942,9 +4942,8 @@ void __init rcu_init(void)
 	else
 		qovld_calc = qovld;
 
-	// Kick-start any polled grace periods that started early.
-	if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
-		(void)start_poll_synchronize_rcu_expedited();
+	// Kick-start in case any polled grace periods started early.
+	(void)start_poll_synchronize_rcu_expedited();
 
 	rcu_test_sync_prims();
 }
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 7cc4856da081..5343f32e7d67 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -1066,9 +1066,10 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
 	if (rcu_init_invoked())
 		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	if (!poll_state_synchronize_rcu(s)) {
-		rnp->exp_seq_poll_rq = s;
-		if (rcu_init_invoked())
+		if (rcu_init_invoked()) {
+			rnp->exp_seq_poll_rq = s;
 			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
+		}
 	}
 	if (rcu_init_invoked())
 		raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
-- 
2.40.0.348.gf938b09366-goog

