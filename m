Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEBBC2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843D12084D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586973392;
	bh=bLyVjyBmJbKAL3Fm3qC3ps5MjTLMjQ1npgysr5LECXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IVHxAUpK/AeO9EYVJtoft+ddKCUs1nz9JfNbZXCJdMziQ9Rd0w8HGvr9gOh2IKRSg
	 3HyLVSakqKIBcHkQYOYRkqUPTZQyVdp5UBQPGANbrURN/aP4zNWWVGjk2/fhZWH2uT
	 3H5pyt7U5TcgE1N914CHq1todjsDegVhMzLn8UcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411513AbgDOR40 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416558AbgDOR4T (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:56:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D7D2166E;
        Wed, 15 Apr 2020 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586973378;
        bh=bLyVjyBmJbKAL3Fm3qC3ps5MjTLMjQ1npgysr5LECXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cq4Ksm0zwVGQX5DiGjXvx3qgi1igzSH5czEdg2A/Ooh3k5f/+n6s93v6nZR/BSzOf
         SdILea+FRADo1FcVRO8+V9jixW0oPKfxfMzApWeq5F8kk4svuPemXecqcoURfONude
         8seBbgFjEXOCxEkZML2Xjo1obUOK+r7EGqUiWXro=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH tip/core/rcu 6/6] rcutorture: Add test of holding scheduler locks across rcu_read_unlock()
Date:   Wed, 15 Apr 2020 10:56:14 -0700
Message-Id: <20200415175614.10837-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415175543.GA10416@paulmck-ThinkPad-P72>
References: <20200415175543.GA10416@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Now that it should be safe to hold scheduler locks across
rcu_read_unlock(), even in cases where the corresponding RCU read-side
critical section might have been preempted and boosted, the commit adds
a test of this capability to rcutorture.  This has been tested on current
mainline (which can deadlock in this situation), and lockdep duly reported
the expected deadlock.  On -rcu, lockdep is silent, thus far, anyway.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5453bd5..b348cf8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1147,6 +1147,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 				  struct torture_random_state *trsp,
 				  struct rt_read_seg *rtrsp)
 {
+	unsigned long flags;
 	int idxnew = -1;
 	int idxold = *readstate;
 	int statesnew = ~*readstate & newstate;
@@ -1181,8 +1182,15 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		rcu_read_unlock_bh();
 	if (statesold & RCUTORTURE_RDR_SCHED)
 		rcu_read_unlock_sched();
-	if (statesold & RCUTORTURE_RDR_RCU)
+	if (statesold & RCUTORTURE_RDR_RCU) {
+		bool lockit = !statesnew && !(torture_random(trsp) & 0xffff);
+
+		if (lockit)
+			raw_spin_lock_irqsave(&current->pi_lock, flags);
 		cur_ops->readunlock(idxold >> RCUTORTURE_RDR_SHIFT);
+		if (lockit)
+			raw_spin_unlock_irqrestore(&current->pi_lock, flags);
+	}
 
 	/* Delay if neither beginning nor end and there was a change. */
 	if ((statesnew || statesold) && *readstate && newstate)
-- 
2.9.5

