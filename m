Return-Path: <SRS0=wCpI=5A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8E7C10DCE
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FFB20722
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArkJ3n9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgCOSS6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:18:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40630 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbgCOSSy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Mar 2020 14:18:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id 19so16040354ljj.7;
        Sun, 15 Mar 2020 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AIsc7t5daJf7za1SbWkJLWMHRcwNlbWv19KiXjX0Fk0=;
        b=ArkJ3n9TLTIBUUWTKP3qF318dTIGgPi5w1uJk18CRF5qNu6o2Kx61QgplfWPQQncJ5
         MRviKBk14R76rjqMtsdTaE9NREjZpOcdA9x0f/6i6VJISpgNk8qBWTGcUuacDgN3EVbe
         u8+4/fP3uh4plScQh3djrJ4d63/Qftl7ot5o+LzOvI+nz/ZBHPPHcbWLb/tlBJWuvm8O
         ED4DoEHd6vLP+bY7O1ZOtgRBmfQIuBeqrJvEwXIOo9kTdSFIQjbjYf25VSz9jUqH0Qjm
         Km3mmhFjXdUvXRyKyqT0nnKJkcc/APGrlBz9bhlEJZRzkQdJpN62D5aCDwRBTE9DYV4r
         WZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIsc7t5daJf7za1SbWkJLWMHRcwNlbWv19KiXjX0Fk0=;
        b=VCcZ/2+RO1d7mHFRK5hYYf6GJymR8+yq8wT/Tg1j+0YGTMSr7CsKp1iosKeuf4Xa6/
         icXz60aN5R6ZdmDjVyn1G46zZUoNcSwBwIEAAFCKuhsf5CS7AFFHzsmfJL/+fzhCt9a+
         VwlpwKjcBufEK3YWhTqlYcLpuCPl0aVQA6tcwpvXY7lH2ZJPkLGs55WVpPbUYvsluoZ1
         6tN5O9KrfzkIKqDGIG2UeN+g89tXFQ19S1Ifq9n4/ZryfV4A5CTy9IZde3VfGaZTA5BE
         74THmRB6RK0kykjwoBG6o6hZYLSdQ/0rCwalygV9v5SaKQhKmlFbihYjwrjHiLCKQp4M
         ZsVg==
X-Gm-Message-State: ANhLgQ0vM3t9BnqFl9cXiufm12jfPzc1ls2KDjq8AwJlgR5OrORAE9Ut
        kRxFyj9vpaI9y5nE5hoYDSWgpfDlTHhpog==
X-Google-Smtp-Source: ADFU+vsPO9hntCV5qCgmOKoS3PtKjyQB/odboTkE1kAHXfXSB6aKW4XXN3Id6iGjH58w6cEcJ8zNBg==
X-Received: by 2002:a2e:9146:: with SMTP id q6mr4761160ljg.240.1584296332762;
        Sun, 15 Mar 2020 11:18:52 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o15sm3040629ljj.55.2020.03.15.11.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 11:18:52 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v1 4/6] rcu: rename __is_kfree_rcu_offset() macro
Date:   Sun, 15 Mar 2020 19:18:38 +0100
Message-Id: <20200315181840.6966-5-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315181840.6966-1-urezki@gmail.com>
References: <20200315181840.6966-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Rename __is_kfree_rcu_offset to __is_kvfree_rcu_offset.
All RCU paths use kvfree() now instead of kfree(), thus
rename it.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 6 +++---
 kernel/rcu/tiny.c        | 2 +-
 kernel/rcu/tree.c        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bb270221dbdc..e4961631a44f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -798,16 +798,16 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /*
  * Does the specified offset indicate that the corresponding rcu_head
- * structure can be handled by kfree_rcu()?
+ * structure can be handled by kvfree_rcu()?
  */
-#define __is_kfree_rcu_offset(offset) ((offset) < 4096)
+#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
 
 /*
  * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
  */
 #define __kfree_rcu(head, offset) \
 	do { \
-		BUILD_BUG_ON(!__is_kfree_rcu_offset(offset)); \
+		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
 		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
 	} while (0)
 
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 3dd8e6e207b0..aa897c3f2e92 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -85,7 +85,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 	unsigned long offset = (unsigned long)head->func;
 
 	rcu_lock_acquire(&rcu_callback_map);
-	if (__is_kfree_rcu_offset(offset)) {
+	if (__is_kvfree_rcu_offset(offset)) {
 		trace_rcu_invoke_kvfree_callback("", head, offset);
 		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index eef75cd210fd..bb9544238396 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2719,7 +2719,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
-	if (__is_kfree_rcu_offset((unsigned long)func))
+	if (__is_kvfree_rcu_offset((unsigned long)func))
 		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
 					 rcu_segcblist_n_cbs(&rdp->cblist));
@@ -2911,7 +2911,7 @@ static void kfree_rcu_work(struct work_struct *work)
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
+		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
 			kvfree((void *)head - offset);
 
 		rcu_lock_release(&rcu_callback_map);
-- 
2.20.1

