Return-Path: <SRS0=frk5=5S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C37C2BA19
	for <rcu@archiver.kernel.org>; Thu,  2 Apr 2020 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988BA20784
	for <rcu@archiver.kernel.org>; Thu,  2 Apr 2020 12:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apIxOOpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbgDBMdI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:33:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46639 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgDBMdI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Apr 2020 08:33:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id r7so2976001ljg.13;
        Thu, 02 Apr 2020 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tB5Om8/vjXd8Shhy7gccK+1zsTKo1F5yn1ziCQxk5RE=;
        b=apIxOOpuaj9CeJortfeXXN6+I17U1oEqokkNyJAsVBVGMa6nppSAZGqaceFNoA5DyN
         mJ5BX0CkvUDnryB6tLnWnaMqc2qvr+8SrhRfxGh4X0/zL09hnSY6lvbqx3Hytd6DRhUr
         dmVvZKXwg5WHyazfygIy2Nmu+P+LiXRXuWu9gsgTLsDHEftEtc+8DaEWlErsbG2zdXkc
         lz9b+iMZLp9Hk08KqdoPktOwMF6FlfXAACsmReS3C74IFR5022ZHRbgyt4RubRnwt73n
         EbG1sEZ0AgzGX3Ij9FrTuE4CfG2V+v1IqRvMP0T4FEyOE+1vWVyGmf0s0GgNgV4FtPcc
         VWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tB5Om8/vjXd8Shhy7gccK+1zsTKo1F5yn1ziCQxk5RE=;
        b=lJgh/CDNSwZRiYqcZynl89Qdf3ZkWEAbf4PThIgUAwSFZfwb3I8y8jtk+XCmWTZ6W9
         roeMmKS4Pi7TAPl/NToTlZPSOuvkgEMzYFuEI1DP61VctL9xDkI3zqmqAC1j4nl24IWt
         nseqftG3nbPQbGhyGcj7ymIrMfxLlwkmb5lROc/u1zr7XPdm0m76wNpX+IzC27BfTeLZ
         TcnBJI9Vyd4vjGWA/Hugn1rSyUrBbNOUsfUbBG0D0AB9LTL3UqjZ+f5V3gSSTyCy8o+S
         jaHRHPfymS4wKqIjdTA7zUxONxXbpMOQOm/SZVyFZfkYefqUpiGs+e9ANlZ3o7IklDnf
         5Bcg==
X-Gm-Message-State: AGi0PubXy69Yho0ge3srAMx9RN8LglBCchnW4ygc0MzhvxuIxyiecbcW
        a0bZ6Ce75PDtc0TYvaJ7cpfHOxP8hbg=
X-Google-Smtp-Source: APiQypIcS/0ZJG7YlW+OPjmQzK2ZO8973RyK3GGEQvRKxPf6FN91uLJ6txbYJd0fY/sqwIBF0bVUeA==
X-Received: by 2002:a2e:854b:: with SMTP id u11mr1868755ljj.75.1585830784175;
        Thu, 02 Apr 2020 05:33:04 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id u25sm3833494lfo.71.2020.04.02.05.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:33:03 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 2/3] rcu/tree: move locking/unlocking to separate functions
Date:   Thu,  2 Apr 2020 14:32:52 +0200
Message-Id: <20200402123253.10382-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402123253.10382-1-urezki@gmail.com>
References: <20200402123253.10382-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Introduce two helpers to lock and unlock an access to the
per-cpu "kfree_rcu_cpu" structure. The reason is to make
kvfree_call_rcu() function to be more readable.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 24f620a06219..5e26145e9ead 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3159,6 +3159,27 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
 	return ((struct rcu_head *) ++ptr);
 }
 
+static inline struct kfree_rcu_cpu *
+krc_this_cpu_lock(unsigned long *flags)
+{
+	struct kfree_rcu_cpu *krcp;
+
+	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
+	krcp = this_cpu_ptr(&krc);
+	if (likely(krcp->initialized))
+		spin_lock(&krcp->lock);
+
+	return krcp;
+}
+
+static inline void
+krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
+{
+	if (likely(krcp->initialized))
+		spin_unlock(&krcp->lock);
+	local_irq_restore(flags);
+}
+
 /*
  * Queue a request for lazy invocation of appropriate free routine after a
  * grace period. Please note there are three paths are maintained, two are the
@@ -3195,10 +3216,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		ptr = (unsigned long *) func;
 	}
 
-	local_irq_save(flags);	// For safely calling this_cpu_ptr().
-	krcp = this_cpu_ptr(&krc);
-	if (krcp->initialized)
-		spin_lock(&krcp->lock);
+	krcp = krc_this_cpu_lock(&flags);
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
@@ -3220,19 +3238,14 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		/* Is headless object? */
 		if (head == NULL) {
 			/* Drop the lock. */
-			if (krcp->initialized)
-				spin_unlock(&krcp->lock);
-			local_irq_restore(flags);
+			krc_this_cpu_unlock(krcp, flags);
 
 			head = attach_rcu_head_to_object(ptr);
 			if (head == NULL)
 				goto inline_return;
 
 			/* Take it back. */
-			local_irq_save(flags);
-			krcp = this_cpu_ptr(&krc);
-			if (krcp->initialized)
-				spin_lock(&krcp->lock);
+			krcp = krc_this_cpu_lock(&flags);
 
 			/*
 			 * Tag the headless object. Such objects have a back-pointer
@@ -3267,9 +3280,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 unlock_return:
-	if (krcp->initialized)
-		spin_unlock(&krcp->lock);
-	local_irq_restore(flags);
+	krc_this_cpu_unlock(krcp, flags);
 
 inline_return:
 	/*
-- 
2.20.1

