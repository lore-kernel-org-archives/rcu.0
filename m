Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A3EC433E6
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCB364F95
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbhCDBBQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1451174AbhCDAak (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:30:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B21164EF4;
        Thu,  4 Mar 2021 00:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817797;
        bh=5LqAc5v3vAiyIyBEf5zKjssRCh70Z9FmZPs7b9Jz4JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8IRZk6qPmyZJxPNEGzQIx3PRSLjs+5ORKsZurhoHq/A8yJ+c2ahUggdyMii8ITR2
         8rCpfJ2rsKRVcCjTrtWgJVZna1x1gJCm1vhJ+UOf9QRiGeXg+nSNkbYR0kkze/ekCq
         sLfvHStuSmB2dc/dJWnm1JamwNUSH87v1oDRlxxIWdCflUJYzKftx4r7vMKCzDkkX3
         2rB3GsO1ooiD0xS/6vjqxyXfqhwcMnIAo+6ya69h2eVh6pLR9L2Tre487Nm9tVfd30
         rhcSF4FZhSb03G/67nk5Dioc/f80ZOCD3OP044uo9hgqr8lOUd6enN/DGMR6ldk74i
         rWm3sYxGUkSjQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 5/5] torture: Make jitter.sh handle large systems
Date:   Wed,  3 Mar 2021 16:29:55 -0800
Message-Id: <20210304002955.24132-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002919.GA24003@paulmck-ThinkPad-P72>
References: <20210304002919.GA24003@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The current jitter.sh script expects cpumask bits to fit into whatever
the awk interpreter uses for an integer, which clearly does not hold for
even medium-sized systems these days.  This means that on a large system,
only the first 32 or 64 CPUs (depending) are subjected to jitter.sh
CPU-time perturbations.  This commit therefore computes a given CPU's
cpumask using text manipulation rather than arithmetic shifts.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 188b864..3a856ec 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -67,10 +67,10 @@ do
 		srand(n + me + systime());
 		ncpus = split(cpus, ca);
 		curcpu = ca[int(rand() * ncpus + 1)];
-		mask = lshift(1, curcpu);
-		if (mask + 0 <= 0)
-			mask = 1;
-		printf("%#x\n", mask);
+		z = "";
+		for (i = 1; 4 * i <= curcpu; i++)
+			z = z "0";
+		print "0x" 2 ^ (curcpu % 4) z;
 	}' < /dev/null`
 	n=$(($n+1))
 	if ! taskset -p $cpumask $$ > /dev/null 2>&1
-- 
2.9.5

