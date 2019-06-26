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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAB1C48BD3
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 19:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AB8208E3
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 19:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl9McW+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFZTMz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:12:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39844 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZTMz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Jun 2019 15:12:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id m202so2794812oig.6;
        Wed, 26 Jun 2019 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfGl7rnx2VtiN/Akv3IMVbLxZWEXAljsIINNTGpUd6E=;
        b=jl9McW+gD+Xjw9rPobYEAO8x98Cyu0pUIzt/bD3vkobvtlRnotgJCJz4v0Cez4L+z/
         HgoG8jFUOy6s3VcUmXA2+BzWSr+F5lnHG17u2mFtOhFFqU6vDMrk6aLLjxTGf3R1tAw4
         ZJE4SqB0wuB9HlcVATD0feWDyWQ1VrZXmxUwVl9zUxl5LB2xd12iYwtSWojp2YJf0tel
         CiSha9pkQlAFJDAeFXrgeWFZzTzim0qvjBPiSgthDv2joDaD0pcFqDE13oqyoSSdFltD
         5C8sVhiJJJy0ggdUeFSZtfCs1Rd/BwicNX8ZFXH0JbDSSms0VkqIUQ1hch20PMREm7dl
         Yyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfGl7rnx2VtiN/Akv3IMVbLxZWEXAljsIINNTGpUd6E=;
        b=mH4RVPseONBrZdv86cLX12swbTZ/dq4Rkg4QoKT2TWRFI4tH7QH/PRPa1GCX1h1Kx6
         cPsuQocBzlyxyt9g8mf2W3lB57GG++Lwji6aVazrKp9UhyPkqBA7Fl4hRyl1ZmhtourY
         cxkNtG++mG/HRsp+2p2CWSQtBUnVCE/Gq+5izPiMggZ2xs9dS/avKHG1nCk2LNIxRI+K
         eoMd9jTJnlg8sCxw7nYiY/lKUth+PChaq6jqTv4Oi0dFImmGWaR1vwFrXjfNxLaCQuHq
         8hG+huIC7kORivjvyHnk7+AlW67T860LFeHODBWTjYhNuWB/reihvyTDuEMVPGwnb54k
         5VhQ==
X-Gm-Message-State: APjAAAXzJlYyful8WonGfigGUD/aY6WnTA8bdckrh9/rkn3UI1W6MFyV
        FKA8syiEL6Bb9t1qIBhKWkM=
X-Google-Smtp-Source: APXvYqzpNRFKFM/eTrTNRyRxj7z8foMAIm/sh7RNDbNBKvHKJzGpsVkrRh0XgHiUKUvHqewyKBAo7A==
X-Received: by 2002:aca:4083:: with SMTP id n125mr398169oia.106.1561576374562;
        Wed, 26 Jun 2019 12:12:54 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id e16sm7886679oih.9.2019.06.26.12.12.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 12:12:54 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v4 3/5] Documentation: RCU: Convert RCU UP systems to reST
Date:   Wed, 26 Jun 2019 14:12:47 -0500
Message-Id: <20190626191249.21135-4-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190625062627.26378-1-c0d1n61at3@gmail.com>
References: <20190625062627.26378-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU UP systems reST markup.

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
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

