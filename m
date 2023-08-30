Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F54DC83F1E
	for <rcu@archiver.kernel.org>; Wed, 30 Aug 2023 18:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbjH3SsD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243455AbjH3LEL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Aug 2023 07:04:11 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D41BF
        for <rcu@vger.kernel.org>; Wed, 30 Aug 2023 04:04:08 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34df2a961a0so3588815ab.2
        for <rcu@vger.kernel.org>; Wed, 30 Aug 2023 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693393447; x=1693998247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Bzb0sW6tNrIYQR91p9kftRZaZNiQ/iubHSIhY1eKkc=;
        b=GJUmWv0U7/GKw3RWPZoxUHg8aeUxd8sBp/DTJ2+rFdnsQZkPQz0ZFyZrSfK54qd2kO
         RZhkdtBAp9L2FI9cFqNhR/r2GwzxmVnNevg6fF2z79DXg0tPhRKCppiOygJEXQpVKC0R
         zicpPWZdgIUEA+CmYCxENeVQgtRsoUZMujIDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693393447; x=1693998247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Bzb0sW6tNrIYQR91p9kftRZaZNiQ/iubHSIhY1eKkc=;
        b=SCKLTTMAr/9/wPqKlAYlkMnHCsHXJYfvoZmFOx+OvtC4eJIWj3O1UsTlaPBZCCznHo
         k3a6glp/0dUQXZKGZltWQhv4uHZbZbd1Ku3aCVV3WLh90uPqrsv4KaDDm5Wm3g6k9Oir
         vJ0qodGe6YRX505oThzE9q9j/pVDU5450w//CWbPxuqRL8hdDB/J4h30P0Pvffdo7LGk
         8+iDZl2KlX+0Qnx2j12Lv20qN50DYVhwodAmHkUTwf0Gz+8eoefuWdQYuicVSYGMKgZq
         mB8HTNuullTy93UuoVhqcURRikYWl2OQV8EMAPe36yWdB8SqwZjz0uHwKMC2Pys3J4zp
         XPJw==
X-Gm-Message-State: AOJu0YyMXMFVSsfIjhF2QBHaSaDoaFBIRYfGUcbuM1hHE08zpzt0oLDz
        ar1SpRED7BmNYybnESii36m1Mw==
X-Google-Smtp-Source: AGHT+IE0HDgO4IV5KIonhYC6qUiVBNTzmO3mraM6GsxI7117CCavMJf06wCisJIG3/9IfOckEZyYiA==
X-Received: by 2002:a05:6e02:f11:b0:346:7c6d:c667 with SMTP id x17-20020a056e020f1100b003467c6dc667mr1886994ilj.13.1693393447713;
        Wed, 30 Aug 2023 04:04:07 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id k8-20020a926f08000000b00348880831fdsm3701371ilc.58.2023.08.30.04.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 04:04:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>, linux-mm@kvack.org
Subject: [PATCH 1/2] mm/vmalloc: Add a safer version of find_vm_area() for debug
Date:   Wed, 30 Aug 2023 11:03:59 +0000
Message-ID: <20230830110402.386898-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It is unsafe to dump vmalloc area information when trying to do so from
some contexts. Add a safer trylock version of the same function to do a
best-effort VMA finding and use it from vmalloc_dump_obj().

Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Cc: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/vmalloc.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93cf99aba335..dae347e446e6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1865,6 +1865,18 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 	return va;
 }
 
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
+
 static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 {
 	struct vmap_area *va;
@@ -2671,6 +2683,27 @@ struct vm_struct *find_vm_area(const void *addr)
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
+
 /**
  * remove_vm_area - find and remove a continuous kernel virtual area
  * @addr:	    base address
@@ -4277,7 +4310,7 @@ bool vmalloc_dump_obj(void *object)
 	struct vm_struct *vm;
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
 
-	vm = find_vm_area(objp);
+	vm = try_to_find_vm_area(objp);
 	if (!vm)
 		return false;
 	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

