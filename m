Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750780;
	b=4xARIDeTCFAjFFiHYsvi+ZY3hbIb2RvIjztVmjIeHVJFpfYiUyvRHwFED/PqiXQCd0UR
	 c1TVb+UEAKKTdIgKRe6YPbfJeSbKUxnRN2BsV345SpYNHQMYNc9NcxWMeQblnevwQNkoU
	 V6ncdMul1Yg67bkROKJQCHaB7ZuZId/r1pX9E+YQw9Y4avTwqYA1e0/HidZwmtBx7oXrD
	 6NkSCdMQf1zZenLGOQQt0er+SnKKKF6Oi752UdR+b7EviWsv0hRI3F8+tOTQcmAgUhI3Y
	 2v8zHv0//mT7rLp7DUoWYspJc3FJyFFc+/Qxoa6IFQIcqJ2FyxbfgI08bE75yv2AneA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=18cHTa8MQcXYDKpSR+x3BmukqRMz/yqNYKnCpHUnqLM=;
	b=pamcEeODWA8nIz5U0hUGaA4yQbnYuxgZm7O2w8S6R28oTu6FVF/l0i+vjZtKVkVPwPrA
	 vItZUFJq5z2S5iz+6gQsdvC9a2GYp9jXydIf0XE21gbcxkOqe5UORk//YJcTevUFEUQoP
	 P9Q9C1oAkmsn2L8oHIpFRjHrHiUCW9G6CP3oo2GX3L88Im3ETdqTDcR3MqKFjyrjzAjJO
	 +MB2fAPFvumSAWO0uLarfEWhVXyQe8owucQZ+Mk6V6Nt4Se5RPmIcJDtnlEbhdhTk+xYE
	 fnmrdzLMTVBVQ4auFE2VDbEv4FK0+xbpQMezY6f+uD/JG0JzM8tQr1Sqzzd/cvZ7iHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eo+8UNaz;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC5606A31A
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 10:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49BC5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eo+8UNaz
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35d0be18c71so1962550eec.1
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750779; x=1793355579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=18cHTa8MQcXYDKpSR+x3BmukqRMz/yqNYKnCpHUnqLM=;
        b=eo+8UNazy+U7YGHuO/DhJ3EJN06y0fja3DIF25mCX//xIaTOy7Mxqi6tGEq6BQbtRM
         iqZwJTsn6g309omuZzGTKsaaMJw7hBo0ga0TlKqmQ4qsQPexw1n0Gwlx9sx9X5z8FAm6
         1HRK1LFZjX0xufhpsMG4iAquTZgmaNzt4QKpVq4EdsGBNEl3KgCu/lSWiZvW7oovXQ4V
         ibD4OgoPFacLa4xFbZRLT0MEHtNNwLgqbeecZrgD7S9o951z+zcuzFDkTryJRp+1gGps
         OtoljZHVQrQcdIgUXHEnMUAyprnraWTZqaReN6hVzEg/lBVq82dRCDiFxgx1RqMdsURm
         PQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750779; x=1793355579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=18cHTa8MQcXYDKpSR+x3BmukqRMz/yqNYKnCpHUnqLM=;
        b=VZGgfh6huWu8LPmCbGZzyrbi5QvlIzS/iwxg5TiH0j3dzf3nraG2S8XYlDmGcc5gj0
         C2eNdUpDBPLqlf/90AChSUyundPCdOmfiS81dZWAUtZKm3x6ok9LNyJyIhyr8LmyJJgd
         AHtmphvuMdMpuOotoIkt1wTAwmW8La204WZ17yw/oY/kj6AUWGpqgacQXh34hXQFAA5D
         CS5wOlSOd1Vqjm9lxybMYjADmm5k05vvV3bcQU0xx6OucsJClkKDdI1HTBPS0gJigP9n
         GcyE2aIrErVYWonodbyJt1hwMt7vA6kaLz6VvNj8cI/3aC6eCk02tmtL2xbjDm5aIZWI
         MsFA==
X-Forwarded-Encrypted: i=1; AKwUvBz/4GkrtdurN4m1O38J9s4tD3Dw3c7N02INXQdDMyL6m3T2wY+v5HH8FzUPgefb2nZ+iio=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVu9DjYjCZZZ2ZbI2TwKpoSbGzMXFR+DJOq6MnhfxwfObNN5bG
	VYDmW4Rgerclqd40QUtpBnVrl7AAW9X1lb8eQGouI0x1zQIbm9XnE0qa
X-Gm-Gg: AYBFou3RkiDYmIvLtezu2ivxXxgoAbxxCiMb2H7a6YyX4BK8iATCeSqRPTfTagYkLof
	wLV7DJ7OaaTbNDvQvW7MsmqEH04Oi4YtiqZSxMcWU7os7qvg1xhzHJ6qcNcYxp/9TeiC7Mmt6RC
	bHzQ9J/+N0iu4suV/KopemuV2woR/ndidykrHXU0AcFqw+LRW3LwcaPir4vaOU5sxXKWxQMnOZB
	fXaR+ioPrZV8ziZI9YdI7DpOnYbv2tBSTdPrD80Gb04+4dQw47gpwuS7hpssmQG1yXiRh9r2o/q
	48t79X8OyP/GAUy+CEBPYbRsIelE16Ghl7k+zeGLtwg1ooFaOVU7ITobV6XMT/qhBfMjnz351OW
	U0eI5UP70uFIjp7QlpnA0PGxNySWTux/gk6NaaKYno6ItVM6uXYpjEl5WF7aLDiLR98G9qyZ7qf
	2wnrA4WwayQoMtLEi5/DAWkV4CMYJ93K+oBSfcEK1bBT6aAzH4f5E2OGOvQqq7SfJzhiyf3z9cJ
	hIy2qJT5oigWapdSlLFj35R1tPP0o8bFiAH2a3GJ6i+sO3ZkmhLhBZUCQWk8h0fNReaWVY6mQ==
X-Received: by 2002:a05:7300:ce13:b0:364:377c:cabe with SMTP id 5a478bee46e88-368b122d304mr5653362eec.24.1792750779241;
        Fri, 23 Oct 2026 03:19:39 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9deef9bsm5852176eec.22.2026.10.23.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:19:38 -0700 (PDT)
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
Subject: [PATCH 6/9] rcu-tasks: Validate callback arguments
Date: Fri, 23 Oct 2026 18:18:38 +0800
Message-ID: <20261023101841.2910719-7-kunwu.chan@gmail.com>
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

Check callback-head alignment and reject NULL callback
functions in the generic RCU Tasks callback registration path.

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

