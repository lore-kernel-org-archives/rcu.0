Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90EFC433F5
	for <rcu@archiver.kernel.org>; Tue, 11 Oct 2022 18:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJKSCf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJKSCW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:22 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D986B8C2
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x13so6474032qkg.11
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlIK2JXtSjygcKXNSyavYIOSGjfzQt35OWNq3l9CMzQ=;
        b=LvBDgkuJk+IME5zmgDjzf4o701MY4MrpG2hj9D4Yl0n0HtP4/bQbYD9I5awN4feWVN
         7ToN+BTdNlAqAY7OXtImUg/VOd+vZC3eAC9q6m7tdq+u/Zn4o31C8CEbGrzQtyrHwkRc
         XUa97CYGEZDQwWiWYW4ZLyQGxUHUmcV1jqaC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlIK2JXtSjygcKXNSyavYIOSGjfzQt35OWNq3l9CMzQ=;
        b=Jb9ArlT9xQKdjKv3b4deX+FlauJ+RFd949Q/keJGtKO00UmKwNboQ6hMb5Ol4LfZny
         xxn57y3tF2eqFgzYMcaXt/NqwcHKZ0CutnKFPucF0Awpxf3BrOmwTJDzsg8jsIaguhSA
         qThrCtgBkwEkTLDPHHREQnVSrYFm08utEB0vpBnRepngiOlTfW5RsXxkKy11EEqwVSy9
         WGJouZQDMeELFQ6XJH+KTmqatPAQVEflXB+B2znDfAwiwHhyPFOg7G+WJBRqzmcXa/88
         1+8ZMn5tsuN9fbmQovHfE9e1TnOWg8vm8zfG01tEzGiD1/akHzm79TtwoDgAk5qfPqXi
         8NQw==
X-Gm-Message-State: ACrzQf0xzRWBs3rr9HfvlyUMQUx3oUeqGLo2gm6onI1isQQeeBf9cieY
        LGbqs0L055T8kEWalAlwfZkukAH/vRZREQ==
X-Google-Smtp-Source: AMsMyM7CLgOFIWKuZVilXx5Cjc1utA74DBNWWqb1zOCxU7VQ07T65f98zJIXad5IQoheKYK3FYBZpA==
X-Received: by 2002:a37:e205:0:b0:6ee:834:1a1b with SMTP id g5-20020a37e205000000b006ee08341a1bmr5591875qki.342.1665511335777;
        Tue, 11 Oct 2022 11:02:15 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:15 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 09/13] rcu/rcutorture: Use call_rcu_flush() where needed
Date:   Tue, 11 Oct 2022 18:01:38 +0000
Message-Id: <20221011180142.2742289-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

call_rcu() changes to save power will change the behavior of rcutorture
tests. Use the call_rcu_flush() API instead which reverts to the old
behavior.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 684e24f12a79..fd56202ae4f4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -514,7 +514,7 @@ static unsigned long rcu_no_completed(void)
 
 static void rcu_torture_deferred_free(struct rcu_torture *p)
 {
-	call_rcu(&p->rtort_rcu, rcu_torture_cb);
+	call_rcu_flush(&p->rtort_rcu, rcu_torture_cb);
 }
 
 static void rcu_sync_torture_init(void)
@@ -559,7 +559,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.start_gp_poll_exp_full	= start_poll_synchronize_rcu_expedited_full,
 	.poll_gp_state_exp	= poll_state_synchronize_rcu,
 	.cond_sync_exp		= cond_synchronize_rcu_expedited,
-	.call			= call_rcu,
+	.call			= call_rcu_flush,
 	.cb_barrier		= rcu_barrier,
 	.fqs			= rcu_force_quiescent_state,
 	.stats			= NULL,
@@ -863,7 +863,7 @@ static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)
 
 static void synchronize_rcu_mult_test(void)
 {
-	synchronize_rcu_mult(call_rcu_tasks, call_rcu);
+	synchronize_rcu_mult(call_rcu_tasks, call_rcu_flush);
 }
 
 static struct rcu_torture_ops tasks_ops = {
@@ -3432,13 +3432,13 @@ static void rcu_test_debug_objects(void)
 	/* Try to queue the rh2 pair of callbacks for the same grace period. */
 	preempt_disable(); /* Prevent preemption from interrupting test. */
 	rcu_read_lock(); /* Make it impossible to finish a grace period. */
-	call_rcu(&rh1, rcu_torture_leak_cb); /* Start grace period. */
+	call_rcu_flush(&rh1, rcu_torture_leak_cb); /* Start grace period. */
 	local_irq_disable(); /* Make it harder to start a new grace period. */
-	call_rcu(&rh2, rcu_torture_leak_cb);
-	call_rcu(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
+	call_rcu_flush(&rh2, rcu_torture_leak_cb);
+	call_rcu_flush(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
 	if (rhp) {
-		call_rcu(rhp, rcu_torture_leak_cb);
-		call_rcu(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
+		call_rcu_flush(rhp, rcu_torture_leak_cb);
+		call_rcu_flush(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
 	}
 	local_irq_enable();
 	rcu_read_unlock();
-- 
2.38.0.rc1.362.ged0d419d3c-goog

