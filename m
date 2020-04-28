Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD6C83000
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706BB20B80
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYZBp9n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgD1VAB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727065AbgD1VAA (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 17:00:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D25C03C1AC;
        Tue, 28 Apr 2020 13:59:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h4so188967ljg.12;
        Tue, 28 Apr 2020 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KoBD39TIcEF5om4wxAY9WABo2MzBmQNw/jZQCSmQt+E=;
        b=pYZBp9n19gsVOTGoO/Sk3hIwSChUFPAuqtoXgQSXrtWfKsilDS0sALg+vhbnSbxvGu
         VdobfSf7hyqLliIrSIaj0t9nu3iDqeFBds26B81XwdubbvYQCcjAnz1LX5w/82X1wPx0
         i3WUHABqC94YnY2H4OpAR8l9zs8RfZn6Xxytlj/3Enc9gvzbOpi6Q9ZfrZjnEg2AK2Y7
         bjxMx8yDoA4Lqo7Q/heylOx3S3xZqCXtya9oCmVVbX/kuQPaw+5HEq0pOfIC0iO4wlE3
         CLAlOGXVfDTxBH8OKQS/IzkGrNB2gypGnYJx6H2v/aWX4ISqOJiSpDNvKf1FVizYkmOf
         SUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KoBD39TIcEF5om4wxAY9WABo2MzBmQNw/jZQCSmQt+E=;
        b=MLMgo6VYzHqnffnx71wEQ2u2FIFS3bCoSz0gqB8eHtZzucNT8fd0oTx+plEMXOPYSH
         LFWnTChfl8d8jSuraD5p/Zf2vpVjmZbJ9sKt/k88eytO1/4O0hWMWXTc2+vPMpljlYJN
         c2g6VdarA1eENe19iuxxQzeHGy4hjhYRqE7EjOU49gg31mqpKAfxOGXcPu8Yw/kmQEzj
         sTDxCjP9bvqkKb39yj/YPatgzMLugXC0kzxMDyd1WUuY7g29fBBz9HM14/coXtiOYu8G
         9rjkbaVlFs7d2IeBU2jwKEftdWU46mxue/qZy0TD1g+rwG7oUQaQQnjXzVT4KVInE6sw
         L8/A==
X-Gm-Message-State: AGi0PuYYjv9Yw/kBz8P1b667hnALx409XEqA8QslhFGZk4LNA7H2QCCB
        BGiDv3zZTysfrw4t1taGTN5dvRQRRS0BMQ==
X-Google-Smtp-Source: APiQypJZR1Ec3ulELhNCGSHkNwXT2m0NQRhUCSqyh7Fi0d8nw8f+9QCfLPXaFRVdPqbaxBXapCWV3w==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr19191207ljw.55.1588107596479;
        Tue, 28 Apr 2020 13:59:56 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:53 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 20/24] rcu/tree: Make kvfree_rcu() tolerate any alignment
Date:   Tue, 28 Apr 2020 22:58:59 +0200
Message-Id: <20200428205903.61704-21-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Handle cases where the the object being kvfree_rcu()'d is not aligned by
2-byte boundaries.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 501cac02146d..649bad7ad0f0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2877,6 +2877,9 @@ struct kvfree_rcu_bulk_data {
 #define KVFREE_BULK_MAX_ENTR \
 	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
 
+/* Encoding the offset of a fake rcu_head to indicate the head is a wrapper. */
+#define RCU_HEADLESS_KFREE BIT(31)
+
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
@@ -3078,9 +3081,9 @@ static void kfree_rcu_work(struct work_struct *work)
 		next = head->next;
 
 		/* We tag the headless object, if so adjust offset. */
-		headless = (((unsigned long) head - offset) & BIT(0));
+		headless = !!(offset & RCU_HEADLESS_KFREE);
 		if (headless)
-			offset -= 1;
+			offset &= ~(RCU_HEADLESS_KFREE);
 
 		ptr = (void *) head - offset;
 
@@ -3356,7 +3359,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 			 * that has to be freed as well as dynamically
 			 * attached wrapper/head.
 			 */
-			func = (rcu_callback_t) (sizeof(unsigned long *) + 1);
+			func = (rcu_callback_t)(sizeof(unsigned long *) | RCU_HEADLESS_KFREE);
 		}
 
 		head->func = func;
-- 
2.20.1

