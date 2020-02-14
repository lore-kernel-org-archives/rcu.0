Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6DBC35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05CE24649
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724674;
	bh=nYJGtkvt8mINfC95IpN7jOIxr7W0o0xbh3lQojeDMYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vPE9XNW2XibwD5dcWIq6XdevXbJ8YQaT5+fQyKCQsbT0vQNrwjRPADmP9GJs2u0r8
	 a6zy1oNyA7nnxxmwDwJTizuFhZBeTEckYnn0f/r9PmW3oiKdgdOp30jddKezUMWWEb
	 OuntmfS2ThDLk3eDamGzfBiFDivTEiL6ltPsGxyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBNX5x (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:57:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbgBNX5x (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:53 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0D422314;
        Fri, 14 Feb 2020 23:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724673;
        bh=nYJGtkvt8mINfC95IpN7jOIxr7W0o0xbh3lQojeDMYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oAxHsCqNpIf5h8M6PLXXLPgJjMKRGmvLWKyTfqIY5xAqn624HIEAfzWZH6YEbuut3
         in5hnrFAyDWfDgGJZ2sofyrr6H6PDlAyT7aOEr8KE8l02RcdHHAxHDQRW/4XtV7BPB
         pSbIakhFquvHm/2MUUJ+aq9yVnN6h/hOqN4yEn5M=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 28/30] rcu: Mark rcu_state.ncpus to detect concurrent writes
Date:   Fri, 14 Feb 2020 15:56:05 -0800
Message-Id: <20200214235607.13749-28-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
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
index 4146207..3a60a160 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3397,6 +3397,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
 	/* Allow lockless access for expedited grace periods. */
 	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
-- 
2.9.5

