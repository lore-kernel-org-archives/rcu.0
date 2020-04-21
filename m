Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738DEC54FC9
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4102120738
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488669;
	bh=o9j8loHbcLjA+F+Ibg7RLuKNHJ/HSg9zzKynq6bYCPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zrErRDgHktxGts6RvRp/Gnl+Svqr9Z2UvmWnTXpB5pO9Vg3pbfhYLYyQb9nKGAOj/
	 IvDq3x9WU7Oz521EMEXuloQ56/IUGA3qyeikYWXUyzhfMkvjsLRDQ1iDmEnwIn63N6
	 rEBapjYe0pkO1R65fF/5rGdH5qnz2HcZCYG1baok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgDUREY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbgDURES (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Apr 2020 13:04:18 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DA2A2073A;
        Tue, 21 Apr 2020 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488654;
        bh=o9j8loHbcLjA+F+Ibg7RLuKNHJ/HSg9zzKynq6bYCPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAUveIAP5QUgJlzWuKdRPmjAIhoOHV9cHNHj+sjmlmt4Vzlv2dREKc+f/2mOPsuxv
         f5dQsTheKeEAmJQ024JpDcDpt3olG770avdcNImKm0K4gQxVrLqCduz5ZTndEzD2Lc
         DVp6g7MitFkeGFiFHdPkjVXXGhFlR/moBEZWP6CA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwJg-00CmM2-8W; Tue, 21 Apr 2020 19:04:12 +0200
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
Subject: [PATCH 08/10] docs: RCU: convert RTFP.txt to ReST
Date:   Tue, 21 Apr 2020 19:04:09 +0200
Message-Id: <bd6eac9395fa61f26c31891f1dd5f5871f04b7b7.1587488137.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587488137.git.mchehab+huawei@kernel.org>
References: <cover.1587488137.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The conversion of this file was not trivial at all.

It had, internally, a bibtex database with 170 references.
From those, 72 entries were used at the text.

There were some bugs at the database, as several things there
were not really compatible with LaTeX. We had to first
solve those issues, with it was done on the previous
patch. The end result is now at the RTFP.bib file.

After having RTFP.bib buildable, we converted the RTFP.txt
file into a RTFP.tex file using sphinx-build, and we changed
the [foo] references to \cite{foo}, fixing some other stuff
(on some places, it uses the word "and" with was not recognized).

Then, we added this at the end of the tex file:

	\bibliographystyle{abstract}
	\bibliography{/devel/v4l/docs/Documentation/RCU/RTFP.bib}

With that, we used latex to produce a PDF file.

Then, we manually copied the generated references to the
text file, converting it to ReST.

As there are othere references inside the bib database, we're
opting to keep the bibliography file at the tree, as it might
be useful in the future.

PS.: An alternative approach would be to use the
sphinxcontrib-bibtex extension. It didn't work here, as
such extension doesn't provide support for "@Conference"
notation. We might also use a lot of ".. raw:  latex",
but, in this case, it won't be able to produce references
for html outputs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/RCU/{RTFP.txt => RTFP.bib} | 225 +--------
 Documentation/RCU/RTFP.rst               | 593 +++++++++++++++++++++++
 Documentation/RCU/index.rst              |   2 +
 Documentation/RCU/rcu.rst                |   4 +-
 4 files changed, 603 insertions(+), 221 deletions(-)
 rename Documentation/RCU/{RTFP.txt => RTFP.bib} (85%)
 create mode 100644 Documentation/RCU/RTFP.rst

diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.bib
similarity index 85%
rename from Documentation/RCU/RTFP.txt
rename to Documentation/RCU/RTFP.bib
index 6b93fbbfad19..b5c6dc5239ae 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.bib
@@ -1,222 +1,9 @@
-Read the Fscking Papers!
-
-
-This document describes RCU-related publications, and is followed by
-the corresponding bibtex entries.  A number of the publications may
-be found at http://www.rdrop.com/users/paulmck/RCU/.  For others, browsers
-and search engines will usually find what you are looking for.
-
-The first thing resembling RCU was published in 1980, when Kung and Lehman
-[Kung80] recommended use of a garbage collector to defer destruction
-of nodes in a parallel binary search tree in order to simplify its
-implementation.  This works well in environments that have garbage
-collectors, but most production garbage collectors incur significant
-overhead.
-
-In 1982, Manber and Ladner [Manber82,Manber84] recommended deferring
-destruction until all threads running at that time have terminated, again
-for a parallel binary search tree.  This approach works well in systems
-with short-lived threads, such as the K42 research operating system.
-However, Linux has long-lived tasks, so more is needed.
-
-In 1986, Hennessy, Osisek, and Seigh [Hennessy89] introduced passive
-serialization, which is an RCU-like mechanism that relies on the presence
-of "quiescent states" in the VM/XA hypervisor that are guaranteed not
-to be referencing the data structure.  However, this mechanism was not
-optimized for modern computer systems, which is not surprising given
-that these overheads were not so expensive in the mid-80s.  Nonetheless,
-passive serialization appears to be the first deferred-destruction
-mechanism to be used in production.  Furthermore, the relevant patent
-has lapsed, so this approach may be used in non-GPL software, if desired.
-(In contrast, implementation of RCU is permitted only in software licensed
-under either GPL or LGPL.  Sorry!!!)
-
-In 1987, Rashid et al. described lazy TLB-flush [RichardRashid87a].
-At first glance, this has nothing to do with RCU, but nevertheless
-this paper helped inspire the update-side batching used in the later
-RCU implementation in DYNIX/ptx.  In 1988, Barbara Liskov published
-a description of Argus that noted that use of out-of-date values can
-be tolerated in some situations.  Thus, this paper provides some early
-theoretical justification for use of stale data.
-
-In 1990, Pugh [Pugh90] noted that explicitly tracking which threads
-were reading a given data structure permitted deferred free to operate
-in the presence of non-terminating threads.  However, this explicit
-tracking imposes significant read-side overhead, which is undesirable
-in read-mostly situations.  This algorithm does take pains to avoid
-write-side contention and parallelize the other write-side overheads by
-providing a fine-grained locking design, however, it would be interesting
-to see how much of the performance advantage reported in 1990 remains
-today.
-
-At about this same time, Andrews [Andrews91textbook] described ``chaotic
-relaxation'', where the normal barriers between successive iterations
-of convergent numerical algorithms are relaxed, so that iteration $n$
-might use data from iteration $n-1$ or even $n-2$.  This introduces
-error, which typically slows convergence and thus increases the number of
-iterations required.  However, this increase is sometimes more than made
-up for by a reduction in the number of expensive barrier operations,
-which are otherwise required to synchronize the threads at the end
-of each iteration.  Unfortunately, chaotic relaxation requires highly
-structured data, such as the matrices used in scientific programs, and
-is thus inapplicable to most data structures in operating-system kernels.
-
-In 1992, Henry (now Alexia) Massalin completed a dissertation advising
-parallel programmers to defer processing when feasible to simplify
-synchronization [HMassalinPhD].  RCU makes extremely heavy use of
-this advice.
-
-In 1993, Jacobson [Jacobson93] verbally described what is perhaps the
-simplest deferred-free technique: simply waiting a fixed amount of time
-before freeing blocks awaiting deferred free.  Jacobson did not describe
-any write-side changes he might have made in this work using SGI's Irix
-kernel.  Aju John published a similar technique in 1995 [AjuJohn95].
-This works well if there is a well-defined upper bound on the length of
-time that reading threads can hold references, as there might well be in
-hard real-time systems.  However, if this time is exceeded, perhaps due
-to preemption, excessive interrupts, or larger-than-anticipated load,
-memory corruption can ensue, with no reasonable means of diagnosis.
-Jacobson's technique is therefore inappropriate for use in production
-operating-system kernels, except when such kernels can provide hard
-real-time response guarantees for all operations.
-
-Also in 1995, Pu et al. [Pu95a] applied a technique similar to that of Pugh's
-read-side-tracking to permit replugging of algorithms within a commercial
-Unix operating system.  However, this replugging permitted only a single
-reader at a time.  The following year, this same group of researchers
-extended their technique to allow for multiple readers [Cowan96a].
-Their approach requires memory barriers (and thus pipeline stalls),
-but reduces memory latency, contention, and locking overheads.
-
-1995 also saw the first publication of DYNIX/ptx's RCU mechanism
-[Slingwine95], which was optimized for modern CPU architectures,
-and was successfully applied to a number of situations within the
-DYNIX/ptx kernel.  The corresponding conference paper appeared in 1998
-[McKenney98].
-
-In 1999, the Tornado and K42 groups described their "generations"
-mechanism, which is quite similar to RCU [Gamsa99].  These operating
-systems made pervasive use of RCU in place of "existence locks", which
-greatly simplifies locking hierarchies and helps avoid deadlocks.
-
-The year 2000 saw an email exchange that would likely have
-led to yet another independent invention of something like RCU
-[RustyRussell2000a,RustyRussell2000b].  Instead, 2001 saw the first
-RCU presentation involving Linux [McKenney01a] at OLS.  The resulting
-abundance of RCU patches was presented the following year [McKenney02a],
-and use of RCU in dcache was first described that same year [Linder02a].
-
-Also in 2002, Michael [Michael02b,Michael02a] presented "hazard-pointer"
-techniques that defer the destruction of data structures to simplify
-non-blocking synchronization (wait-free synchronization, lock-free
-synchronization, and obstruction-free synchronization are all examples of
-non-blocking synchronization).  The corresponding journal article appeared
-in 2004 [MagedMichael04a].  This technique eliminates locking, reduces
-contention, reduces memory latency for readers, and parallelizes pipeline
-stalls and memory latency for writers.  However, these techniques still
-impose significant read-side overhead in the form of memory barriers.
-Researchers at Sun worked along similar lines in the same timeframe
-[HerlihyLM02].  These techniques can be thought of as inside-out reference
-counts, where the count is represented by the number of hazard pointers
-referencing a given data structure rather than the more conventional
-counter field within the data structure itself.  The key advantage
-of inside-out reference counts is that they can be stored in immortal
-variables, thus allowing races between access and deletion to be avoided.
-
-By the same token, RCU can be thought of as a "bulk reference count",
-where some form of reference counter covers all reference by a given CPU
-or thread during a set timeframe.  This timeframe is related to, but
-not necessarily exactly the same as, an RCU grace period.  In classic
-RCU, the reference counter is the per-CPU bit in the "bitmask" field,
-and each such bit covers all references that might have been made by
-the corresponding CPU during the prior grace period.  Of course, RCU
-can be thought of in other terms as well.
-
-In 2003, the K42 group described how RCU could be used to create
-hot-pluggable implementations of operating-system functions [Appavoo03a].
-Later that year saw a paper describing an RCU implementation
-of System V IPC [Arcangeli03] (following up on a suggestion by
-Hugh Dickins [Dickins02a] and an implementation by Mingming Cao
-[MingmingCao2002IPCRCU]), and an introduction to RCU in Linux Journal
-[McKenney03a].
-
-2004 has seen a Linux-Journal article on use of RCU in dcache
-[McKenney04a], a performance comparison of locking to RCU on several
-different CPUs [McKenney04b], a dissertation describing use of RCU in a
-number of operating-system kernels [PaulEdwardMcKenneyPhD], a paper
-describing how to make RCU safe for soft-realtime applications [Sarma04c],
-and a paper describing SELinux performance with RCU [JamesMorris04b].
-
-2005 brought further adaptation of RCU to realtime use, permitting
-preemption of RCU realtime critical sections [PaulMcKenney05a,
-PaulMcKenney05b].
-
-2006 saw the first best-paper award for an RCU paper [ThomasEHart2006a],
-as well as further work on efficient implementations of preemptible
-RCU [PaulEMcKenney2006b], but priority-boosting of RCU read-side critical
-sections proved elusive.  An RCU implementation permitting general
-blocking in read-side critical sections appeared [PaulEMcKenney2006c],
-Robert Olsson described an RCU-protected trie-hash combination
-[RobertOlsson2006a].
-
-2007 saw the journal version of the award-winning RCU paper from 2006
-[ThomasEHart2007a], as well as a paper demonstrating use of Promela
-and Spin to mechanically verify an optimization to Oleg Nesterov's
-QRCU [PaulEMcKenney2007QRCUspin], a design document describing
-preemptible RCU [PaulEMcKenney2007PreemptibleRCU], and the three-part
-LWN "What is RCU?" series [PaulEMcKenney2007WhatIsRCUFundamentally,
-PaulEMcKenney2008WhatIsRCUUsage, and PaulEMcKenney2008WhatIsRCUAPI].
-
-2008 saw a journal paper on real-time RCU [DinakarGuniguntala2008IBMSysJ],
-a history of how Linux changed RCU more than RCU changed Linux
-[PaulEMcKenney2008RCUOSR], and a design overview of hierarchical RCU
-[PaulEMcKenney2008HierarchicalRCU].
-
-2009 introduced user-level RCU algorithms [PaulEMcKenney2009MaliciousURCU],
-which Mathieu Desnoyers is now maintaining [MathieuDesnoyers2009URCU]
-[MathieuDesnoyersPhD].  TINY_RCU [PaulEMcKenney2009BloatWatchRCU] made
-its appearance, as did expedited RCU [PaulEMcKenney2009expeditedRCU].
-The problem of resizable RCU-protected hash tables may now be on a path
-to a solution [JoshTriplett2009RPHash].  A few academic researchers are now
-using RCU to solve their parallel problems [HariKannan2009DynamicAnalysisRCU].
-
-2010 produced a simpler preemptible-RCU implementation
-based on TREE_RCU [PaulEMcKenney2010SimpleOptRCU], lockdep-RCU
-[PaulEMcKenney2010LockdepRCU], another resizable RCU-protected hash
-table [HerbertXu2010RCUResizeHash] (this one consuming more memory,
-but allowing arbitrary changes in hash function, as required for DoS
-avoidance in the networking code), realization of the 2009 RCU-protected
-hash table with atomic node move [JoshTriplett2010RPHash], an update on
-the RCU API [PaulEMcKenney2010RCUAPI].
-
-2011 marked the inclusion of Nick Piggin's fully lockless dentry search
-[LinusTorvalds2011Linux2:6:38:rc1:NPigginVFS], an RCU-protected red-black
-tree using software transactional memory to protect concurrent updates
-(strange, but true!) [PhilHoward2011RCUTMRBTree], yet another variant of
-RCU-protected resizable hash tables [Triplett:2011:RPHash], the 3.0 RCU
-trainwreck [PaulEMcKenney2011RCU3.0trainwreck], and Neil Brown's "Meet the
-Lockers" LWN article [NeilBrown2011MeetTheLockers].  Some academic
-work looked at debugging uses of RCU [Seyster:2011:RFA:2075416.2075425].
-
-In 2012, Josh Triplett received his Ph.D. with his dissertation
-covering RCU-protected resizable hash tables and the relationship
-between memory barriers and read-side traversal order:  If the updater
-is making changes in the opposite direction from the read-side traveral
-order, the updater need only execute a memory-barrier instruction,
-but if in the same direction, the updater needs to wait for a grace
-period between the individual updates [JoshTriplettPhD].  Also in 2012,
-after seventeen years of attempts, an RCU paper made it into a top-flight
-academic journal, IEEE Transactions on Parallel and Distributed Systems
-[MathieuDesnoyers2012URCU].  A group of researchers in Spain applied
-user-level RCU to crowd simulation [GuillermoVigueras2012RCUCrowd], and
-another group of researchers in Europe produced a formal description of
-RCU based on separation logic [AlexeyGotsman2012VerifyGraceExtended],
-which was published in the 2013 European Symposium on Programming
-[AlexeyGotsman2013ESOPRCU].
-
-
-
-Bibtex Entries
+%
+% Note: This file contains the references used when RTFP.rst was created,
+% plus ~100 other unused references. While we could probably get rid of
+% this file as a hole, I opted to keep it here, as maybe those other
+% references could be useful to someone.
+%
 
 @article{Kung80
 ,author="H. T. Kung and Q. Lehman"
diff --git a/Documentation/RCU/RTFP.rst b/Documentation/RCU/RTFP.rst
new file mode 100644
index 000000000000..32a3668ed8ef
--- /dev/null
+++ b/Documentation/RCU/RTFP.rst
@@ -0,0 +1,593 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Read the Fscking Papers!
+========================
+
+
+This document describes RCU-related publications, and is followed by
+the corresponding bibtex entries.  A number of the publications may
+be found at http://www.rdrop.com/users/paulmck/RCU/.  For others, browsers
+and search engines will usually find what you are looking for.
+
+The first thing resembling RCU was published in 1980, when Kung and Lehman
+[Kung80]_ recommended use of a garbage collector to defer destruction
+of nodes in a parallel binary search tree in order to simplify its
+implementation.  This works well in environments that have garbage
+collectors, but most production garbage collectors incur significant
+overhead.
+
+In 1982, Manber and Ladner [Manber82]_ [Manber84]_ recommended deferring
+destruction until all threads running at that time have terminated, again
+for a parallel binary search tree.  This approach works well in systems
+with short-lived threads, such as the K42 research operating system.
+However, Linux has long-lived tasks, so more is needed.
+
+In 1986, Hennessy, Osisek, and Seigh [Hennessy89]_ introduced passive
+serialization, which is an RCU-like mechanism that relies on the presence
+of "quiescent states" in the VM/XA hypervisor that are guaranteed not
+to be referencing the data structure.  However, this mechanism was not
+optimized for modern computer systems, which is not surprising given
+that these overheads were not so expensive in the mid-80s.  Nonetheless,
+passive serialization appears to be the first deferred-destruction
+mechanism to be used in production.  Furthermore, the relevant patent
+has lapsed, so this approach may be used in non-GPL software, if desired.
+(In contrast, implementation of RCU is permitted only in software licensed
+under either GPL or LGPL.  Sorry!!!)
+
+In 1987, Rashid et al. described lazy TLB-flush [RichardRashid87a]_.
+At first glance, this has nothing to do with RCU, but nevertheless
+this paper helped inspire the update-side batching used in the later
+RCU implementation in DYNIX/ptx.  In 1988, Barbara Liskov published
+a description of Argus that noted that use of out-of-date values can
+be tolerated in some situations.  Thus, this paper provides some early
+theoretical justification for use of stale data.
+
+In 1990, Pugh [Pugh90]_ noted that explicitly tracking which threads
+were reading a given data structure permitted deferred free to operate
+in the presence of non-terminating threads.  However, this explicit
+tracking imposes significant read-side overhead, which is undesirable
+in read-mostly situations.  This algorithm does take pains to avoid
+write-side contention and parallelize the other write-side overheads by
+providing a fine-grained locking design, however, it would be interesting
+to see how much of the performance advantage reported in 1990 remains
+today.
+
+At about this same time, Andrews [Andrews91textbook]_ described ``chaotic
+relaxation``, where the normal barriers between successive iterations
+of convergent numerical algorithms are relaxed, so that iteration $n$
+might use data from iteration $n-1$ or even $n-2$.  This introduces
+error, which typically slows convergence and thus increases the number of
+iterations required.  However, this increase is sometimes more than made
+up for by a reduction in the number of expensive barrier operations,
+which are otherwise required to synchronize the threads at the end
+of each iteration.  Unfortunately, chaotic relaxation requires highly
+structured data, such as the matrices used in scientific programs, and
+is thus inapplicable to most data structures in operating-system kernels.
+
+In 1992, Henry (now Alexia) Massalin completed a dissertation advising
+parallel programmers to defer processing when feasible to simplify
+synchronization [HMassalinPhD]_.  RCU makes extremely heavy use of
+this advice.
+
+In 1993, Jacobson [Jacobson93]_ verbally described what is perhaps the
+simplest deferred-free technique: simply waiting a fixed amount of time
+before freeing blocks awaiting deferred free.  Jacobson did not describe
+any write-side changes he might have made in this work using SGI's Irix
+kernel.  Aju John published a similar technique in 1995 [AjuJohn95]_.
+This works well if there is a well-defined upper bound on the length of
+time that reading threads can hold references, as there might well be in
+hard real-time systems.  However, if this time is exceeded, perhaps due
+to preemption, excessive interrupts, or larger-than-anticipated load,
+memory corruption can ensue, with no reasonable means of diagnosis.
+Jacobson's technique is therefore inappropriate for use in production
+operating-system kernels, except when such kernels can provide hard
+real-time response guarantees for all operations.
+
+Also in 1995, Pu et al. [Pu95a]_ applied a technique similar to that of Pugh's
+read-side-tracking to permit replugging of algorithms within a commercial
+Unix operating system.  However, this replugging permitted only a single
+reader at a time.  The following year, this same group of researchers
+extended their technique to allow for multiple readers [Cowan96a]_.
+Their approach requires memory barriers (and thus pipeline stalls),
+but reduces memory latency, contention, and locking overheads.
+
+1995 also saw the first publication of DYNIX/ptx's RCU mechanism
+[Slingwine95]_, which was optimized for modern CPU architectures,
+and was successfully applied to a number of situations within the
+DYNIX/ptx kernel.  The corresponding conference paper appeared in 1998
+[McKenney98]_.
+
+In 1999, the Tornado and K42 groups described their "generations"
+mechanism, which is quite similar to RCU [Gamsa99]_.  These operating
+systems made pervasive use of RCU in place of "existence locks", which
+greatly simplifies locking hierarchies and helps avoid deadlocks.
+
+The year 2000 saw an email exchange that would likely have
+led to yet another independent invention of something like RCU
+[RustyRussell2000a]_ [RustyRussell2000b]_.  Instead, 2001 saw the first
+RCU presentation involving Linux [McKenney01a]_ at OLS.  The resulting
+abundance of RCU patches was presented the following year [McKenney02a]_,
+and use of RCU in dcache was first described that same year [Linder02a]_.
+
+Also in 2002, Michael [Michael02b]_ [Michael02a]_ presented "hazard-pointer"
+techniques that defer the destruction of data structures to simplify
+non-blocking synchronization (wait-free synchronization, lock-free
+synchronization, and obstruction-free synchronization are all examples of
+non-blocking synchronization).  The corresponding journal article appeared
+in 2004 [MagedMichael04a]_.  This technique eliminates locking, reduces
+contention, reduces memory latency for readers, and parallelizes pipeline
+stalls and memory latency for writers.  However, these techniques still
+impose significant read-side overhead in the form of memory barriers.
+Researchers at Sun worked along similar lines in the same timeframe
+[HerlihyLM02]_.  These techniques can be thought of as inside-out reference
+counts, where the count is represented by the number of hazard pointers
+referencing a given data structure rather than the more conventional
+counter field within the data structure itself.  The key advantage
+of inside-out reference counts is that they can be stored in immortal
+variables, thus allowing races between access and deletion to be avoided.
+
+By the same token, RCU can be thought of as a "bulk reference count",
+where some form of reference counter covers all reference by a given CPU
+or thread during a set timeframe.  This timeframe is related to, but
+not necessarily exactly the same as, an RCU grace period.  In classic
+RCU, the reference counter is the per-CPU bit in the "bitmask" field,
+and each such bit covers all references that might have been made by
+the corresponding CPU during the prior grace period.  Of course, RCU
+can be thought of in other terms as well.
+
+In 2003, the K42 group described how RCU could be used to create
+hot-pluggable implementations of operating-system functions [Appavoo03a]_.
+Later that year saw a paper describing an RCU implementation
+of System V IPC [Arcangeli03]_ (following up on a suggestion by
+Hugh Dickins [Dickins02a]_ and an implementation by Mingming Cao
+[MingmingCao2002IPCRCU]_), and an introduction to RCU in Linux Journal
+[McKenney03a]_.
+
+2004 has seen a Linux-Journal article on use of RCU in dcache
+[McKenney04a]_, a performance comparison of locking to RCU on several
+different CPUs [McKenney04b]_, a dissertation describing use of RCU in a
+number of operating-system kernels [PaulEdwardMcKenneyPhD]_, a paper
+describing how to make RCU safe for soft-realtime applications [Sarma04c]_,
+and a paper describing SELinux performance with RCU [JamesMorris04b]_.
+
+2005 brought further adaptation of RCU to realtime use, permitting
+preemption of RCU realtime critical sections [PaulMcKenney05a]_
+[PaulMcKenney05b]_.
+
+2006 saw the first best-paper award for an RCU paper [ThomasEHart2006a]_,
+as well as further work on efficient implementations of preemptible
+RCU [PaulEMcKenney2006b]_, but priority-boosting of RCU read-side critical
+sections proved elusive.  An RCU implementation permitting general
+blocking in read-side critical sections appeared [PaulEMcKenney2006c]_,
+Robert Olsson described an RCU-protected trie-hash combination
+[RobertOlsson2006a]_.
+
+2007 saw the journal version of the award-winning RCU paper from 2006
+[ThomasEHart2007a]_, as well as a paper demonstrating use of Promela
+and Spin to mechanically verify an optimization to Oleg Nesterov's
+QRCU [PaulEMcKenney2007QRCUspin]_, a design document describing
+preemptible RCU [PaulEMcKenney2007PreemptibleRCU]_, and the three-part
+LWN "What is RCU?" series [PaulEMcKenney2007WhatIsRCUFundamentally]_
+[PaulEMcKenney2008WhatIsRCUUsage]_ [PaulEMcKenney2008WhatIsRCUAPI]_.
+
+2008 saw a journal paper on real-time RCU [DinakarGuniguntala2008IBMSysJ]_,
+a history of how Linux changed RCU more than RCU changed Linux
+[PaulEMcKenney2008RCUOSR]_, and a design overview of hierarchical RCU
+[PaulEMcKenney2008HierarchicalRCU]_.
+
+2009 introduced user-level RCU algorithms [PaulEMcKenney2009MaliciousURCU]_,
+which Mathieu Desnoyers is now maintaining [MathieuDesnoyers2009URCU]_
+[MathieuDesnoyersPhD]_.  TINY_RCU [PaulEMcKenney2009BloatWatchRCU]_ made
+its appearance, as did expedited RCU [PaulEMcKenney2009expeditedRCU]_.
+The problem of resizable RCU-protected hash tables may now be on a path
+to a solution [JoshTriplett2009RPHash]_.  A few academic researchers are now
+using RCU to solve their parallel problems [HariKannan2009DynamicAnalysisRCU]_.
+
+2010 produced a simpler preemptible-RCU implementation
+based on TREE_RCU [PaulEMcKenney2010SimpleOptRCU]_, lockdep-RCU
+[PaulEMcKenney2010LockdepRCU]_, another resizable RCU-protected hash
+table [HerbertXu2010RCUResizeHash]_ (this one consuming more memory,
+but allowing arbitrary changes in hash function, as required for DoS
+avoidance in the networking code), realization of the 2009 RCU-protected
+hash table with atomic node move [JoshTriplett2010RPHash]_, an update on
+the RCU API [PaulEMcKenney2010RCUAPI]_.
+
+2011 marked the inclusion of Nick Piggin's fully lockless dentry search
+[LinusTorvalds2011Linux2:6:38:rc1:NPigginVFS]_, an RCU-protected red-black
+tree using software transactional memory to protect concurrent updates
+(strange, but true!) [PhilHoward2011RCUTMRBTree]_, yet another variant of
+RCU-protected resizable hash tables [Triplett:2011:RPHash]_, the 3.0 RCU
+trainwreck [PaulEMcKenney2011RCU3.0trainwreck]_, and Neil Brown's "Meet the
+Lockers" LWN article [NeilBrown2011MeetTheLockers]_.  Some academic
+work looked at debugging uses of RCU [Seyster:2011:RFA:2075416.2075425]_.
+
+In 2012, Josh Triplett received his Ph.D. with his dissertation
+covering RCU-protected resizable hash tables and the relationship
+between memory barriers and read-side traversal order:  If the updater
+is making changes in the opposite direction from the read-side traveral
+order, the updater need only execute a memory-barrier instruction,
+but if in the same direction, the updater needs to wait for a grace
+period between the individual updates [JoshTriplettPhD]_.  Also in 2012,
+after seventeen years of attempts, an RCU paper made it into a top-flight
+academic journal, IEEE Transactions on Parallel and Distributed Systems
+[MathieuDesnoyers2012URCU]_.  A group of researchers in Spain applied
+user-level RCU to crowd simulation [GuillermoVigueras2012RCUCrowd]_, and
+another group of researchers in Europe produced a formal description of
+RCU based on separation logic [AlexeyGotsman2012VerifyGraceExtended]_,
+which was published in the 2013 European Symposium on Programming
+[AlexeyGotsman2013ESOPRCU]_.
+
+
+References
+==========
+
+.. [AjuJohn95] Aju John. Dynamic vnodes – design and implementation.
+    In USENIX Winter 1995, pages 11–23, New Orleans, LA, January 1995.
+    USENIX Association.
+    Available: https://www.usenix.org/publications/library/proceedings/neworl/full_papers/john.a
+    [Viewed October 1, 2010].
+
+.. [AlexeyGotsman2012VerifyGraceExtended] Alexey Gotsman, Noam Rinetzky,
+    and Hongseok Yang.
+    Verifying highly concurrent algorithms with grace (extended version).
+    http://software.imdea.org/~gotsman/papers/recycling-esop13-ext.pdf,
+    July 2012.
+
+.. [AlexeyGotsman2013ESOPRCU] Alexey Gotsman, Noam Rinetzky, and Hongseok Yang.
+    Verifying concurrent memory reclamation algorithms with grace.
+    In ESOP’13: European Symposium on Programming,
+    pages 249–269, Rome, Italy, 2013. Springer.
+
+.. [Andrews91textbook] Gregory R. Andrews.
+    Concurrent Programming, Principles, and Practices.
+    Benjamin Cummins, 1991.
+
+.. [Appavoo03a] J. Appavoo, K. Hui, C. A. N. Soules, R. W. Wisniewski,
+    D. M. Da Silva, O. Krieger, M. A. Auslander, D. J. Edelsohn, B. Gamsa,
+    G. R. Ganger, P. McKenney, M. Ostrowski, B. Rosenburg, M. Stumm,
+    and J. Xenidis.
+    Enabling autonomic behavior in systems software with hot swapping.
+    IBM Systems Journal,
+    42(1):60–76, January 2003.
+
+.. [Arcangeli03] Andrea Arcangeli, Mingming Cao, Paul E. McKenney, and Dipankar Sarma.
+    Using read-copy update techniques for System V IPC in the Linux 2.5 kernel.
+    In Proceedings of the 2003 USENIX Annual Technical Conference (FREENIX Track),
+    pages 297–310. USENIX Association, June 2003.
+
+.. [Cowan96a] Crispin Cowan, Tito Autrey, Charles Krasic, Calton Pu,
+    and Jonathan Walpole.
+    Fast concurrent dynamic linking for an adaptive operating system.
+    In International Conference on Configurable Distributed Systems (ICCDS’96),
+    page 108, Annapolis, MD, May 1996.
+
+.. [Dickins02a] Hugh Dickins. Use rcu for system-v ipc.
+    private communication, October 2002.
+
+.. [DinakarGuniguntala2008IBMSysJ] D. Guniguntala, P. E. McKenney, J. Triplett,
+    and J. Walpole.
+    The read-copy-update mechanism for supporting real-time applications
+    on shared-memory multiprocessor systems with Linux.
+    IBM Systems Journal, 47(2):221–236, May 2008.
+
+.. [Gamsa99] Ben Gamsa, Orran Krieger, Jonathan Appavoo, and Michael Stumm.
+    Tornado: Maximizing locality and concurrency in a shared memory
+    multiprocessor operating system.
+    In Proceedings of the 3 rd Symposium on Operating System Design
+    and Implementation, pages 87–100, New Orleans, LA, February 1999.
+
+.. [GuillermoVigueras2012RCUCrowd] Guillermo Vigueras, Juan M. Orduña, and
+    Miguel Lozano.
+    A Read-Copy Update based parallel server for distributed crowd simulations.
+    The Journal of Supercomputing, April 2012.
+
+.. [HMassalinPhD] H. Massalin.
+    Synthesis: An Efficient Implementation of Fundamental
+    Operating System Services.
+    PhD thesis, Columbia University, New York, NY, 1992.
+
+.. [HariKannan2009DynamicAnalysisRCU] Hari Kannan.
+    Ordering decoupled meta-data accesses in multiprocessors.
+    In MICRO 42: Proceedings of the 42nd Annual IEEE/ACM International
+    Symposium on Microarchitecture, pages 381–390, New York, NY, USA, 2009. ACM.
+
+.. [Hennessy89] James P. Hennessy, Damian L. Osisek, and Joseph W. Seigh II.
+    Passive serialization in a multitasking environment.
+    Technical Report US Patent 4,809,168 (lapsed),
+    US Patent and Trademark Office, Washington, DC, February 1989.
+
+.. [HerbertXu2010RCUResizeHash] Herbert Xu.
+    bridge: Add core igmp snooping support.
+    Available: http://thread.gmane.org/gmane.linux.network/153338
+    [Viewed June 9, 2014], February 2010.
+
+.. [HerlihyLM02] Maurice Herlihy, Victor Luchangco, and Mark Moir.
+    The repeat offender problem: A mechanism for supporting
+    dynamic-sized, lock-free data structures.
+    In Proceedings of 16 th International Symposium on Distributed Computing,
+    pages 339–353, October 2002.
+
+.. [Jacobson93] Van Jacobson. Avoid read-side locking via delayed free.
+    private communication, September 1993.
+
+.. [JamesMorris04b] James Morris.
+    Recent developments in SELinux kernel performance.
+    Available: http://www.livejournal.com/users/james_morris/2153.
+    html [Viewed December 10, 2004], December 2004.
+
+.. [JoshTriplett2009RPHash] Josh Triplett.
+    Scalable concurrent hash tables via relativistic programming.
+    Linux Plumbers Conference presentation, September 2009.
+
+.. [JoshTriplett2010RPHash] Josh Triplett, Paul E. McKenney, and Jonathan Walpole.
+    Scalable concurrent hash tables via relativistic programming.
+    ACM Operating Systems Review, 44(3), July 2010.
+
+.. [JoshTriplettPhD] Josh Triplett.
+    Relativistic Causal Ordering: A Memory Model for Scalable Concurrent
+    Data Structures. PhD thesis, Portland State University, 2012.
+
+.. [Kung80] H. T. Kung and Q. Lehman.
+    Concurrent manipulation of binary search trees.
+    ACM Transactions on Database Systems, 5(3):354–382, September1980.
+
+.. [Linder02a] Hanna Linder, Dipankar Sarma, and Maneesh Soni.
+    Scalability of the directory entry cache.
+    In Ottawa Linux Symposium, pages 289–300, June 2002.
+
+.. [LinusTorvalds2011Linux2:6:38:rc1:NPigginVFS] Linus Torvalds.
+    Linux 2.6.38-rc1.
+    Available: https://lkml.org/lkml/2011/1/18/322 [Viewed March 4, 2011],
+    January 2011.
+
+.. [MagedMichael04a] Maged M. Michael.
+    Hazard pointers: Safe memory reclamation for lock-free objects.
+    IEEE Transactions on Parallel and Distributed Systems,
+    15(6):491–504, June 2004.
+
+.. [Manber82] Udi Manber and Richard E. Ladner.
+    Concurrency control in a dynamic search structure.
+    Technical Report 82-01-01, Department of Computer Science,
+    University of Washington, Seattle, Washington, January 1982.
+
+.. [Manber84] Udi Manber and Richard E. Ladner.
+    Concurrency control in a dynamic search structure.
+    ACM Transactions on Database Systems,
+    9(3):439–455, September 1984.
+
+.. [MathieuDesnoyers2009URCU] Mathieu Desnoyers.
+    [RFC git tree] userspace RCU (urcu) for Linux.
+    http://lttng.org/urcu, February 2009.
+
+.. [MathieuDesnoyers2012URCU] Mathieu Desnoyers, Paul E. McKenney,
+    Alan Stern, Michel R. Dagenais, and Jonathan Walpole.
+    User-level implementations of read-copy update.
+    IEEE Transactions on Parallel and Distributed Systems, 23:375–382, 2012.
+
+.. [MathieuDesnoyersPhD] Mathieu Desnoyers.
+    Low-Impact Operating System Tracing.
+    PhD thesis, Ecole Polytechnique de Montréal, December 2009.
+    Available: http://www.lttng.org/pub/thesis/desnoyers-dissertation-2009-12.
+    [Viewed December 9, 2009].
+
+.. [McKenney01a] Paul E. McKenney, Jonathan Appavoo, Andi Kleen, Orran Krieger,
+    Rusty Russell, Dipankar Sarma, and Maneesh Soni.
+    Read-copy update. In Ottawa Linux Symposium, July 2001.
+    Available: http://www.linuxsymposium.org/2001/abstracts/readcopy.php
+    http://www.rdrop.com/users/paulmck/RCU/rclock_OLS.2001.05.01c.pdf
+    [Viewed June 23, 2004].
+
+.. [McKenney02a] Paul E. McKenney, Dipankar Sarma, Andrea Arcangeli, Andi Kleen,
+    Orran Krieger, and Rusty Russell.
+    Read-copy update.
+    In Ottawa Linux Symposium, pages 338–367, June 2002.
+    Available: http://www.linux.org.uk/~ajh/ols2002_proceedings.pdf.gz
+    [Viewed June 23, 2004].
+
+.. [McKenney03a] Paul E. McKenney. Using RCU in the Linux 2.5 kernel.
+    Linux Journal, 1(114):18–26, October 2003.
+    Available: http://www.linuxjournal.com/article/6993
+    [Viewed November 14, 2007].
+
+.. [McKenney04a] Paul E. McKenney, Dipankar Sarma, and Maneesh Soni.
+    Scaling dcache with RCU. Linux Journal, 1(118):38–46, January 2004.
+
+.. [McKenney04b] Paul E. McKenney.
+    RCU vs. locking performance on different CPUs.
+    In linux.conf.au, Adelaide, Australia, January 2004.
+    Available: http://www.linux.org.au/conf/2004/abstracts.html#90
+    http://www.rdrop.com/users/paulmck/RCU/lockperf.2004.01.17a.pdf
+    [Viewed June 23, 2004].
+
+.. [McKenney98] Paul E. McKenney and John D. Slingwine.
+    Read-copy update: Using execution history to solve concurrency problems.
+    In Parallel and Distributed Computing and Systems, pages 509–518,
+    Las Vegas, NV, October 1998.
+
+.. [Michael02a] Maged M. Michael.
+    Safe memory reclamation for dynamic lock-free objects using atomic reads
+    and writes. In Proceedings of the 21 st Annual ACM Symposium on
+    Principles of Distributed Computing, pages 21–30, August 2002.
+
+.. [Michael02b] Maged M. Michael.
+    High performance dynamic lock-free hash tables and list-based sets.
+    In Proceedings of the 14 th Annual ACM Symposium on Parallel Algorithms
+    and Architecture, pages 73–82, August 2002.
+
+.. [MingmingCao2002IPCRCU] Mingming Cao. [patch]updated ipc lock patch.
+    Available: https://lkml.org/lkml/2002/10/24/262
+    [Viewed February 15, 2014], October 2002.
+
+.. [NeilBrown2011MeetTheLockers] Neil Brown. Meet the Lockers.
+    Available: http://lwn.net/Articles/453685/
+    [Viewed September 2, 2011], August 2011.
+
+.. [PaulMcKenney05a] Paul E. McKenney.
+    [RFC] RCU and CONFIG_PREEMPT_RT progress.
+    Available: http://lkml.org/lkml/2005/5/9/185
+    [Viewed May 13, 2005], May 2005.
+
+.. [PaulMcKenney05b] Paul E. McKenney and Dipankar Sarma.
+    Towards hard realtime response from the Linux kernel on SMP hardware.
+    In linux.conf.au 2005, Canberra, Australia, April 2005.
+    Available: http://www.rdrop.com/users/paulmck/RCU/realtimeRCU.2005.04.23a.pdf
+    [Viewed May 13, 2005].
+
+.. [PaulEMcKenney2006b] Paul E. McKenney, Dipankar Sarma, Ingo Molnar, and
+    Suparna Bhattacharya.
+    Extending RCU for realtime and embedded workloads.
+    In Ottawa Linux Symposium, pages v2 123–138, July 2006.
+    Available: http://www.linuxsymposium.org/2006/view_abstract.php?content_key=184
+    http://www.rdrop.com/users/paulmck/RCU/OLSrtRCU.2006.08.11a.pdf
+    [Viewed January 1, 2007].
+
+.. [PaulEMcKenney2006c] Paul E. McKenney. Sleepable RCU.
+    Available: http://lwn.net/Articles/202847/
+    Revised: http://www.rdrop.com/users/paulmck/RCU/srcu.2007.01.14a.pdf
+    [Viewed August 21, 2006], October 2006.
+
+.. [PaulEMcKenney2007PreemptibleRCU] Paul E. McKenney.
+    The design of preemptible read-copy-update.
+    Available: http://lwn.net/Articles/253651/
+    [Viewed October 25, 2007], October 2007.
+
+.. [PaulEMcKenney2007QRCUspin] Paul E. McKenney.
+    Using Promela and Spin to verify parallel algorithms.
+    Available: http://lwn.net/Articles/243851/
+    [Viewed September 8, 2007], August 2007.
+
+.. [PaulEMcKenney2007WhatIsRCUFundamentally] Paul E. McKenney and
+    Jonathan Walpole. What is RCU, fundamentally?
+    Available: http://lwn.net/Articles/262464/
+    [Viewed December 27, 2007], December 2007.
+
+.. [PaulEMcKenney2008HierarchicalRCU] Paul E. McKenney.
+    Hierarchical RCU. http: //lwn.net/Articles/305782/, November 2008.
+
+.. [PaulEMcKenney2008RCUOSR] Paul E. McKenney and Jonathan Walpole.
+    Introducing technology into the Linux kernel: a case study.
+    SIGOPS Oper. Syst. Rev., 42(5):4–17, 2008.
+
+.. [PaulEMcKenney2008WhatIsRCUAPI] Paul E. McKenney.
+    RCU part 3: the RCU API.
+    Available: http://lwn.net/Articles/264090/
+    [Viewed January 10, 2008], January 2008.
+
+.. [PaulEMcKenney2008WhatIsRCUUsage] Paul E. McKenney.
+    What is RCU? part 2: Usage.
+    Available: http://lwn.net/Articles/263130/
+    [Viewed January 4, 2008], January 2008.
+
+.. [PaulEMcKenney2009BloatWatchRCU] Paul E. McKenney.
+    Re: [patch fyi] rcu: the bloatwatch edition.
+    Available: http://lkml.org/lkml/2009/1/14/449
+    [Viewed January 15, 2009], January 2009.
+
+.. [PaulEMcKenney2009MaliciousURCU] Paul E. McKenney.
+    Using a malicious user-level RCU to torture RCU-based algorithms.
+    In linux.conf.au 2009, Hobart, Australia, January 2009.
+    Available: http://www.rdrop.com/users/paulmck/RCU/urcutorture.2009.01.22a.pdf
+    [Viewed February 2, 2009].
+
+.. [PaulEMcKenney2009expeditedRCU] Paul E. McKenney.
+    [PATCH -tip 0/3] expedited ’big hammer’ RCU grace periods.
+    Available: http://lkml.org/lkml/2009/6/25/306 [Viewed August 16, 2009],
+    June 2009.
+
+.. [PaulEMcKenney2010LockdepRCU] Paul E. McKenney. Lockdep-RCU.
+    https://lwn.net/Articles/371986/, February 2010.
+
+.. [PaulEMcKenney2010RCUAPI] Paul E. McKenney. The RCU API, 2010 edition.
+    http://lwn.net/Articles/418853/, December 2010.
+
+.. [PaulEMcKenney2010SimpleOptRCU] Paul E. McKenney.
+    Simplicity through optimization.
+    In linux.conf.au 2010, Wellington, New Zealand, January 2010.
+    Available: http://www.rdrop.com/users/paulmck/RCU/SimplicityThruOptimization.2010.01.21f.pdf
+    [Viewed October 10, 2010].
+
+.. [PaulEMcKenney2011RCU3.0trainwreck] Paul E. McKenney.
+    3.0 and RCU: what went wrong. http://lwn.net/Articles/453002/, July 2011.
+
+.. [PaulEdwardMcKenneyPhD] Paul E. McKenney.
+    Exploiting Deferred Destruction: An Analysis of Read-Copy-Update
+    Techniques in Operating System Kernels. PhD thesis,
+    OGI School of Science and Engineering at Oregon Health
+    and Sciences University, 2004.
+
+.. [PhilHoward2011RCUTMRBTree] Philip W. Howard and Jonathan Walpole.
+    A relativistic enhancement to software transactional memory.
+    In Proceedings of the 3rd USENIX conference on Hot topics in parallelism,
+    HotPar’11, pages 1–6, Berkeley, CA, USA, 2011. USENIX Association.
+
+.. [Pu95a] Calton Pu, Tito Autrey, Andrew Black, Charles Consel, Crispin Cowan,
+    Jon Inouye, Lakshmi Kethana, Jonathan Walpole, and Ke Zhang.
+    Optimistic incremental specialization: Streamlining a commercial,
+    operating system.
+    In 15 the ACM Symposium on Operating Systems Principles (SOSP’95),
+    pages 314–321, Copper Mountain, CO, December 1995.
+
+.. [Pugh90] William Pugh. Concurrent maintenance of skip lists.
+    Technical Report CS-TR-2222.1,
+    Institute of Advanced Computer Science Studies,
+    Department of Computer Science, University of Maryland,
+    College Park, Maryland, June 1990.
+
+.. [RichardRashid87a] Richard Rashid, Avadis Tevanian, Michael Young,
+    David Golub,Robert Baron, David Black, William Bolosky, and Jonathan Chew.
+    Machine-independent virtual memory management for paged uniprocessor
+    and multiprocessor architectures. In 2 nd Symposium on Architectural
+    Support for Programming Languages and Operating Systems,
+    pages 31–39, Palo Alto, CA, October 1987.
+    Association for Computing Machinery.
+    Available: http://www.cse.ucsc.edu/~randal/221/rashid-machvm.pdf
+    [Viewed February 17, 2005].
+
+.. [RobertOlsson2006a] Robert Olsson and Stefan Nilsson.
+    TRASH: A dynamic LC-trie and hash data structure.
+    http://www.nada.kth.se/~snilsson/publications/TRASH/trash.pdf, August 2006.
+
+.. [RustyRussell2000a] Rusty Russell. Re: modular net drivers.
+    Available: http://oss.sgi.com/projects/netdev/archive/2000-06/msg00250.html
+    [Viewed April 10, 2006], June 2000.
+
+.. [RustyRussell2000b] Rusty Russell. Re: modular net drivers.
+    Available: http://oss.sgi.com/projects/netdev/archive/2000-06/msg00254.html
+    [Viewed April 10, 2006], June 2000.
+
+.. [Sarma04c] Dipankar Sarma and Paul E. McKenney.
+    Making RCU safe for deep sub-millisecond response realtime applications.
+    In Proceedings of the 2004 USENIX Annual Technical Conference
+    (FREENIX Track), pages 182–191. USENIX Association, June 2004.
+
+.. [Seyster:2011:RFA:2075416.2075425] Justin Seyster, Prabakar Radhakrishnan,
+    Samriti Katoch, Abhinav Duggal, Scott D. Stoller, and Erez Zadok.
+    Redflag: a framework for analysis of kernel-level concurrency.
+    In Proceedings of the 11th international conference on Algorithms
+    and architectures for parallel processing - Volume Part I, ICA3PP’11,
+    pages 66–79, Berlin, Heidelberg, 2011. Springer-Verlag.
+
+.. [Slingwine95] John D. Slingwine and Paul E. McKenney.
+    Apparatus and method for achieving reduced overhead mutual exclusion
+    and maintaining coherency in a multiprocessor system utilizing execution
+    history and thread monitoring.
+    Technical Report US Patent 5,442,758, US Patent and Trademark Office,
+    Washington, DC, August 1995.
+
+.. [ThomasEHart2006a] Thomas E. Hart, Paul E. McKenney, and
+    Angela Demke Brown. Making lockless synchronization fast:
+    Performance implications of memory reclamation.
+    In 20 th IEEE International Parallel and Distributed Processing Symposium,
+    Rhodes, Greece, April 2006.
+    Available: http://www.rdrop.com/users/paulmck/RCU/hart_ipdps06.pdf
+    [Viewed April 28, 2008].
+
+.. [ThomasEHart2007a] Thomas E. Hart, Paul E. McKenney, Angela Demke Brown,
+    and Jonathan Walpole. Performance of memory reclamation for lockless
+    synchronization. J. Parallel Distrib. Comput., 67(12):1270–1285, 2007.
+
+.. [Triplett:2011:RPHash] Josh Triplett, Paul E. McKenney, and Jonathan Walpole.
+    Resizable, scalable, concurrent hash tables via relativistic programming.
+    In Proceedings of the 2011 USENIX Annual Technical Conference,
+    pages 145–158, Portland, OR USA, June 2011. The USENIX Association.
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 9a1d51f394dc..9a99db701e5d 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -24,6 +24,8 @@ RCU concepts
    NMI-RCU
    UP
 
+   RTFP
+
    Design/Memory-Ordering/Tree-RCU-Memory-Ordering
    Design/Expedited-Grace-Periods/Expedited-Grace-Periods
    Design/Requirements/Requirements
diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 0e03c6ef3147..c8fb0b5531b6 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -75,7 +75,7 @@ Frequently Asked Questions
 - I hear that RCU is patented?  What is with that?
 
   Yes, it is.  There are several known patents related to RCU,
-  search for the string "Patent" in Documentation/RCU/RTFP.txt to find them.
+  search for the string "Patent" in Documentation/RCU/RTFP.rst to find them.
   Of these, one was allowed to lapse by the assignee, and the
   others have been contributed to the Linux kernel under GPL.
   There are now also LGPL implementations of user-level RCU
@@ -88,5 +88,5 @@ Frequently Asked Questions
 
 - Where can I find more information on RCU?
 
-  See the Documentation/RCU/RTFP.txt file.
+  See the Documentation/RCU/RTFP.rst file.
   Or point your browser at (http://www.rdrop.com/users/paulmck/RCU/).
-- 
2.25.2

