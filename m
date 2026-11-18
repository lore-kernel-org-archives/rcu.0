Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991950;
	b=mS+dcd7PhaMfVAPfb691FJFc0ELjy9KIgP+pR6NuZE331bm1/HwC5ArK7ddLUU/MoRtw
	 vKcLEvUpSTbS8CcwVFUSEhcx0Kxv47Wc8sfAtNnS1HhcMYJddiZ7bEGOlu+vdNbDZaAXj
	 XrQ03/Z8Jq+RFzOXXZWfEPTqyUWbjMIVca1UWC5xftiddw+KfYnx/VwheVXWu9kkpHuca
	 CKl6pb7W5u7RzUUD+bDXgVLskQ8OC0zr507Z8f8v2oSfqwrQiFTZQq0LH1O1Lz64sx1k6
	 8+0tiU0hD0MGg0UAszYRmpI8m9nsV/fpj7BcgU775etu0Gh0qR/qwEMYYBhrRMkcTiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K2VXvsE8Kb9V+lDeqW1cFDtziuGBumC83nZx9hEEydA=;
	b=vyfSbDh+2CCm4HAuXF/SI3WYwIMBc+YwOwoKbD1QHnuwlWd1SXcWBsaZ0SrL6bvqYrke
	 EWTOW58FBLSGcVjc9fyKzdC+3B3sDfln97RNFh+7hU8zu5vn0SGupsOdjXZT3GlvaIv8i
	 x0vHf6qUUDMbYSzqT/DNYTXn/fIJ2PK4g/9aX7VpjQBRBg0csGvYcEJXpYwa8LCai4Hc8
	 kKh2kyaZzDisggEk1dNwM/VujHHk39JJoYlBD/cnaJFQZULfsvwss/nX8aAUyO6LLF0xI
	 nG+6E9C4eSfLOtfUb466nPK/eeCrPWae1RUUQI5tJfdAWEBe3rE4okxZiTzTlJrqgEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tDy2jNQ3;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4D606A325
	for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 08:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D4D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tDy2jNQ3
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50e26763a4so94208266b.1
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 00:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794991948; x=1795596748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K2VXvsE8Kb9V+lDeqW1cFDtziuGBumC83nZx9hEEydA=;
        b=tDy2jNQ3+6CLAJF6z69RMjECpGI/Ixk+1Y3e/Tof0O6Z/b0xKNIjN8MNFLJhculQdN
         XTu0n2WIFXEfgoNYuuJE3LVR+E7sD21U+frCl+JkCWNvPuwEMRuUeyusrtpwsLPnJNUL
         /AcR+h4nth5whXbjITZUB+UtH6mPMk3AzJnQt+ViHqbtNi7C0xNqwRhhdKpr+1ckGdSG
         8gIJAeqTvaWiFk0AuYM04VVpNFjZL5rlISvoz16r63uq+rk8uMcxS4BmynBMGcpXGgOF
         /2uLdrRKLegTs8FScfC2lxs7CbwZfNsv5Hfr143eo6iSX8+Fa3JMEMBlTwlA24vPcQS0
         6VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794991948; x=1795596748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K2VXvsE8Kb9V+lDeqW1cFDtziuGBumC83nZx9hEEydA=;
        b=ifOmViL/PWy7eEwux+0i44PNGdxMcPL40mGKu7/T5p88jMjZ8vKj/QW9RTDQY38L6d
         Mq2OM7BZ4icchW3MsMzzpkv9irrrcTDMOcOeArfr9kktW7VTPL+5D9dX/ftprT92O5RL
         dZtn98lQKqoKzhqiho4vwUcsQS6dFNoq1sfb6H6awJvFDbZ5XRF7d7d2ASVRR5E6otR2
         7l7pRSEA7N9doRcWmw6ylwJF9HpWomtYm222ib0+3i58dSXHceT0kpwdN+bWmSDOt19q
         KlggRjZGunTCYO+ytWm8AOD7CAyxTrrQKT4G7V4ZL5z61YmH8374hrp5MeDKkzQmSYkv
         AzMA==
X-Forwarded-Encrypted: i=1; AL+hErH1jF1FDrADk4M5CkR9Xz7eEcFGN6UNOd0QHPEElLSPj1RiRUVkke4YQsYSuE+MfBxRyjk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xKby2pxEs6rzJWba1O5JwHrPWJ1g9uBmy6+RB9gmAQnkofBf0
	CItZ/4q0O+lDFLmf8LmaSqfQnmQ6urg5/fThDLByCLFpKnIEBZIOSj21
X-Gm-Gg: AYBFou0lhqKXuJpav0WKf6pRQ3KlCJCYDOpm3ByWZZTuo1qeQSULVkWcy5PxUWJfJ8L
	ZzVv4bCUDXIk0kanYTB5JY8Bq+jd/g9APcG3ArhZWFiALjbFPh4cz1kpDUgWw3VGiVt38scU4J/
	b5UnB3h8PTGX1eJwV5DivUX3MG1qVjfTGosl8OMk2fVdEDjlN0Awgrtt1Bo+8Ca+mT4ZqCig/C9
	RbNdlg9Cy+VeJ9il9WOGVfdVZvF+kA9ImHy4jhytqmzDk6hqkVX6SLhrx7rCMhTkzv3C2Ah0kVx
	L6Si53x2RI8anM0dLqBwKt4f2auqWpkNeX99VEyzUAecLs441h3aCWRKGbFma8Yfhvah3lpchrv
	eqmgOcciWnXfpzXdD+Oyg1P19HJlRRV+mqkaAYWgZHg7eeBOrKqkbWiK0vx75mmg+EMgS30inIs
	wXS8VPH0rowPfC/o31qfrZb/PQIs0FLGRDQdalFBNGzyqjyaQzmIr8fNF/nkU1uq9ZOoRAvLqW2
	QdXHFTU2IcO3bEab67iXYxv50ioyAprFbwHzNzw6aRITwL0rw+ZloL1BpzVHQZVqdkhocFBTAuX
	rB17PO8AOwTIccidViquq3dkbiBnKyabY4VtA2EvUrdiz8ey9PEV7TZ57Q==
X-Received: by 2002:a17:907:6eab:b0:c46:9d7b:37d with SMTP id a640c23a62f3a-c510e2a8771mr156578166b.17.1794991947373;
        Wed, 18 Nov 2026 00:52:27 -0800 (PST)
Received: from kernel.. ([191.40.25.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83f31csm71077266b.10.2026.11.18.00.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:52:27 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2 3/7] rcutorture: Test duplicate call_rcu_tasks() callback enqueue
Date: Wed, 18 Nov 2026 16:51:43 +0800
Message-ID: <20261118085147.1668598-4-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118085147.1668598-1-kunwu.chan@gmail.com>
References: <20261118085147.1668598-1-kunwu.chan@gmail.com>
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

Enable the existing duplicate-callback test for RCU Tasks by
setting ->debug_objects.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index caa550095705a..3dcc3d4318ad1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1221,6 +1221,7 @@ static struct rcu_torture_ops tasks_ops = {
 	.get_gp_data	= rcu_tasks_get_gp_data,
 	.irq_capable	= 1,
 	.slow_gps	= 1,
+	.debug_objects	= 1,
 	.name		= "tasks"
 };
 
-- 
2.43.0

