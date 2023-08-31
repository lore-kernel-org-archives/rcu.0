Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E487C83F34
	for <rcu@archiver.kernel.org>; Thu, 31 Aug 2023 17:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345822AbjHaRSg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 31 Aug 2023 13:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjHaRSf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 31 Aug 2023 13:18:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B58D1
        for <rcu@vger.kernel.org>; Thu, 31 Aug 2023 10:18:32 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-76c64da0e46so40521939f.0
        for <rcu@vger.kernel.org>; Thu, 31 Aug 2023 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693502312; x=1694107112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uNen2wFqGs+WYv0jInGdV6FOrUFFJP4ofxSiG/zeNsQ=;
        b=hUK/2WJ6HUz5jMtQUNEG/YNVfDoRl6WnNNHu833Cff6e2iMbiNFipmQkCAmryNDcET
         IJgDZfFVhATCMOJAb322psreSf/nH3LhozVDKMdZq/GMpNsiLYMobe8UWG+RUu/y4Shw
         zqRC+4unircGcI/D3LuNZxud79ERlLvNtAB8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693502312; x=1694107112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNen2wFqGs+WYv0jInGdV6FOrUFFJP4ofxSiG/zeNsQ=;
        b=OuHc2ClvL+MA0XRTgq4YpNH4VVOh/Wu7FSBODEPVwn94P4yaW3tqbkqayMETVv0bom
         Pq2gNCB+i3RQGaDcvWR4D04wsiZ4n/9SV5h1zKLQl5f/J0QseZYCtD8CVneOq96SAp7n
         3Aj6BqLozmidmj0Q/5EEfegNoOv8rW1Nph+fEqe8mOyR1PbyAu1VdD2Lp8YGtQcksTgj
         bgSHV1RpGNgHEiaflZtqB1/gMRawom+nQk2ucoPnk65vNDOj8ZJe6EBC91TGEtTwiSUk
         bdXMIb5qI+MQohsjVIY8p71VVb6H64shE2pNz0yk+5inGRVWZfqCsVaVQXiRLFQ+ADmI
         y2KQ==
X-Gm-Message-State: AOJu0Yx+bS5wv/NrQVpNe+IudUFIhOjk4Bd3vwp5iQKEsQylL/AthHCY
        DYy7aoNzyvcgNS5XA6kbp/37oA==
X-Google-Smtp-Source: AGHT+IH9nNzsM/Nlgp8Zi3Oo7b7WP2tj3Njcw0OCUdypAZrLXBRUvBA+50OCgoB1OKAFfZ42JKDmVA==
X-Received: by 2002:a5e:c203:0:b0:790:ab53:ed16 with SMTP id v3-20020a5ec203000000b00790ab53ed16mr6691054iop.21.1693502312260;
        Thu, 31 Aug 2023 10:18:32 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id a16-20020a056638019000b0042af069eeefsm489720jaq.50.2023.08.31.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 10:18:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH v2 1/2] mm/vmalloc: Add a safer version of find_vm_area() for debug
Date:   Thu, 31 Aug 2023 17:18:25 +0000
Message-ID: <20230831171827.2625016-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It is unsafe to dump vmalloc area information when trying to do so from
some contexts. Add a safer trylock version of the same function to do a
best-effort VMA finding and use it from vmalloc_dump_obj().

[apply test robot feedback on unused function fix.]

Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Cc: Zqiang <qiang.zhang1211@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Apply review tags and test robot feedback.

 mm/vmalloc.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93cf99aba335..f09e882ae3b8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1865,6 +1865,20 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 	return va;
 }
 
+#ifdef CONFIG_PRINTK
+static struct vmap_area *find_vmap_area_trylock(unsigned long addr)
+{
+	struct vmap_area *va;
+
+	if (!spin_trylock(&vmap_area_lock))
+		return NULL;
+	va = __find_vmap_area(addr, &vmap_area_root);
+	spin_unlock(&vmap_area_lock);
+
+	return va;
+}
+#endif
+
 static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 {
 	struct vmap_area *va;
@@ -2671,6 +2685,29 @@ struct vm_struct *find_vm_area(const void *addr)
 	return va->vm;
 }
 
+/**
+ * try_to_find_vm_area - find a continuous kernel virtual area
+ * @addr:	  base address
+ *
+ * This function is the same as find_vm_area() except that it is
+ * safe to call if vmap_area_lock is already held and returns NULL
+ * if it is. See comments in find_vmap_area() for other details.
+ *
+ * Return: the area descriptor on success or %NULL on failure.
+ */
+#ifdef CONFIG_PRINTK
+static struct vm_struct *try_to_find_vm_area(const void *addr)
+{
+	struct vmap_area *va;
+
+	va = find_vmap_area_trylock((unsigned long)addr);
+	if (!va)
+		return NULL;
+
+	return va->vm;
+}
+#endif
+
 /**
  * remove_vm_area - find and remove a continuous kernel virtual area
  * @addr:	    base address
@@ -4277,7 +4314,7 @@ bool vmalloc_dump_obj(void *object)
 	struct vm_struct *vm;
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
 
-	vm = find_vm_area(objp);
+	vm = try_to_find_vm_area(objp);
 	if (!vm)
 		return false;
 	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

