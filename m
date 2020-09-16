Return-Path: <SRS0=+/rT=CZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67985C43461
	for <rcu@archiver.kernel.org>; Wed, 16 Sep 2020 18:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0526820732
	for <rcu@archiver.kernel.org>; Wed, 16 Sep 2020 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600282115;
	bh=8I44Km9U3t9un+nDbVhEqJsEqGg2Mq8y7ajfRbuf0hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FrDW0Bz3omd45xKUpkE2IOmN84qBBeSvFu6QR6R1VJ+PVc+NnqG8C8vwSRnFQ96Wy
	 EZBhRxJl6XfVedu5E1SVVNHxs3w7ePa+igXVb9lKz4Mrv0XB/ZeHGdV/DCwLIDPh6X
	 z+hEUVeY14dh5seosqZtZ/SHgtZHu+0AyPQP9VjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgIPSsB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgIPSqK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Sep 2020 14:46:10 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0D10221E8;
        Wed, 16 Sep 2020 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600281966;
        bh=8I44Km9U3t9un+nDbVhEqJsEqGg2Mq8y7ajfRbuf0hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vTyfUCOwE1lwmiYnfEcN0n4bEyAGTCtEGZviyaBJUgXLxOkDv854rxlQp1Dqa4dhw
         u/M4Qzv7IgFOPWNH3ujFqVs37/TLVl+PvE7CEb2xQvI32ljUVFBFZYj+8Ms0Ap1Lu7
         hp7lXGwbtn6+eDcF3urPcabiuKxRHIq90unMPtm0=
From:   Jakub Kicinski <kuba@kernel.org>
To:     davem@davemloft.net, paulmck@kernel.org, joel@joelfernandes.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, peterz@infradead.org,
        christian.brauner@ubuntu.com, Jakub Kicinski <kuba@kernel.org>,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: [PATCH net-next 2/7] rcu: un-hide lockdep maps for !LOCKDEP
Date:   Wed, 16 Sep 2020 11:45:23 -0700
Message-Id: <20200916184528.498184-3-kuba@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916184528.498184-1-kuba@kernel.org>
References: <20200916184528.498184-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We're trying to make LOCKDEP-related forward declarations
visible to the compiler and depend on dead code elimination
to remove them.

Expose RCU lock maps.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: paulmck@kernel.org
CC: josh@joshtriplett.org
CC: rostedt@goodmis.org
CC: mathieu.desnoyers@efficios.com
CC: joel@joelfernandes.org
CC: jiangshanlai@gmail.com
---
 include/linux/rcupdate.h       | 9 +++++----
 include/linux/rcupdate_trace.h | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d15d46db61f7..53f9648cb982 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -234,6 +234,11 @@ bool rcu_lockdep_current_cpu_online(void);
 static inline bool rcu_lockdep_current_cpu_online(void) { return true; }
 #endif /* #else #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PROVE_RCU) */
 
+extern struct lockdep_map rcu_lock_map;
+extern struct lockdep_map rcu_bh_lock_map;
+extern struct lockdep_map rcu_sched_lock_map;
+extern struct lockdep_map rcu_callback_map;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 static inline void rcu_lock_acquire(struct lockdep_map *map)
@@ -246,10 +251,6 @@ static inline void rcu_lock_release(struct lockdep_map *map)
 	lock_release(map, _THIS_IP_);
 }
 
-extern struct lockdep_map rcu_lock_map;
-extern struct lockdep_map rcu_bh_lock_map;
-extern struct lockdep_map rcu_sched_lock_map;
-extern struct lockdep_map rcu_callback_map;
 int debug_lockdep_rcu_enabled(void);
 int rcu_read_lock_held(void);
 int rcu_read_lock_bh_held(void);
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index aaaac8ac927c..25cdef506cae 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -11,10 +11,10 @@
 #include <linux/sched.h>
 #include <linux/rcupdate.h>
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-
 extern struct lockdep_map rcu_trace_lock_map;
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+
 static inline int rcu_read_lock_trace_held(void)
 {
 	return lock_is_held(&rcu_trace_lock_map);
-- 
2.26.2

