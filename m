Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F61C433E0
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653D1206C3
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiYel4cr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgEYVsU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731504AbgEYVsT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:19 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FBAC08C5C0;
        Mon, 25 May 2020 14:48:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b6so22188474ljj.1;
        Mon, 25 May 2020 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myZbGzUvCLDF53laDPj5mc/dKuerQ91BFIMGTCX8KTY=;
        b=MiYel4crknK5dXCl5GHpc6bBf3Hel4UK5iJXpbbn3FNgSjsxMB1Mq5QBrlw9Dm0oKt
         p5pJ/J6P3q28DJM/MHq/cL40IA1JX42PUYLbPaUa4l16QNFz/R9GXie4lY5P31QrVdyc
         U7qEY+zsEkwxvJvZKg2h3Qk5wwTiIyseRKQ+fyscqBk0nerwsTHcRG0rzs/XaAdw9cFE
         fcQTGKZLjzeowQ1ntpUs8Lk3cv02BJw9afWKbJxYVpCQ5OJ6i/SxwVWLDBF/0bxRFY1Z
         Hb+Ylu/piIEoG9HTZX1ceVG/SFPuFWQOFTYL3RG/AHpMqgDV/6b/YFyIu+6fowY1+TJV
         gBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myZbGzUvCLDF53laDPj5mc/dKuerQ91BFIMGTCX8KTY=;
        b=ADXkgiNQacraGrSV1VOs14T4UuBa5GNqMCAu2uXtMrJkTAC8rmv2cbFJ/pAR006VMN
         41froBFMR/Kq3F8bvMXe+33snGCLzy6kX5toDtRITP8w+d9Bj58r2BGAtoqZEGqTjp3e
         FRPZY8G2N3P0Bmjs64QPsWALcoYi/bQ2rYIw7DP1phJWlEkiV5LHj0ihGDFrbAMd9EOq
         wLPZDejzCyX8zz2eXDQglxjww6Dut+L7gDOwvJeApnvpptkuQ/3zzIbK1nPrztUjpvE5
         JHoaQoZ9G/ucMp8zokIjkhSaeFICesrjUQHoN+KlCAgl35bS9k/9ZJ1GUKczSKEHji/W
         ffZw==
X-Gm-Message-State: AOAM532VTHhKFzT4Du3ygGatvp+hVYE25zGNStd6/n24XCotZC/doN+T
        N2pEfWhbRUMvdyIeVxw+OK/CvmwlXkYOyg==
X-Google-Smtp-Source: ABdhPJwSIz48TxBYILx85UNtNxrSRT7oQBbn/6kX4IFkWPacY0Y7bMHszbNeQvbgXRgnvoSyEX311Q==
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr14028058ljc.255.1590443297064;
        Mon, 25 May 2020 14:48:17 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:16 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 06/16] rcu/tree: Move kfree_rcu_cpu locking/unlocking to separate functions
Date:   Mon, 25 May 2020 23:47:50 +0200
Message-Id: <20200525214800.93072-7-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Introduce helpers to lock and unlock per-cpu "kfree_rcu_cpu"
structures. That will make kfree_call_rcu() more readable
and prevent programming errors.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6501fbcae3c7..c1f4b740cf14 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2901,6 +2901,27 @@ debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
 #endif
 }
 
+static inline struct kfree_rcu_cpu *
+krc_this_cpu_lock(unsigned long *flags)
+{
+	struct kfree_rcu_cpu *krcp;
+
+	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
+	krcp = this_cpu_ptr(&krc);
+	if (likely(krcp->initialized))
+		raw_spin_lock(&krcp->lock);
+
+	return krcp;
+}
+
+static inline void
+krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
+{
+	if (likely(krcp->initialized))
+		raw_spin_unlock(&krcp->lock);
+	local_irq_restore(flags);
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bhead_free or ->head_free.
@@ -3126,11 +3147,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	struct kfree_rcu_cpu *krcp;
 	void *ptr;
 
-	local_irq_save(flags);	// For safely calling this_cpu_ptr().
-	krcp = this_cpu_ptr(&krc);
-	if (krcp->initialized)
-		raw_spin_lock(&krcp->lock);
-
+	krcp = krc_this_cpu_lock(&flags);
 	ptr = (void *)head - (unsigned long)func;
 
 	// Queue the object but don't yet schedule the batch.
@@ -3161,9 +3178,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 unlock_return:
-	if (krcp->initialized)
-		raw_spin_unlock(&krcp->lock);
-	local_irq_restore(flags);
+	krc_this_cpu_unlock(krcp, flags);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
-- 
2.20.1

