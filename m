Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19398C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E517820720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872309;
	bh=2MReE7tg93XK7F6VlsZb0HBX0126pFFv2a8PRqW+SfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JhVL7QB5Co/ENyzDpHvwrN+L8ycmvTjZpw8cxR+XcNxpalloN47qDY6K87BOBJGyJ
	 sW3CLYgx4Y4hhe7lLzHO9RA6s3aA2y9QbCIVc8B/ykyCPgzAnYzfogbzrPBXrAit+j
	 ehgg5YCVTG2fXuTObyQxZuUBdADt4+sNNVDp9xSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgFWAbY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731693AbgFWAaT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7546D20C56;
        Tue, 23 Jun 2020 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872219;
        bh=2MReE7tg93XK7F6VlsZb0HBX0126pFFv2a8PRqW+SfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQWwDhXfgF5kKnk2R86QhLsyW8Hg/qgizlzB99udRv59rxm7u/xfFQeHDYKKRP52I
         YH+rDQwGTgEc4O/Kj7HfQGMC9E3aCn+qClVaZJMMyvx7VCf4rzBI9ahcHcO+5LbQbQ
         vxG1YnuyC7szbTqTHl+m4aGKq4NP9BsOGFdofM0g=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 21/30] refperf: Adjust refperf.loop default value
Date:   Mon, 22 Jun 2020 17:30:04 -0700
Message-Id: <20200623003013.26252-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

With the various measurement optimizations, 10,000 loops normally
suffices.  This commit therefore reduces the refperf.loops default value
from 10,000,000 to 10,000.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 57a750b..063eeb0 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -61,7 +61,7 @@ torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_PERF_TEST) ? 10 : 0,
 	      "Holdoff time before test start (s)");
 // Number of loops per experiment, all readers execute operations concurrently.
-torture_param(long, loops, 10000000, "Number of loops per experiment.");
+torture_param(long, loops, 10000, "Number of loops per experiment.");
 // Number of readers, with -1 defaulting to about 75% of the CPUs.
 torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
 // Number of runs.
-- 
2.9.5

