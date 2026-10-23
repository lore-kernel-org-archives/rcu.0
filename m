Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750774;
	b=GxR4FwBhtB881GBt2Sv48elmO8DNwDK7FUxjL5dMGqb3DzlPf2Hv5epg/vroFsC2hOvZ
	 Q/kba7igZUp44BIJ9vwvZYV8pfycUCroFKd0N4ZFC1q/71ll8+tiZF8EzTe38nec2eE82
	 zHZK1tVtf5IHx+muh8LF8/HsujkOkUOyqwHugDpv31BJGCsQYq11tl29dPzUhMk8cL19n
	 EgqQHfEHo2S9fiHdHb0Ynnwr9XCcBwBvZs5Nv1x0JNyFGKR52D0vmwMYeD8HyiYybPMpJ
	 Ig6fFgm1sc5TZZum89rogeDUctKcqs18+tRCfTuujl3OK25S0S3q3o7/7v+VV73vuiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yhX3Co88olrCtk6/h+mWMlsE2G5ipIoGvccQ3rnpw8s=;
	b=R1U+O222RHQAuQFezPnRC/2XPV6JAm2j6ukOhNOsWkdAb2FT8b6D4/P75dXQFKKIOP++
	 ZpNL4lbfLxgdKX9uW5uzdUdQ2UygWT2z2THBTszqs/bRbx5sPobCp5lASqgtmAfKC4Ixe
	 0ElQcjxhVwVyIsiSQbySwo6jeKHQDBfJj7s5U6BvKVLlJZpKaePRj2IZo7JNi2RhAu2k9
	 CBljC0qPotaPYodLBuY5GdrKr9LAJRfY1j+Gd2aLJA5cKZUEQD3aJ0+8t4vAacFi2x4m3
	 Kmpibtif21i/zqWDb+NmS81a79yYTjTIlPG550YGmJoUjRg5KcO2gW2PSeQBuvubz0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GZX8x0Db;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3E606A31B
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 10:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EC3E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GZX8x0Db
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so1162222eec.0
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750773; x=1793355573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yhX3Co88olrCtk6/h+mWMlsE2G5ipIoGvccQ3rnpw8s=;
        b=GZX8x0DbuuImQ+h9JY2az4ttqUG7P94WHhMPGOovjKHFjT9smkGC/RTsLbASVqRW3q
         Qxrr/SzzGGr3lcN97RG5QOsm1W+9s3/Zsl/cc7Wp5+pg1Ju7OKE/fk1UBBf7Fhh25rli
         T27A+GX+3Oma+1oFMiEHlh2v/w07/hbDhZCVXCeGYDLoImpwQSIjeibKQXf/AuG23dzj
         c6JpLu8R0w/XxzEl3daWVCdrmOhBU+ylRtuN6+rTskq7zftYLIkMGsGp48WwV0ScGMM4
         UIgi1N5uH8lsT+rBYZ5YhupAQ0uqW7v1+1LIXnanJ9uf7b54Atb83uONYJeAjgJYZThb
         M0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750773; x=1793355573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yhX3Co88olrCtk6/h+mWMlsE2G5ipIoGvccQ3rnpw8s=;
        b=jeLL9JpglPm5bls1dOEjtS60sExIA4gla/J0iC+8WqRfMWK3RYItSt5ejeUkQQfSJF
         FWUcqm90SUrSWcegNN2szoPLpoN7I9qpopG7MA1MW/7nzdupnkl7+n5HVu3+j3r6HcPK
         hFD3NlTyKkt5n18MEKKV9okgOPuQ3GQfHsV5TKcZN+0U5u+nWJ81zMai/S6KoIvq/azr
         4uSLEP0OZZ2KVq3tNNhpmWRAWUkqcQCiwXo3snUYXt4/6KGfnHmeg8WGy6Lwptu3o6Kj
         Yr6wqPgrMlMZM+46+Nuhd71wyLTTpCMr7EFe0oqCbsgoHBPxB3QpEMgz7MYn60z0U6Bk
         IZ6Q==
X-Forwarded-Encrypted: i=1; AKwUvBx+LHNveuoA8AnalP2BqATPrFvNe+N8gcNvjv59Ixzgzr4YuIAYRWRj+2/F0XMqkhG7c+g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUdgufZZzBW3kZVx0iCCZ0ulPn6yo3M8SqggD0S8X3oSzexFWI
	6SYQHpEBHKE9LZEaCR/KIjN6UcuTGF92fupQE5vWdq18VwQf4X6Pg3FQ
X-Gm-Gg: AYBFou1zgvSeO4W0iC8L5JYuvDpgattcoTv642dQCPN8CJWSC6yB9ZFUNcxHB/oGhoF
	Ssr51W/qRtNiu6BJ40dOV0JQM8+TTgK3Bc5rzFISAJcMkBXIrbWK8mdBXIK6B3KFi6nk4R80KeJ
	jLnGazjafL+le45V8mA8nboXGjY+AT38Otr+aL/EMA2cN4s2MeiHLeLzmSQF0zJ/DxSDvLVqcc5
	iilJ7aH5LzggoF+KoLgUY8Epjn23Uxnx6AGwKJNR3gjZIOUD30V6eeR6us3uBVW9hQt/XVvt8I7
	/f+TpoPNO6d+FK5fWpjTYsDTKrEL7mpNaZsiO/eYfERBoSAOojV9YpHyhTu8KRRBCLKf087WloZ
	/7rQOPJb8GyiKVC+1nNRK1ytR1XCN3G7xaEzaXW3yb2cZ6UKtwaIF0MrT2tyxFIJi9dcaYFHCqf
	IU6qX2n4D0RuTo0gkJjXEKiYMF/JrN/l+KBkcFWgfcztHKnZtvBWPlzNjlfE8x154lNHwPrbHIz
	+ESD7CMwLMF4WTVqKbTNYflr06kV1Z2PrM34/24YYY8KjXCVyQmgjgE9hKyxKN3PN07vyioBg==
X-Received: by 2002:a05:693c:8801:20b0:35c:e696:2d4a with SMTP id 5a478bee46e88-369d9851d1amr2182117eec.24.1792750772975;
        Fri, 23 Oct 2026 03:19:32 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9deef9bsm5852176eec.22.2026.10.23.03.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:19:32 -0700 (PDT)
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
Subject: [PATCH 5/9] rcu: Validate callback arguments in Tiny RCU
Date: Fri, 23 Oct 2026 18:18:37 +0800
Message-ID: <20261023101841.2910719-6-kunwu.chan@gmail.com>
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
functions in Tiny RCU's call_rcu() path.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/tiny.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index bd22fa43108d..ef0b0474f207 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -252,6 +252,13 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	/* Misaligned rcu_head! */
+	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
+
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
 	/* Record the caller: the irq_work's stack says nothing about it. */
 	kasan_record_aux_stack(head);
 
-- 
2.43.0

