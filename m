Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E398C54FD0
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A49A2070B
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488699;
	bh=rC2JBpb/hIW4mOQqSFBmTya+Rci4vyWyJfGs+Tk/U2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cfPoOfXc18bc3jW7YEroEAk4Ypj1DBCjuKC00LWmQf86NGqSEECP3518GH5nTiQIs
	 GpZc2xGR6YNkzAREkIBVkhyLUAyNxqtHM5SDLhiEacu5LSkTMF65LkeYCelUaYxzo4
	 wbrzXRWiWh2M05DsYgKjguvjs7SDrRG76NjLPqW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgDUREm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbgDUREQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Apr 2020 13:04:16 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EBEE20747;
        Tue, 21 Apr 2020 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488654;
        bh=rC2JBpb/hIW4mOQqSFBmTya+Rci4vyWyJfGs+Tk/U2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1wkqvCp3liLAYErzSkakJ5v72MT6EIGV2VCo+q6gp278ywdNiO6/2G/qpIDxTYKON
         9jCMFPl3SbFCx0vWbNJkBb+A5upTgmuhz8SYrUkZ7jHugEzzjvczh9dODZFk03cV9X
         poKLe5au5b7M2JoUkZTYO9OCE0WuMNDA7W2yDCGw=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwJg-00CmLw-7U; Tue, 21 Apr 2020 19:04:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 07/10] docs: RCU: RTFP: fix bibtex entries
Date:   Tue, 21 Apr 2020 19:04:08 +0200
Message-Id: <3cc10823634f12c3d3c44ee03f73b7aaa347df63.1587488137.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587488137.git.mchehab+huawei@kernel.org>
References: <cover.1587488137.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There are several troubles at the bibtex entries with
prevent them to be processed by LaTeX:

- On LaTeX, comment lines start with '%', but here, comments
  are starting with "#";
- Underlines should be escaped.
- While the best would be to use \url{} for all URL entries,
  let's do it at least for a couple that would otherwise
  produce errors on LaTeX.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/RCU/RTFP.txt | 98 +++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
index 9bccf16736f7..6b93fbbfad19 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -231,7 +231,7 @@ Bibtex Entries
 	Use garbage collector to clean up data after everyone is done with it.
 	.
 	Oldest use of something vaguely resembling RCU that I have found.
-	http://portal.acm.org/citation.cfm?id=320619&dl=GUIDE,
+	\url{http://portal.acm.org/citation.cfm?id=320619&dl=GUIDE},
 	[Viewed December 3, 2007]
 }
 }
@@ -379,7 +379,7 @@ for Programming Languages and Operating Systems}"
 }
 }
 
-# Was Adams91, see also syncrefs.bib.
+% Was Adams91, see also syncrefs.bib.
 @Book{Andrews91textbook
 ,Author="Gregory R. Andrews"
 ,title="Concurrent Programming, Principles, and Practices"
@@ -566,7 +566,7 @@ Operating System Design and Implementation}"
 	Use of RCU-like facility in K42/Tornado.  Another independent
 	invention of RCU.
 	See especially pages 7-9 (Section 5).
-	http://www.usenix.org/events/osdi99/full_papers/gamsa/gamsa.pdf
+	\url{http://www.usenix.org/events/osdi99/full_papers/gamsa/gamsa.pdf}
 	[Viewed August 30, 2006]
 }
 }
@@ -1037,10 +1037,10 @@ Add per-cpu batch counter"
 	RCU runs reasonably on a 512-CPU SGI using Manfred Spraul's patches,
 	which may be found at:
 	https://lkml.org/lkml/2004/5/20/49 (split vars into cachelines)
-	https://lkml.org/lkml/2004/5/22/114 (cpu_quiet() patch)
+	https://lkml.org/lkml/2004/5/22/114 (cpu\_quiet() patch)
 	https://lkml.org/lkml/2004/5/25/24 (0/5)
 	https://lkml.org/lkml/2004/5/25/23 (1/5)
-		https://lkml.org/lkml/2004/5/25/265 (works for Jack)
+	https://lkml.org/lkml/2004/5/25/265 (works for Jack)
 	https://lkml.org/lkml/2004/5/25/20 (2/5)
 	https://lkml.org/lkml/2004/5/25/22 (3/5)
 	https://lkml.org/lkml/2004/5/25/19 (4/5)
@@ -1109,7 +1109,7 @@ Oregon Health and Sciences University"
 \url{http://lkml.org/lkml/2004/8/6/237}
 [Viewed June 8, 2010]"
 ,annotation={
-	Introduce rcu_dereference().
+	Introduce rcu\_dereference().
 }
 }
 
@@ -1122,7 +1122,7 @@ Oregon Health and Sciences University"
 \url{http://lkml.org/lkml/2004/8/30/87}
 [Viewed February 17, 2005]"
 ,annotation={
-	Uses active code in rcu_read_lock() and rcu_read_unlock() to
+	Uses active code in rcu\_read\_lock() and rcu\_read\_unlock() to
 	make RCU happen, allowing RCU to function on CPUs that do not
 	receive a scheduling-clock interrupt.
 }
@@ -1134,7 +1134,7 @@ Oregon Health and Sciences University"
 ,month="October"
 ,year="2004"
 ,note="Available:
-\url{http://www.cs.toronto.edu/~tomhart/masters_thesis.html}
+\url{http://www.cs.toronto.edu/~tomhart/masters\_thesis.html}
 [Viewed October 15, 2004]"
 ,annotation={
 	Proposes comparing RCU to lock-free methods for the Linux kernel.
@@ -1150,7 +1150,7 @@ Oregon Health and Sciences University"
 \url{http://marc.theaimsgroup.com/?t=109395731700004&r=1&w=2}
 [Viewed October 18, 2004]"
 ,annotation={
-	Srivatsa's RCU patch for tcp_ehash lookup.
+	Srivatsa's RCU patch for tcp\_ehash lookup.
 }
 }
 
@@ -1182,14 +1182,14 @@ Oregon Health and Sciences University"
 
 @unpublished{PaulEMcKenney2004rcu:assign:pointer
 ,Author="Paul E. McKenney"
-,Title="{[PATCH 1/3] RCU: \url{rcu_assign_pointer()} removal of memory barriers}"
+,Title="{[PATCH 1/3] RCU: \url{rcu\_assign\_pointer()} removal of memory barriers}"
 ,month="October"
 ,year="2004"
 ,note="Available:
 \url{http://lkml.org/lkml/2004/10/23/241}
 [Viewed June 8, 2010]"
 ,annotation={
-	Introduce rcu_assign_pointer().
+	Introduce rcu\_assign\_pointer().
 }
 }
 
@@ -1283,7 +1283,7 @@ Data Structures"
 
 @unpublished{JonCorbet2005DeprecateSyncKernel
 ,Author="Jonathan Corbet"
-,Title="API change: synchronize_kernel() deprecated"
+,Title="API change: synchronize\_kernel() deprecated"
 ,month="May"
 ,day="3"
 ,year="2005"
@@ -1291,8 +1291,8 @@ Data Structures"
 \url{http://lwn.net/Articles/134484/}
 [Viewed May 3, 2005]"
 ,annotation={
-	Jon Corbet describes deprecation of synchronize_kernel()
-	in favor of synchronize_rcu() and synchronize_sched().
+	Jon Corbet describes deprecation of synchronize\_kernel()
+	in favor of synchronize\_rcu() and synchronize\_sched().
 }
 }
 
@@ -1306,7 +1306,7 @@ Data Structures"
 [Viewed May 13, 2005]"
 ,annotation={
 	First publication of working lock-based deferred free patches
-	for the CONFIG_PREEMPT_RT environment.
+	for the CONFIG\_PREEMPT\_RT environment.
 }
 }
 
@@ -1511,7 +1511,7 @@ Canis Rufus and Zoicon5 and Anome and Hal Eisen"
 ,Year="2006"
 ,pages="v2 249-254"
 ,note="Available:
-\url{http://www.linuxsymposium.org/2006/view_abstract.php?content_key=184}
+\url{http://www.linuxsymposium.org/2006/view\_abstract.php?content\_key=184}
 [Viewed January 11, 2009]"
 ,annotation={
 	Uses RCU-protected radix tree for a lockless page cache.
@@ -1606,8 +1606,8 @@ Revised:
 
 @unpublished{JensAxboe2006SlowSRCU
 ,Author="Jens Axboe"
-,Title="Re: [patch] cpufreq: mark \url{cpufreq_tsc()} as
-\url{core_initcall_sync}"
+,Title="Re: [patch] cpufreq: mark \url{cpufreq\_tsc()} as
+\url{core\_initcall\_sync}"
 ,month="November"
 ,year="2006"
 ,day=17
@@ -1701,7 +1701,7 @@ Revised:
 }
 }
 
-# CoreyMinyard2007list_splice_rcu
+% CoreyMinyard2007list_splice_rcu
 @unpublished{CoreyMinyard2007list:splice:rcu
 ,Author="Corey Minyard and Paul E. McKenney"
 ,Title="{[PATCH]} add an {RCU} version of list splicing"
@@ -1712,7 +1712,7 @@ Revised:
 \url{http://lkml.org/lkml/2007/1/3/112}
 [Viewed May 28, 2007]"
 ,annotation={
-	Patch for list_splice_rcu().
+	Patch for list\_splice\_rcu().
 }
 }
 
@@ -1726,7 +1726,7 @@ Revised:
 \url{http://lwn.net/Articles/217484/}
 [Viewed November 22, 2007]"
 ,annotation={
-	LWN article introducing the rcu_barrier() primitive.
+	LWN article introducing the rcu\_barrier() primitive.
 }
 }
 
@@ -1925,7 +1925,7 @@ Revised:
 }
 }
 
-# MathieuDesnoyers2007call_rcu_schedNeeded
+% MathieuDesnoyers2007call_rcu_schedNeeded
 @unpublished{MathieuDesnoyers2007call:rcu:schedNeeded
 ,Author="Mathieu Desnoyers"
 ,Title="Re: [patch 1/2] {Linux} Kernel Markers - Support Multiple Probes"
@@ -1936,18 +1936,18 @@ Revised:
 \url{http://lkml.org/lkml/2007/12/20/244}
 [Viewed March 27, 2008]"
 ,annotation={
-	Request for call_rcu_sched() and rcu_barrier_sched().
+	Request for call\_rcu\_sched() and rcu\_barrier\_sched().
 }
 }
 
 
-########################################################################
-#
-#	"What is RCU?" LWN series.
-#
-#	http://lwn.net/Articles/262464/ (What is RCU, Fundamentally?)
-#	http://lwn.net/Articles/263130/ (What is RCU's Usage?)
-#	http://lwn.net/Articles/264090/ (What is RCU's API?)
+%#######################################################################
+%
+%	"What is RCU?" LWN series.
+%
+%	http://lwn.net/Articles/262464/ (What is RCU, Fundamentally?)
+%	http://lwn.net/Articles/263130/ (What is RCU's Usage?)
+%	http://lwn.net/Articles/264090/ (What is RCU's API?)
 
 @unpublished{PaulEMcKenney2007WhatIsRCUFundamentally
 ,Author="Paul E. McKenney and Jonathan Walpole"
@@ -2000,10 +2000,10 @@ Revised:
 }
 }
 
-#
-#	"What is RCU?" LWN series.
-#
-########################################################################
+%
+%	"What is RCU?" LWN series.
+%
+%#######################################################################
 
 
 @unpublished{SteveRostedt2008dyntickRCUpatch
@@ -2093,7 +2093,7 @@ lot of {Linux} into your technology!!!"
 ,annotation={
 	Updated RCU classic algorithm.  Introduced multi-tailed list
 	for RCU callbacks and also pulling common code into
-	__call_rcu().
+	\_\_call\_rcu().
 }
 }
 
@@ -2145,7 +2145,7 @@ lot of {Linux} into your technology!!!"
 }
 }
 
-# Was PaulEMcKenney2011cyclicRCU
+% Was PaulEMcKenney2011cyclicRCU
 @techreport{PaulEMcKenney2008cyclicRCU
 ,author="Paul E. McKenney"
 ,title="Efficient Support of Consistent Cyclic Search With Read-Copy Update"
@@ -2353,7 +2353,7 @@ lot of {Linux} into your technology!!!"
 \url{http://lkml.org/lkml/2009/10/18/129}
 [Viewed December 29, 2009]"
 ,annotation={
-	Mathieu proposed defer_rcu() with fixed-size per-thread pool
+	Mathieu proposed defer\_rcu() with fixed-size per-thread pool
 	of RCU callbacks.
 }
 }
@@ -2413,8 +2413,8 @@ lot of {Linux} into your technology!!!"
 \url{http://www.rdrop.com/users/paulmck/RCU/SimplicityThruOptimization.2010.01.21f.pdf}
 [Viewed October 10, 2010]"
 ,annotation={
-	TREE_PREEMPT_RCU optimizations greatly simplified the old
-	PREEMPT_RCU implementation.
+	TREE\_PREEMPT\_RCU optimizations greatly simplified the old
+	PREEMPT\_RCU implementation.
 }
 }
 
@@ -2426,7 +2426,7 @@ lot of {Linux} into your technology!!!"
 ,day="1"
 ,note="\url{https://lwn.net/Articles/371986/}"
 ,annotation={
-	CONFIG_PROVE_RCU, or at least an early version.
+	CONFIG\_PROVE\_RCU, or at least an early version.
 	[Viewed June 4, 2010]
 }
 }
@@ -2454,7 +2454,7 @@ lot of {Linux} into your technology!!!"
 \url{http://thread.gmane.org/gmane.linux.network/153338}
 [Viewed June 9, 2014]"
 ,annotation={
-	Use a pair of list_head structures to support RCU-protected
+	Use a pair of list\_head structures to support RCU-protected
 	resizable hash tables.
 }
 }
@@ -2466,7 +2466,7 @@ lot of {Linux} into your technology!!!"
 ,year="2010"
 ,annotation={
 	Data-race detector incorporating RCU.
-	http://www.filesystems.org/docs/abhinav-thesis/abhinav_thesis.pdf
+	\url{http://www.filesystems.org/docs/abhinav-thesis/abhinav_thesis.pdf}
 }
 }
 
@@ -2528,7 +2528,7 @@ lot of {Linux} into your technology!!!"
 	nice about it is that it actually improves performance a lot even for
 	single-threaded loads (on an SMP kernel), because it gets rid of some
 	of the most expensive parts of path component lookup, which was the
-	d_lock on every component lookup. So I'm seeing improvements of 30-50%
+	d\_lock on every component lookup. So I'm seeing improvements of 30-50%
 	on some seriously pathname-lookup intensive loads."
 }
 }
@@ -2551,7 +2551,7 @@ lot of {Linux} into your technology!!!"
 ,location = {Berkeley, CA}
 ,pages = {1--6}
 ,numpages = {6}
-,url = {http://www.usenix.org/event/hotpar11/tech/final_files/Howard.pdf}
+,url = {http://www.usenix.org/event/hotpar11/tech/final\_files/Howard.pdf}
 ,publisher = {USENIX Association}
 ,address = {Berkeley, CA, USA}
 }
@@ -2581,7 +2581,7 @@ lot of {Linux} into your technology!!!"
 ,year = {2011}
 ,pages = {145--158}
 ,numpages = {14}
-,url={http://www.usenix.org/event/atc11/tech/final_files/Triplett.pdf}
+,url={http://www.usenix.org/event/atc11/tech/final\_files/Triplett.pdf}
 ,publisher = {The USENIX Association}
 ,address = {Portland, OR USA}
 }
@@ -2690,7 +2690,7 @@ lot of {Linux} into your technology!!!"
 \url{http://www.rdrop.com/users/paulmck/RCU/RCUdynticks.2012.02.15b.pdf}
 [Viewed March 1, 2012]"
 ,annotation={
-	RCU_FAST_NO_HZ, round 2.
+	RCU\_FAST\_NO\_HZ, round 2.
 }
 }
 
@@ -2719,7 +2719,7 @@ lot of {Linux} into your technology!!!"
 ,note="\url{http://lwn.net/Articles/508991/}"
 ,annotation={
 	A couple of simple specific compiler optimizations that motivate
-	ACCESS_ONCE().
+	ACCESS\_ONCE().
 }
 }
 
@@ -2741,7 +2741,7 @@ lot of {Linux} into your technology!!!"
 ,month="September"
 ,day="17"
 ,year="2012"
-,url=http://rdrop.com/users/paulmck/techreports/survey.2012.09.17a.pdf
+,url={http://rdrop.com/users/paulmck/techreports/survey.2012.09.17a.pdf}
 ,note="Technical report paulmck.2012.09.17"
 ,annotation={
 	Overview of the first variant of no-CBs CPUs for RCU.
@@ -2807,6 +2807,6 @@ lot of {Linux} into your technology!!!"
 ,year="2013"
 ,note="\url{http://lwn.net/Articles/541037/}"
 ,annotation={
-	Getting rid of TINY_PREEMPT_RCU.
+	Getting rid of TINY\_PREEMPT\_RCU.
 }
 }
-- 
2.25.2

