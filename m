Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C8FC2D0E7
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4D120735
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="w1Utm7e6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgC3Cd7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:33:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32983 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgC3Cdu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id v7so17571351qkc.0
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIwgeh9rHwo41HBlXUss+pfAH9DbFE6iCebsly3ZN4c=;
        b=w1Utm7e6d4/535TdQtPiMXksX4j1qcmln0qSp2Ce5ITm627q5dnSU8lnhyBq3uY9oE
         0PhDmMsluIYgdTjcV+PSd7sVQ/WGe+IhJGHMYogCDZYqSvqJL1tsZLjyg/tB9D7Y4aYN
         zqy3An60oNrntByo8BqUBrC2oSWocnndGjLG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIwgeh9rHwo41HBlXUss+pfAH9DbFE6iCebsly3ZN4c=;
        b=OYTfTA5k8q8Y4xgN/Sk6JwRVEJjeRAySuhee+dVGnO738M1uUyESMnbXfecJy0bYn5
         U8x6EMsQX1jDs5YKIwiRGESE7qdPeoz9iL97y2FNr8IZf8UpT6luF3IO8aB4PZ16K8ls
         1NQIWaewyeNL6emevGNCud3Nr42ChcJvIe1MkApHZ0x0l/s2uOQlENluPTqbUh51Ls1Z
         NXsDFacMkWSi92Q9BHoqyvN71b7WrWFxT9c8RNlXTrd2aooeRLx9mapB6mGdNQxA2MZg
         L5IATpiYNXq4zt53OqCmhL//t87+0ol6axZ9PFdIEv7LkE32IxfJWydBUgj7TBjbl1fP
         PAsg==
X-Gm-Message-State: ANhLgQ1v8jZRrCf3j7fpmQ9o+i+6FAHT2n82+nE1aJ4oHoRuyJTPuzDG
        14IMew3T7SV9pEeg9rAtyAy4lw==
X-Google-Smtp-Source: ADFU+vurXBFAw9FRqEBRvtnmRBiIAJYMQMQAx1nAenRxy7DRsubkevgiGpgtf0ZMZlIvcVQv3d7mpA==
X-Received: by 2002:a37:a68e:: with SMTP id p136mr9993192qke.7.1585535629357;
        Sun, 29 Mar 2020 19:33:49 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:48 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 18/18] rcu/tree: Make kvfree_rcu() tolerate any alignment
Date:   Sun, 29 Mar 2020 22:32:48 -0400
Message-Id: <20200330023248.164994-19-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Handle cases where the the object being kvfree_rcu()'d is not aligned by
2-byte boundaries.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 311d216c7faa7..d6536374d12a9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2827,6 +2827,9 @@ struct kvfree_rcu_bulk_data {
 #define KVFREE_BULK_MAX_ENTR \
 	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
 
+/* Encoding the offset of a fake rcu_head to indicate the head is a wrapper. */
+#define RCU_HEADLESS_KFREE BIT(31)
+
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
@@ -2970,9 +2973,9 @@ static void kfree_rcu_work(struct work_struct *work)
 		next = head->next;
 
 		/* We tag the headless object, if so adjust offset. */
-		headless = (((unsigned long) head - offset) & BIT(0));
+		headless = !!(offset & RCU_HEADLESS_KFREE);
 		if (headless)
-			offset -= 1;
+			offset &= ~(RCU_HEADLESS_KFREE);
 
 		ptr = (void *) head - offset;
 		debug_rcu_head_unqueue((struct rcu_head *)ptr);
@@ -3221,7 +3224,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 			 * to the original allocated memory, that has to be freed as
 			 * well as dynamically attached wrapper/head.
 			 */
-			func = (rcu_callback_t) (sizeof(unsigned long *) + 1);
+			func = (rcu_callback_t)(sizeof(unsigned long *) | RCU_HEADLESS_KFREE);
 		}
 
 		head->func = func;
-- 
2.26.0.rc2.310.g2932bb562d-goog

