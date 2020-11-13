Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005CBC56202
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970D32085B
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaR0BoWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgKMMO2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:14:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbgKMMO1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:27 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 048AE2224F;
        Fri, 13 Nov 2020 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269666;
        bh=2wX32pzaUsSeA2hWLhU4VMj2gnnaEO0hHOrH98cWcKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WaR0BoWgYeBHWmVHq7P9YlGXvkwB1PvwRFLE7JK24lv9JHDCoHI1IbGTvKGaUz07t
         gclAQSKRXG1BXU6SWPkFkbbCV/j0dhh4mlhCJwKIhFfNvZNYO/6nGyz97gIDROKq+T
         WesVVa4N5bFs22bV09e1vVzId9skr8q8G8JfVKcU=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 14/19] tools/rcutorture: Support nocb toggle in TREE01
Date:   Fri, 13 Nov 2020 13:13:29 +0100
Message-Id: <20201113121334.166723-15-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add periodic toggling of 7 CPUs over 8 every second in order to test
NOCB toggle code. Choose TREE01 for that as it's already testing nocb.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
index d6da9a61d44a..40af3df0f397 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
@@ -2,5 +2,7 @@ maxcpus=8 nr_cpus=43
 rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
-rcu_nocbs=0
+rcu_nocbs=0-1,3-7
+rcutorture.nocbs_nthreads=8
+rcutorture.nocbs_toggle=1000
 rcutorture.fwd_progress=0
-- 
2.25.1

