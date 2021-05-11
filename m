Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2D9C43600
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D175061925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhEKXNd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230126AbhEKXNb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9EA06191D;
        Tue, 11 May 2021 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774744;
        bh=30S5iOXnslHL1osx5EDHKlJAxheo0X+6nBkYijKwvCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZCjV1iz4Oyz03EGeqIsJgwut2LTmgJtDQzlB0Dw/9XmefZA8jBRfPvaDbG5IBcna
         si2477DWdQLhvEQ1FjhdIrWMFXtMJ9cZ/hCKUJy6Q8uHOsQrE+a9oLGD2/b9WqtBn8
         sgk5bwz34DYvj8+PocMWqUmr+Qxyl3ktCaeWipwt9+A1Pun9N0e3PQ6BY7B7OMqNBZ
         HMXZPSrZ9kxVJOj/kC0Gzfi6/6/dCR7T7uzwr/XaQVB+OLAoCj/qL6L80itGcKI786
         uAvqeWKA0z2UvILV0phl6G57er2pw57W/UQ+druF7E7uZinMqXkxD+PIb16RDfPp5J
         n9PgD0qu/fLeA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7203B5C0D4A; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/26] rcuscale: Allow CPU hotplug to be enabled
Date:   Tue, 11 May 2021 16:12:02 -0700
Message-Id: <20210511231223.2895398-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It is no longer possible to disable CPU hotplug in many configurations,
which means that the CONFIG_HOTPLUG_CPU=n lines in rcuscale's Kconfig
options are just a source of useless diagnostics.  In addition, rcuscale
doesn't do CPU-hotplug operations in any case.  This commit therefore
changes these lines to read CONFIG_HOTPLUG_CPU=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcuscale/TREE   | 2 +-
 tools/testing/selftests/rcutorture/configs/rcuscale/TREE54 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
index 721cfda76ab2..4cc1cc581321 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
@@ -7,7 +7,7 @@ CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_HOTPLUG_CPU=n
+CONFIG_HOTPLUG_CPU=y
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
 CONFIG_RCU_NOCB_CPU=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
index 7629f5dd73b2..f5952061fde7 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
@@ -8,7 +8,7 @@ CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_HOTPLUG_CPU=n
+CONFIG_HOTPLUG_CPU=y
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
 CONFIG_RCU_FANOUT=3
-- 
2.31.1.189.g2e36527f23

