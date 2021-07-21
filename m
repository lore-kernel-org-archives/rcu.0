Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E373EC6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCBEB61363
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGUUYH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhGUUYH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:24:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C1356135A;
        Wed, 21 Jul 2021 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901483;
        bh=uLNy3yIK4EBO9lKuJ5GSBVXdPDG6YtLrOMDVTxwg7p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gu3El/Kk9uCmsl/KjH8HLKmaHv/2RDJD2+HXUoTj66/HggQXCoGI2NUC1fTUjmwqC
         NnS7ZhqzPq6VR7bmfHF0hsjWFvOTDTvvpaC7R9RSj70VkLHIbW0lIJ1CkSQr43WegV
         1HTNB2pK5++j9NsD0khW+NWA/6+IlXHOLYv2f/4tbiwUCyUpdupS0vuNbmZPhzts16
         v09UeDpUpTSC4kkzUo+LEQZuCjDYOT2MVTvYpNMu3lNKl0qgJJ3AETr0UU+wcxVZnU
         dLHCIFexxrkCSR7oN2urjJqxE5Vhy2iVyYB85rBpt3Wfv4g0K8MPHRSK9A0KUdTA5H
         jqjxHWI6i0eSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 251125C0A2D; Wed, 21 Jul 2021 14:04:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/7] locktorture: Mark statistics data races
Date:   Wed, 21 Jul 2021 14:04:38 -0700
Message-Id: <20210721210441.796995-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The lock_stress_stats structure's ->n_lock_fail and ->n_lock_acquired
fields are incremented and sampled locklessly using plain C-language
statements, which KCSAN objects to.  This commit therefore marks the
statistics gathering with data_race() to flag the intent.  While in
the area, this commit also reduces the number of accesses to the
->n_lock_acquired field, thus eliminating some possible check/use
confusion.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index b3adb40549bf3..313d5e613fbe6 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -738,20 +738,22 @@ static int lock_torture_reader(void *arg)
 static void __torture_print_stats(char *page,
 				  struct lock_stress_stats *statp, bool write)
 {
+	long cur;
 	bool fail = false;
 	int i, n_stress;
-	long max = 0, min = statp ? statp[0].n_lock_acquired : 0;
+	long max = 0, min = statp ? data_race(statp[0].n_lock_acquired) : 0;
 	long long sum = 0;
 
 	n_stress = write ? cxt.nrealwriters_stress : cxt.nrealreaders_stress;
 	for (i = 0; i < n_stress; i++) {
-		if (statp[i].n_lock_fail)
+		if (data_race(statp[i].n_lock_fail))
 			fail = true;
-		sum += statp[i].n_lock_acquired;
-		if (max < statp[i].n_lock_acquired)
-			max = statp[i].n_lock_acquired;
-		if (min > statp[i].n_lock_acquired)
-			min = statp[i].n_lock_acquired;
+		cur = data_race(statp[i].n_lock_acquired);
+		sum += cur;
+		if (max < cur)
+			max = cur;
+		if (min > cur)
+			min = cur;
 	}
 	page += sprintf(page,
 			"%s:  Total: %lld  Max/Min: %ld/%ld %s  Fail: %d %s\n",
-- 
2.31.1.189.g2e36527f23

