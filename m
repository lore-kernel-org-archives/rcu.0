Return-Path: <SRS0=Ms3y=WH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891AAC0650F
	for <rcu@archiver.kernel.org>; Sun, 11 Aug 2019 22:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578202084D
	for <rcu@archiver.kernel.org>; Sun, 11 Aug 2019 22:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RNMJIQZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHKWLa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Aug 2019 18:11:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39485 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKWL3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 11 Aug 2019 18:11:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so44764301pfn.6
        for <rcu@vger.kernel.org>; Sun, 11 Aug 2019 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jg1q7sKCNt8sI7DQNayH9inWmrGqOZwwN13K5ONIY4Q=;
        b=RNMJIQZoGD+AKdhoRPPti5I51AMHvV5mYDXKAJvWLLTIXhov2hAB/mlubzCGJZZvqN
         jdFGMPAG0ui/vmgBiTmzrK1TSmtU4Ff8BsjO/AOMv/ogYfOTU7XEwv4oYwpoynaUuXlz
         FB+/0/PFQfK8A6SidEG+2RrPrN0tWz6fx7rwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jg1q7sKCNt8sI7DQNayH9inWmrGqOZwwN13K5ONIY4Q=;
        b=BDrPbrzFI2j5kdKF3fG/4UpQKaNFW0HueLjVchij1eEHfp/sqqrRtPN0QLGCgvSz9c
         jMmbEKAf397hS1lMU7DrC4ekZH04JK+ReFj63hGyrintlUl2aWtF8bZ83AgPnDT9KNcM
         165Olq9uMCVWji52jMMlkND2XtXAfo1KisziucnhkoUq5Bc/XoXDoEVlyRle3773c19k
         duATPZw0WpQpNNN1WywxJxX53RGvrwvoe9/K58B0SaypP6gYGJJ2g5nl+rhjlV8YGfzV
         bHRKlEWAV+rsOjaZpzhmqJpR2Pv3VI3Qc00q7+3vZvoJ9+ZJWBy3kG4ZrbptHiywIpsN
         Sr1Q==
X-Gm-Message-State: APjAAAW+Udiy7/gfOlsgaPps94GrLaqb/knc5RpjiblMVIVF/KVyeQYT
        AoEB6CfWOxqkhvRFxnmI8KUAPA==
X-Google-Smtp-Source: APXvYqwV0Q84Ts/sU/Wiyc5e58Q2BXvfPrlpDhgpdlrMav0oBqexshnN2vV/yXZRyBgkrd69z686NQ==
X-Received: by 2002:a62:e901:: with SMTP id j1mr33444864pfh.189.1565561489050;
        Sun, 11 Aug 2019 15:11:29 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n10sm31376428pgv.67.2019.08.11.15.11.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 15:11:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] workqueue: Convert for_each_wq to use built-in list check (v2)
Date:   Sun, 11 Aug 2019 18:11:09 -0400
Message-Id: <20190811221111.99401-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

list_for_each_entry_rcu now has support to check for RCU reader sections
as well as lock. Just use the support in it, instead of explicitly
checking in the caller.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/workqueue.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 601d61150b65..e882477ebf6e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -364,11 +364,6 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 			 !lockdep_is_held(&wq_pool_mutex),		\
 			 "RCU or wq_pool_mutex should be held")
 
-#define assert_rcu_or_wq_mutex(wq)					\
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
-			 !lockdep_is_held(&wq->mutex),			\
-			 "RCU or wq->mutex should be held")
-
 #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
 			 !lockdep_is_held(&wq->mutex) &&		\
@@ -425,9 +420,8 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
  * ignored.
  */
 #define for_each_pwq(pwq, wq)						\
-	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node)		\
-		if (({ assert_rcu_or_wq_mutex(wq); false; })) { }	\
-		else
+	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,		\
+				 lock_is_held(&(wq->mutex).dep_map))
 
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

