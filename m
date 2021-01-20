Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43614C433DB
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 04:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CAD2313B
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 04:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbhATEdU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Jan 2021 23:33:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbhATEdT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Jan 2021 23:33:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56D3223158;
        Wed, 20 Jan 2021 04:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611117158;
        bh=qjT7jsABtEkFjwh3R7KdQ5ewWLKm1ZZKq9tH2fwcEL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhYwQJZUlisZ8GZRFmGaljm/I7LLoVlDuJ53datkQIX+N9Jy5+Y/a8XcUehcjGqDD
         Y2gXfl21l+h83l32LMESw1KsQZML1/OUWixJiUaij5MnWuPLMGOS4wrlrC3htU6ytn
         ze4w15gkv76jjcmkL+rPf8pCeKYQgwqyEdB6xwoJp+yq0AM4oIhAmdLjxQE8sokz7f
         iMLATE34G1E9KUGH6O5Y1lPDandz/tsxx33P0ysIXqQawTCEXHrv+fn7GltqDTz7bz
         axwUKoP0dAASOE/+MK8GdX9R7AJzwMpiPPQS1bU7yrGw6bNI4e8I/i9OTnIze99QS5
         WbAX0AgyGckJQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/4] rcutorture: Make TREE03 use real-time tree.use_softirq setting
Date:   Tue, 19 Jan 2021 20:32:34 -0800
Message-Id: <20210120043236.7254-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210120043144.GA7045@paulmck-ThinkPad-P72>
References: <20210120043144.GA7045@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

TREE03 tests RCU priority boosting, which is a real-time feature.
It would also be good if it tested something closer to what is
actually used by the real-time folks.  This commit therefore adds
tree.use_softirq=0 to the TREE03 kernel boot parameters in TREE03.boot.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
index 1c21894..64f864f1 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
@@ -4,3 +4,4 @@ rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
+tree.use_softirq=0
-- 
2.9.5

