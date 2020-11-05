Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818E4C4742C
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A00D2073A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620138;
	bh=+wtCTO8ugs2wQ5HRkr5jLmWMwhgf+IR2IfaGFnsAG6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vw0EOd84W4kI1oQ9vyvOrBjVEzl6EEwC4vlAZ1ZFlRcVZ8yVRN7KvN7PwLRzeiExs
	 KK9j+tVZlCsqlPL80Mcirb9Emo4XF/Xwl3E6oE5o7xUTMhsTFxB+TrvH4HyL3uHRUj
	 AW8My3ly9u96ZG4WSA2SSkJbwIf3PXSCMFIta27o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbgKEXsz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:48:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732619AbgKEXr0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:26 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668E820782;
        Thu,  5 Nov 2020 23:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620046;
        bh=+wtCTO8ugs2wQ5HRkr5jLmWMwhgf+IR2IfaGFnsAG6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTYp0SswFTvS8NmT12XcS77Utl7wn7ALlvXByf8UaspbIv9ekz2oSJzKf9WsEkyyc
         g/gaGeQ/dWPgWdoU8LHsdVhPRfrQFqdop/0e36aKMDohc7DO2FLKXd/O/HQfTNa5ct
         Kug7toUi2lUty7mR3ucAfyzZ3uBwMIaNXPqGvOF4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/28] rcutorture: Adjust scenarios SRCU-t and SRCU-u to make kconfig happy
Date:   Thu,  5 Nov 2020 15:47:03 -0800
Message-Id: <20201105234719.23307-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The SRCU-u scenario expects to enable lockdep but to also disable the
CONFIG_PREEMPT_COUNT kconfig option.  This no longer works.  This commit
therefore instead enables lockdep in SRCU-t, which then allows SRCU-u
to disable CONFIG_PREEMPT_COUNT.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-t | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-u | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
index 6c78022..d6557c3 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
@@ -4,7 +4,8 @@ CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 #CHECK#CONFIG_TINY_SRCU=y
 CONFIG_RCU_TRACE=n
-CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 #CHECK#CONFIG_PREEMPT_COUNT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
index c15ada8..6bc24e9 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
@@ -4,7 +4,6 @@ CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 #CHECK#CONFIG_TINY_SRCU=y
 CONFIG_RCU_TRACE=n
-CONFIG_DEBUG_LOCK_ALLOC=y
-CONFIG_PROVE_LOCKING=y
+CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_PREEMPT_COUNT=n
-- 
2.9.5

