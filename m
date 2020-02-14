Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CEEC3B1BF
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB0E222C4
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581723587;
	bh=OoRz/vStV+uis4KGn9nSRBOnKCx9EHOqEGWylWwOkm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XWXAXrzFhIWjX1Ra4RabOgL76Gs1u01mK4y0QLo9mqkZHPFi9UFheVc48zsv1OGCH
	 hhBs+ppRIutFegDy65c/y5GnSAly6UYBeSOTbeFg8b8Bnflm1kWRD0X53AxO5/K2Tq
	 qMukJJVfuttAP9tZIkZaxMpQe13DBsqO20qm+Qvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgBNXjm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgBNXjl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:39:41 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93A0422314;
        Fri, 14 Feb 2020 23:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581723581;
        bh=OoRz/vStV+uis4KGn9nSRBOnKCx9EHOqEGWylWwOkm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQcfI2i60LzYu8AycsYYDZ1XjupRagKPuunByAOt06y1qTiD5hOHM4sBVkRNvTJ9N
         qCdBYPwME4zYs5JfUVY4U6FA08TttVLjCE9hRIIJASAKG/9EotmKn18XunYuR1Rfe8
         77AFrV0etwvVwSWLNjT1/0L0pwzG8TxlYKviteWU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        SeongJae Park <sjpark@amazon.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 9/9] Documentation/memory-barriers: Fix typos
Date:   Fri, 14 Feb 2020 15:39:03 -0800
Message-Id: <20200214233903.12916-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <@@@>
References: <@@@>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/memory-barriers.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 7146da0..e1c355e 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -185,7 +185,7 @@ As a further example, consider this sequence of events:
 	===============	===============
 	{ A == 1, B == 2, C == 3, P == &A, Q == &C }
 	B = 4;		Q = P;
-	P = &B		D = *Q;
+	P = &B;		D = *Q;
 
 There is an obvious data dependency here, as the value loaded into D depends on
 the address retrieved from P by CPU 2.  At the end of the sequence, any of the
@@ -569,7 +569,7 @@ following sequence of events:
 	{ A == 1, B == 2, C == 3, P == &A, Q == &C }
 	B = 4;
 	<write barrier>
-	WRITE_ONCE(P, &B)
+	WRITE_ONCE(P, &B);
 			      Q = READ_ONCE(P);
 			      D = *Q;
 
@@ -1721,7 +1721,7 @@ of optimizations:
      and WRITE_ONCE() are more selective:  With READ_ONCE() and
      WRITE_ONCE(), the compiler need only forget the contents of the
      indicated memory locations, while with barrier() the compiler must
-     discard the value of all memory locations that it has currented
+     discard the value of all memory locations that it has currently
      cached in any machine registers.  Of course, the compiler must also
      respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,
      though the CPU of course need not do so.
@@ -1833,7 +1833,7 @@ Aside: In the case of data dependencies, the compiler would be expected
 to issue the loads in the correct order (eg. `a[b]` would have to load
 the value of b before loading a[b]), however there is no guarantee in
 the C specification that the compiler may not speculate the value of b
-(eg. is equal to 1) and load a before b (eg. tmp = a[1]; if (b != 1)
+(eg. is equal to 1) and load a[b] before b (eg. tmp = a[1]; if (b != 1)
 tmp = a[b]; ).  There is also the problem of a compiler reloading b after
 having loaded a[b], thus having a newer copy of b than a[b].  A consensus
 has not yet been reached about these problems, however the READ_ONCE()
-- 
2.9.5

