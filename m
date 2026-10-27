Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085035;
	b=J5OJfB/4IzXxAZ8uH++7sOPKws7W7XKQ1DCdkPINZm8jOl2RuIqHRsXSYCO1F5kADj0/
	 I3qQ7jeRvQHdjBPiNaQGtWl+RUoWoQPJR2PzGd1eTmabY0bG3BVBNNk9Fqs9rC49Mf/J1
	 BTyKBSahG6/4NljKxmttIKlyQfil9j7uJiqvA1SUOZwo/VqGwq4gm8IwFqLLEtW83dKIe
	 FSyCwcwYIZNImzc0E43x6KMRQnW2vXL1DHW7JX5J2+NeF31NJdG/MIm94cGAs970EOK6I
	 vOkhDd3Ie+EdVdxKYvhzK6xi5nKlHtxmYta43E7mTODcqUA19KlRdoXSeBEiuiL8+mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G49yOkjHll/OcWD0zAplg4x1BvQSWYpduHQ9gxRuz20=;
	b=cwuY+hRnu9eHMr7WtBC7ZqT2rz1qDbQf0UV/WWZMu+riJp60F6rdIk6erWVNNAQyvS1/
	 fzWpajhydkL+98uM0mxVKK4KvXyZsZvmUWMWJthdzM3Gv4sX/wLG0cuXill5Nd8MKHMzO
	 L3yOrTAEaAKyhf7y8sCO3h5pPksR8zGQC89UTEP3wiBlsKdDHkD6YqUxgVvlKANOqS3o4
	 MB8PMpJl8FnRH7vDJ/AbxLkciHhCArTyRlF9q9LSZyZ5F2oaBFFUSFBhxJe+5P/tSzfjt
	 Lw1aGbJIM2VgAyuA7cYBKvbV0BUpBZ4cpyitQJHePZBpzx9ZWSCYu52ezP1D6pHbjBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="peP6IJm/";
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC2606A31B
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 07:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9FC2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=peP6IJm/
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a07078200fso1289014b3a.2
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 00:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793085034; x=1793689834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G49yOkjHll/OcWD0zAplg4x1BvQSWYpduHQ9gxRuz20=;
        b=peP6IJm/nau4y6pkCgIupWs11PFiNUnQYajlr00rPZH1G5YNbGP+zhAlc68/Ku2ljK
         an3vLR5F5drIfv4WLeC0Rmqx24JH33kliW/3DxlF+qrTn9VRRxoN7pyNUnjJRxonSPUr
         RG0rAZD5Ie4UzjtLrI9EpkadlI3TqQdbAMNu4rYwbJKBqiJcS4X+QlQYdFLw6jxzbr3l
         V8QlG3PFv+T+wi7xMa3xq9q53wfOJI7HZ1+KOKKZhtECP5TKKANar6oVUSE1uJ0CYuPY
         Xpjv7U0P+w8p6Nmdv+p26XLSlTQzhob+piYLojrKv+tPaFoGuyQt1bm0pPUCDoTLg21/
         ZZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793085034; x=1793689834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G49yOkjHll/OcWD0zAplg4x1BvQSWYpduHQ9gxRuz20=;
        b=g5k26cQtoyzodo4FnEwjC/0dk1f3OxS6KfL7ahbLudkr1U4zoQeAMGqmBBUv0hNVE4
         6acwGiFVuvzS7n1k5rdSTthQlvyDvJ/2/itvuh+EhDAliAdFOfwXPNvfRYtmzm8SifSq
         nZWK7lOUBdeQ4yt2uV/26/sHZu6pZd3P3TideP9KEedecRK8Wl9geJFgLH2fQ6aRXkcB
         FNO+PmVcVJ8CUaUZBGIVICQ6Ek6++M36cTLXWjbxAOsl8m972/MRwSn3OehkmULzkIht
         b9x48P/pGSZQX5RAIMaX9yqPRPUW5vizVS/D55XUoT1y856Wwk0f22+0vVLTm9KmB+6B
         zB2g==
X-Forwarded-Encrypted: i=1; AKwUvBxymZucXhlQszvCM2rrz/LP7OWij5rffjKw/e3tmCgc0vXo13QKjcuFc6O82NhxgRVTFoA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmb6B5qOAoYNtl7wbUV/l5ID1zNW1727zwlj8L6zJWzscsj/xZ
	jxCmV+DJW//0/k/xOazt0MvQD/6N1wFtJY4GZxjAPMD28bfgh+FmFpW7
X-Gm-Gg: AYBFou1LCIQ5SYhYWHLJKdXNbMYa7PiM6wBmEQ1nmTfUOHFoXjc/9+jdNLNRyBDGBkU
	0SYvxfboCweSxlBg0dlHaV9ZF4pMe+9A+F66c6sf1Slt5VWjYhZI5RQGZoGFOao5jCgfptwSCed
	AjKajzms7i4TvEGOmBs+V0RjtVOsREZgRnk9aIpqyhf+WC0biv192JpdG8JzbzX/A7IR1tC9i+d
	AN52VEZlFbE9pjAV/GcpTGlDM5cTpyx1iEPGDWuWGKVx/QqDdK1CbPeqFrhODC9lmizturAZwtn
	ugNU4ELBJhBVeiGTl1jRLYmNKP1vrU0itHG5GF024H5UKV1rH/LohIcv44yH0d9hn8yo3zhJ2rH
	3kmOMYTW+nwk4CAqXJsTQpfd8T5HaqLcnHMIS0lcisM17FHYVsgiE21H4o/jRJRFHFIN2pY+TWM
	MX7ls3lWuYvHWDXsvCp9iqJ6z8YkkinsLpIpl+3wdK2iEc4rAZ/7bta5qdnplrZTzRmz6FqKPdb
	HbKYeQb5IPl9dThbI/1SZZHZ6Ft496TW8LA9D0l2oUpXn3rOWSGKNxiVUkgK08Pr5iXJVsYbMVl
	CHkdUt/ZizlJ7ZcBx5YJ0ySSro7NI2EAPExFa+EUxoSyQkg=
X-Received: by 2002:a05:6a21:2c15:b0:3e1:d43e:367f with SMTP id adf61e73a8af0-3e7cd5cb5f1mr6607387637.73.1793085033781;
        Tue, 27 Oct 2026 00:10:33 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21274sm2277512a12.8.2026.10.27.00.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:10:32 -0700 (PDT)
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
Subject: [PATCH v2 03/10] rcu: Record callback registration stack for Tiny RCU
Date: Tue, 27 Oct 2026 15:09:16 +0800
Message-ID: <20261027070923.3054462-4-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027070923.3054462-1-kunwu.chan@gmail.com>
References: <20261027070923.3054462-1-kunwu.chan@gmail.com>
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

Record the callback registration stack in call_rcu()
for KASAN diagnostics involving Tiny RCU callbacks.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/tiny.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 656b6a682e31..bd22fa43108d 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/irq_work.h>
+#include <linux/kasan.h>
 #include <linux/llist.h>
 #include <linux/notifier.h>
 #include <linux/rcupdate_wait.h>
@@ -251,6 +252,9 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	/* Record the caller: the irq_work's stack says nothing about it. */
+	kasan_record_aux_stack(head);
+
 	if (should_rcu_defer()) {
 		call_rcu_defer(head, func);
 		return;
-- 
2.43.0

