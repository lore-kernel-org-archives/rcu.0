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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E93C48BD4
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 06:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5DB20659
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 06:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un8NUg8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfFYG0c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:26:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46277 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbfFYG0c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jun 2019 02:26:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id z23so16059615ote.13
        for <rcu@vger.kernel.org>; Mon, 24 Jun 2019 23:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YFX68lUA9sgUgFyYp+ltvAYsnUgXr1z9VOeOxTKbtDY=;
        b=Un8NUg8MyfRPcolfm3xkXFYSmg+OH8yJjFvhjfjBGsU0uAj+HxMql8kBu9AebKLyjH
         3+HB64QNXS+dOYaKQeC8sHn4AD0xDbhZtODwZn9MTSGqg0kdFuF+M3/WHXxSGjeFayzs
         g0BSYLQJQF5stc4Rt8UEKTb2cDHbIVnka/G9PxGf3FSMLhMmR65kFMLBV8nWvUhfAWPa
         ugW8zlPvOEJODoEXbvoltNAZjdBLtRBaBhfT9ZJ27qDn7dD6TlQV3c0uz+y0Pp5cvMIB
         BsCQBWlxKyRkGg74LIb2tOpIgr3qeTVTtKUGINEmGICuQXyohxfVg3bqP1ADPOuYR/h+
         cKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFX68lUA9sgUgFyYp+ltvAYsnUgXr1z9VOeOxTKbtDY=;
        b=poY0kVvhwplCQ+BdAFkA9mVisXFeWxQgAtRmYHFF58ilmJ5Rz02GkVh+7plGia0C/R
         E6zKjsG6/NH8ReXoWViANUxq0Kh1S5fBRcf4vnkTc+qYIEmVia22J6sODHDEQ4iiwrk2
         TFIHiYj5Ar7KscWP1W4ay7kSMT+3OzJna2o4AKWBRn8j/PdRCgqILVsyrmuYzxy7U8Vg
         Bc78nnxF6g18dVfz4+0KpM/kZHZ8/8MPrpS59GzqF5/bUdY0FY+XPZtIvn1+NMRKEbCZ
         Xi1AK5dZkUEmh9GYznRwTIlL8AZuWguVxN/pEUlridEwUrts+9lES3WNsJi3kazTF0ce
         mPAQ==
X-Gm-Message-State: APjAAAXRqSg1QIqHFVnGdZP5TvS0gljMpm8cUCIQOyrSz63XSvJ+07XY
        SFImC4XAnuuTl2lsHAPw1Pw=
X-Google-Smtp-Source: APXvYqy4vMNijP5/srwsGp46hmfjzj08OjJ1pRrRGcDzT+BcE6em42mrOyGK1jgAE997UUvjJMGmDA==
X-Received: by 2002:a05:6830:1c5:: with SMTP id r5mr67754958ota.226.1561443991094;
        Mon, 24 Jun 2019 23:26:31 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id e4sm5050183oti.64.2019.06.24.23.26.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 23:26:30 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, paulmck@linux.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v3 3/6] Documentation: RCU: Convert RCU UP systems to reST
Date:   Tue, 25 Jun 2019 01:26:24 -0500
Message-Id: <20190625062627.26378-4-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623081413.7095-1-c0d1n61at3@gmail.com>
References: <20190623081413.7095-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU UP systems reST markup.

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/UP.txt | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/Documentation/RCU/UP.txt b/Documentation/RCU/UP.txt
index 53bde717017b..67715a47ae89 100644
--- a/Documentation/RCU/UP.txt
+++ b/Documentation/RCU/UP.txt
@@ -1,17 +1,19 @@
-RCU on Uniprocessor Systems
+.. _up_doc:
 
+RCU on Uniprocessor Systems
+===========================
 
 A common misconception is that, on UP systems, the call_rcu() primitive
 may immediately invoke its function.  The basis of this misconception
 is that since there is only one CPU, it should not be necessary to
 wait for anything else to get done, since there are no other CPUs for
-anything else to be happening on.  Although this approach will -sort- -of-
+anything else to be happening on.  Although this approach will *sort of*
 work a surprising amount of the time, it is a very bad idea in general.
 This document presents three examples that demonstrate exactly how bad
 an idea this is.
 
-
 Example 1: softirq Suicide
+--------------------------
 
 Suppose that an RCU-based algorithm scans a linked list containing
 elements A, B, and C in process context, and can delete elements from
@@ -28,8 +30,8 @@ your kernel.
 This same problem can occur if call_rcu() is invoked from a hardware
 interrupt handler.
 
-
 Example 2: Function-Call Fatality
+---------------------------------
 
 Of course, one could avert the suicide described in the preceding example
 by having call_rcu() directly invoke its arguments only if it was called
@@ -46,11 +48,13 @@ its arguments would cause it to fail to make the fundamental guarantee
 underlying RCU, namely that call_rcu() defers invoking its arguments until
 all RCU read-side critical sections currently executing have completed.
 
-Quick Quiz #1: why is it -not- legal to invoke synchronize_rcu() in
-	this case?
+Quick Quiz #1:
+	Why is it *not* legal to invoke synchronize_rcu() in this case?
 
+:ref:`Answers to Quick Quiz <answer_quick_quiz_up>`
 
 Example 3: Death by Deadlock
+----------------------------
 
 Suppose that call_rcu() is invoked while holding a lock, and that the
 callback function must acquire this same lock.  In this case, if
@@ -76,25 +80,30 @@ there are cases where this can be quite ugly:
 If call_rcu() directly invokes the callback, painful locking restrictions
 or API changes would be required.
 
-Quick Quiz #2: What locking restriction must RCU callbacks respect?
+Quick Quiz #2:
+	What locking restriction must RCU callbacks respect?
 
+:ref:`Answers to Quick Quiz <answer_quick_quiz_up>`
 
 Summary
+-------
 
 Permitting call_rcu() to immediately invoke its arguments breaks RCU,
 even on a UP system.  So do not do it!  Even on a UP system, the RCU
-infrastructure -must- respect grace periods, and -must- invoke callbacks
+infrastructure *must* respect grace periods, and *must* invoke callbacks
 from a known environment in which no locks are held.
 
-Note that it -is- safe for synchronize_rcu() to return immediately on
-UP systems, including !PREEMPT SMP builds running on UP systems.
+Note that it *is* safe for synchronize_rcu() to return immediately on
+UP systems, including PREEMPT SMP builds running on UP systems.
 
-Quick Quiz #3: Why can't synchronize_rcu() return immediately on
-	UP systems running preemptable RCU?
+Quick Quiz #3:
+	Why can't synchronize_rcu() return immediately on UP systems running
+	preemptable RCU?
 
+.. _answer_quick_quiz_up:
 
 Answer to Quick Quiz #1:
-	Why is it -not- legal to invoke synchronize_rcu() in this case?
+	Why is it *not* legal to invoke synchronize_rcu() in this case?
 
 	Because the calling function is scanning an RCU-protected linked
 	list, and is therefore within an RCU read-side critical section.
@@ -119,7 +128,7 @@ Answer to Quick Quiz #2:
 
 	This restriction might seem gratuitous, since very few RCU
 	callbacks acquire locks directly.  However, a great many RCU
-	callbacks do acquire locks -indirectly-, for example, via
+	callbacks do acquire locks *indirectly*, for example, via
 	the kfree() primitive.
 
 Answer to Quick Quiz #3:
-- 
2.22.0

