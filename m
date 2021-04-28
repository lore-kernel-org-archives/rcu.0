Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8ABC433ED
	for <rcu@archiver.kernel.org>; Wed, 28 Apr 2021 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC2561445
	for <rcu@archiver.kernel.org>; Wed, 28 Apr 2021 13:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbhD1Npy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbhD1Npx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Apr 2021 09:45:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326E8C061574;
        Wed, 28 Apr 2021 06:45:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 12so99019796lfq.13;
        Wed, 28 Apr 2021 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yU5BsBqRXnUKpO7SOFdGn2djcvOgQnp9qomIXoyWyA4=;
        b=XOCIc5oy9JtNNVQZdC5HrwwofVIqZDLoItofdg/IM6/f2hZntNMqfVTxIl/nXWbNjB
         +Khpx28loD9Ys5GPbLLapD2hLouYVtaDmDplypZJlmZMk51JWGWG8y0jNE5XtnfJtpIB
         zUiafm7lcPqyE5oHThvR8U+KMO2/1k9D39LDBT6MM+YMvbxO94cO96IfbVCxWpFwEuhp
         C3f+h32UH+RlzEKGnF5VhWB8/TGBJ+UBbnr19C/Ntuq9QQhbt3051MMTw8IIGKa1dejU
         eD2zSWERIwMi5qaitRPD4tq8yIwQXqyF1uueShbb5wXMRn6P1Fm57NoaheNS5z4r9/2g
         FE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yU5BsBqRXnUKpO7SOFdGn2djcvOgQnp9qomIXoyWyA4=;
        b=Ls5Sb+2h27cEfIxfbLZdLFtOMJU/ZUtkJE2YATqEXWUu/MKbq5Si0+qlsdciOIa/bB
         eFCpVrX6K4uqNzor5YvISh/RpSKL9tASiRsslABs+NKpLmiW7ldkwo3GM++LZK3lJ8ol
         E6WEl8WJz5Raz9TeSDzfhW6eoISeBOvHNVnfqLWnmYdW0d94/oq0brmbG3IO1LXTBPpS
         XYO1iBwUUpRvDwe+nqNmPLYu5SgDRTnHKnlmTOkgXbXJqAaxak/1Lcx1iTWFdsHzg6sM
         1WpItwbFaW2yG1DClQ99HccHEc8h8/SZQCUvGSFFAdhu7aQfC2pa4eN5G6U4bFukR8dZ
         jGrA==
X-Gm-Message-State: AOAM531hdMHNUiPxYP6jPcJ3gAZ4lssDsIMhE+wrtAsfv+rZXzrnTgsy
        M4BG14mNenTgTs4yN4+Y9Yt/RH16MdO8SM2Z8Rw=
X-Google-Smtp-Source: ABdhPJx6PK97lUDj70vGQRjt6rPIah8lYpYwUKdCqMsryFEoKfkBYO8oC2UZ3NpKAsuNPf7AK8jUqQ==
X-Received: by 2002:a05:6512:470:: with SMTP id x16mr138302lfd.255.1619617506268;
        Wed, 28 Apr 2021 06:45:06 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id o16sm730253lfu.228.2021.04.28.06.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 06:45:05 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v1 1/5] mm/vmalloc.c: Introduce vfree_bulk() interface
Date:   Wed, 28 Apr 2021 15:44:18 +0200
Message-Id: <20210428134422.1894-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Provide vfree_bulk() function and make it public. Some users
need to vfree vmalloc ptrs. as one set of batch. For example
there is a kvfree_rcu() API that keeps pointers in array.

As of now start with a simple implementation of vmalloc-bulk
interface that can be improved step by step in the future.

To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/vmalloc.h |  1 +
 mm/vmalloc.c            | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 3de7be6dd17c..bef1588c165b 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -112,6 +112,7 @@ void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
+extern void vfree_bulk(size_t count, void **addrs);
 
 extern void *vmap(struct page **pages, unsigned int count,
 			unsigned long flags, pgprot_t prot);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d5f2a84e488a..a07aa336b05d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2365,6 +2365,37 @@ void vfree(const void *addr)
 }
 EXPORT_SYMBOL(vfree);
 
+/**
+ * vfree_bulk - Release memory allocated by vmalloc()
+ * @count: Number of elements in array
+ * @addrs: Array of elements to be freed
+ *
+ * Free the virtually continuous memory area starting at @addrs[i], as obtained
+ * from one of the vmalloc() family of APIs.  This will usually also free the
+ * physical memory underlying the virtual allocation, but that memory is
+ * reference counted, so it will not be freed until the last user goes away.
+ *
+ * If @addrs[i] is NULL, no operation is performed.
+ *
+ * Context:
+ * Same as for vfree()
+ */
+void vfree_bulk(size_t count, void **addrs)
+{
+	unsigned int i;
+
+	BUG_ON(in_nmi());
+	might_sleep_if(!in_interrupt());
+
+	for (i = 0; i < count; i++) {
+		kmemleak_free(addrs[i]);
+
+		if (addrs[i])
+			__vfree(addrs[i]);
+	}
+}
+EXPORT_SYMBOL(vfree_bulk);
+
 /**
  * vunmap - release virtual mapping obtained by vmap()
  * @addr:   memory base address
-- 
2.20.1

