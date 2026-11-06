Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975991;
	b=BTkuUjg6b0K1IMOLgazwpqvx0MEygCI0imwS26DsKPXaVRDBndUbP9nW3M+SHWjTkl7p
	 Dnq4GSm8EmTOX2cJlYU0lU0ItGomaJ5GgF/BmQftty2bPSB56BIXToG9jMst1EUjjYvCV
	 TvCgtajmkkmTXBnfcyRGS4z+M/8UeEyxKMRZZ57oO6m5T45c//4oFz2xDUiHLAIzv+4e6
	 eDS3et/cPgx89aKftU+T+ZS9PxJ8krwpGqwuD5/DjyzFoddVxFZkmg3JBRHwH73v+37yG
	 wZ/Bhhl8sgT7t4q1nHd6ZNNbzKVEaDJlJfsCeaALrwVsM87VM/ZH+o/JwVWasxiIb1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BI33hpZ4bTGQ1W8I7xzBVVJiQ5tzHH99Rr4lxg2VPLo=;
	b=Lzr8Nd8m6dgjiOnq9IsyA7Z184R0fXYrRE4pbCx7YwgMc9U+s2U6Dvd8Jv0/vdP1tx0t
	 tZa4cioGPQ1hjbWFMjOBtmUvcW4L3X8Y6XRJ+bUqSJPlxy2TL+WGq8sxtXBk56g+CPguI
	 MroVqVWPobt7/rO9yOamJBmEhH9dSri31doG8Bhe0xL+0IsAzPvfmYSD0Vw90sGcUdNN/
	 gbX7pDBtNunrjP0bx3hR8N234Bi7iiul58tcbo+g7FkPoN+4hiDNEptGEVDRM98VyiKg4
	 KA3pDDDRMzSkyhi8N4enojYezBQ05XBNOj27vfSkHzodd4K/iMHUDvFNoRUE/V66NBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=twwGumpt;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE012606D802
	for <rcu@vger.kernel.org>; Fri,  6 Nov 2026 14:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE012606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=twwGumpt
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36f6295304dso700554eec.1
        for <rcu@vger.kernel.org>; Fri, 06 Nov 2026 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793975990; x=1794580790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BI33hpZ4bTGQ1W8I7xzBVVJiQ5tzHH99Rr4lxg2VPLo=;
        b=twwGumptiUj+ts/FuaqNnYTr+NPXEw5sOxF6f9nrRTPc/wqS4egEvAKRCphUMpdeWC
         bs2UWZ9GvrjOFVqCwDsp60sE3wrpWlpopHjA+pcvTrxDFKr34DPfhwGfhA0RW8NNN1AR
         91GFIVr9B2f4/9yypPZ7h7bw6j04IQ7s1hrAANgg6uE2S7yKxgY5XFDGt97y0oH/zEKE
         pdevGtxFgqxrufgfROsu2ft1oOG/7iV530NvsEtrp9ZWQHlDWe4/5d4E9Zf12fY0GEB6
         pmFlXNcph7eB8c4zM+PT1fUea7Nh6kY/qpotnUUYEa9Ra0dn0K9Z05je7LhIBlVPvO00
         neKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975990; x=1794580790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BI33hpZ4bTGQ1W8I7xzBVVJiQ5tzHH99Rr4lxg2VPLo=;
        b=UIcZ6KiR+oZ/nIxQeXtxb5hXAHXrsXdYknhURyBqiftID8ePqggbdUwNWr2kgZUuhn
         cYLDrmtrZ0dc32LAqv1C2fkpDfP9ec7ut1MOPuoQHBbEWYM/m/h5H3z/hVEBpC1mGaB5
         A1r8z5azkfoH6HVPu4v/YfS8KsgNkDtWbdsl7kI4IX4qFEt6QeMm7hcOzJ4ikmPMaiMo
         HU5YuFJf6J90cvuo3vU19hfj8IMunwajQX7J3PRMSNtVXj23WZatrqZd93Jc1mUOIAgl
         KGIM4q39B009C1Ur0Q2HLPjUizmx4bRrJzGFIhbX/onwkK4bKWp66QqF4X6CK0swdwMP
         JWTg==
X-Forwarded-Encrypted: i=1; AL+hErFi8qn3OvKSOyVah7ipc8u2HPYW02WrFdFN8fSl1pt7H41LmzpbGtBsVJJpjTygFa1oaC0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YtNDEkZFn8WzuWVHvCjU/3MZtDibqLxbn8mgVlYo49CVMHU3Z
	CEDu1OuCoUIgftN82IfMIwzh+eezWTZqHHhguTnYzhNGtoP6HZ8py80A
X-Gm-Gg: AYBFou3/ERtpLBxPhzQrWUUaNC3ADce7s+nz7bRO1Zpl7146tBDbrnVidNNPH1/2R1L
	+z8qrEyhA7HkvMC03/H1kKt/tvHTlLuZfnc/g+bVJY+Jt+gVS20Ppd+qyYL1/r3X5dKMi2EUNKc
	X0uTO6/BdQKviUrBmRDB7GVc+S0tCFpqXPSCC/9MJSp3jFn5hjW8SfYaCPXjvyn8uAFmRszxUGw
	JoBcxgynzMtMPrtPiuJqNNvqpTJwM3xoDJaeeemDabY8SAzH0PX71CFqOWsCXEaAnEGn0SesDoz
	kaym1H+pPo+GU0dlwYrCFvsO+fIAMi293QDcwFu9UmYibumVqfy15ZLi+J/MPcXKVqP+lAZnWLR
	poS+X6vrFBGABfq5I2F9zbf1nBdR5a1p3OH3Ey/beqLU+72I1h3Z3V1qnMFfiOz/tZE7dKQ2XVg
	4raY1aZHnAKihadS5G4xbYMfmNmVqoMPaCU8jSpQ3mldbxHY3Ue32kD4Tl+PyyxPwQkZ53y3vRa
	0zX8wN3cI1BvDSv8UQXVhwmRJfexCZymh6HBODnJ1veCj5GgZUIFelu6rkx/gdZTEcoKTxarF+t
	B+OKqFiOZE3khcui+ncsB9aU1ng3IGIHEi3+QAE=
X-Received: by 2002:a05:7301:d196:b0:36f:be1f:1191 with SMTP id 5a478bee46e88-36fbe1f11efmr2995180eec.29.1793975989305;
        Fri, 06 Nov 2026 06:39:49 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm7182068eec.26.2026.11.06.06.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:39:48 -0800 (PST)
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
Subject: [PATCH 2/5] rcutorture: Test duplicate call_rcu_tasks() callback enqueue
Date: Fri,  6 Nov 2026 22:39:10 +0800
Message-ID: <20261106143913.3627722-3-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106143913.3627722-1-kunwu.chan@gmail.com>
References: <20261106143913.3627722-1-kunwu.chan@gmail.com>
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

The rcu_test_debug_objects() function double-enqueues an rcu_head
to test debug-objects duplicate-callback detection, but only for
torture types whose ->debug_objects field is set.  This commit
therefore sets ->debug_objects for the "tasks" torture type so
that call_rcu_tasks()'s duplicate-callback detection is tested.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 968343be4e0d..a056a79aa3d2 100644
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

