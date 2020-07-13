Return-Path: <SRS0=XkjU=AY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21643C433DF
	for <rcu@archiver.kernel.org>; Mon, 13 Jul 2020 12:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED272206F0
	for <rcu@archiver.kernel.org>; Mon, 13 Jul 2020 12:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgGMMHt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:07:49 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:53196 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbgGMMHt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Jul 2020 08:07:49 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 02322BC053;
        Mon, 13 Jul 2020 12:07:43 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] docs: rcu: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 14:07:37 +0200
Message-Id: <20200713120737.33971-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 Documentation/RCU/RTFP.txt       | 46 ++++++++++++++++----------------
 Documentation/RCU/rcubarrier.rst |  4 +--
 Documentation/RCU/whatisRCU.rst  |  4 +--
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
index 9bccf16736f7..fab2870f59cb 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -566,7 +566,7 @@ Operating System Design and Implementation}"
 	Use of RCU-like facility in K42/Tornado.  Another independent
 	invention of RCU.
 	See especially pages 7-9 (Section 5).
-	http://www.usenix.org/events/osdi99/full_papers/gamsa/gamsa.pdf
+	https://www.usenix.org/events/osdi99/full_papers/gamsa/gamsa.pdf
 	[Viewed August 30, 2006]
 }
 }
@@ -921,7 +921,7 @@ Michal Ostrowski and Bryan Rosenburg and Jimi Xenidis"
 ,number="114"
 ,pages="18-26"
 ,note="Available:
-\url{http://www.linuxjournal.com/article/6993}
+\url{https://www.linuxjournal.com/article/6993}
 [Viewed November 14, 2007]"
 ,annotation={
 	Reader-friendly intro to RCU, with the infamous old-man-and-brat
@@ -967,7 +967,7 @@ Michal Ostrowski and Bryan Rosenburg and Jimi Xenidis"
 ,pages="38-46"
 ,annotation={
 	Reader friendly intro to dcache and RCU.
-	http://www.linuxjournal.com/node/7124
+	https://www.linuxjournal.com/node/7124
 	[Viewed December 26, 2010]
 }
 }
@@ -1134,7 +1134,7 @@ Oregon Health and Sciences University"
 ,month="October"
 ,year="2004"
 ,note="Available:
-\url{http://www.cs.toronto.edu/~tomhart/masters_thesis.html}
+\url{https://www.cs.toronto.edu/~tomhart/masters_thesis.html}
 [Viewed October 15, 2004]"
 ,annotation={
 	Proposes comparing RCU to lock-free methods for the Linux kernel.
@@ -1288,7 +1288,7 @@ Data Structures"
 ,day="3"
 ,year="2005"
 ,note="Available:
-\url{http://lwn.net/Articles/134484/}
+\url{https://lwn.net/Articles/134484/}
 [Viewed May 3, 2005]"
 ,annotation={
 	Jon Corbet describes deprecation of synchronize_kernel()
@@ -1322,7 +1322,7 @@ Data Structures"
 [Viewed May 13, 2005]"
 ,annotation={
 	Realtime turns into making RCU yet more realtime friendly.
-	http://lca2005.linux.org.au/Papers/Paul%20McKenney/Towards%20Hard%20Realtime%20Response%20from%20the%20Linux%20Kernel/LKS.2005.04.22a.pdf
+	https://lca2005.linux.org.au/Papers/Paul%20McKenney/Towards%20Hard%20Realtime%20Response%20from%20the%20Linux%20Kernel/LKS.2005.04.22a.pdf
 }
 }
 
@@ -1453,7 +1453,7 @@ Distributed Processing Symposium"
 [Viewed April 28, 2008]"
 ,annotation={
 	Compares QSBR, HPBR, EBR, and lock-free reference counting.
-	http://www.cs.toronto.edu/~tomhart/perflab/ipdps06.tgz
+	https://www.cs.toronto.edu/~tomhart/perflab/ipdps06.tgz
 }
 }
 
@@ -1540,7 +1540,7 @@ Revised:
 ,month="August"
 ,day="18"
 ,year="2006"
-,note="\url{http://www.nada.kth.se/~snilsson/publications/TRASH/trash.pdf}"
+,note="\url{https://www.nada.kth.se/~snilsson/publications/TRASH/trash.pdf}"
 ,annotation={
 	RCU-protected dynamic trie-hash combination.
 	[Viewed March 4, 2011]
@@ -1723,7 +1723,7 @@ Revised:
 ,day="14"
 ,year="2007"
 ,note="Available:
-\url{http://lwn.net/Articles/217484/}
+\url{https://lwn.net/Articles/217484/}
 [Viewed November 22, 2007]"
 ,annotation={
 	LWN article introducing the rcu_barrier() primitive.
@@ -2057,7 +2057,7 @@ lot of {Linux} into your technology!!!"
 ,day="24"
 ,year="2008"
 ,note="Available:
-\url{http://lwn.net/Articles/279077/}
+\url{https://lwn.net/Articles/279077/}
 [Viewed April 24, 2008]"
 ,annotation={
 	Describes use of Promela and Spin to validate (and fix!) the
@@ -2229,7 +2229,7 @@ lot of {Linux} into your technology!!!"
 ,day="17"
 ,year="2009"
 ,note="Available:
-\url{http://lwn.net/Articles/323929/}
+\url{https://lwn.net/Articles/323929/}
 [Viewed March 20, 2009]"
 ,annotation={
 	Uniprocessor assumptions allow simplified RCU implementation.
@@ -2298,7 +2298,7 @@ lot of {Linux} into your technology!!!"
 , month  = "December"
 , year   = 2009
 ,note="Available:
-\url{http://www.lttng.org/pub/thesis/desnoyers-dissertation-2009-12.pdf}
+\url{https://www.lttng.org/pub/thesis/desnoyers-dissertation-2009-12.pdf}
 [Viewed December 9, 2009]"
 ,annotation={
 	Chapter 6 (page 97) covers user-level RCU.
@@ -2375,7 +2375,7 @@ lot of {Linux} into your technology!!!"
 ,Title="User-Level Implementations of Read-Copy Update"
 ,month="December"
 ,year="2010"
-,url={\url{http://www.computer.org/csdl/trans/td/2012/02/ttd2012020375-abs.html}}
+,url={\url{https://www.computer.org/csdl/trans/td/2012/02/ttd2012020375-abs.html}}
 ,annotation={
 	RCU overview, desiderata, semi-formal semantics, user-level RCU
 	usage scenarios, three classes of RCU implementation, wait-free
@@ -2437,7 +2437,7 @@ lot of {Linux} into your technology!!!"
 ,month="February"
 ,year="2010"
 ,note="Available:
-\url{http://www.mail-archive.com/kvm@vger.kernel.org/msg28640.html}
+\url{https://www.mail-archive.com/kvm@vger.kernel.org/msg28640.html}
 [Viewed March 20, 2010]"
 ,annotation={
 	Use of RCU permits KVM to increase the size of guest OSes from
@@ -2466,7 +2466,7 @@ lot of {Linux} into your technology!!!"
 ,year="2010"
 ,annotation={
 	Data-race detector incorporating RCU.
-	http://www.filesystems.org/docs/abhinav-thesis/abhinav_thesis.pdf
+	https://www.filesystems.org/docs/abhinav-thesis/abhinav_thesis.pdf
 }
 }
 
@@ -2551,7 +2551,7 @@ lot of {Linux} into your technology!!!"
 ,location = {Berkeley, CA}
 ,pages = {1--6}
 ,numpages = {6}
-,url = {http://www.usenix.org/event/hotpar11/tech/final_files/Howard.pdf}
+,url = {https://www.usenix.org/event/hotpar11/tech/final_files/Howard.pdf}
 ,publisher = {USENIX Association}
 ,address = {Berkeley, CA, USA}
 }
@@ -2581,7 +2581,7 @@ lot of {Linux} into your technology!!!"
 ,year = {2011}
 ,pages = {145--158}
 ,numpages = {14}
-,url={http://www.usenix.org/event/atc11/tech/final_files/Triplett.pdf}
+,url={https://www.usenix.org/event/atc11/tech/final_files/Triplett.pdf}
 ,publisher = {The USENIX Association}
 ,address = {Portland, OR USA}
 }
@@ -2654,7 +2654,7 @@ lot of {Linux} into your technology!!!"
 ,year="2012"
 ,issn="1045-9219"
 ,pages="375-382"
-,doi="http://doi.ieeecomputersociety.org/10.1109/TPDS.2011.159"
+,doi="https://doi.ieeecomputersociety.org/10.1109/TPDS.2011.159"
 ,publisher="IEEE Computer Society"
 ,address="Los Alamitos, CA, USA"
 ,annotation={
@@ -2677,7 +2677,7 @@ lot of {Linux} into your technology!!!"
 ,numpages = {12}
 ,publisher = {ACM}
 ,address = {London, UK}
-,url="http://people.csail.mit.edu/nickolai/papers/clements-bonsai.pdf"
+,url="https://people.csail.mit.edu/nickolai/papers/clements-bonsai.pdf"
 }
 
 @unpublished{PaulEMcKenney2012ELCbattery
@@ -2729,7 +2729,7 @@ lot of {Linux} into your technology!!!"
 ,month="July"
 ,day="10"
 ,year="2012"
-,note="\url{http://software.imdea.org/~gotsman/papers/recycling-esop13-ext.pdf}"
+,note="\url{https://software.imdea.org/~gotsman/papers/recycling-esop13-ext.pdf}"
 ,annotation={
 	Separation-logic formulation of RCU uses.
 }
@@ -2768,9 +2768,9 @@ lot of {Linux} into your technology!!!"
 ,annotation={
 	Looking for data races, including those involving RCU.
 	Proposal:
-	http://www.fsl.cs.sunysb.edu/docs/jseyster-proposal/redflag.pdf
+	https://www.fsl.cs.sunysb.edu/docs/jseyster-proposal/redflag.pdf
 	Dissertation:
-	http://www.fsl.cs.sunysb.edu/docs/jseyster-dissertation/redflag.pdf
+	https://www.fsl.cs.sunysb.edu/docs/jseyster-dissertation/redflag.pdf
 }
 }
 
@@ -2795,7 +2795,7 @@ lot of {Linux} into your technology!!!"
 ,publisher = {Springer}
 ,address = {Rome, Italy}
 ,annotation={
-	http://software.imdea.org/~gotsman/papers/recycling-esop13.pdf
+	https://software.imdea.org/~gotsman/papers/recycling-esop13.pdf
 }
 }
 
diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.rst
index f64f4413a47c..e7b229bb4db7 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -3,7 +3,7 @@
 RCU and Unloadable Modules
 ==========================
 
-[Originally published in LWN Jan. 14, 2007: http://lwn.net/Articles/217484/]
+[Originally published in LWN Jan. 14, 2007: https://lwn.net/Articles/217484/]
 
 RCU (read-copy update) is a synchronization mechanism that can be thought
 of as a replacement for read-writer locking (among other things), but with
@@ -59,7 +59,7 @@ But what if p_callback is defined in an unloadable module?
 If we unload the module while some RCU callbacks are pending,
 the CPUs executing these callbacks are going to be severely
 disappointed when they are later invoked, as fancifully depicted at
-http://lwn.net/images/ns/kernel/rcu-drop.jpg.
+https://lwn.net/images/ns/kernel/rcu-drop.jpg.
 
 We could try placing a synchronize_rcu() in the module-exit code path,
 but this is not sufficient. Although synchronize_rcu() does wait for a
diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index c7f147b8034f..c1d5105a7317 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -11,8 +11,8 @@ to start learning about RCU:
 | 3.	RCU part 3: the RCU API      http://lwn.net/Articles/264090/
 | 4.	The RCU API, 2010 Edition    http://lwn.net/Articles/418853/
 | 	2010 Big API Table           http://lwn.net/Articles/419086/
-| 5.	The RCU API, 2014 Edition    http://lwn.net/Articles/609904/
-|	2014 Big API Table           http://lwn.net/Articles/609973/
+| 5.	The RCU API, 2014 Edition    https://lwn.net/Articles/609904/
+|	2014 Big API Table           https://lwn.net/Articles/609973/
 
 
 What is RCU?
-- 
2.27.0

