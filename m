Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441927;
	b=VWHSsE1nZDuJHzF8+yWS8N0n4Oxx1OlagEGtF6XpbfxCrqGkZ+yeTUny0oQN0QKW0P/R
	 FS3dBB6IpVttac4RQum9Bi5qYKJYu6HIGltMb4vrY7EOR4QKU5AgzlUhY5mOkvblImv5v
	 AnEUBC/fI95YTQ2ltXDiEz3pUSt2cTq1TckhGoJDrHdl4kueqLT8iB8tRk5lPw/oOjiGU
	 XF9rSf54eg4iSlP9rFwjaGggs/zUh4CSKQ6cejHbgb2NInBrlqjPGvdfQKRRkh7JhaDGC
	 m+9AS5xYiJb+JZMXumK4GRHmxxTq+XIrqmufk5t7LhNfypOk667uk2d135FDu0Xz6Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RrTUeuiSWYSLVvE8ZZ1kOMd1tWwePjn1AWC0+hhhsyU=;
	b=zEDcIGxVdlAoXdr9Oi9Dn+D9BKgfyJ+gKVD2n8OsCZk9MRT9Sf2E/38aQ7IVPo6x3TD/
	 67EJotGW/Wd49zYilofu2cLTj/uqe7S1i2KvtlvoeBoFglKEjg6qVD4iALs0fO2meg1Br
	 NXFXyfR9CgP9SoSo8AqhJ5RUnvaBmi4SzB6E5eub5HxLkBIn8Afhqg3zFo9QIOqM6jUgE
	 2T/yl78Z6fZ37Asba6x47IGZco3GwtO2kd3ftDO0JY1kxj1N/N8eAcKbLQSQwWa/C3jKf
	 Hu/QZY2hbAlpzwjSNupc9sP7r2+VnVLNvQ1Amoj4ymHdn0/tOAiRe/wmg+k5ACvIueA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=gurPkCLo;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA61606A32A
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA61606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=gurPkCLo
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso32839635e9.3
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 05:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1795441925; x=1796046725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RrTUeuiSWYSLVvE8ZZ1kOMd1tWwePjn1AWC0+hhhsyU=;
        b=gurPkCLoehZH7iUCBFNkG3P9wnxD+3Nxe6Gpzqr4JBQO3c+182MWLQN/fQcIllPgna
         l1hj57p0dSsXgnWklkJr68BcPvPU6HWqDnhdVx22301PoReThkYWpGPhsqHr7PRWKX3C
         kNtTk9k+49fEQ63IZCsRXLQPv2RzUt8LaBc2Ag3NYiBP+rscOFPVHi807kkn5f25Ty8h
         VzJk+rPIHcxm1TXdgsdXsFLcahWRd60LJWBg8gkrpDhxcgW0/kmo2WX8FFEEO/aI3O2c
         b4Usc22Y8JUnOjcbuwnHkZBqPKo2EEt3+juMPvZQHhYzyjlerXYtwWH07D7Xzh++WyAQ
         0jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441925; x=1796046725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RrTUeuiSWYSLVvE8ZZ1kOMd1tWwePjn1AWC0+hhhsyU=;
        b=gklqtDdYqhrbjJe6zvejGogk/nG1mTzMl8Qif6XuO+BDOT7P5E+M5+Yc5MlRgEOCWl
         8IgzAzDSmTzTNZ+rSc3TKGH5BVjI8ONkU2dxxYE+Q/MpD378yVLibZvG7B0dzlQmwPbn
         vm+84MIkSgn363WyhJVKaJaalW5RZIxu8f1nNAmJBJiVeWwlcvtphZ+6G9R7KtjDwzdp
         JT0hjZMfr+GSkA3C7Tca2YqJbfK7gZa1HUreCOKsapMMO1lIz+DeoN45AbwxqY1asuQT
         GiUPbgQ8BI+RGXoU+uITXvYpNg2cgStUadBQdAwVIa5/yKDEw9E7fnVrY5AQZ+nOZv0G
         /ZYg==
X-Forwarded-Encrypted: i=1; AL+hErGI0rZLyKq4IQ6EbZ+OxbDGW3bYt+K7jDq8cq0hgFAdyMPoAgebMA0WTV1+5JZ+02erSH4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8epDpjMgliE7/tFssq2OBM+5NT32+dba+a/lLpVne4pPGRFHii
	GkYbjs1/rJPvQRM6IB8usMRjn7SRn0QJ63UOTC3XJqNUiJDFzK66enwQjm/5gT0u6e8=
X-Gm-Gg: AZFdTZdywEMQcFMjeajhtoYeyUfzn40j5vEar1PrMLgPcYyCAsd0UAM8ORE98Ij013r
	aNjukA4UnB5b8Y7xfBIWN0fYYZa6fvDLSUA/K32KrHoSKcA9kUI2dPN2KkcRYbXYwvuPwazUamg
	tTTG5bgdyf8DbW9HCMfnoLIXGoLbKX6xce3wtmbQy8nzQPzytp2FQZeR/par75mVjTGBgjf8vhf
	S+wSabRIwV/Fx+/9EDqfAz7b0oxs5yg6q8pc7ggiPcg2f+ZTiEBoi+OSdt5pkxEriYBkEsnsrdV
	MAAiS88z02oxEmcsAQgmVFwtM53p1v3Ld0eu4Ec65lijICYFTCucRnJVusjZbhO2e2jSzZ/Mdqd
	u/L5HJVsuT7HUr266/VXtKtMYxcBW86ZWhNvIyBfXCxT2GbXODUOK5AQxAKonGu97CijCffDJ62
	8fNeNE4na4+WPxkzpnKbzY7MpQVqZ7R78f7j8HhD4MwOYL9YeVwLAVNUgimGCvCyM0wcjvqjVgA
	FJHHIHVtQK70z1AgdjCuMezT+7wwodJdtXWMrnLgzhDgs/VOop6RDhpIBqiichmIHrCQtRRbY6Z
	d7x3mIgl7LNHsr9Lmzf18vLTcuTDgUKf8sWq44dObvIPKMNFZAdCj+aw+7spLvhJpa8HKyNNghu
	IzM8bNwxE+yU/fnGtZ1+4vE1o7IRSNg==
X-Received: by 2002:a05:600c:37c9:b0:4a6:eca1:7d5c with SMTP id 5b1f17b1804b1-4bb888251b4mr214460955e9.32.1795441924994;
        Mon, 23 Nov 2026 05:52:04 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f1b7800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1b:7800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm169279215e9.5.2026.11.23.05.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:04 -0800 (PST)
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
Cc: Max Kellermann <max.kellermann@ionos.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 1/5] include/linux/rculist_nulls: add hlist_nulls_add_behind_last_rcu()
Date: Mon, 23 Nov 2026 14:51:56 +0100
Message-ID: <20261123135200.4086519-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123135200.4086519-1-max.kellermann@ionos.com>
References: <20261123135200.4086519-1-max.kellermann@ionos.com>
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
hlist_nulls_add_behind_last_rcu() for callers that already know the last
node of an `hlist_nulls` list, to allow constant-time appends.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
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

