Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705850;
	b=zy9DfSANAURMS1wcF71wSO+tQbLDK8t5oCliJufErbMoJ4e5PI9gCxtl99P5WXb8lv1k
	 Ab36CIOJY+n/tzU447K8EgnfDnKrGWrs3Hc4Dp0JmEKUsEgcsbzSbcYF43VwX//jo7ym6
	 fmC4H1+K3hpgkdqBJhxjEwfY6ncmXfBv7FcF+tQhXHP3DWcZVN2DlXN4UKjrdITw49m/4
	 HaYdNGgFcw7nYX25v9DBp0cWH9NkaXEkocKQoknQf/k8cavsZ3sP34kjF5mSySFkGmhsF
	 JDiU9v0hGz7UgZ+lGKOD3n52pWO/9YjYDRGhLmLArsJ2zwuoYqBXrKf+MAdnaWzyGjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SwDDfs8eS2UrIyJ875nz0ilkf79JUl413gKXLxgd0/A=;
	b=hfuBNmXBxluz6py3PszNyrB17I3iK6CNYlONKMPCdE+iKJHxzkuwp6i/ptA2xjY7dksK
	 YqmRmULMmEDYe1U8nCNXM7UsnODlfCCXMaBEpq8nMRW16vMZqz+YlX+TEFXEDxS3sM5jQ
	 1rJHNEaSwiNJ+jNFl3nUzFsqCMFiH/gdvoWh8xAboGrLTYb0fypYprM85W7sY4/wMmnVG
	 vxPOmv6gHXP9/2l7oytWdTj6t5/5o61xaLemyDJSS6IxzYJzUmCLPrYnBDEtMH2NRUpKm
	 mjpdr/+ICl3RO61lghJQ8bBDOevGCxhB/PvB40xyV6tw09bu3A0CFAaZ+cRqyBnsejg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=B5miBP30;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E460850B1
	for <rcu@vger.kernel.org>; Tue,  3 Nov 2026 11:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 710E460850B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=B5miBP30
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso3575897f8f.2
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 03:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793705848; x=1794310648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SwDDfs8eS2UrIyJ875nz0ilkf79JUl413gKXLxgd0/A=;
        b=B5miBP30hXqwh/4dXSrYtoEd0RPDsXOtTrsEQy8aifRuN2FNnv3lMB8ZA/voKyHE4L
         sHP3jM3uBIWs7dxmwwKmzJFGmP1c7OjAonmr11P3fAJazZnspPxssii2Toj6lb3GLLq3
         tHf/LLpWcHrgbhGG2fyCXHYUoRqEWiKqhK9YbMC0DuXekEVpbHJguDadjPvgXB2Qtedn
         JArOf5msr9t7pzgpQEcqFMTj4oELKBi3/+yX4tBska95hF8jHWJNq9hozStEQM54/ZzR
         nWnpuzFXWz5jk8k+s+iZ6JIekWQMAHj4SQ47HObmNuNsOOi7yINqB0V2YhN1hve/It34
         MYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705848; x=1794310648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SwDDfs8eS2UrIyJ875nz0ilkf79JUl413gKXLxgd0/A=;
        b=wzbSX55ba4hCfSZYYSbbhnX6D10dDMeI24Og+nHnyh5IhUGLTXP34/8TjfJL6vlW8q
         F7IZtqWE9/ugZd5vAra8dd4Je+geyTcj+NJpjhPryrUcglOgpCi1C/ml2zg3LIMwprXY
         IHUkkhQ9jVurcWyBhknt8jmFDzKf7jAsdW3aKMhW5QwStcs7+yycc2uFQ7/ScZlmJuXG
         wI/VW6jqJ25FWUP5i9K10vlxOt0TRgZ8FgBCnAdvA8x+g2ssGOpTBsaFO7j0ckZUmFJv
         6gntyj4pRdhBiMHXGlJXJhm+vqeI9DnMdXRR0BoYBzNfZTVVP9MNpQFzrBhv/mZ2w9aX
         VL8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwXGZY9wZx+nK/3bmc60b+D/y2KpMTLMWdXhzgolA9aKfGL7PMXfzvPcagUQ0WhBVoO5eM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SRGzcGK7I6B0Jh11sQ68kgFHH22wMZy8aF/+pgMHHYZRU6Y+0
	2muzbd7TN2b+0m/O4n3TllwbVELlyLRNFbc3dtSpKVWmDwT3t5E2RW0oZqoCqQev1Mg=
X-Gm-Gg: AYBFou3dwdoHu6PLYip8BNyvRETJZlXQiFhVG8Dz8evgFGm3wIi+YnpKd2WQ+qxZFdK
	gKbuNsOJR7b2ElAyv+MaQVtvdFO0bR9CNLKnjQsljgo/4i9Xgv+LgMhAshjVUHRujxg6c8OJMdR
	J3pB3KTm24YfTdMBRJqyfiDhrq1BG84YRt94aZP6Jf4q4jMO+ndnmrYwzgcK/7lcFjlv37nJ2Bu
	zxaq828UBRtBK0+rqjVFMoJtK+/2YxC63F93tCvZG15qi/4DPGimx0rqAXSO8NM4Woz1Dzu7w2c
	vAJo9cP9iQFqezqKt7ZkTfCvzugcJyP8+L8wmo+ZhvDXD1qGUZRCozbnJSP+h9QtBOczAyStmFl
	x/FbXFjF6cR8gqTnr+8oYPKlsOC4eirzH5EHBvtfq3Ja8Ccfr6FXu4vbCHFm7EStZQgODn9TxK8
	wdBUYBIY56woRsxBfdDpQCkAnZgkQ8rrfXNf0rOMMv95G1Mun8NeLS+ozC+0PWRGlJbY0AL5AH3
	J27xl5jzxDPM5dumwdgeIEtmBWznfUR2CDMnC/g3ovicb22c8W3c+pXCq1OcgPqjIVR9Ff0FiEf
	6ZFf09s5CGyr5lpUsnGuwbeJ1BkmMmvHh5stXkdKNGet2mBrFdlrMj1scMOlIJm147UuiGMf+10
	a3uYMZUbRXjDIw3C6J7NaKws75xTPNQ==
X-Received: by 2002:a05:6000:400a:b0:48e:4115:f3e8 with SMTP id ffacd0b85a97d-48e6e50096emr30315688f8f.27.1793705847639;
        Tue, 03 Nov 2026 03:37:27 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78f95sm23000997f8f.28.2026.11.03.03.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:37:26 -0800 (PST)
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
Subject: [PATCH v2 4/5] mm/mglru: avoid redundant rotations of young memcgs
Date: Tue,  3 Nov 2026 12:37:09 +0100
Message-ID: <20261103113711.1832834-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103113711.1832834-1-max.kellermann@ionos.com>
References: <20261103113711.1832834-1-max.kellermann@ionos.com>
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
index 3075949bf641..899f756bd15b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4620,6 +4620,14 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
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
 
@@ -4633,6 +4641,7 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	if (!pgdat->memcg_lru.nr_memcgs[old] && old == get_memcg_gen(pgdat->memcg_lru.seq))
 		WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
 
+unlock:
 	spin_unlock_irqrestore(&pgdat->memcg_lru.lock, flags);
 }
 
-- 
2.53.0

