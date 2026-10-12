Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B24DE719
	for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838518; cv=none; b=UmvbR+ilbf5cHkP7kor+hljpy138oTA82aQakeS3nB2x9GhVyZT5SnKOlfB7P/NIAoqWWm8s6tMet/gErDizEAGU2FKknj+ejUEaEtzDG39YSU8e5Gj7X+VxPZXQz3tmkiNBPAmFbjkDQW0Sco9+RZ70zKFWQNINpJAggnD/ohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838518; c=relaxed/simple;
	bh=h0PplBiawVa7S4Amkyri+VVGvaJkaMBRAxOzxD4sNhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7pK9a1TLMtEPyCYuGVZhHga2CZO0HUP06jx8TVFeFzsx4e+Etq/W5FWkheZOu0sDvvA1xuHdZ4p5v3HupZWHGbPTxGfbmzfsDD5xX8ayv3cnXzUH+Jj4K3ygjVHxzVHKluM7yISdAzwSg/fF6O91B9ulK0RNZYrg9eor4lgkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EAxlLg/r; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EAxlLg/r"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-486e8faff03so960290f8f.1
        for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1791838510; x=1792443310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zoshf0ayjIN/zktQbCOgmhPRix1kYVIFgS6hIX67uLk=;
        b=EAxlLg/rA/rWDEK+pNmNcuCs+2o8ET638Ur5t7IwLX5/ReuQbiIEjZU9G+hL2pJSJn
         kLIgFXGJ1tvY5wIIFlNy1pKMD53hadXi2fImC5jv/i0r46fjSHyOmDtPFyVIm08W663R
         ky4/pKQ11FHKCOS51MIa233YaLn4IKNpmCr8WIgjIU+w1WpDmCgQq0CbXLY2y4iNgCVw
         gRCHwlTz0/RJzNc8YnJHeJ9ZeVYopdImO3K9aoG5ZYSHwBM+Gzs9AbEK98rX0whJzM+o
         3rSgOGD/imilguoQKTnVLR7v54yBS/kdUDjHgfpgPhtIg/LTqkF7AZIVwnXNRJSUJia8
         btig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791838510; x=1792443310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zoshf0ayjIN/zktQbCOgmhPRix1kYVIFgS6hIX67uLk=;
        b=mtOs+emzOjVLlqRtehup6VPlkUXdDAkN+HvmP+fCD+s5/CLDFC6qEz6Sqwqvi1rKAf
         8Atez3nRu6ryIqWr5LeNG/fbY3xbzaGUSGSt32M/V2khLT9wJaL3OAMA9BIdgO4r74FP
         b0+oWFTTjyfRNL1ExtEW+1b66df8kpxgV4i14Q3QpAv29AIrvNED0YlKYwtQHkMSdOCs
         6q9UEg1WaJUqpP30xr194H1wRPSLwwww9LqDoFmYEmVC1xw4wNpkKq+M+p8q+l77xVNX
         9oPL8hcaqtMEftnRYf2wTIPodgPhM9Me83dfBBRKE0oT22sdfCX/LuZ+vsgGc0F8S0bv
         FNNA==
X-Forwarded-Encrypted: i=1; AKwUvBy++6FKOO3Li+8zrr9IBeSQeWDFJqmT40eer7Iu0GRjLgJLJ2p4OH4l7cCZe03ZjQ5R8/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3O2GGeImacX3t+Tiffu949iSIJvPX1az0Mm98fS2p/+L3L/zP
	QQlleH3EZiHVAo7yViHPZn3ViDD62VTzYYjV7mRv+Km6D4anduKPjBbUe6OXyCBPp8s=
X-Gm-Gg: AYBFou1SUZfv/ByI04MiWJQzoiCAuqSZn2PvN1vR6RxbgcPWAnihYow65cTFrAt9z0Q
	yo8FZVKz1bmzv2+WxVP2p8V59Dwae8/EQSgEV7f41K16wV6e4KRCG1ErfPNNap9IUiuQYsP8OMz
	9AAe+VRZv+Nbqc+adnmVMQBc4jAvb6pkMzV03Vyjf8Tic3X+ewTnQ324pzqPoz/c/4QX9IVtmi7
	8iUWktVyBSZW8LPh6DwWuZl3VNIJ8/XxkOwy5FCwvVyraqsYOqxIY88iOHfbpKVHGarbrj206tP
	cFQuje/GXIpPwMIqB3u8eCnbvvBCHge4+hSY5bt9V4k5iF16ldL7hC0g3sKpigZfxCJ+LsB2RGT
	t4BTTvubAlWdmfHrZjVZaLzh5eb4NtixBgCI1cXeS2zMGK7oXdx1VvJxlt5fNLOZXzqENJy8rBv
	JSRBibl76eC/Qar49CRQLb90qTPRHL6GILJILXgY0xat63oM1RVVWhpaXI8+qh3SNDMGdOkZgAt
	I6lTpfaMaoge7X7cWec7Mo6MV/l4+TfbnjbYLV0boZFODh9mRQsZZEgJfGRpoHxFinHrTi5rKg=
X-Received: by 2002:adf:ed50:0:b0:48c:7caa:12cd with SMTP id ffacd0b85a97d-48dbaae379dmr12995250f8f.22.1791838510474;
        Mon, 12 Oct 2026 13:55:10 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0514ab1sm1895744f8f.0.2026.10.12.13.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:55:10 -0700 (PDT)
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
Subject: [PATCH 4/5] mm/mglru: avoid redundant rotations of young memcgs
Date: Mon, 12 Oct 2026 22:54:46 +0200
Message-ID: <20261012205447.2717801-5-max.kellermann@ionos.com>
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

Concurrent reclaimers can request promotion after another reclaimer
has already moved a memcg into the young generation.  Requeueing it
into a random bin again adds list mutations without advancing the
old-generation scan.

Therefore, skip `MEMCG_LRU_YOUNG` when the memcg is already in the
default segment of the current young generation.

In my micro benchmark, this increases the request rate by 36% and
reduces the average duration of each write request by 27%.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 mm/vmscan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 69976df5d537..922c59eb9629 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4445,6 +4445,14 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	else
 		VM_WARN_ON_ONCE(true);
 
+	if (op == MEMCG_LRU_YOUNG && old == new && lruvec->lrugen.seg == seg)
+		/*
+		 * This memcg is already in the young generation and
+		 * reshuffling it again cannot help the scan of the
+		 * old generation.
+		 */
+		goto unlock;
+
 	WRITE_ONCE(lruvec->lrugen.seg, seg);
 	WRITE_ONCE(lruvec->lrugen.gen, new);
 
@@ -4458,6 +4466,7 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	if (!pgdat->memcg_lru.nr_memcgs[old] && old == get_memcg_gen(pgdat->memcg_lru.seq))
 		WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
 
+unlock:
 	spin_unlock_irqrestore(&pgdat->memcg_lru.lock, flags);
 }
 
-- 
2.47.3

