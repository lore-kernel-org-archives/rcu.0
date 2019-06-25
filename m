Return-Path: <SRS0=oVcv=UY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C944C48BD4
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 06:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBA120659
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 06:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBrsWVcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfFYG0a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:26:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40471 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbfFYG0a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jun 2019 02:26:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id e8so16083910otl.7
        for <rcu@vger.kernel.org>; Mon, 24 Jun 2019 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0k5IDZv28STHndBfL5mlLA85GfJC/vy4Bd3L4dDMBrg=;
        b=fBrsWVcJ/yE+oFJDUs6As6+zJhL8Kh8KlY4L6wwBXBc9ov7EC/SiYDLMFHLK8w/Sdw
         CzqpqhV3uzdrcU7MEWJH8fovgNBS2Nx7pO+EYTVyEZrn4CBT0YPLqzQFj4pXzlGrwaJJ
         4q1FlDYQIokEZBGXZ0/bdq2hA3oGgHmBuVNNKK6UzAeNkaVHvNwRl/gX4P8YPqixXRI4
         gO0/c5bV3lRvnNaUfpyZG20/cFch5PnsdUKLcyZ25lup03FIE9K6itoCBcueJrwnoBrg
         J3Hs0iK1My8aNumoQXZb2kfxMMCNw1uNlAe7E+sLzqEVFSidaiV5iPxse9q2wfjP6uM7
         e5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0k5IDZv28STHndBfL5mlLA85GfJC/vy4Bd3L4dDMBrg=;
        b=BYHbscntQHzqbnWG0VoRVCftLeTwKCf3Si5rjgOUhECSExfsmQQR+VPZvUqlFt3Y2s
         9cF7G9jmJbas6fzf+J1V+kw9dJ+JniOo/Sq9cdi9/yDj9iFrpoa52vCtF2R4oYaa+RWS
         SACe0JuBI5vQU8qN9YFz4N2i+y19GsEBg5mLb7baRjWdn/R828het+iKaDYcW+HqkyDT
         WXOLBfvX9L1ZqAJUPlVKvgI2+hXV4Pr0jcWXm6y9t65a4sDKSOtHA1CDhLb/8VTezyRx
         i26cd3EQxlDEsyV5/o/siZp+uma9UW9OP4XNLKjKbl75JcOAtLvMHBWfQJSgYALYpL9c
         g5JA==
X-Gm-Message-State: APjAAAVMio7Rk8tCtGx474wvmyE5r4nKPPuRctnksXSBfuzNTbD2nmj5
        VMzwgZj/GlQBr2Gb5EwaLo4=
X-Google-Smtp-Source: APXvYqzpupyuTu+To2F41/sMWgKvvx9f4eJrBVedwj40lRd/xwRjbHDxXhlzFROlivVN/v1NmKzz1g==
X-Received: by 2002:a9d:71cf:: with SMTP id z15mr19895321otj.21.1561443989517;
        Mon, 24 Jun 2019 23:26:29 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id e4sm5050183oti.64.2019.06.24.23.26.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 23:26:29 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, paulmck@linux.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v3 1/6] Documentation: RCU: Convert RCU basic concepts to reST
Date:   Tue, 25 Jun 2019 01:26:22 -0500
Message-Id: <20190625062627.26378-2-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623081413.7095-1-c0d1n61at3@gmail.com>
References: <20190623081413.7095-1-c0d1n61at3@gmail.com>
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
 Documentation/RCU/rcu.txt | 114 +++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 56 deletions(-)

diff --git a/Documentation/RCU/rcu.txt b/Documentation/RCU/rcu.txt
index c818cf65c5a9..000da07d683e 100644
--- a/Documentation/RCU/rcu.txt
+++ b/Documentation/RCU/rcu.txt
@@ -1,5 +1,7 @@
-RCU Concepts
+.. _rcu_doc:
 
+RCU Concepts
+============
 
 The basic idea behind RCU (read-copy update) is to split destructive
 operations into two parts, one that prevents anyone from seeing the data
@@ -11,79 +13,79 @@ from a linked list would first remove the item from the list, wait for
 a grace period to elapse, then free the element.  See the listRCU.txt
 file for more information on using RCU with linked lists.
 
-
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
+  See the UP.txt file in this directory.
 
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
+  "RCU" stands for "read-copy update".  The file listRCU.txt has
+  more information on where this name came from, search for
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

