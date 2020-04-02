Return-Path: <SRS0=frk5=5S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0277BC43331
	for <rcu@archiver.kernel.org>; Thu,  2 Apr 2020 12:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4D420784
	for <rcu@archiver.kernel.org>; Thu,  2 Apr 2020 12:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdCj68Co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbgDBMdG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:33:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46638 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgDBMdG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Apr 2020 08:33:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id r7so2975945ljg.13;
        Thu, 02 Apr 2020 05:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3xG+lzh6Q2m2bU1b/cZLY6stz0OrJ21NrAPdv3f5lI=;
        b=YdCj68CoIGNm8klzekN6UwRYTOMrJXNAezwvbdvUizysC4JClKGycqepTK+P7kMSvz
         uwVO0pWBAXIY1nFRiH8r9VGbzeOqyH9dKdPayLKVc+dWktRsc/A/1Sov+46ZtTtRdUB/
         xUJNK1/Gz3eateO4IDozVXnf1oN0EuAtjmu4VOSsRljrle+pIg2MY1gNdURCin4zU6/k
         SWHI1+MuowwyS8UwE8c8lJi2kBSm5o++E57IM3Er2yNVdlacfF/ktRO8zJygZVEjM92l
         tQHJkbf5Mij5Ekw+QVL+Gt0PzXldNxNVNJ3WuoTmVy3hWs8vAndrvhY6XDAQ5mGgF4yv
         5pUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3xG+lzh6Q2m2bU1b/cZLY6stz0OrJ21NrAPdv3f5lI=;
        b=G+wVldXzC35//9/Y4ma0LnzCfBYx/39PMU07+SMC2iH2u6AOSW4XNNr1iV/+6cdN32
         1r2x74kRNG+aB1Is6HgRduCfxOFFXE3XKbxszD10XHTJOdA3fLfHoLNESr6vdyvLlxru
         XYfFnzOEF39qq3a1syqQnHSjc7Rr0NCTcx+lcdiiWAsfGVDbcyJlWphwyUkWaY816dXG
         SUC1swHDY3FJeR2IEAcpa0KFEYH+LSYA2rrVgld/krtvNwIFInqVX/RHnrLnLQRLL4o7
         FxpBaZQZXj2QHgmvt+kR5V1Oh6K0b9vZaqoMWx9lbCw2Q/Pfv1s7QmLIyc7boxzUJgT4
         k+1Q==
X-Gm-Message-State: AGi0PuZHBOLB3ETdtdUioiYWOIU5tB13lFzehKdJuppeItlW34Nb5b9m
        QlUzc698aRXtbLoMUaZx7Z29ZTwIpqQ=
X-Google-Smtp-Source: APiQypL/TMoPg1xpQz/u+DpsCIjhLMV4V4JUwSAbK/9BffhqsJD2f8okxquuS6KlEyeqFYyh6hqOaQ==
X-Received: by 2002:a2e:8887:: with SMTP id k7mr1909764lji.193.1585830783082;
        Thu, 02 Apr 2020 05:33:03 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id u25sm3833494lfo.71.2020.04.02.05.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:33:01 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 1/3] rcu/tree: use more permissive parameters when attaching a head
Date:   Thu,  2 Apr 2020 14:32:51 +0200
Message-Id: <20200402123253.10382-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It is documneted that a headless object can be reclaimed from
might_sleep() context only. Because of that when a head is
dynamically attached it makes sense to drop the lock and do
an allocation with much more permissve flags comparing if it
is done from atomic context.

That is why use GFP_KERNEL flag plus some extra ones which
would make an allocation most likely to be succeed. The big
advantage of doing so is a direct reclaim process.

Tested such approach on my local tiny system with 145MB of
ram(the minimum amount the KVM system is capable of booting)
and 4xCPUs. For stressing the rcuperf module was used. During
tests with difference combinations i did not observe any hit
of our last emergency case, when synchronize_rcu() is involved.

Please note, the "dynamically attaching" path was enabled only,
apart of that all types of objects were considered as headless
variant during testing.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6172e6296dd7..24f620a06219 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3148,13 +3148,10 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
 {
 	unsigned long *ptr;
 
+	/* Try hard to get the memory. */
 	ptr = kmalloc(sizeof(unsigned long *) +
-			sizeof(struct rcu_head), GFP_NOWAIT | __GFP_NOWARN);
-
-	if (!ptr)
-		ptr = kmalloc(sizeof(unsigned long *) +
-				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
-
+		sizeof(struct rcu_head), GFP_KERNEL |
+			__GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL);
 	if (!ptr)
 		return NULL;
 
@@ -3222,9 +3219,20 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	if (!success) {
 		/* Is headless object? */
 		if (head == NULL) {
+			/* Drop the lock. */
+			if (krcp->initialized)
+				spin_unlock(&krcp->lock);
+			local_irq_restore(flags);
+
 			head = attach_rcu_head_to_object(ptr);
 			if (head == NULL)
-				goto unlock_return;
+				goto inline_return;
+
+			/* Take it back. */
+			local_irq_save(flags);
+			krcp = this_cpu_ptr(&krc);
+			if (krcp->initialized)
+				spin_lock(&krcp->lock);
 
 			/*
 			 * Tag the headless object. Such objects have a back-pointer
@@ -3263,6 +3271,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
 
+inline_return:
 	/*
 	 * High memory pressure, so inline kvfree() after
 	 * synchronize_rcu(). We can do it from might_sleep()
-- 
2.20.1

