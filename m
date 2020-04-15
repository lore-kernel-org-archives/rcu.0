Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CBAC2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC07C21707
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586970723;
	bh=dmpyRpRc++xi9KkXweAWSawKqD80BTw54kiQlk5yZVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O6S+/kBwhTlEfHgrPOrPdfdwF0qQFt0rD/IhNhiT2eEu/NiBiP7CaZTKzGUKDgskW
	 E0DqM8VTiBHhHmzB/sPMmw4hG9PfsBxly+S4jtVrCji7WQ/6wpGB4qXngThtMOpUni
	 glT7tXSEpIFDCoXpN+qWxoUd6k9Ox4kmHbsDsCZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410724AbgDORLB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410710AbgDORK5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:10:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81E421973;
        Wed, 15 Apr 2020 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970657;
        bh=dmpyRpRc++xi9KkXweAWSawKqD80BTw54kiQlk5yZVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1tVbQd/dvCVWYC2kNLKlHCDMVJDHASlNKsYSe1LPvlE1fLHuLR0TZP2xDHDou00cO
         2ueBIzta+BYucxSRFfpf+AJshmQoAbAkE2KoPas79HThfUhm+s5WEx1K42xAZ8QKlX
         KMcF3nYI1l3wGAh4b5AlSBo1miDKqVfZTBYWAmj4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/19] rcu: Mark rcu_state.ncpus to detect concurrent writes
Date:   Wed, 15 Apr 2020 10:10:38 -0700
Message-Id: <20200415171054.9013-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_state structure's ncpus field is only to be modified by the
CPU-hotplug CPU-online code path, which is single-threaded.  This
commit therefore enlists KCSAN's help in enforcing this restriction.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f13130a..4fd3e0f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3612,6 +3612,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
 	/* Allow lockless access for expedited grace periods. */
 	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
-- 
2.9.5

