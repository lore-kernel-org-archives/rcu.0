Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C43C433EF
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 20:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB22D610E8
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 20:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhIOUIt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231722AbhIOUIs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 16:08:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 427736105A;
        Wed, 15 Sep 2021 20:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631736448;
        bh=Np8v5aY+z67dE6jqe4r/1xKsH4Pr28NhJwhdRPabqec=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VIp5K4a5OszfeXYWv3aoCOI6WKicLYeMQ92p60GZjXx/42/rd5kqEhbHC0V2hzP1k
         W+n0w+ecC3r3YFJ5AkUoF7ihW1Toyx8RTOQe3GeK2A/3UagYl8rmgbJ9lLQM6Hz/vt
         hBs+iNSw53pLyu68deI0Q/I9h1hT4OtTnkQ8TW4rEqpV9AiHnEagn4TC+Nt5Ob6BG2
         N3LCmJstRwvEphhC0HjER+7vgY3sFdUC0eoYZSnoBHbrBbNCXHcXBLY354zaLr6wCV
         9XXo0xwHOsJbdOPlgfFjpYdM5T1v2vEQq6+5SgCTHSrcBMx+je6V/RfIe72d7KnldB
         0CMjmvqM8kEEw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 124A75C054E; Wed, 15 Sep 2021 13:07:28 -0700 (PDT)
Date:   Wed, 15 Sep 2021 13:07:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chun-Hung Tseng <henrybear327@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Huang <jserv@ccns.ncku.edu.tw>
Subject: Re: [PATCH v2] rcu: replace ________p1 and _________p1 with
 __UNIQUE_ID(rcu)
Message-ID: <20210915200728.GX4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210915090218.530565-1-henrybear327@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915090218.530565-1-henrybear327@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 15, 2021 at 05:02:18PM +0800, Chun-Hung Tseng wrote:
> This commit replaced both ________p1 and _________p1 with __UNIQUE_ID(rcu).
> Necessary modifications due to the changes in the RCU macros have also been
> reflected in this commit.
> 
> __UNIQUE_ID(rcu) will generate unique variable names during compilation,
> which eliminates the need of ________p1 and _________p1 (both having 4
> occurrences prior to the code change). Also, this avoids the variable name
> shadowing issue.
> 
> The same idea is used for the min/max macros (commit 589a978 and commit
> e9092d0).
> 
> Signed-off-by: Jim Huang <jserv@ccns.ncku.edu.tw>
> Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>

Queued with the usual wordsmithing, thank you!

							Thanx, Paul

------------------------------------------------------------------------

commit bc16d19516eadd1ef04019079b4d8b46bdb2fa5d
Author: Chun-Hung Tseng <henrybear327@gmail.com>
Date:   Wed Sep 15 17:02:18 2021 +0800

    rcu: Replace ________p1 and _________p1 with __UNIQUE_ID(rcu)
    
    This commit replaces both ________p1 and _________p1 with __UNIQUE_ID(rcu),
    and also adjusts the callers of the affected macros.
    
    __UNIQUE_ID(rcu) will generate unique variable names during compilation,
    which eliminates the need of ________p1 and _________p1 (both having 4
    occurrences prior to the code change).  This also avoids the variable
    name shadowing issue, or at least makes those wishing to cause shadowing
    problems work much harder to do so.
    
    The same idea is used for the min/max macros (commit 589a978 and commit
    e9092d0).
    
    Signed-off-by: Jim Huang <jserv@ccns.ncku.edu.tw>
    Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e0beb5c5659..88b42eb46406 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -364,6 +364,12 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define rcu_check_sparse(p, space)
 #endif /* #else #ifdef __CHECKER__ */
 
+#define __unrcu_pointer(p, local)					\
+({									\
+	typeof(*p) *local = (typeof(*p) *__force)(p);			\
+	rcu_check_sparse(p, __rcu);					\
+	((typeof(*p) __force __kernel *)(local)); 			\
+})
 /**
  * unrcu_pointer - mark a pointer as not being RCU protected
  * @p: pointer needing to lose its __rcu property
@@ -371,39 +377,35 @@ static inline void rcu_preempt_sleep_check(void) { }
  * Converts @p from an __rcu pointer to a __kernel pointer.
  * This allows an __rcu pointer to be used with xchg() and friends.
  */
-#define unrcu_pointer(p)						\
-({									\
-	typeof(*p) *_________p1 = (typeof(*p) *__force)(p);		\
-	rcu_check_sparse(p, __rcu);					\
-	((typeof(*p) __force __kernel *)(_________p1)); 		\
-})
+#define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
 
-#define __rcu_access_pointer(p, space) \
+#define __rcu_access_pointer(p, local, space) \
 ({ \
-	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
+	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(_________p1)); \
+	((typeof(*p) __force __kernel *)(local)); \
 })
-#define __rcu_dereference_check(p, c, space) \
+#define __rcu_dereference_check(p, local, c, space) \
 ({ \
 	/* Dependency order vs. p above. */ \
-	typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
+	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(________p1)); \
+	((typeof(*p) __force __kernel *)(local)); \
 })
-#define __rcu_dereference_protected(p, c, space) \
+#define __rcu_dereference_protected(p, local, c, space) \
 ({ \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
 	rcu_check_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(p)); \
 })
-#define rcu_dereference_raw(p) \
+#define __rcu_dereference_raw(p, local) \
 ({ \
 	/* Dependency order vs. p above. */ \
-	typeof(p) ________p1 = READ_ONCE(p); \
-	((typeof(*p) __force __kernel *)(________p1)); \
+	typeof(p) local = READ_ONCE(p); \
+	((typeof(*p) __force __kernel *)(local)); \
 })
+#define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
 
 /**
  * RCU_INITIALIZER() - statically initialize an RCU-protected global variable
@@ -490,7 +492,7 @@ do {									      \
  * when tearing down multi-linked structures after a grace period
  * has elapsed.
  */
-#define rcu_access_pointer(p) __rcu_access_pointer((p), __rcu)
+#define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
 
 /**
  * rcu_dereference_check() - rcu_dereference with debug checking
@@ -526,7 +528,8 @@ do {									      \
  * annotated as __rcu.
  */
 #define rcu_dereference_check(p, c) \
-	__rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+				(c) || rcu_read_lock_held(), __rcu)
 
 /**
  * rcu_dereference_bh_check() - rcu_dereference_bh with debug checking
@@ -541,7 +544,8 @@ do {									      \
  * rcu_read_lock() but also rcu_read_lock_bh() into account.
  */
 #define rcu_dereference_bh_check(p, c) \
-	__rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+				(c) || rcu_read_lock_bh_held(), __rcu)
 
 /**
  * rcu_dereference_sched_check() - rcu_dereference_sched with debug checking
@@ -556,7 +560,8 @@ do {									      \
  * only rcu_read_lock() but also rcu_read_lock_sched() into account.
  */
 #define rcu_dereference_sched_check(p, c) \
-	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+				(c) || rcu_read_lock_sched_held(), \
 				__rcu)
 
 /*
@@ -566,7 +571,8 @@ do {									      \
  * The no-tracing version of rcu_dereference_raw() must not call
  * rcu_read_lock_held().
  */
-#define rcu_dereference_raw_check(p) __rcu_dereference_check((p), 1, __rcu)
+#define rcu_dereference_raw_check(p) \
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), 1, __rcu)
 
 /**
  * rcu_dereference_protected() - fetch RCU pointer when updates prevented
@@ -585,7 +591,7 @@ do {									      \
  * but very ugly failures.
  */
 #define rcu_dereference_protected(p, c) \
-	__rcu_dereference_protected((p), (c), __rcu)
+	__rcu_dereference_protected((p), __UNIQUE_ID(rcu), (c), __rcu)
 
 
 /**
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e6011a9975af..01226e4d960a 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -117,7 +117,8 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
  * lockdep_is_held() calls.
  */
 #define srcu_dereference_check(p, ssp, c) \
-	__rcu_dereference_check((p), (c) || srcu_read_lock_held(ssp), __rcu)
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+				(c) || srcu_read_lock_held(ssp), __rcu)
 
 /**
  * srcu_dereference - fetch SRCU-protected pointer for later dereferencing
