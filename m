Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B0AC2B9F0
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12EAD61925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhEKXNo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhEKXNd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64C766194E;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=29FKnzg8V5Lrvw7Ha8tjC54/3ShpnxzheDlihIyK1/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIYAwm4ppDCI11PiHtELmvGPTGiW0MeATXEy+mKvb1MOHVE+zfeYvulO0bO/0RE5m
         eVYkg2hkKvqfJXsxjNUAd3YyA4VgSUkHJHb7FWg3yIV/FD7uN9EF+zPAV5c4AU2wmW
         81JMHZ2l15q+yOsY+XrUGnqoX1q4ZKMw8vrJf8qHDc73435+rMuT66QO4V3OZ7s0np
         ZdMwlcbicry/S+jizmmMDuljyZbQeckZKrBRP5GceK7tQ+aPiMA7jhw3NJSTl+2PHF
         38/RTo45DakOSzhan8E6/xe/uG13L2zzbRpPNNOxJSkTlKgJQgT6eSqcI5wfhQiudn
         QBGvJ/EHVAttg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8DDF35C0E5D; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 20/26] rcutorture: Add BUSTED-BOOST to test RCU priority boosting tests
Date:   Tue, 11 May 2021 16:12:17 -0700
Message-Id: <20210511231223.2895398-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds the BUSTED-BOOST rcutorture scenario, which can be
used to test rcutorture's ability to test RCU priority boosting.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../rcutorture/configs/rcu/BUSTED-BOOST         | 17 +++++++++++++++++
 .../rcutorture/configs/rcu/BUSTED-BOOST.boot    |  8 ++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST
new file mode 100644
index 000000000000..22d598f9cabe
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST
@@ -0,0 +1,17 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=16
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+#CHECK#CONFIG_PREEMPT_RCU=y
+CONFIG_HZ_PERIODIC=y
+CONFIG_NO_HZ_IDLE=n
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_TRACE=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_RCU_FANOUT=2
+CONFIG_RCU_FANOUT_LEAF=2
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
new file mode 100644
index 000000000000..f57720c52c0f
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
@@ -0,0 +1,8 @@
+rcutorture.test_boost=2
+rcutorture.stutter=0
+rcutree.gp_preinit_delay=12
+rcutree.gp_init_delay=3
+rcutree.gp_cleanup_delay=3
+rcutree.kthread_prio=2
+threadirqs
+tree.use_softirq=0
-- 
2.31.1.189.g2e36527f23

