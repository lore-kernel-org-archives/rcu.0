Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816857;
	b=WlXkt+2pQ4MwRqWszXo7B3DnduuXpTf2qtAdOXQJRCOEHaqQiFflNsbQzROhrUYX6VYh
	 xqQi7buO3bG1LdzUOJ72/ukKD1qkmWkVCS2WpC/SVvvRCkQMotwSx2K/YZjdQsRIAKVeT
	 5cbM8SjMAmklFRix556cdzYEd4gpcQnzxQEY2wX+PswMbGrIfVZgOB2ffs2dXoU6GEJ5O
	 K72NEl48leBr3wVlCuhK1wm0BSzMsPZkJsXEuAJh2utatpos9O7W+w47KUudf6lblboko
	 qWlNiq/jZHrAnpFYoe2jX0NYoPVgm7PCEfIsqs0B7oi3aPXirccUn1H/GXcBQ9NbD/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hykglC9qjGoSXJNJVYRVj2488doF0rYVIjiEwYqGfzk=;
	b=w5g6JFTgyVTEY+goQW2Vy9i1Lnvnk32z2tW7TyWJtSqi7Fg+vdpR1qD3s0RN7euCvxGJ
	 br1NQUxgQBG6kQymXpqF2nupYCbi7Dmf9L9CFpfeo3RghCCvL/Sh+h7DjkiR1710ewM80
	 fa7z5hwZFCt2hS7jCTU6jqRMPW4hyKP6jIfr/VRMhz7wfwRdJAAWPslgDGGBlj3cqJ9+6
	 go98xwghhcyYReoaEk6WkR74j/MuaOfiDbgwJaRbTAmZiifYhENJySQaDIGC2VS9ft5i8
	 qzp18h/g3OrDEdXZqQtb4c4tUnZqKoAudyxIrGY6C/OKbuC5uUnzqibPwkvIWaz6nTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=i11vAehu;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396FC606A883
	for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 08:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 396FC606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=i11vAehu
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso16956935e9.1
        for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 00:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794816854; x=1795421654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hykglC9qjGoSXJNJVYRVj2488doF0rYVIjiEwYqGfzk=;
        b=i11vAehuAmJvnq3dB1Hf5yiLPYPhqTOudoUHaTJGDCa8M7BZNUFCh6/eXKtRkSKe4N
         2300R2n156bNElRB7xQ3CjXdaWl5nUtrjjpz6l0HQOPviqOJjs0WHeveeHJFl+GHdcIo
         d1VeeF3SMLfngzlGVO7N9VZj0pNFoWrdJAe5XZoyqb9Tk3OnmIEsrQWzF7lT2h+vDN0K
         izhJRJkYkyPzGEnWXHEvTSMqDAST1Oo09rb89VRXCOmwvxdtZwQRtZDt5OVeG6GgPolv
         bS29zy+0TK+fsNBTRCHmoXuKLdm/XqE8D5JAt+PhcveSBApVj55VtRTsecPIHCghijrp
         QlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816854; x=1795421654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hykglC9qjGoSXJNJVYRVj2488doF0rYVIjiEwYqGfzk=;
        b=asRGOyvObNHwOxdRe314uW/w6IMc/xOsM58YxOmVlg0IBNV5xgpCzGeYjsw2s/AWWH
         Y8wKxMqUE4H6KPH9Ue4d3VLXtXOd6qfEB6/xEdXaTWMVi5PKZzGfz5inbxcgJPd+3CD8
         ig2hASN9O/HDjFCoUke/5GQey9hBnkOw5qM/yi5Z7uKJLbTbgmx0O4EMpHg3gDnE1FaY
         ApPGw46WQZ0Pk1hMbMryeNaszAexlQcxEDDALXsVOowbCbBR6OMXUq4Cn1vI23AoFSe8
         CF2r87drymbgnGUX9AR3gnKRRX39h/OQw8sdxkgbQp51QzxyMjXOZGZT3HOfCGxwbAHM
         H1eA==
X-Forwarded-Encrypted: i=1; AL+hErEiREKcjvwCv8dOG6esM3MmggCo6XENEoaKkDBO/8Nx5cgmksv1tdxQiEJc7HIraVyKTzU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lC//UQRjFYxtcB0a/jT6q/9cnUgavKdCqx09xZTLTxQWiblmH
	gmUmotTJhZPLwo4MSBwNS3PnaIOS/8KN6CVsZr/R3y2MdqPQe61mnlFvuAt/a+FAOkI=
X-Gm-Gg: AYBFou1go6lT8PB/O6KxcVBqNRxSsfUnWt1CUcIEACPjJndET35ppTWORV1jkwolkt+
	Of/MBMcrnLXQY7FFIQGWjjmjaQuwx/oydPs8jVFFRCoQ/6++pbLtRCxdb1PeiSciafYLutVQINd
	KNAE1pQcsOwIYHoz+lZJhje54utCsUhNpCFzBEGjCJ8+53uG2SBa5qG58OKd/xy2n08GCo/LNtO
	h1x2bk8LjT04TIkaisRia7cMxAIrP3juxggKu1pmDAaTKu95pmFb3djdwXmR5AzJ6UY9AjfW4E/
	puTZL7vOqSQaw+XBuQCBz9rdAa4qpQ3lj4LB0hys9TcM5ycHFs9L3yL/HIz+uXQwm0EeoGedcbb
	wkj+NYOsF83ZBAzrodtN9cVPjzfrOplDrG4IZaCh8kQzEW0cCN4pLZ5ORuNJ9LUDP03wIemlZJz
	VuAhhWMi4opduIDJXEP/TnFoD+sLCae1Qlb9+zdDr12haWYk9lmuUi4I0UljpMF845buSFQO7zx
	vebvztR3MZTgMTDeaw3DagcPk9YAt1Pxap5SkDHlWU3AgkJQFFDZsXQO3FRN9Vs6yGhOASLbxce
	9nYFOt7jiba8JPQ+SYS7gaT1ucjyi+VMYmRJC4AMrCGil2iBTVCJgip29AafP3cAU72c7+lndXS
	OTMP3puLIgR9NEAAHK8L7xJUJbb2c
X-Received: by 2002:a05:600c:3487:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb55a4f1b4mr208646975e9.13.1794816854509;
        Mon, 16 Nov 2026 00:14:14 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm22902289f8f.11.2026.11.16.00.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:14:14 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 1/5] include/linux/rculist_nulls: add hlist_nulls_add_behind_rcu()
Date: Mon, 16 Nov 2026 09:13:59 +0100
Message-ID: <20261116081403.216452-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116081403.216452-1-max.kellermann@ionos.com>
References: <20261116081403.216452-1-max.kellermann@ionos.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move some code from hlist_nulls_add_tail_rcu() to the new function
hlist_nulls_add_behind_rcu() for callers that already know the last
node of an `hlist_nulls` list, to allow constant-time appends.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/rculist_nulls.h | 36 +++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index a97c3bcb1656..ffbf5ed4ff19 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -115,6 +115,33 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
 		WRITE_ONCE(first->pprev, &n->next);
 }
 
+/**
+ * hlist_nulls_add_behind_last_rcu - append after the last list entry
+ * @n: the new element to add to the hash list.
+ * @last: the last element in the list.
+ *
+ * Adds the specified element after @last while permitting racing RCU
+ * traversals.  @last must be the last list entry, with its next
+ * pointer holding the terminating nulls marker.
+ *
+ * The caller must take whatever precautions are necessary
+ * (such as holding appropriate locks) to avoid racing
+ * with another list-mutation primitive, such as hlist_nulls_add_head_rcu()
+ * or hlist_nulls_del_rcu(), running on this same list.
+ * However, it is perfectly legal to run concurrently with
+ * the _rcu list-traversal primitives, such as
+ * hlist_nulls_for_each_entry_rcu(), used to prevent memory-consistency
+ * problems on Alpha CPUs.  Regardless of the type of CPU, the
+ * list-traversal primitive must be guarded by rcu_read_lock().
+ */
+static inline void hlist_nulls_add_behind_last_rcu(struct hlist_nulls_node *n,
+						   struct hlist_nulls_node *last)
+{
+	WRITE_ONCE(n->next, last->next);
+	WRITE_ONCE(n->pprev, &last->next);
+	rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
+}
+
 /**
  * hlist_nulls_add_tail_rcu
  * @n: the element to add to the hash list.
@@ -143,13 +170,10 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
 	for (i = h->first; !is_a_nulls(i); i = i->next)
 		last = i;
 
-	if (last) {
-		WRITE_ONCE(n->next, last->next);
-		WRITE_ONCE(n->pprev, &last->next);
-		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
-	} else {
+	if (last)
+		hlist_nulls_add_behind_last_rcu(n, last);
+	else
 		hlist_nulls_add_head_rcu(n, h);
-	}
 }
 
 /* after that hlist_nulls_del will work */
-- 
2.53.0

