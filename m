Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3172C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C859220720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872318;
	bh=NikS6kZnJMgfWoKPGbJkJ7wcM3dKwmIyQMIP+gNRW3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HmRTkb3hWJyg3Q9EXTeAZMk6L7Gp9tHpeODd+rbJ9mrd6N7p3hMu3YGjbqMp3Iq4Q
	 nQkFlWBRcvt+A4c4w7afTP9/ewssDCGBLnTshR6nuYKCsCtDNBEaqiL8YZIGXD0iX0
	 ZtoQrRn6uzI8ejbBnoBnjzLG2HlNBrjMUwLg5b4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbgFWAbu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731664AbgFWAaR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E3320842;
        Tue, 23 Jun 2020 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872217;
        bh=NikS6kZnJMgfWoKPGbJkJ7wcM3dKwmIyQMIP+gNRW3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lW18rELvBcG5P/gw3h4KtzvoPbD183FWVQs9E6efVbxIDvE9l+S7xhnUKbuliGY5i
         TSgsMnWdY0w9y10FjmcGAZah6cMEwkFz2xy7qmJDe5WAcVeadFkMevkZlLVJnmU/8i
         NOI2UhRvfdU6mrNB8rHX80mUtOmrpegsIgXSbWAs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/30] refperf: Make functions static
Date:   Mon, 22 Jun 2020 17:29:55 -0700
Message-Id: <20200623003013.26252-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Because the reset_readers() and process_durations() functions are used
only within kernel/rcu/refperf.c, this commit makes them static.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index fc940e3..0a900f3 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -283,7 +283,7 @@ ref_perf_reader(void *arg)
 	return 0;
 }
 
-void reset_readers(void)
+static void reset_readers(void)
 {
 	int i;
 	struct reader_task *rt;
@@ -296,7 +296,7 @@ void reset_readers(void)
 }
 
 // Print the results of each reader and return the sum of all their durations.
-u64 process_durations(int n)
+static u64 process_durations(int n)
 {
 	int i;
 	struct reader_task *rt;
-- 
2.9.5

