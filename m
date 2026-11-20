Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163839;
	b=BpfON8DeMydLyWSX6HNR9fyfRH/w6+oWNN9eP4TegNLk4iFlws0WAfZyKtfFYRLgxhu2
	 mVxGZQ5rvqNTSpQS69g17kL9stk9Xx+vIlzE7DD8IwYUiVK051LJiMI8rIqJWMFETgXXn
	 rpG+qQmcETbEQUjgyAiqoUhalmJ1cxOH6DemOtqGTMKjEhqMvClR4t1h572oXVnKEWL8X
	 QCR3C6JcL2D/96O5+VvERm4m1c30GZEXN18UsY9GX7ZP0+LlwccVALVbjZimGvlijCyIh
	 F57bQVMQfNLrupAkfjSdmjU41oWswGCh78wMZjrvDE/6AxMgsnuU9UF5xjSKY2EErTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=g/fHu7Nley/JjRttReoBdOyGfNrnA+dp2NZ1oWj3jhM=;
	b=roo+VGo54Fjvk3v3tIvCHyXIyyNolFFPfXVulmEcGEdKkilMZKZXBN8kEKYbTF3WQH51
	 1WKSzI9l4OpFBHvaXAzvBlRRwWGZY/bAmiI0Kh5i2EzVmnFNXEWQhnhECjNlJz3wnxAl0
	 vPaZZuTXUQyXpIzcDb97WFkQq62RrwfvC1Rw+W9femuJMmkvOugz87ZdgroBOBmOQzXJA
	 u2ORDNRteeUEz9+xaup6IPUDbma9Lg1tLWbGPssw4Hf74MKv1XXyVQdpt0f9a/LeQJSae
	 ywE+PfFuSV+60LNvxAxWp2BvYZFNFUJVqkLGx8AY0eD75btfefbJ/uhYBPmLyovD93w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MMBzzU1p;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281AA606A330
	for <rcu@vger.kernel.org>; Fri, 20 Nov 2026 08:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 281AA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MMBzzU1p
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2efd7259872so3818055ad.2
        for <rcu@vger.kernel.org>; Fri, 20 Nov 2026 00:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795163838; x=1795768638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g/fHu7Nley/JjRttReoBdOyGfNrnA+dp2NZ1oWj3jhM=;
        b=MMBzzU1ptyoyq6zsyOP6nVX94qw1w/E3iaH/MXmFwXbKgU4DESzfqOE33mcwIozVCP
         NRnyKlCO9LcGbZgX7stkIeWUYqon8Dau79yCnyAP/48sRENzWzOPKr9wCyPeuGKQfhi9
         1DADM+f4IucDs2bcWE9Jmjk6h63zVQhhie1xKUOl2UNoy66ePEtmnxr0nSQqqg6rRo10
         tTTW7QLefJHfjAkfjNRM2yS1jgMZa7x58lOBWfvOSzQI5mOYV/szpqw1GC2jMgfYOi5V
         89Qq9Ml97mudCkqmuTNgo0KJ1a6NyIQbQyQJxUB6HvKUfXVu1VVlJzG31zsPpDOUxuHx
         PynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163838; x=1795768638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g/fHu7Nley/JjRttReoBdOyGfNrnA+dp2NZ1oWj3jhM=;
        b=V/k5Z4YgmHHq2pF5ogs99FyuVJENQkCbZ/97UiM71W+JZdapOyTg2OtKVczztuwenF
         KD2ttNFMTZIPj2LZreC9/VyweCXH9qAfWO+Hei+b1BNIe8BF74XXYYMTuL2H83YBpqDz
         Z0ksD2uXZvcZ9pM7sVTjUt/xwb578lAdmEVmjFsG0hDBpqrsJkJlnw8xBRqXx2q+qG/Y
         0PXvZFyOrnYkl273unanfHbcplTT1drzhFEZTepgF5SNCCk94RbSDOAZZXsxNraaLOmx
         z87gkNuGLwbR3U19ALxW2vZxm0hpoijp9+7btYw2CnxP/hT3BKe2lWz0WjwskxlOoswk
         UNGQ==
X-Forwarded-Encrypted: i=1; AL+hErGjQendUETplDXyCIUZ8Nz9GF9rptzsOLkuEkDyGuBM1ChoD6UyqR/RD+PUL9+aKRtkRsU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rWHrcHgZlqLrANAZhFF41OQzNlqLY5muXf7E1Sz5QWnKVLV+I
	38W6zHGWrPr8gxdPuVrW2R/1nCRT04mpUHS4gDgeLEeNJHpdd8Khk+a1aNltxw==
X-Gm-Gg: AZFdTZd1mGv3AuGZ/vwWb/8KbPHSfneaVbQ1ZEAa4S4ohGOvAjgq1xy8XV/jNAojsNq
	9EGllud9cQqTnnUbhY9Jwrtn1TFb7gBQEJ9ckIcXoTTzNsz+ZXozyV7jy+sZXxmlXTcBOQ3bWdu
	Ndv7L2fUvCKIV19KhOL9sD/xhctMHJuuANAy/F4QgWQB3lcUyNfayu9MyN2WfanNwNEVt1VyKtq
	Tqxr9VaTB6QBlxPYWiJhu3SN3jClwsOa+ucqdHxaeqh9Z9Ww1QCAGFoUe48wj5GdJE4ZxegpDaX
	c3N1BJAqbnX1VAOsQhDs4+g8y94i60Fz6L/HHgmDouzIwMKJYg5G9l6SByksZBdVGZAuEVNmLvr
	ztW23LEX1sLU4wyHspMhC1TmdEIhmU9UaXsUTcf7KgwPj0cvDx/JLOalZKnw+fqZpa8UDQXNh0V
	uEgwWrqmQxcI5rTRM7NTmeHIIWpEoNaN8Hw2G9JuSXAchXXviGHZhnySom7yhLMdaEA1P3Rxefr
	ap1pPmi+MNgEeE3jnGGGHel8cTJo4LnEyFoiJ6Uo/HnMUUDBoM1VJYBr2Rg4UxVwhPHDNPv3B0A
	TlqIC2+c5n5wzUzEOIJwCvrtc/4HAPkB7n4NfU3nCWzn0w==
X-Received: by 2002:a17:90b:3891:b0:3b4:127a:2bc2 with SMTP id 98e67ed59e1d1-3b41c8d9bfamr2140676a91.14.1795163838461;
        Fri, 20 Nov 2026 00:37:18 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm3590057a91.5.2026.11.20.00.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:37:18 -0800 (PST)
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
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] mm/slab: don't queue the page cache work under krcp->lock
Date: Fri, 20 Nov 2026 16:37:07 +0800
Message-ID: <20261120083707.296481-2-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120083707.296481-1-zhanxusheng1024@gmail.com>
References: <20261120083707.296481-1-zhanxusheng1024@gmail.com>
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

Commit 56292e8609e3 ("rcu/tree: Defer kvfree_rcu() allocation to a
clean context") deferred page allocations to a workqueue. To avoid
deadlocks with the scheduler, it used hrtimer to queue the work instead
of queueing it directly.

Commit d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory
pressure") later added a backoff mechanism under memory pressure, but
did not consider that queue_delayed_work() with delay = 0 immediately
queues the work and introduced the deadlock commit 56292e8609e3 tried to
avoid.

run_page_cache_worker() runs under krcp->lock, from kvfree_call_rcu()
callers that may hold more, such as set_cpus_allowed_force() under
pi_lock, so it kicks the refill work from an hrtimer. Under memory
pressure it instead queues the work with a delay of
rcutree.rcu_delay_page_cache_fill_msec, which may be 0, and a zero delay
queues it at once, taking pool->lock under krcp->lock.

With the delay set to 0, calling kvfree_rcu() on vmalloc memory under
pi_lock after a drop_caches makes lockdep report:

  Chain exists of:
    &pool->lock --> &p->pi_lock --> krc.lock

A zero delay also defeats the backoff, which is there to defer the
refill under memory pressure.  Clamp the delay to [1:100000] ms, so that
queue_delayed_work() always arms a timer, and update the documented
range.

Fixes: d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory pressure")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v2: clamp the delay to [1:100000] ms instead of using the hrtimer for a
zero delay (Uladzislau).  The changelog is Harry's version from
slab/for-next-fixes, with the last paragraph rewritten.  The
Reviewed-by tags of Vlastimil and Hao on v1 are not carried over, as
the code changed.

Tested in a VM on v7.4-rc1 with lockdep: with
rcutree.rcu_delay_page_cache_fill_msec=0, patch 1 alone reports the
circular dependency above; with this patch the boot log says "Adjusting
rcutree.rcu_delay_page_cache_fill_msec to 1 ms." and lockdep stays
quiet.

v1: https://lore.kernel.org/all/20261028134647.3176080-1-zhanxusheng1024@gmail.com/

 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 mm/slab_common.c                                | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..0d1d76a6af70 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5763,7 +5763,7 @@ Kernel parameters
 	rcutree.rcu_delay_page_cache_fill_msec= [KNL]
 			Set the page-cache refill delay (in milliseconds)
 			in response to low-memory conditions.  The range
-			of permitted values is in the range 0:100000.
+			of permitted values is in the range 1:100000.
 
 	rcutree.rcu_divisor= [KNL]
 			Set the shift-right count to use to compute
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 41dea01a8c1f..6fb453118641 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -2262,12 +2262,12 @@ void __init kvfree_rcu_init(void)
 			WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_reclaim_wq);
 
-	/* Clamp it to [0:100] seconds interval. */
-	if (rcu_delay_page_cache_fill_msec < 0 ||
+	/* Clamp it to [1:100000] milliseconds interval. */
+	if (rcu_delay_page_cache_fill_msec < 1 ||
 		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
 
 		rcu_delay_page_cache_fill_msec =
-			clamp(rcu_delay_page_cache_fill_msec, 0,
+			clamp(rcu_delay_page_cache_fill_msec, 1,
 				(int) (100 * MSEC_PER_SEC));
 
 		pr_info("Adjusting rcutree.rcu_delay_page_cache_fill_msec to %d ms.\n",
-- 
2.43.0

