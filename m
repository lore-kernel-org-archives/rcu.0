Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD7CC2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664A02076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586972030;
	bh=pV76y96zUxJd7EWMF5pltBZoK1thilUhlP6HlW/tbgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ccXvlhucGNRk+swT0V3YEDVDHej1Kl4GqyWdKh95yW57iYSIlH9FneMmCvxfqplGq
	 gZJ1tuGgyHHC7oorNMgcKrR6UXMOMUIuFekiF0e1dpV3Ib9R21FIE5x0ZMhG4wFBhK
	 uTvh6MonW6V9+Tx5N7sGRJ9FUbtGAzvyOZkArtE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411337AbgDORds (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411116AbgDORbE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A207214D8;
        Wed, 15 Apr 2020 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971862;
        bh=pV76y96zUxJd7EWMF5pltBZoK1thilUhlP6HlW/tbgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtsM403/8yboQLqaasDJV5jxmqr0jmIeJssW5zfYGbQel7z0FIRoywed8giWi5Cvx
         A1MNipjPQS5oeqWgCCh1vuE0BgbzG8Zat6Z8aavy+zYUwwAzDtqKVXG0QI9zk03jv2
         KlONMQUyCIJ/brq1Oipkxp6IAVJp/d+QAUMM7J+Q=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/18] rcutorture: Mark data-race potential for rcu_barrier() test statistics
Date:   Wed, 15 Apr 2020 10:30:45 -0700
Message-Id: <20200415173100.9927-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The n_barrier_successes, n_barrier_attempts, and
n_rcu_torture_barrier_error variables are updated (without access
markings) by the main rcu_barrier() test kthread, and accessed (also
without access markings) by the rcu_torture_stats() kthread.  This of
course can result in KCSAN complaints.

Because the accesses are in diagnostic prints, this commit uses
data_race() to excuse the diagnostic prints from the data race.  If this
were to ever cause bogus statistics prints (for example, due to store
tearing), any misleading information would be disambiguated by the
presence or absence of an rcutorture splat.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely and due to the mild consequences of the
failure, namely a confusing rcutorture console message.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7e2ea0c5..d0345d1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1456,9 +1456,9 @@ rcu_torture_stats_print(void)
 		atomic_long_read(&n_rcu_torture_timers));
 	torture_onoff_stats();
 	pr_cont("barrier: %ld/%ld:%ld\n",
-		n_barrier_successes,
-		n_barrier_attempts,
-		n_rcu_torture_barrier_error);
+		data_race(n_barrier_successes),
+		data_race(n_barrier_attempts),
+		data_race(n_rcu_torture_barrier_error));
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
-- 
2.9.5

