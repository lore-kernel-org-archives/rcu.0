Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D06FC43381
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1250D22227
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbhAFAyv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:54:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbhAFAyu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 19:54:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2CF6230FC;
        Wed,  6 Jan 2021 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894449;
        bh=JpD4KmBx9W1IJoZv4gPsJ3c87ykjhFRPnU0mnL8rr9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lH01wX2Dce5LHdEkmXaTTYGVTZHINXdKQQby+ZCC2T0pywHA9kFHJQ3yjitpX0gXT
         QWveqNAZqv4szfA1zDbbnxN7DEx452CWB/McVlin9QRRHiaduvVIg6RjwzQp2kgFNT
         yPnZWwBSl7hX8khzAvva8V0Hcdc/A1DZyD2l4hewOAEneFZv8pTnWp6FtXH2Wbimvf
         gk1ZVQHkSii6jZmJupsrg8+rP+oMAFcJQvP82gTMktiwZDyDc2bpwybA8pjn4gzis3
         FeFHeShdzZoHK890eR39rk/BbIyOMdL+GRj7zN3TifJieVZSU9yC1dgEAfQ8TuYLkE
         tOOmMjWuoV08Q==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Michael Opdenacker <michael.opdenacker@free-electrons.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/8] docs: Fix typos and drop/fix dead links in RCU documentation
Date:   Tue,  5 Jan 2021 16:54:03 -0800
Message-Id: <20210106005407.12295-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005334.GA12159@paulmck-ThinkPad-P72>
References: <20210106005334.GA12159@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

It appears the Compaq link moved to a machine at HP for a while
after the merger of the two, but that doesn't work either.  A search
of HP for "wiz_2637" (w and w/o html suffix) comes up empty.

Since the references aren't critical to the documents we remove them.

Also, the lkml.kernel.org/g links have been broken for ages, so replace
them with lore.kernel.org/r links - standardize on lore for all links too.

Note that we put off fixing these 4y ago - presumably thinking that a
treewide fixup was pending.  Probably safe to go fix the RCU ones now.

https://lore.kernel.org/r/20160915144926.GD10850@linux.vnet.ibm.com/

Cc: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst       | 23 +++++++++++-----------
 Documentation/RCU/checklist.rst                    |  8 +++-----
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 1e3df77..f32f8fa 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -321,11 +321,10 @@ do_something_gp_buggy() below:
       12 }
 
 However, this temptation must be resisted because there are a
-surprisingly large number of ways that the compiler (to say nothing of
-`DEC Alpha CPUs <https://h71000.www7.hp.com/wizard/wiz_2637.html>`__)
-can trip this code up. For but one example, if the compiler were short
-of registers, it might choose to refetch from ``gp`` rather than keeping
-a separate copy in ``p`` as follows:
+surprisingly large number of ways that the compiler (or weak ordering
+CPUs like the DEC Alpha) can trip this code up. For but one example, if
+the compiler were short of registers, it might choose to refetch from
+``gp`` rather than keeping a separate copy in ``p`` as follows:
 
    ::
 
@@ -1183,7 +1182,7 @@ costs have plummeted. However, as I learned from Matt Mackall's
 `bloatwatch <http://elinux.org/Linux_Tiny-FAQ>`__ efforts, memory
 footprint is critically important on single-CPU systems with
 non-preemptible (``CONFIG_PREEMPT=n``) kernels, and thus `tiny
-RCU <https://lkml.kernel.org/g/20090113221724.GA15307@linux.vnet.ibm.com>`__
+RCU <https://lore.kernel.org/r/20090113221724.GA15307@linux.vnet.ibm.com>`__
 was born. Josh Triplett has since taken over the small-memory banner
 with his `Linux kernel tinification <https://tiny.wiki.kernel.org/>`__
 project, which resulted in `SRCU <#Sleepable%20RCU>`__ becoming optional
@@ -1624,7 +1623,7 @@ against mishaps and misuse:
    init_rcu_head() and cleaned up with destroy_rcu_head().
    Mathieu Desnoyers made me aware of this requirement, and also
    supplied the needed
-   `patch <https://lkml.kernel.org/g/20100319013024.GA28456@Krystal>`__.
+   `patch <https://lore.kernel.org/r/20100319013024.GA28456@Krystal>`__.
 #. An infinite loop in an RCU read-side critical section will eventually
    trigger an RCU CPU stall warning splat, with the duration of
    “eventually” being controlled by the ``RCU_CPU_STALL_TIMEOUT``
@@ -1716,7 +1715,7 @@ requires almost all of them be hidden behind a ``CONFIG_RCU_EXPERT``
 
 This all should be quite obvious, but the fact remains that Linus
 Torvalds recently had to
-`remind <https://lkml.kernel.org/g/CA+55aFy4wcCwaL4okTs8wXhGZ5h-ibecy_Meg9C4MNQrUnwMcg@mail.gmail.com>`__
+`remind <https://lore.kernel.org/r/CA+55aFy4wcCwaL4okTs8wXhGZ5h-ibecy_Meg9C4MNQrUnwMcg@mail.gmail.com>`__
 me of this requirement.
 
 Firmware Interface
@@ -1837,9 +1836,9 @@ NMI handlers.
 
 The name notwithstanding, some Linux-kernel architectures can have
 nested NMIs, which RCU must handle correctly. Andy Lutomirski `surprised
-me <https://lkml.kernel.org/r/CALCETrXLq1y7e_dKFPgou-FKHB6Pu-r8+t-6Ds+8=va7anBWDA@mail.gmail.com>`__
+me <https://lore.kernel.org/r/CALCETrXLq1y7e_dKFPgou-FKHB6Pu-r8+t-6Ds+8=va7anBWDA@mail.gmail.com>`__
 with this requirement; he also kindly surprised me with `an
-algorithm <https://lkml.kernel.org/r/CALCETrXSY9JpW3uE6H8WYk81sg56qasA2aqmjMPsq5dOtzso=g@mail.gmail.com>`__
+algorithm <https://lore.kernel.org/r/CALCETrXSY9JpW3uE6H8WYk81sg56qasA2aqmjMPsq5dOtzso=g@mail.gmail.com>`__
 that meets this requirement.
 
 Furthermore, NMI handlers can be interrupted by what appear to RCU to be
@@ -2264,7 +2263,7 @@ more extreme measures. Returning to the ``page`` structure, the
 ``rcu_head`` field shares storage with a great many other structures
 that are used at various points in the corresponding page's lifetime. In
 order to correctly resolve certain `race
-conditions <https://lkml.kernel.org/g/1439976106-137226-1-git-send-email-kirill.shutemov@linux.intel.com>`__,
+conditions <https://lore.kernel.org/r/1439976106-137226-1-git-send-email-kirill.shutemov@linux.intel.com>`__,
 the Linux kernel's memory-management subsystem needs a particular bit to
 remain zero during all phases of grace-period processing, and that bit
 happens to map to the bottom bit of the ``rcu_head`` structure's
@@ -2328,7 +2327,7 @@ preempted. This requirement made its presence known after users made it
 clear that an earlier `real-time
 patch <https://lwn.net/Articles/107930/>`__ did not meet their needs, in
 conjunction with some `RCU
-issues <https://lkml.kernel.org/g/20050318002026.GA2693@us.ibm.com>`__
+issues <https://lore.kernel.org/r/20050318002026.GA2693@us.ibm.com>`__
 encountered by a very early version of the -rt patchset.
 
 In addition, RCU must make do with a sub-100-microsecond real-time
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index bb7128e..2d1dc1d 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -70,7 +70,7 @@ over a rather long period of time, but improvements are always welcome!
 	is less readable and prevents lockdep from detecting locking issues.
 
 	Letting RCU-protected pointers "leak" out of an RCU read-side
-	critical section is every bid as bad as letting them leak out
+	critical section is every bit as bad as letting them leak out
 	from under a lock.  Unless, of course, you have arranged some
 	other means of protection, such as a lock or a reference count
 	-before- letting them out of the RCU read-side critical section.
@@ -129,9 +129,7 @@ over a rather long period of time, but improvements are always welcome!
 		accesses.  The rcu_dereference() primitive ensures that
 		the CPU picks up the pointer before it picks up the data
 		that the pointer points to.  This really is necessary
-		on Alpha CPUs.	If you don't believe me, see:
-
-			http://www.openvms.compaq.com/wizard/wiz_2637.html
+		on Alpha CPUs.
 
 		The rcu_dereference() primitive is also an excellent
 		documentation aid, letting the person reading the
@@ -216,7 +214,7 @@ over a rather long period of time, but improvements are always welcome!
 7.	As of v4.20, a given kernel implements only one RCU flavor,
 	which is RCU-sched for PREEMPT=n and RCU-preempt for PREEMPT=y.
 	If the updater uses call_rcu() or synchronize_rcu(),
-	then the corresponding readers my use rcu_read_lock() and
+	then the corresponding readers may use rcu_read_lock() and
 	rcu_read_unlock(), rcu_read_lock_bh() and rcu_read_unlock_bh(),
 	or any pair of primitives that disables and re-enables preemption,
 	for example, rcu_read_lock_sched() and rcu_read_unlock_sched().
-- 
2.9.5

