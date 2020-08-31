Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE957C433E7
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C651B2083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897358;
	bh=IqBPY769hzDOI/BG43saaXqPp2h4NGr/1gHwqrCupjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y4Wqz1PLyymqN3lNeIZ3Oud71+7Knl+STBlC/vX6hCNS7iosGfNl/kKwkIkWw53Ss
	 YWJPMv+VwvkxEUKLzQp7Gz698BgUadmB7dwbF74pP54jgtO1plNHaeK60M2tD2rgzX
	 zkm/Ra3bzfvESCHuC7XI9/GeJLh86pbDEDjsoYt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgHaSJA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729275AbgHaSH4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24062168B;
        Mon, 31 Aug 2020 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897274;
        bh=IqBPY769hzDOI/BG43saaXqPp2h4NGr/1gHwqrCupjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Df+lVwCVMCkuzMXd7Y9uIrz9ce9YZ7hjMpIUJvwmg+UQEupsMuYhipaAXkxOGWjKW
         f30Y3wPkh/JYqEjCVk2cCh0xKXxHJp+tclLABZ91V/c5p3md3b6dHnNVuO/WGuKsH4
         8+XmJHZg92/bhHr5HC1nlo44wC7Mesilf4RhYKH0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/19] scftorture: Make symbol 'scf_torture_rand' static
Date:   Mon, 31 Aug 2020 11:07:44 -0700
Message-Id: <20200831180749.843-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The sparse tool complains as follows

kernel/scftorture.c:124:1: warning:
 symbol '__pcpu_scope_scf_torture_rand' was not declared. Should it be static?

And this per-CPU variable is not used outside of scftorture.c,
so this commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 8349681..9180de7 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -134,7 +134,7 @@ static atomic_t n_alloc_errs;
 static bool scfdone;
 static char *bangstr = "";
 
-DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
+static DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
 
 // Print torture statistics.  Caller must ensure serialization.
 static void scf_torture_stats_print(void)
-- 
2.9.5

