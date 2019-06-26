Return-Path: <SRS0=LF1p=UZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40987C48BD3
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 20:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A284208E3
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 20:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKhGMtib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfFZUHJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:07:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45065 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZUHJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Jun 2019 16:07:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id x21so1498017otq.12;
        Wed, 26 Jun 2019 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8LsqGKVqHsA3QFbhiUqQaAgq2yHXmXdpVbDSUB0uWiw=;
        b=TKhGMtiblAg3vv8lQEjeDpxBY8mDiOkYaGPenu/zc9gr188AjojqzRnGT1RJ4mEVCK
         SZkhsPhG3qQtC/1pFnELRbqvPtbSS9G/Z31Q1M5bXVLecu5WYI4auyRos9OqQDu/dhKo
         hpKIlI5R35Q7f/+wIH+fs/EDn53bvKASAmRsEDgbyO8PgNzGbRMngelyL3RnBPHiAhWl
         mMGCw52Fs0OKzbJYRxZ11PIDIII25Mn28L6VZ60l2KMw9oTcp/X8it0BrZR/c8P8BSAM
         ouGLnTHr+10+INbwTm82kFyLW+BcsRXwkLSgZykhOK0HtJEy1Ovq7KRuGfdhPb91Uug5
         Jbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LsqGKVqHsA3QFbhiUqQaAgq2yHXmXdpVbDSUB0uWiw=;
        b=Bz3slrdF+s8McFx8DEmSuaIFojXtfnCd8JFbbwFU1opuTOPtxuNAsU/vMI+kPqhKDy
         gzO5tF0/W/v6jIAVxvZKqdm5CbJ+C46SN6J5F0ZFhKbM8w2IWLTPNk7a4rGKJIfVX/mQ
         5juWJkvF9eRHuBU5ncnzXk89BuZKShsfgdU5p1//Q0LrIxUpZVZKCldKnZZghK8aqEYT
         RO5h3lhRBJcVfiCjVIHLz/fC1x/T4Er/0YC6ZEka52FWSn+VgcjE8OGQzo2xA4nCahmQ
         ih4r0EP8Ca9KqAFxECWYwbbrO0w2S0YTcYXZ5WgYbexSqFzsOfOAr3ejmYE7GcQLdHqm
         WcUA==
X-Gm-Message-State: APjAAAUovJWFH+v4IV5Lb5T1dPnWUVwj3eucptKBK8pEYtqyB1XwwOsK
        0TjYOFDUm1lm7s3zMkkY7dU=
X-Google-Smtp-Source: APXvYqzLBSt20Ba9AeDt5fynHD79t1OpMnorkCL96Hnfn7LA9tAPBAMuERaVxPTEQwyEo1mrC7pL4g==
X-Received: by 2002:a05:6830:164e:: with SMTP id h14mr91897otr.186.1561579628626;
        Wed, 26 Jun 2019 13:07:08 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id l15sm6952771otr.38.2019.06.26.13.07.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 13:07:08 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v5 2/5] Documentation: RCU: Convert RCU linked list to reST
Date:   Wed, 26 Jun 2019 15:07:02 -0500
Message-Id: <20190626200705.24501-3-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626191249.21135-1-c0d1n61at3@gmail.com>
References: <20190626191249.21135-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU linked list reST markup.

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
 Documentation/RCU/listRCU.txt | 38 ++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/Documentation/RCU/listRCU.txt b/Documentation/RCU/listRCU.txt
index adb5a3782846..7956ff33042b 100644
--- a/Documentation/RCU/listRCU.txt
+++ b/Documentation/RCU/listRCU.txt
@@ -1,5 +1,7 @@
-Using RCU to Protect Read-Mostly Linked Lists
+.. _list_rcu_doc:
 
+Using RCU to Protect Read-Mostly Linked Lists
+=============================================
 
 One of the best applications of RCU is to protect read-mostly linked lists
 ("struct list_head" in list.h).  One big advantage of this approach
@@ -7,8 +9,8 @@ is that all of the required memory barriers are included for you in
 the list macros.  This document describes several applications of RCU,
 with the best fits first.
 
-
 Example 1: Read-Side Action Taken Outside of Lock, No In-Place Updates
+----------------------------------------------------------------------
 
 The best applications are cases where, if reader-writer locking were
 used, the read-side lock would be dropped before taking any action
@@ -24,7 +26,7 @@ added or deleted, rather than being modified in place.
 
 A straightforward example of this use of RCU may be found in the
 system-call auditing support.  For example, a reader-writer locked
-implementation of audit_filter_task() might be as follows:
+implementation of audit_filter_task() might be as follows::
 
 	static enum audit_state audit_filter_task(struct task_struct *tsk)
 	{
@@ -48,7 +50,7 @@ the corresponding value is returned.  By the time that this value is acted
 on, the list may well have been modified.  This makes sense, since if
 you are turning auditing off, it is OK to audit a few extra system calls.
 
-This means that RCU can be easily applied to the read side, as follows:
+This means that RCU can be easily applied to the read side, as follows::
 
 	static enum audit_state audit_filter_task(struct task_struct *tsk)
 	{
@@ -73,7 +75,7 @@ become list_for_each_entry_rcu().  The _rcu() list-traversal primitives
 insert the read-side memory barriers that are required on DEC Alpha CPUs.
 
 The changes to the update side are also straightforward.  A reader-writer
-lock might be used as follows for deletion and insertion:
+lock might be used as follows for deletion and insertion::
 
 	static inline int audit_del_rule(struct audit_rule *rule,
 					 struct list_head *list)
@@ -106,7 +108,7 @@ lock might be used as follows for deletion and insertion:
 		return 0;
 	}
 
-Following are the RCU equivalents for these two functions:
+Following are the RCU equivalents for these two functions::
 
 	static inline int audit_del_rule(struct audit_rule *rule,
 					 struct list_head *list)
@@ -154,13 +156,13 @@ otherwise cause concurrent readers to fail spectacularly.
 So, when readers can tolerate stale data and when entries are either added
 or deleted, without in-place modification, it is very easy to use RCU!
 
-
 Example 2: Handling In-Place Updates
+------------------------------------
 
 The system-call auditing code does not update auditing rules in place.
 However, if it did, reader-writer-locked code to do so might look as
 follows (presumably, the field_count is only permitted to decrease,
-otherwise, the added fields would need to be filled in):
+otherwise, the added fields would need to be filled in)::
 
 	static inline int audit_upd_rule(struct audit_rule *rule,
 					 struct list_head *list,
@@ -187,7 +189,7 @@ otherwise, the added fields would need to be filled in):
 The RCU version creates a copy, updates the copy, then replaces the old
 entry with the newly updated entry.  This sequence of actions, allowing
 concurrent reads while doing a copy to perform an update, is what gives
-RCU ("read-copy update") its name.  The RCU code is as follows:
+RCU ("read-copy update") its name.  The RCU code is as follows::
 
 	static inline int audit_upd_rule(struct audit_rule *rule,
 					 struct list_head *list,
@@ -216,8 +218,8 @@ RCU ("read-copy update") its name.  The RCU code is as follows:
 Again, this assumes that the caller holds audit_netlink_sem.  Normally,
 the reader-writer lock would become a spinlock in this sort of code.
 
-
 Example 3: Eliminating Stale Data
+---------------------------------
 
 The auditing examples above tolerate stale data, as do most algorithms
 that are tracking external state.  Because there is a delay from the
@@ -231,13 +233,16 @@ per-entry spinlock, and, if the "deleted" flag is set, pretends that the
 entry does not exist.  For this to be helpful, the search function must
 return holding the per-entry spinlock, as ipc_lock() does in fact do.
 
-Quick Quiz:  Why does the search function need to return holding the
-	per-entry lock for this deleted-flag technique to be helpful?
+Quick Quiz:
+	Why does the search function need to return holding the per-entry lock for
+	this deleted-flag technique to be helpful?
+
+:ref:`Answer to Quick Quiz <answer_quick_quiz_list>`
 
 If the system-call audit module were to ever need to reject stale data,
 one way to accomplish this would be to add a "deleted" flag and a "lock"
 spinlock to the audit_entry structure, and modify audit_filter_task()
-as follows:
+as follows::
 
 	static enum audit_state audit_filter_task(struct task_struct *tsk)
 	{
@@ -268,7 +273,7 @@ audit_upd_rule() would need additional memory barriers to ensure
 that the list_add_rcu() was really executed before the list_del_rcu().
 
 The audit_del_rule() function would need to set the "deleted"
-flag under the spinlock as follows:
+flag under the spinlock as follows::
 
 	static inline int audit_del_rule(struct audit_rule *rule,
 					 struct list_head *list)
@@ -290,8 +295,8 @@ flag under the spinlock as follows:
 		return -EFAULT;		/* No matching rule */
 	}
 
-
 Summary
+-------
 
 Read-mostly list-based data structures that can tolerate stale data are
 the most amenable to use of RCU.  The simplest case is where entries are
@@ -302,8 +307,9 @@ If stale data cannot be tolerated, then a "deleted" flag may be used
 in conjunction with a per-entry spinlock in order to allow the search
 function to reject newly deleted data.
 
+.. _answer_quick_quiz_list:
 
-Answer to Quick Quiz
+Answer to Quick Quiz:
 	Why does the search function need to return holding the per-entry
 	lock for this deleted-flag technique to be helpful?
 
-- 
2.22.0

