Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085055;
	b=vXoBY4bwW/rhJhIhcSUELJ6fFkUIFsixIkI6MmFVjnJm9CVvS0k3bauXRk3qQNiCwM4b
	 UoJH9HNuzuP3/Z2OzmY4dDEn6p6x1zieB8mV0+5nCAms3i68GFUrzgF3TpjuMnUHSUM8Q
	 E+r/L51SaMrng6kNogARpy77g5vaPFXRtvb2+u5iv48W+FWDedXNaTwXoPmJ1PRafPXUQ
	 +7hcwb0W1K7RfaueHUu55XzC2sGmGSlybkO5kIgRICdaOMdOLQ+ZaZY39fMGriXTQknqv
	 ytcMKgmF7EmTTMem7G+3OW/KO7mYD0WQkzYEShqWm8oJK8Armr7qAg2VudbNMv5I96A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UZgXNRDybz+RvZYxWwkDSCBQ8npDe221Cmrr41lYgfE=;
	b=wtMfLGMrWOfREScFF+RFfSNHkZbWerIyns4Zx85b5O9b7P0v5S16HD4RmXRW6E8RqYSv
	 Z73zU7alCfh+4LJpI8d7GUnOxd3nnafPUfr8+jFP4Ycg2SuiTnWnxv27TmNfuYcgNmTyF
	 cMOJP0DG9JaHcNJY8jVFCWLm4heBVsodfYBZlPYo5o7yK4zzqefTarjhFadFD1shJVDmX
	 /V5XO6QHjbLx9dDXUHYK6wlxnIuag3xhqXu0bJWF0VERbKu5/kj8siN6jFNkhPXV51AOD
	 rNFjQc3RqNj4olYKHro0BOl/79Jf6ePzgy6pemUf9FduvPiaBSrX7AM9skItAzj/+oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dwTpyXHg;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9E606A320
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 07:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CF9E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dwTpyXHg
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso1023636a12.2
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 00:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793085054; x=1793689854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UZgXNRDybz+RvZYxWwkDSCBQ8npDe221Cmrr41lYgfE=;
        b=dwTpyXHgcPq55Jo8hHsHeCxQi8/0JH6WIUhkZAVGAfcvAAy4lXod4LbUZAeLWZKhpr
         CDQvUVVRgJp4mrVD8UDXPZOYPzr8QZ6VabWm97VICNo0Qao6b0475hC1H6lyZhfR6nbu
         htu1Q/cR0lO7SbypgUy7XhvKqoy9wWEghGymAZLfL4hOo6Esj+QxvI4jMNw6tbVALqcD
         uR9qd8i7ZB2cZgnX7QjYzumlgcktqToy2h+AJT9aeOX170Hwav356qYdV+ggmYoPTBUr
         riBaWtck/seUkEaM3yXW4wjBRUZNWa5qYiyy5XQpW0Kiw69pNm3trGd+8RyGJdrwpveO
         VJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793085054; x=1793689854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZgXNRDybz+RvZYxWwkDSCBQ8npDe221Cmrr41lYgfE=;
        b=SfDx2Ne/DG6KJmbI2Gzr1wF5mZZjcMWV/g2scACSxtdmmy0vMkD+/US0SnT6NMLxnM
         hSoT/tqRC4tGO7BZFfY7FPNB+9pG/qtZZhK2n2NLBV9S89+eMsjkViQsy91/UflAGDs7
         psK76ER/Xg/q/zW7j2SINzU2mh+h1MDx2Vpo2CJR5FEatY4UdTKz48r2adB6QNHHiB0K
         Z+sQV63fLb6ctwy18Q1KLKANt6q0Gj0Ib/9zSgvXHTA9mg4KXV1wQkpXHjpZXN3FLEkD
         BDgEtxnlKFdipoOYZL3tBfXeCnJOBjot7akZnIBqLhLk7Q2c5qqLtZR/6m/IjnsW4RTD
         +qQw==
X-Forwarded-Encrypted: i=1; AKwUvBzBCBAofnGIFpZlbSd3JgfTTTGLs/OeQ3JXyVd9n5Y+Ez2wvPwnMztYqKfNXw4JbArLNho=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlkxbYQhMZAHfehgJjbHkVNWcmA/lkKw/LVpfEoOF/itaYLePI
	vJKnREqBrojd9gNcSQKaQdtIdIE8OGCFdJJZdXHqiOGnjamMqc5Awcnv
X-Gm-Gg: AYBFou3TkijRUrhAkaySbyK9ZHrG1n4VbwPa+kJjePL1B1jplfvJTP6NtXtRlLN/LwU
	fkahZHtXSlUu60unpxsHQ0G7sXzzCV75sH5oouM+t2+VIE7B+awE+1/Vijec/nC9LTS8uaJyns5
	PQqup+9Qi9YavtBtOr4CDGJXYra4R/E5agB7Q3hUnD3qWbJAPcSnONPPEAiNJILYcAGqBAqY5o6
	gnzmH+gufSnkvcomDBvTZRBxEju1pmXvMpuRPKGTU7jZaQtzHNfw+t/2kD5KBPe+O2wIj7Ah+/9
	30zTEtdebOK15RPdNSxShXUvh2goqKZvdpLmxE9ugY/Ot1DJM2g6QdT+QxGSx0gWCDyJcpD3wj2
	zy1OCoqiBNdiAWcrfyLifxYHYd1u4bGZT7bRx0dH4OzVBtwZa+YZe2fNLMiXEod2AktQg9CpXLk
	oVnqlovoZG1sn8ok4qeKmAR4WbDuJwmKH8tvuwnAr+3h3zm+cxWC+NnwF7Ih7ZzG419UQg07PWL
	mA1WXB437sWPxZ+Up71oKgD3VkdXMGqoo7yk6H8o5QQ/Mj0loavGGAVfYHPTE4OfZYBSnHaRg==
X-Received: by 2002:a17:90b:518d:b0:3a8:cc4f:3475 with SMTP id 98e67ed59e1d1-3adeafd6b5amr7936297a91.60.1793085054120;
        Tue, 27 Oct 2026 00:10:54 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21274sm2277512a12.8.2026.10.27.00.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:10:53 -0700 (PDT)
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
Subject: [PATCH v2 06/10] rcu-tasks: Validate callback arguments
Date: Tue, 27 Oct 2026 15:09:19 +0800
Message-ID: <20261027070923.3054462-7-kunwu.chan@gmail.com>
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

Check callback-head alignment and reject NULL callback
functions in the generic RCU Tasks callback registration path.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/tasks.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fcac7361ec51..5d7f234795b4 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -351,6 +351,13 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	bool needwake;
 	struct rcu_tasks_percpu *rtpcp;
 
+	/* Misaligned rcu_head! */
+	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
+
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
 	rhp->next = NULL;
 	rhp->func = func;
 	local_irq_save(flags);
-- 
2.43.0

