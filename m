Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0442E40E
	for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838510; cv=none; b=tcQeFY19cdNul/Kd3hD4TU6hKK3IAZnkrwnNtz7KjluEo09r39Naw4qrwIhfONr68mpxk+5M5/gtAhBFhxus6/qvCqr17OC3v1qasMxwo+CX1XLhTBXes48RwAGwbA8E/zz/mTo4zIJy2A2Omz5qHKfBDJ77Fq2n7t6EHCFAyVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838510; c=relaxed/simple;
	bh=CciK8lvZmWf5lp69k80//3LtnHj+NJqLm52ZmNUBerg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjF19vKLVrAjzcym1Me5+iTnLs/1pcYCYq0z3fIovs9EEp1UfaYDDmkEODy/TBfVhIoZHC8jKULQAUHFV+VyMWWIAr3z5m3ovnoZbDfwkpA/dUPw2+3JVpKn8QddwCAknxjqbILqMZtqVHa0DFkcJP3KHN1F3H8lbxfLVqRgSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Lh9ykIcD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Lh9ykIcD"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4be28b82so2204102f8f.2
        for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 13:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1791838507; x=1792443307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Wqv1pEc3eUHWVa1vlKnSnpZ/TcSKODci0Njc/4Uwzs=;
        b=Lh9ykIcDWWJb+vdyzf/DIZJ6moMobGiab8pmbAtZ0wBDHV24O2F9ZOnKie3pFNAJSB
         sFpiyUjMn547mdg2kGmQbNrPGvD0Ps5oB5Bd49lhGbnDrn9GVyb9b4X87ZxzhMiuF+s3
         7i1AfaW9fSSzuza/eZk1hlNKa/9HV64N273Z5y0qqFZu46wYmibESEqNk2dCroUcGEMS
         kKOnr6TRtZORaMZe11ak9ibUcdqg83v6EDpBRNxJ1RreESVb0Zu8t7TsUVr4s/wE9hlS
         Tn4RwcYmLKvMQEtW9T7b26+N9Pupj5bPQyxSZfqdQ0TDeAKXsqKOZfo2phNCMlWylaQs
         Ob0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791838507; x=1792443307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Wqv1pEc3eUHWVa1vlKnSnpZ/TcSKODci0Njc/4Uwzs=;
        b=Yw17Ef9XACizo8tY/+Q3zHagII5gLXc+aplCayLGGe3O685vIsKrVlEqUMMvyu7mmd
         b++D9d8lXkNc8boQLvcKyL7Wsac0nfZcmqzV+tIrhEUxXoloXEtBAiPdGjh8AMPqNnbL
         01FNaoVBd3w6nZyggDJG3dnDwm0stNKwEg1pF12lzfHrFMAkPwAytODTuZKLcP8cFjVd
         dV3GzfepvIbekqPl9JowPw3po8Fg980GTh5g0+74exKYiH9+5Xl1RgsP3eH1vVRU1vjO
         9fvCB4eqzLIjRlhWYVdWeFyr2Sl5T9JvNgMhhs3JiTPtm2bPhLO5wwexXtDiq1mnkJ3p
         5chQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNQAbdg8TTp46yXI5ZLwkMCOml1muS//OHeFyO+P0tdanoN8UBf0DjXM0pHQpSLUZDBnM=@vger.kernel.org
X-Gm-Message-State: AFq9FYItWt3Y9YPV17a03aw1062t2svYWvsyy2DdTKTlRrrQ4RbQTKOi
	w8RbXp/irRbwyNkXezmgbpK1u56igI2pmAjcs+mtMpJT5OGyCRt7YDaPmu9zDalYtA0=
X-Gm-Gg: AYBFou2R5oIx4DaHXNHzmm3wm08qJ683YsvyxYGfIrs9iQeniGoDivfYgaLKvjtt2zm
	d9xwv94meoBdKfYsq652LKOUKtfE/fOVFStjsjwa3cCL9btm7yzQcP6LzeabSIT3KYT41RnM7XK
	hXb9v3WgTvke/VfQZjxTPFcrZkHs+etscZheeNLqkGjKD4fsv2LmiMNo2m3ENbaa+fHtw5aCQRy
	TpyykeXBx3lJTI41bQDQ8aZjnJ/Zj1F9wVZCJT9NR2Y6BKKhR5KvMzYeFeq1rxZUHdBDev1UY+9
	VcYf0d71BSVPlOhrRQTPUHA2KBQ1SlNquvRMJZjlJF6/Pd9R3/TRU0xeQ027MmLYJAXT9zyV0Vr
	6Eu+mNbjZlRe/NYk0JI8nOBJlDY4D7pt7/PYzTiI6lXYQPYsiBd7gOZRI5DMSZhz3Kq88EfXB1J
	ym+b0WRwxvkQseqes39xD0omdw0f18jHCsNO/kGPyLz3GMZjdmfxsV8FlXN6SCHtim54QWYsSiN
	Nl5rWD5KcyXZZ59kmejUSgynRaxMNS7Z3jp5qMUHo/Ve6r3Ls7sfju7B1GPNMN8y65PNCgcxaI=
X-Received: by 2002:a05:6000:2505:b0:487:27f9:840 with SMTP id ffacd0b85a97d-48dbace65bcmr20779470f8f.53.1791838506637;
        Mon, 12 Oct 2026 13:55:06 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0514ab1sm1895744f8f.0.2026.10.12.13.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:55:06 -0700 (PDT)
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
Subject: [PATCH 1/5] include/linux/rculist_nulls: add hlist_nulls_add_behind_rcu()
Date: Mon, 12 Oct 2026 22:54:43 +0200
Message-ID: <20261012205447.2717801-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012205447.2717801-1-max.kellermann@ionos.com>
References: <20261012205447.2717801-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
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
index a97c3bcb1656..054e477dd093 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -115,6 +115,33 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
 		WRITE_ONCE(first->pprev, &n->next);
 }
 
+/**
+ * hlist_nulls_add_behind_rcu - append after the last list entry
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
+static inline void hlist_nulls_add_behind_rcu(struct hlist_nulls_node *n,
+					      struct hlist_nulls_node *last)
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
+		hlist_nulls_add_behind_rcu(n, last);
+	else
 		hlist_nulls_add_head_rcu(n, h);
-	}
 }
 
 /* after that hlist_nulls_del will work */
-- 
2.47.3

