Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E427C4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 17:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6506101E
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 17:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhG1Rib (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhG1Rib (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 13:38:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A7506103E;
        Wed, 28 Jul 2021 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627493909;
        bh=xW/pDu1zJLsRdhipPxhrV+TMxZ+TgZXD4N6tQJtcRfE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tB6/5VSbif3jvDBNCRmmaMrwytQnX4Yoyu7LygD2P45NkLzXR8JzTkBj6JUkrQoxO
         rjO/VFLmXeFPBt0uHYsTyyptmi89PQngkYXBBYeZBBCFqseHWBNC7pIwpTFDl6cuJN
         Stwi+Um+293x65fsT67HkXzlsoYhfkoRgzBAC8gQowiPwBff5cSBniwgJt3UaA+Jjy
         kj+7PmthhN9T7eovbtErsfZBwuBIiBwQaY6Ehx71CMURnMuSSFllOW+lOyGA4jcUVw
         Ly2Um+eUf9WCgB7kEP1NcaiVukHqDky08VcBivd7N+KHO527gygAg5ylq67pg5hIKz
         uU7G7kr3ZVSng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 07E015C048D; Wed, 28 Jul 2021 10:38:29 -0700 (PDT)
Date:   Wed, 28 Jul 2021 10:38:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH v2 rcu 1/7] refscale: Add measurement of clock readout
Message-ID: <20210728173829.GB9416@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
 <20210721210441.796995-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721210441.796995-1-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds a "clock" type to refscale, which checks the performance
of ktime_get_real_fast_ns().  Use the "clocksource=" kernel boot parameter
to select the underlying clock source.

[ paulmck: Work around compiler false positive per kernel test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index d998a76fb5422..66dc14cf5687e 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -467,6 +467,40 @@ static struct ref_scale_ops acqrel_ops = {
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
+	for (i = nloops; i >= 0; i--)
+		x += ktime_get_real_fast_ns();
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
@@ -759,7 +793,7 @@ ref_scale_init(void)
 	int firsterr = 0;
 	static struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops, &refcnt_ops, &rwlock_ops,
-		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops,
+		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
