Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390B4C6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E4A613D3
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhGUUYJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbhGUUYH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:24:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 497FE61009;
        Wed, 21 Jul 2021 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901483;
        bh=/VxKSMWdxAhj2KXF42bEUqeXKTmhfN1e2+A7r0mzqZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NiApJ/s9McBsqyp6hwNmlVuSU5q423/ekDjOy7s0QJ2VHg5LoVSWKwoaG+ldvSbgY
         8jODOkZ44Fgf16d8UujSN0CE+yA/wdkJDtKfkwdJoORbMZNpic38GEVx0d0MGyj9/9
         EjIhQfclFwlvBLsdKtG7353Z/NZWA8yHom2qCy5JOooxlDpaM3C4jcw0ALRxSyhPJa
         HHkHv1znQWvsRBs9QvhC04a2mFNcgSWOWD06NsnGedl/EOOIv2GTRNJlL5TJ9s5QlG
         kvLNRowaxwkOQmSNvzgbtNAjBlAyOYdydM0zWXcQQXzYmPtE33zeyAxmQnGhxPgo/c
         PzaALddQyjhIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 182AC5C09A4; Wed, 21 Jul 2021 14:04:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/7] refscale: Add measurement of clock readout
Date:   Wed, 21 Jul 2021 14:04:35 -0700
Message-Id: <20210721210441.796995-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds a "clock" type to refscale, which checks the performance
of ktime_get_real_fast_ns().  Use the "clocksource=" kernel boot parameter
to select the underlying clock source.

[ paulmck: Work around compiler false positive per kernel test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index d998a76fb5422..cba737cb246e8 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -467,6 +467,41 @@ static struct ref_scale_ops acqrel_ops = {
 	.name		= "acqrel"
 };
 
+static volatile u64 stopopts;
+
+static void ref_clock_section(const int nloops)
+{
+	u64 x = 0;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		x += ktime_get_real_fast_ns();
+	}
+	preempt_enable();
+	stopopts = x;
+}
+
+static void ref_clock_delay_section(const int nloops, const int udl, const int ndl)
+{
+	u64 x = 0;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		x += ktime_get_real_fast_ns();
+		un_delay(udl, ndl);
+	}
+	preempt_enable();
+	stopopts = x;
+}
+
+static struct ref_scale_ops clock_ops = {
+	.readsection	= ref_clock_section,
+	.delaysection	= ref_clock_delay_section,
+	.name		= "clock"
+};
+
 static void rcu_scale_one_reader(void)
 {
 	if (readdelay <= 0)
@@ -759,7 +794,7 @@ ref_scale_init(void)
 	int firsterr = 0;
 	static struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops, &refcnt_ops, &rwlock_ops,
-		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops,
+		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.31.1.189.g2e36527f23

