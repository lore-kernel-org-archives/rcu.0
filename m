Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8B4C433ED
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 04:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF25D610CC
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 04:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhETEeC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 May 2021 00:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhETEeC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 May 2021 00:34:02 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12707C061574;
        Wed, 19 May 2021 21:32:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v13so8267224ple.9;
        Wed, 19 May 2021 21:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cQYpfba6b45enTj3AyckA3KCrMogX01g9zAcWVgY74Y=;
        b=KYIAYWQZPaGStcbPGB+l6xjgBzN9uyRFtvkiburpX1xvyPdLLIDmsr5EotHXarO6MO
         SOuq0wqBRPYhdiTd4u2/KBarX4FDilh6LZqpNI68FF3EsNUzUdyPd/JEAhh3CgXNcUUR
         PtwaSCpFMMDbp0BuwsAAfLKbfW7pxOTuxwYrtBVT7boLkD37dTRNGRymMCR6SXevdiZL
         5gh1Pxy5k4T68Su+9fIw0po90pcqRIXsucMIICZVsBBzx3f40ReW5koeh2uiNidv+/uZ
         fcx6Cxfok074h9dsCvs7Td8SpfF4GKvoGCm8R4sTL7euAvEy9HYwKH0svI+uzESbtm0W
         sFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cQYpfba6b45enTj3AyckA3KCrMogX01g9zAcWVgY74Y=;
        b=G/P9SS06HRQIgOkXHGPdLw29T34qEwJ2BegaKnj3i0hC8YI7cdbepIB2Y9BdItm9qt
         h2t4h6dsbitzUEovEJSZTdY/k1/qQm28zMrIt/33ZJQaUL+XYy7SrO/ZOmJbtOJfnwrE
         I9hGSldX9WIeEXQk5aCrqpJJIH1HldJ3EXSqBsd8YisWS8lThLoN0KRJnB9PzJAZYw1t
         FPovSVRLmc6YPKZCOuUgCx6TpRiU0lSGFIJXH4QruJvoym9UXBReM1d6/RJex3+VnOj/
         XY1DvxozcDH+CW6DZhUKbBgxFAw0IZ6XzPfi6S1AyccgW1HVYbKKvkYPaECMpg6R7BjU
         5OCQ==
X-Gm-Message-State: AOAM532j2juufwV6RL4ygE1dlWmnXgV4NLkkkeIXiH5OGLPff6EIkqnq
        TMqYCuDM1M/Rb5DST3WdtkM=
X-Google-Smtp-Source: ABdhPJxb6tqdqRNmXI4IrcfiNvb/0ih7xClJHARyMcBmcf9NvastOBLw60HtfxB1BE9y9c+g5L84Dw==
X-Received: by 2002:a17:90a:6ace:: with SMTP id b14mr3115229pjm.142.1621485161203;
        Wed, 19 May 2021 21:32:41 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c3sm748887pfi.213.2021.05.19.21.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 21:32:40 -0700 (PDT)
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH -rcu] Documentation/RCU: Fix emphasis markers
Message-ID: <c680825b-380d-dca0-edcd-fb74603b5641@gmail.com>
Date:   Thu, 20 May 2021 13:32:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

"-foo-" does not work as emphasis in ReST markdown.
Use "*foo*" instead.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
Hi Paul,

This is relative to -rcu's dev branch.
I've started learning how to do ReST markdown. ;-)

For emphasis, both "*foo*" and "_bar_" work.
I see several "*foo*" patterns in other .rst files under RCU/.

Yes, I have now sphinx installed in a container for "make htmldocs" to work.
"make pdfdocs" does not work as expected at the moment, though.

        Thanks, Akira
--
 Documentation/RCU/checklist.rst       | 24 ++++++++++++------------
 Documentation/RCU/rcu_dereference.rst |  6 +++---
 Documentation/RCU/stallwarn.rst       |  8 ++++----
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 1030119294d0..a71d3f134323 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -37,7 +37,7 @@ over a rather long period of time, but improvements are always welcome!
 
 1.	Does the update code have proper mutual exclusion?
 
-	RCU does allow -readers- to run (almost) naked, but -writers- must
+	RCU does allow *readers* to run (almost) naked, but *writers* must
 	still use some sort of mutual exclusion, such as:
 
 	a.	locking,
@@ -73,7 +73,7 @@ over a rather long period of time, but improvements are always welcome!
 	critical section is every bit as bad as letting them leak out
 	from under a lock.  Unless, of course, you have arranged some
 	other means of protection, such as a lock or a reference count
-	-before- letting them out of the RCU read-side critical section.
+	*before* letting them out of the RCU read-side critical section.
 
 3.	Does the update code tolerate concurrent accesses?
 
@@ -101,7 +101,7 @@ over a rather long period of time, but improvements are always welcome!
 	c.	Make updates appear atomic to readers.	For example,
 		pointer updates to properly aligned fields will
 		appear atomic, as will individual atomic primitives.
-		Sequences of operations performed under a lock will -not-
+		Sequences of operations performed under a lock will *not*
 		appear to be atomic to RCU readers, nor will sequences
 		of multiple atomic primitives.
 
@@ -320,7 +320,7 @@ over a rather long period of time, but improvements are always welcome!
 	for example) may be omitted.
 
 10.	Conversely, if you are in an RCU read-side critical section,
-	and you don't hold the appropriate update-side lock, you -must-
+	and you don't hold the appropriate update-side lock, you *must*
 	use the "_rcu()" variants of the list macros.  Failing to do so
 	will break Alpha, cause aggressive compilers to generate bad code,
 	and confuse people trying to read your code.
@@ -346,12 +346,12 @@ over a rather long period of time, but improvements are always welcome!
 	callback pending, then that RCU callback will execute on some
 	surviving CPU.	(If this was not the case, a self-spawning RCU
 	callback would prevent the victim CPU from ever going offline.)
-	Furthermore, CPUs designated by rcu_nocbs= might well -always-
+	Furthermore, CPUs designated by rcu_nocbs= might well *always*
 	have their RCU callbacks executed on some other CPUs, in fact,
 	for some  real-time workloads, this is the whole point of using
 	the rcu_nocbs= kernel boot parameter.
 
-13.	Unlike other forms of RCU, it -is- permissible to block in an
+13.	Unlike other forms of RCU, it *is* permissible to block in an
 	SRCU read-side critical section (demarked by srcu_read_lock()
 	and srcu_read_unlock()), hence the "SRCU": "sleepable RCU".
 	Please note that if you don't need to sleep in read-side critical
@@ -398,16 +398,16 @@ over a rather long period of time, but improvements are always welcome!
 14.	The whole point of call_rcu(), synchronize_rcu(), and friends
 	is to wait until all pre-existing readers have finished before
 	carrying out some otherwise-destructive operation.  It is
-	therefore critically important to -first- remove any path
+	therefore critically important to *first* remove any path
 	that readers can follow that could be affected by the
-	destructive operation, and -only- -then- invoke call_rcu(),
+	destructive operation, and *only then* invoke call_rcu(),
 	synchronize_rcu(), or friends.
 
 	Because these primitives only wait for pre-existing readers, it
 	is the caller's responsibility to guarantee that any subsequent
 	readers will execute safely.
 
-15.	The various RCU read-side primitives do -not- necessarily contain
+15.	The various RCU read-side primitives do *not* necessarily contain
 	memory barriers.  You should therefore plan for the CPU
 	and the compiler to freely reorder code into and out of RCU
 	read-side critical sections.  It is the responsibility of the
@@ -446,8 +446,8 @@ over a rather long period of time, but improvements are always welcome!
 	pass in a function defined within a loadable module, then it in
 	necessary to wait for all pending callbacks to be invoked after
 	the last invocation and before unloading that module.  Note that
-	it is absolutely -not- sufficient to wait for a grace period!
-	The current (say) synchronize_rcu() implementation is -not-
+	it is absolutely *not* sufficient to wait for a grace period!
+	The current (say) synchronize_rcu() implementation is *not*
 	guaranteed to wait for callbacks registered on other CPUs.
 	Or even on the current CPU if that CPU recently went offline
 	and came back online.
@@ -457,7 +457,7 @@ over a rather long period of time, but improvements are always welcome!
 	-	call_rcu() -> rcu_barrier()
 	-	call_srcu() -> srcu_barrier()
 
-	However, these barrier functions are absolutely -not- guaranteed
+	However, these barrier functions are absolutely *not* guaranteed
 	to wait for a grace period.  In fact, if there are no call_rcu()
 	callbacks waiting anywhere in the system, rcu_barrier() is within
 	its rights to return immediately.
diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index f3e587acb4de..0b418a5b243c 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -43,7 +43,7 @@ Follow these rules to keep your RCU code working properly:
 	-	Set bits and clear bits down in the must-be-zero low-order
 		bits of that pointer.  This clearly means that the pointer
 		must have alignment constraints, for example, this does
-		-not- work in general for char* pointers.
+		*not* work in general for char* pointers.
 
 	-	XOR bits to translate pointers, as is done in some
 		classic buddy-allocator algorithms.
@@ -174,7 +174,7 @@ Follow these rules to keep your RCU code working properly:
 		Please see the "CONTROL DEPENDENCIES" section of
 		Documentation/memory-barriers.txt for more details.
 
-	-	The pointers are not equal -and- the compiler does
+	-	The pointers are not equal *and* the compiler does
 		not have enough information to deduce the value of the
 		pointer.  Note that the volatile cast in rcu_dereference()
 		will normally prevent the compiler from knowing too much.
@@ -360,7 +360,7 @@ in turn destroying the ordering between this load and the loads of the
 return values.  This can result in "p->b" returning pre-initialization
 garbage values.
 
-In short, rcu_dereference() is -not- optional when you are going to
+In short, rcu_dereference() is *not* optional when you are going to
 dereference the resulting pointer.
 
 
diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 7148e9be08c3..1cc944aec46f 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -32,7 +32,7 @@ warnings:
 
 -	Booting Linux using a console connection that is too slow to
 	keep up with the boot-time console-message rate.  For example,
-	a 115Kbaud serial console can be -way- too slow to keep up
+	a 115Kbaud serial console can be *way* too slow to keep up
 	with boot-time message rates, and will frequently result in
 	RCU CPU stall warning messages.  Especially if you have added
 	debug printk()s.
@@ -105,7 +105,7 @@ warnings:
 	leading the realization that the CPU had failed.
 
 The RCU, RCU-sched, and RCU-tasks implementations have CPU stall warning.
-Note that SRCU does -not- have CPU stall warnings.  Please note that
+Note that SRCU does *not* have CPU stall warnings.  Please note that
 RCU only detects CPU stalls when there is a grace period in progress.
 No grace period, no CPU stall warnings.
 
@@ -145,7 +145,7 @@ CONFIG_RCU_CPU_STALL_TIMEOUT
 	this parameter is checked only at the beginning of a cycle.
 	So if you are 10 seconds into a 40-second stall, setting this
 	sysfs parameter to (say) five will shorten the timeout for the
-	-next- stall, or the following warning for the current stall
+	*next* stall, or the following warning for the current stall
 	(assuming the stall lasts long enough).  It will not affect the
 	timing of the next warning for the current stall.
 
@@ -202,7 +202,7 @@ causing stalls, and that the stall was affecting RCU-sched.  This message
 will normally be followed by stack dumps for each CPU.  Please note that
 PREEMPT_RCU builds can be stalled by tasks as well as by CPUs, and that
 the tasks will be indicated by PID, for example, "P3421".  It is even
-possible for an rcu_state stall to be caused by both CPUs -and- tasks,
+possible for an rcu_state stall to be caused by both CPUs *and* tasks,
 in which case the offending CPUs and tasks will all be called out in the list.
 
 CPU 2's "(3 GPs behind)" indicates that this CPU has not interacted with
-- 
2.17.1

