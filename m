Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42093C2BB48
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 20:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1223123B99
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 20:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbgLIU3E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387764AbgLIU3D (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 15:29:03 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFDBC0613D6;
        Wed,  9 Dec 2020 12:28:22 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y22so3970095ljn.9;
        Wed, 09 Dec 2020 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r7X+qMHHXynKlFUBS+aa2jV1Xf5viHTgNOxEqaUj2j8=;
        b=kVnDuHAfprRwHXchEqvRdwvxrgao7FtoeNK6k/31jKdochzbvXDtp7MT9w2V2/QhPd
         GuZ45oUen5O61A1bBnDeOPCXDHmcfOK++onN5+2geNc1MhkzTB6HqzbTLJLRX2Bbc4Rp
         4pHOOlQQTrto5S26tWS15hqmSt6sc1U8957xn9Hh8G9Dy5JN38wnSi0r5dJZWPpg1hd9
         Ob3eQy93S0eP5aOT9lTS281/fIve8hE36utNWDUW0NABGuAn0dJBA4P3SSmyggqPz9nU
         2NOJeKOBeaFVseLjJ54P0LAF5G1yEf/FQOwTdxAmQQ8aClSvl7sfCgHOs7oX2c+IOvor
         z/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r7X+qMHHXynKlFUBS+aa2jV1Xf5viHTgNOxEqaUj2j8=;
        b=Nr6ZXPwuIjOfSNj+200z3GjaYfQtC5FbaEksDv78S1ICx+j+1a1+lIVBj8ammL/ofl
         8k61Fssq1ILm5z0Ku0vUlZPAt4yHHSqS9z62qEteAuttArsr3cE9/fiYqLpoV4C2HjUK
         1+723+YU4PUnzPYc7ZFPr52LvkQumaotY/004HslDsNhNV+sjgQP80g505kDvYgWUm04
         4nkZ+KdIf4eeDIdOBM+l9rLYD+KapfAlot9rBCbB7OWsyLs+4fAc4nIPSJqrxwbouHs5
         NyFRk8rxEV2h8N6LQSw4BSSeD6GcUP3C63FTZdoviEDa4Yo2oX7+ucTMc5fexhgtyBUq
         Z0Vw==
X-Gm-Message-State: AOAM531lt8UUVgFO+A3j+/MEOBXbrcp4S8ywVKjeptqBaIew5mJxJkb0
        vQdiLiUV9bnwq3/vGSXhCDtDXE5K1SfZCA==
X-Google-Smtp-Source: ABdhPJxs08XJoLLDVxDQzbnE8VP9aIoOT5nhH7DK/eggOyTgF8w6b4RcHx+NZxvoFAund4BHIwEnrg==
X-Received: by 2002:a2e:b6d0:: with SMTP id m16mr142942ljo.133.1607545700983;
        Wed, 09 Dec 2020 12:28:20 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id z26sm17323lja.125.2020.12.09.12.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:28:20 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 2/2] rcu-tasks: add RCU-tasks self tests
Date:   Wed,  9 Dec 2020 21:27:32 +0100
Message-Id: <20201209202732.5896-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201209202732.5896-1-urezki@gmail.com>
References: <20201209202732.5896-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add self tests for checking of RCU-tasks API functionality.
It covers:
    - wait API functions;
    - invoking/completion call_rcu_tasks*().

Self-tests are run when CONFIG_PROVE_RCU kernel parameter is set.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tasks.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 67a162949763..9407772780c1 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1225,6 +1225,16 @@ void show_rcu_tasks_gp_kthreads(void)
 }
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+static struct rcu_head rhp;
+static int rcu_execurted_test_counter;
+static int rcu_run_test_counter;
+
+static void test_rcu_tasks_callback(struct rcu_head *r)
+{
+	pr_info("RCU-tasks test callback executed %d\n",
+		++rcu_execurted_test_counter);
+}
+
 void __init rcu_init_tasks_generic(void)
 {
 #ifdef CONFIG_TASKS_RCU
@@ -1238,7 +1248,41 @@ void __init rcu_init_tasks_generic(void)
 #ifdef CONFIG_TASKS_TRACE_RCU
 	rcu_spawn_tasks_trace_kthread();
 #endif
+
+	if (IS_ENABLED(CONFIG_PROVE_RCU)) {
+		pr_info("Running RCU-tasks wait API self tests\n");
+#ifdef CONFIG_TASKS_RCU
+		rcu_run_test_counter++;
+		call_rcu_tasks(&rhp, test_rcu_tasks_callback);
+		synchronize_rcu_tasks();
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+		rcu_run_test_counter++;
+		call_rcu_tasks_trace(&rhp, test_rcu_tasks_callback);
+		synchronize_rcu_tasks_rude();
+#endif
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+		rcu_run_test_counter++;
+		call_rcu_tasks_trace(&rhp, test_rcu_tasks_callback);
+		synchronize_rcu_tasks_trace();
+#endif
+	}
+}
+
+static int rcu_tasks_verify_self_tests(void)
+{
+	int ret = 0;
+
+	if (rcu_run_test_counter != rcu_execurted_test_counter) {
+		WARN_ON(1);
+		ret = -1;
+	}
+
+	return ret;
 }
+late_initcall(rcu_tasks_verify_self_tests);
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
-- 
2.20.1

