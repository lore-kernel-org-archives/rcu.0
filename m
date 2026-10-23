Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750747;
	b=R5eTcS7TUC1AI54QgVNSjnmuEeZ6k5UFtFiukHWNzSTBZ+F7Q2YVHqO4qUY1Q85pXlrJ
	 enNCVzqIUJkv8kuA0X5UfJ25NvUZX0ea5DDQahH9KHpkMm5VnkBF7oh84SQ283krvPueT
	 RIMgO0qoAqBle9PZb+f7kjJxUXQ5YsMrpbLSAyRorekpIOcpZcAy6IgxSao6/aCO9YL2u
	 NM43+MwlOzaUcjI3H0Bqz5a9r/42ZlIwrdVBup8locRV18U3puN4oliEIMSk89IGDsg+O
	 CaD+ULNicm92tMNb3MBMqvPWD/s8rAfk8KhPIG3177sUNv2OaP/ocbjPg8pV6HgSr9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EtqIIM3bW6NOeXuYxzInv9x9RXwFgInG15ngZwHQesg=;
	b=UHBK8dJwLq40ICPZQNtBSqiCAdNiVE2VoXmNuLUjCXrttdXIOa9w00xVhX8ltix0h7Ze
	 //FgAJGRJYz++UUH3+7o3MKjdHC4ArTmpTj3BQG/zbYe9SsOjYzfEy3WcjwoIxf+ZJOr2
	 swJc7MB6TiOMKOE+8iqlnhVRU4CWVBlipuCf+ZkGW0aaIiANh0t9w8U0VfFutPiTn4ziN
	 ajA8+xVi+QLAogWgBfM2KafClcY6v8mHj512/5OTiyAr2dUh1RGcTIJu+bpz9mProrjkV
	 puBlOOjkgmuYaE/d3haLQlsAEP8/rdxkkZBzn/E32iQBXO1eWUAHwK0wZflNJA3BHdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WgJoA6S4;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C47606A320
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 10:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7C47606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WgJoA6S4
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-353804b591eso1242150eec.0
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750746; x=1793355546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EtqIIM3bW6NOeXuYxzInv9x9RXwFgInG15ngZwHQesg=;
        b=WgJoA6S44uO/kodNCvO5TWbOc5qRb941lr1BdiQSPZD1ZmbbclzwNvze+lgsbWqm+j
         vL0hh4xcgsfWF9OZTnxs+7mFhoy49Q3FrUYbumgMFJNmeLOJvguO0mjbUThrdxcWFRi+
         LgqqA8/+mad43oN5NaWT80APlrZc7Isi3ZCfIQZO/wVEOAGDHp/aoExxTdsBGwo340QM
         8b+vAayY3N0rgkUXFHgAFb93/fEkdsVt6L2dgkBk+9DW2PXNs0nwivLfOEPVbv/LI/yd
         eIsZziTPdkHUj1twXuTaIMAL3S6XIRRilLxju6S5J9OKXjRXTufHW9Yene8JaU6X3Hg0
         +rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750746; x=1793355546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EtqIIM3bW6NOeXuYxzInv9x9RXwFgInG15ngZwHQesg=;
        b=KPGUzLjeki0Ap/fZIRQYLK/d5RCBsbMcABYcICPzE/HgGTZyHDfGaU9cnI2XsBJLdt
         wBNojGamqq4XioojPJXC3pHubNqA9HEzIX+sbNv9inRjrIAjmeQFRM3G5AZ+0pZHSsar
         4I40AQXVrhj4dEFqS+hjr3bNF2hNOnaZyYnIAT8TftAqZ+aAgmHJCt7coWGR5Bx2bVzj
         KueTPQJytuBNQw1mKN3bAgwXwynrAmdUOXkDrsthH6FuzOfossAHKGLGIJrNDzjnEFCS
         8K0U9EfzK+T83vsYm/4r59MUW080I1R4R2zAW+14k65IWEWgUSRrnO5J0uGzSOVgl+r1
         TDSg==
X-Forwarded-Encrypted: i=1; AKwUvBx3tb62CfcTa/92hDKkvb4glvBZDw1AmXGtN1sJ5DdmfRX1Lp/xxv58HEi24dwElUJ/HXM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXOW/6rZtTireEyTajoKfU5uhEnGG5LxY9JoCQByLiOil5R2An
	l9K3JyTzIr0JHWIz5iEYkUrRxthGfw5emkMnOqAo7FAGEeQcyF/To2/z
X-Gm-Gg: AYBFou2YIBLPt2xpqeRPvKNoUa7wTAI8guzcdjgmWfkvl8HSEXZGWG6FQ/CpvWyKd64
	kKSNCE6NceUNLlbIZAFQpKg76XOLyd90AYAYqeEwl2RIWFcoDsFDPs6BVilGkHXidjq0oHwJ1Gp
	XNrFYJXg9kHHVh9ogBuNuW+QkzTN5uxiwEY2E8UsTJAeMZwAJNVROXiq3YUGABY6TexYmws11My
	KFB6n6uOO1T3oVgFhx02umVPMdnMH15sP6dr58CGpwiL911tNS+79rnWY87Iq4u13BLPdreWwN4
	ivrx063SIW0CXoUTkoAuGxz9bj9tq3lB/68EZ4wSW1Te0rDDhBvVCGwGXA7THseWNSfJRT6b6fw
	ciyHlnurYRHegfdRhQmYxtQVgdhPC4sQx1tf4PslMFRikVptsTWAhhSnw1a4cx1Ziy4WnPmbwDb
	jdQfSPynhk0qs8mqrkkQSRBMazxlZXhtf+VRfHlqC7DI3y99Fm4mZy8NB1AXM5txsG0cYMhGBEw
	kVCwUIYV5wfKCtW3IB8jbR81yPV0QBI167EYLiFXUIMqg8UnUnsv9wQ0mOXN4f2Op3ub/ZUQ1c=
X-Received: by 2002:a05:693c:6383:20b0:369:5583:bf48 with SMTP id 5a478bee46e88-369d975b14fmr2185109eec.24.1792750745608;
        Fri, 23 Oct 2026 03:19:05 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9deef9bsm5852176eec.22.2026.10.23.03.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:19:02 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	work@onurozkan.dev,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 1/9] srcu: Record callback registration stack for KASAN
Date: Fri, 23 Oct 2026 18:18:33 +0800
Message-ID: <20261023101841.2910719-2-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023101841.2910719-1-kunwu.chan@gmail.com>
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
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

Record the callback registration stack in __call_srcu()
for KASAN diagnostics involving SRCU callbacks.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/srcutree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2b0e2b2d2c18..46fe2f0cef85 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -20,6 +20,7 @@
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/irq_work.h>
+#include <linux/kasan.h>
 #include <linux/llist.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched.h>
@@ -1530,6 +1531,10 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 {
 	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
 		return; // Leak the callback rather than corrupt SRCU state.
+
+	/* Record the caller: the irq_work's stack says nothing about it. */
+	kasan_record_aux_stack(rhp);
+
 	if (should_rcu_defer()) {
 		struct srcu_defer *sndp = this_cpu_ptr(&srcu_defer);
 		struct srcu_data *sdp;
-- 
2.43.0

