Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195220;
	b=C2sD/PTNaV3ZOXRvKaAdDE4If8RpUo1U7X8vuLWax2/as2eqMrCx+zh7eBQs7PchlZqP
	 JxRM+ZBhF3CWEsEDHeYFoLHja8J1twsUqerJrPdgbdgTJwwC3+xfAsPrQMl2o6cbyGRvL
	 Uq5EvgOZUzHf+EOutjHz8dKdTYqpXhrlWGvFEUlPShhlGw3ndmlOfv7DdJAuDdBVECMUv
	 QKXljObUlbnxawPPXgk6m4ntcKEyKOUWXrv7oT7Kl+9TPw92ElfHibmjy0obir9u8jEyF
	 ZYquQZPTcB2HtdudzMQPDgh3DLMGrbR/RugtLsTmJY+NKGXpIzfoUsPQfkWn26fWhuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dyFRVqblmLXE8qjlBr7bz/X+uC/PuqAiTQQAhFFS2yY=;
	b=WiRtR0UVS/R/St5WrSKsMIRKGF4f97kYX1T6x4edM9D81kh+ijtGW5bm8m96XQGG2mrk
	 NxSggX44jwOST1MfvFSGSgxnOaLpAvEYACwMX6PMIi/71A7Ml7VpmRO2tfi0HOQWSwRYM
	 oMez9JEpnE1oZmViLW17/CPFYqch2uu2P/I2Y2R4d9DuwO4WpYgg1iXGqFM2kIRbAk06h
	 /eXcvijbPQltF/Lcqwt+5CBk49oEOeEuis3A9XbW40sB/WTPGIVlLIfhnOykWXKOJnrXm
	 kNxWfc4E5Q2O/tEHC91DMLSeN6yrQEGasHIQDEC/RutRFCwYxGUZQsUwH8Chc9BUIKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a4jhljGj;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBF606A31C
	for <rcu@vger.kernel.org>; Wed, 28 Oct 2026 13:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AFBF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a4jhljGj
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e96502e447so8554195ad.1
        for <rcu@vger.kernel.org>; Wed, 28 Oct 2026 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793195219; x=1793800019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyFRVqblmLXE8qjlBr7bz/X+uC/PuqAiTQQAhFFS2yY=;
        b=a4jhljGjGqD002ZO0lyzkQzZnIKwkHH6WfRExDEerDrtJQB+nHAaXAwii5m9MUcbS+
         iWYcRyreRd6SAzQbiAzjKNxLyR9IZtxcguhjgNNUj2dpYHUF2MZpL783e65D0c3Hcn6Y
         m/649M54fzbmRETfUYO5tq+n5zCSzVJyWLNbBwbLQvjEgUa7dB/oYoPqQhPGi2WmXavP
         Z6mbH4lbUj9ScWJQBDxy9KzYIdde9FxuWHE8O7ono+gJ7zbK4Aj/9Ms6ZMUdu/vmmyr7
         gnpW29bn7ep9rAacbDLvbiT90lhXOU4nWTU37mpdCzGV3FV6paNrTCEMI/LDuRGz7IkM
         H4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793195219; x=1793800019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dyFRVqblmLXE8qjlBr7bz/X+uC/PuqAiTQQAhFFS2yY=;
        b=GPiQWFIDv4ZN6Ba7NHrHk4yxmDnUoUO8pDwp+nNOR6mdGh4G43nCg9Lqr7glYLhyfI
         rJYldXZvuJ4fPFW/yJTablBIZzih1Grd2WxXBJxnGYlnh5BRccimRzp8n/O9tRLyngED
         E6ldNEweylQJkS127z15gzWzolyjrXZk1sJ3iJ6Hpcxs11fjz2LXAeVaD4EW39vEK0cy
         4ck6ZQPf0lgwaGMR/+SjjfjV6gGc645kqKufOg3I1aWLlnjJKA7j1EMGiX7CDRIpRN8O
         jMzO4T+tjvxV5w3DW5ZbA1i/A3XRzR070Pch06JLB4qmA71xGbMB7gDAf5mXRBGSkFcm
         gDKA==
X-Forwarded-Encrypted: i=1; AKwUvBzfY/90pIb7qGRPjJ8/rKZ+bH/9KIlz2cVQ5eQIgGUBIPS+vIVLKfWejiVPJS5wT7jQEE8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6796t3+FMNigkK2Mr//dVNRHgfFP450s3bgV/74FFqF+7o0uO
	R+scKyG1SHz+ARLP1x+oZQ6bHojPdn4pqqZlTFm3eVZAn+GxUYetbm/U
X-Gm-Gg: AYBFou1z8m5ADjop9NsGo4qD8RdYl31PCfGAfiAQCt+4PYsB48VstGevSYbIkOjzj6e
	q//+/BlzR29NVfiXBXDGdEZU6NXtV0Gmsae2yYctZ1BN+t92zOL4jVcuNuL9wr/QC/lbShcoKPT
	sJLv5oa63TkSqRadSF3p+S35/VGafTWvk07yhP9QOMVX6xg4WdA+KOERG+5fH9Oy9+CjeqNRIb9
	ZXTjF8Jdu04nJ+gpfAH6lZdPovLGV65HiNqRuoLOvEvbn+yQdTKMLfTcS+c0FOXifUKumoza7KK
	IaAqCgTQb0uEQ3+UfeSIBvTpGNG+40St53WAkTia5/JJEBsvg3x85LlMhTh1Yl2gSaZ3ppweOQJ
	ItcPkUFtAIkwEjCwrhZ1/Et8ptoewrJZNBvTi/j++re/RPWz1QnJVMG095jZp8C+wzvDO6yBZJ6
	BnF+qg3wEx+mn4XUY6GHlzNACtfc6D4U6HnYDykCccwME/4/6dK6am7hUjwy23TWON9vgeXaXQ0
	3OSTRPgy9EurAZO1OchOoctGOTve2CCu7cVFthJjCUFdwBDKcyUypi9B0HvFsIiDBuxTsfR7vV9
	+GZvjY0NRDur982RweCruUQmITShXaR5RMS0GRKgsstg5A==
X-Received: by 2002:a17:903:40c6:b0:2d6:e9f3:9305 with SMTP id d9443c01a7336-2eb0012ec15mr23435175ad.5.1793195219458;
        Wed, 28 Oct 2026 06:46:59 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ca1bb2sm22014585ad.68.2026.10.28.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:46:58 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: vbabka@kernel.org,
	harry@kernel.org
Cc: urezki@gmail.com,
	paulmck@kernel.org,
	qiang.zhang@linux.dev,
	akpm@linux-foundation.org,
	hao.li@linux.dev,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH 2/2] mm/slab: don't queue the page cache work under krcp->lock
Date: Wed, 28 Oct 2026 21:46:47 +0800
Message-ID: <20261028134647.3176080-2-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

run_page_cache_worker() runs under krcp->lock, from kvfree_call_rcu()
callers that may hold more, such as set_cpus_allowed_force() under
pi_lock, so it kicks the refill work from an hrtimer.  Under memory
pressure it instead queues the work with a delay of
rcutree.rcu_delay_page_cache_fill_msec, which may be 0, and a zero delay
queues it at once, taking pool->lock under krcp->lock.

With the delay set to 0, calling kvfree_rcu() on vmalloc memory under
pi_lock after a drop_caches makes lockdep report:

  Chain exists of:
    &pool->lock --> &p->pi_lock --> krc.lock

Use the hrtimer when the delay is 0.

Fixes: d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory pressure")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 mm/slab_common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3729aa7a6156..ef5ff0a20249 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1987,7 +1987,13 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		if (atomic_read(&krcp->backoff_page_cache_fill)) {
+		/*
+		 * A zero delay would queue the work right here, under
+		 * krcp->lock and possibly the caller's pi_lock, so let the
+		 * hrtimer do it.
+		 */
+		if (atomic_read(&krcp->backoff_page_cache_fill) &&
+		    rcu_delay_page_cache_fill_msec) {
 			queue_delayed_work(rcu_reclaim_wq,
 				&krcp->page_cache_work,
 					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
-- 
2.43.0

