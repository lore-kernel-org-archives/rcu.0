Return-Path: <SRS0=LF1p=UZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF98C48BD6
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 20:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0D1208E3
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 20:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXh+krZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfFZUHJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:07:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45062 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfFZUHI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Jun 2019 16:07:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so1497982otq.12;
        Wed, 26 Jun 2019 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80yphXKc7+ax2BhQKNdt1wTSg726mb3YDvcqvcIpMqc=;
        b=mXh+krZwyd3P7hbA72x+9JiNabkHOpwvbgp6GIJ6gt14KvoeFUpYPiu19A0krK8rJN
         cZ1354/S/zSkz6gBgmDqW8v8QL1e6T61djXl3kfKQw7SAJ4FnG91gY3zSqzRGVpPv3CR
         8cQTV/kGOdC/5S2prZLbBdI9DEoE2oktri9zBgGyj48jXHDqOi8cM3GXSrcIM5nXjxt+
         /R0BCnu6fhx2F4JCShbBAPSTDe1MmuvYOPzGeNowA6dbIRuTc8jRmCbtGxeAZ1FkKdKH
         3a9MnYEeOmWZ7eHd8fUY/iVt8K3g9m0m8MWn2diyZIvVgwGu/4MEXBhDgOgIQKLcXwMs
         igLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80yphXKc7+ax2BhQKNdt1wTSg726mb3YDvcqvcIpMqc=;
        b=pddnUBXAOKE5BojTVN9t1KG2Jh7DIuqS3LFvCcuSSDankQv4x4whNSok6wk0JxioVC
         riXVoRe1firsmFgl+yU4K88qHj3PKZWrZ6jPCGIhXyse7XvZNTDT7qwXzObqiWVG8TL2
         9lPAjs9UVCTlOT6mcipASoNpd4ILDACbaVsah/1W/HX877bJDnthuEvuI46I9BQy4sly
         mmap8dmWErBMxJKJFQVJH9r6r2/ilYtwtqnMjB3OKSfHZav4auuPMP7/ERD5Appma9j+
         1yqsB6KUrLkMfSSnv6Lpt9+XCvAYM75OMNQl0WGjv4zhVf4XTCh1ga41TzDNfIGUpj9x
         lh9A==
X-Gm-Message-State: APjAAAVnRM31GV/BIHvQ4QXAJpgSA4+KzoyB9W4Kl1UAnk51VZeTNrue
        LL7uGgaBdIpDuLf4qLMmxjg=
X-Google-Smtp-Source: APXvYqznkz3abF6wyx63Cjl/LYTeRNxOalk8MkzqfEl04HmuwNogmJ/hPfp8skGVwTW7GFEY51p6mQ==
X-Received: by 2002:a9d:7ccb:: with SMTP id r11mr89131otn.80.1561579627836;
        Wed, 26 Jun 2019 13:07:07 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id l15sm6952771otr.38.2019.06.26.13.07.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 13:07:07 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v5 1/5] Documentation: RCU: Convert RCU basic concepts to reST
Date:   Wed, 26 Jun 2019 15:07:01 -0500
Message-Id: <20190626200705.24501-2-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626191249.21135-1-c0d1n61at3@gmail.com>
References: <20190626191249.21135-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU basic concepts reST markup.

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/rcu.txt | 119 +++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 58 deletions(-)

diff --git a/Documentation/RCU/rcu.txt b/Documentation/RCU/rcu.txt
index c818cf65c5a9..8dfb437dacc3 100644
--- a/Documentation/RCU/rcu.txt
+++ b/Documentation/RCU/rcu.txt
@@ -1,5 +1,7 @@
-RCU Concepts
+.. _rcu_doc:
 
+RCU Concepts
+============
 
 The basic idea behind RCU (read-copy update) is to split destructive
 operations into two parts, one that prevents anyone from seeing the data
@@ -8,82 +10,83 @@ A "grace period" must elapse between the two parts, and this grace period
 must be long enough that any readers accessing the item being deleted have
 since dropped their references.  For example, an RCU-protected deletion
 from a linked list would first remove the item from the list, wait for
-a grace period to elapse, then free the element.  See the listRCU.txt
-file for more information on using RCU with linked lists.
-
+a grace period to elapse, then free the element.  See the
+Documentation/RCU/listRCU.rst file for more information on using RCU with
+linked lists.
 
 Frequently Asked Questions
+--------------------------
 
-o	Why would anyone want to use RCU?
+- Why would anyone want to use RCU?
 
-	The advantage of RCU's two-part approach is that RCU readers need
-	not acquire any locks, perform any atomic instructions, write to
-	shared memory, or (on CPUs other than Alpha) execute any memory
-	barriers.  The fact that these operations are quite expensive
-	on modern CPUs is what gives RCU its performance advantages
-	in read-mostly situations.  The fact that RCU readers need not
-	acquire locks can also greatly simplify deadlock-avoidance code.
+  The advantage of RCU's two-part approach is that RCU readers need
+  not acquire any locks, perform any atomic instructions, write to
+  shared memory, or (on CPUs other than Alpha) execute any memory
+  barriers.  The fact that these operations are quite expensive
+  on modern CPUs is what gives RCU its performance advantages
+  in read-mostly situations.  The fact that RCU readers need not
+  acquire locks can also greatly simplify deadlock-avoidance code.
 
-o	How can the updater tell when a grace period has completed
-	if the RCU readers give no indication when they are done?
+- How can the updater tell when a grace period has completed
+  if the RCU readers give no indication when they are done?
 
-	Just as with spinlocks, RCU readers are not permitted to
-	block, switch to user-mode execution, or enter the idle loop.
-	Therefore, as soon as a CPU is seen passing through any of these
-	three states, we know that that CPU has exited any previous RCU
-	read-side critical sections.  So, if we remove an item from a
-	linked list, and then wait until all CPUs have switched context,
-	executed in user mode, or executed in the idle loop, we can
-	safely free up that item.
+  Just as with spinlocks, RCU readers are not permitted to
+  block, switch to user-mode execution, or enter the idle loop.
+  Therefore, as soon as a CPU is seen passing through any of these
+  three states, we know that that CPU has exited any previous RCU
+  read-side critical sections.  So, if we remove an item from a
+  linked list, and then wait until all CPUs have switched context,
+  executed in user mode, or executed in the idle loop, we can
+  safely free up that item.
 
-	Preemptible variants of RCU (CONFIG_PREEMPT_RCU) get the
-	same effect, but require that the readers manipulate CPU-local
-	counters.  These counters allow limited types of blocking within
-	RCU read-side critical sections.  SRCU also uses CPU-local
-	counters, and permits general blocking within RCU read-side
-	critical sections.  These variants of RCU detect grace periods
-	by sampling these counters.
+  Preemptible variants of RCU (CONFIG_PREEMPT_RCU) get the
+  same effect, but require that the readers manipulate CPU-local
+  counters.  These counters allow limited types of blocking within
+  RCU read-side critical sections.  SRCU also uses CPU-local
+  counters, and permits general blocking within RCU read-side
+  critical sections.  These variants of RCU detect grace periods
+  by sampling these counters.
 
-o	If I am running on a uniprocessor kernel, which can only do one
-	thing at a time, why should I wait for a grace period?
+- If I am running on a uniprocessor kernel, which can only do one
+  thing at a time, why should I wait for a grace period?
 
-	See the UP.txt file in this directory.
+  See the Documentation/RCU/UP.rst file for more information.
 
-o	How can I see where RCU is currently used in the Linux kernel?
+- How can I see where RCU is currently used in the Linux kernel?
 
-	Search for "rcu_read_lock", "rcu_read_unlock", "call_rcu",
-	"rcu_read_lock_bh", "rcu_read_unlock_bh", "srcu_read_lock",
-	"srcu_read_unlock", "synchronize_rcu", "synchronize_net",
-	"synchronize_srcu", and the other RCU primitives.  Or grab one
-	of the cscope databases from:
+  Search for "rcu_read_lock", "rcu_read_unlock", "call_rcu",
+  "rcu_read_lock_bh", "rcu_read_unlock_bh", "srcu_read_lock",
+  "srcu_read_unlock", "synchronize_rcu", "synchronize_net",
+  "synchronize_srcu", and the other RCU primitives.  Or grab one
+  of the cscope databases from:
 
-	http://www.rdrop.com/users/paulmck/RCU/linuxusage/rculocktab.html
+  (http://www.rdrop.com/users/paulmck/RCU/linuxusage/rculocktab.html).
 
-o	What guidelines should I follow when writing code that uses RCU?
+- What guidelines should I follow when writing code that uses RCU?
 
-	See the checklist.txt file in this directory.
+  See the checklist.txt file in this directory.
 
-o	Why the name "RCU"?
+- Why the name "RCU"?
 
-	"RCU" stands for "read-copy update".  The file listRCU.txt has
-	more information on where this name came from, search for
-	"read-copy update" to find it.
+  "RCU" stands for "read-copy update".  The file Documentation/RCU/listRCU.rst
+  has more information on where this name came from, search for
+  "read-copy update" to find it.
 
-o	I hear that RCU is patented?  What is with that?
+- I hear that RCU is patented?  What is with that?
 
-	Yes, it is.  There are several known patents related to RCU,
-	search for the string "Patent" in RTFP.txt to find them.
-	Of these, one was allowed to lapse by the assignee, and the
-	others have been contributed to the Linux kernel under GPL.
-	There are now also LGPL implementations of user-level RCU
-	available (http://liburcu.org/).
+  Yes, it is.  There are several known patents related to RCU,
+  search for the string "Patent" in RTFP.txt to find them.
+  Of these, one was allowed to lapse by the assignee, and the
+  others have been contributed to the Linux kernel under GPL.
+  There are now also LGPL implementations of user-level RCU
+  available (http://liburcu.org/).
 
-o	I hear that RCU needs work in order to support realtime kernels?
+- I hear that RCU needs work in order to support realtime kernels?
 
-	Realtime-friendly RCU can be enabled via the CONFIG_PREEMPT_RCU
-	kernel configuration parameter.
+  Realtime-friendly RCU can be enabled via the CONFIG_PREEMPT_RCU
+  kernel configuration parameter.
 
-o	Where can I find more information on RCU?
+- Where can I find more information on RCU?
 
-	See the RTFP.txt file in this directory.
-	Or point your browser at http://www.rdrop.com/users/paulmck/RCU/.
+  See the RTFP.txt file in this directory.
+  Or point your browser at (http://www.rdrop.com/users/paulmck/RCU/).
-- 
2.22.0

