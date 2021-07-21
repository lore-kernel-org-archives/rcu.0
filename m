Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D46C63797
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C7A6124C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhGUUVQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBC416139A;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=WR0JBuJJ4v+AueQNLDr+YNS6ogvipX34EYylSqPkD0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lX87yJKfIgN9Ef5f5YkrnrTFUdlFnmFpLezjzarGliAnz+QIHhg0SEV1CKua9RBrT
         S6tWsbFpAuHLfBtK60BGuZP4Uh7lh/LGtqZQyyGYyy1XzdxD4/GKHBsY3FFKHoog24
         I+ZU4PmkLesXGSrbYkdz8wUoc+2qpnBGzwwzn3BW7ve/5p/UC2FLYNTH3OeZ1kxqeJ
         dmGYjMrW5ZSNRZwuiPh9/RUOtkTKpwKG5/9eqFtCWnnnV7Y+jU9kr2aZcc0JxdKp6X
         imY+0TwGZaH/vuR2NYLRTEnNkkGChBsjzwNPVVuDEjdk6G4OeYM7L5j+tH5xCHmSV2
         5Xo9xX34GQr4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E44A55C22E5; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 15/21] rcutorture: Upgrade two-CPU scenarios to four CPUs
Date:   Wed, 21 Jul 2021 14:01:34 -0700
Message-Id: <20210721210140.787717-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There is no way to place the vCPUs in a two-CPU rcutorture scenario to
get variable memory latency.  This commit therefore upgrades the current
two-CPU rcutorture scenarios to four CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01  | 2 +-
 tools/testing/selftests/rcutorture/configs/rcu/TASKS01 | 2 +-
 tools/testing/selftests/rcutorture/configs/rcu/TASKS03 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01 b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
index bafe94cbd7390..3ca112444ce77 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
@@ -1,5 +1,5 @@
 CONFIG_SMP=y
-CONFIG_NR_CPUS=2
+CONFIG_NR_CPUS=4
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS01 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01
index bafe94cbd7390..3ca112444ce77 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01
@@ -1,5 +1,5 @@
 CONFIG_SMP=y
-CONFIG_NR_CPUS=2
+CONFIG_NR_CPUS=4
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS03 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
index ea4399020c6c1..dc02083803ce5 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
@@ -1,5 +1,5 @@
 CONFIG_SMP=y
-CONFIG_NR_CPUS=2
+CONFIG_NR_CPUS=4
 CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=y
-- 
2.31.1.189.g2e36527f23

