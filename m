Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163835;
	b=ZoZZbVO32ehQNvrMwyQBy3ywPKZPlTbfo8F6oMpo4FtaXW1A2YOADXL0yuhSw3wEE7JR
	 Yav1bJ9x/KT21ntw7yyvWMqsd1+bj5fyrTj0iJO/eDlQPrUkxKyOwlkzKKRm6vcSXfLF9
	 ZTX5gs41OUXpaxh7S7HjSNAR8cvCuV4kccReNCMujov64wPpJ9RTr4HNYjLFMDc01K8JI
	 Ey2Ev3OBYMTuitNGX+ZfM0hpdpD6lQxFu8x4DCmWOB+4ayP9vc37V9bYp212GWuBLkNTy
	 EjWIY6zNEE1zhtQdjPkdZu85IsRarD/1mwecen8b8gTzEweMo11xF+ya9H7KlKjklSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZCyEGFLuMrF8ud7Iy/GAi36dvb9TvTE7pQNBco9ToNs=;
	b=BRRFjEaWK9YAjP2e3GAo2BYrY1zuY7yMu0IwF/MSaCZMZgUqfWLk8FuWG+2PUqPf98Fy
	 udbAgKU2RS3jEo2SRzRUQbOYyypmo0GogmXtzAx10q9w79/wmwVK423/9rKZtCXl1QyVW
	 UOS0sEs/zPKtojpNzcrscI9Kc6pR0ZKUdPwIXK+94m9/o7lanjFtaHQtvST9/BZJNLK0k
	 hqXOZC0ECmFT5Kpb/D/8Ha5lkL6no3DxPaF2V6keRWqU+bBDHCjRgB7/J279j+y/Zg+PH
	 UNzkoYRTrIK2HJ5GhYtsfgToD6ShqdI/1z3obBZdu0KG5/cXep8O3bD+4FjgO6vYwTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPGgjm8d;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED68606A326
	for <rcu@vger.kernel.org>; Fri, 20 Nov 2026 08:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ED68606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPGgjm8d
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdb9f760337so997772a12.0
        for <rcu@vger.kernel.org>; Fri, 20 Nov 2026 00:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795163834; x=1795768634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZCyEGFLuMrF8ud7Iy/GAi36dvb9TvTE7pQNBco9ToNs=;
        b=tPGgjm8dHvqkhvM6qaWX27QGfhfch+yhwN+RmPTN25HBRzCfLyqMVAQWFxpyoa4mtJ
         bSfnf0bo7bGgXmOVnaXbm6JbJLCd2G/RgTMtPCBO71hgU8rQ3a4sGT0p9cTIPVQmEyGa
         SA1TWTAAZ6YAbzS8RDhjPmfDnSd3BG2Y+Pw/oMGUa+4k73ZnQqXgYYYfAVEENUa3rwEy
         pqPSDGPlcOceSwKE0cTtVhJdxsPQX47V4vbKH4BJUHf8UJBa1QmRmljkZrTlJHFTxyw8
         g7YsmMnuthmIvMKgBLuW8yMludgCDcLLXbeUNnIY/cje4YvgaW4oMhSDm+/DSxn9pA7D
         pp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163834; x=1795768634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZCyEGFLuMrF8ud7Iy/GAi36dvb9TvTE7pQNBco9ToNs=;
        b=GtwHLw6nGo84KIoK45MTt+2ntoETSzaim+IX7xFWMUrnnZEJtTvqqlLQOWLNjtfvXt
         6kOyiiV9XB9vWHl8MkyAA2qwvZf/k2jNeG+hcWv9Pois726wAwqZFYXBg/IxtHZONLwB
         5L3S2K4cN/1AtZF/kGhFxoJCIp9Y9S8HedZw5qre7f+npBg4GmJAoXxu8o0IUAr7x5e7
         Q2naoSrwPuZt36UciKXJwn4/T/jjLpHhjJFgoMfdGn6hxk0KdeYanEwhXcxkDD0ZLsCO
         CL4XXTPtZnZocFAPidsvp2Zxbui9GVeB6ZRhUoQDg3k4HQWlYl3/sSLOU6viHvW59Ns2
         ATnw==
X-Forwarded-Encrypted: i=1; AL+hErFsjF6tssxtbPhafYWnX5g9cZAjN61zEVbD8Ghkj/Q388M0wcfUwNG33G38SX4zt95SnMU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rmSAhwOjnvErDG4kT9DAfYX+/TufVx7ln8um2QCVjsqaSbISS
	CyqAHEZYnEg3JLTwQpPoSckegVdcdcprRbYFhf1hG5NTL8in/h56zd+S
X-Gm-Gg: AZFdTZeBriRGYqIyBGLIKdm9Vtn/xRfNsFMEX49uBUv3Jnd8t4rWfaRpu4e/RTvhWaV
	Al2eiDeymzHByrvepOq3sCUlIy9WuCNi4szY93mNeL6nHDW2SIRcsjYdAGvC3nkGu4PUlGrIO0Z
	NrcVx/zS3VqppUhyh5/WaZZoVRftmyz+Z19V3tmcTes2o6ooWghZL2m6EQOxIUxVMjLL9lL3boT
	/mFGOvwqUomrPJMUMiYKyMV0IxknQNcBNfYss0foD14w6xh1XnhCTG2zMyatWLpMptU4SAhjKkD
	L4aqB5bYejhJLo5oDfJovZ740Ha9kt2wWuK9sreodroP188G97Ig41A2y0eOFIkg134yT6MSHoM
	6/iPlmCm4J2CBZNTctOGRJyOYrZjTviqUyx22TPheimoC6P2OxTw75/dNybL3NdLw1cTPACtJyP
	NBfDiIw9xbaEdmQbjnOarbjse5a69/uo+dE1lwjtcJtjPTIb7Uipa5nx8feYgCBuaXYJZ7Jd7QZ
	wbekEbS8BsWmsB49OpV4OWFgtrXGjd4eqf8jgr+9ljIpuWmJlBZi8jeQlMXaqxmZNpepC22o1mE
	Q/pZe2gr69Nt+SqAEftTZ7eKi+q4nnjK9TmVXCjvfGtvjQ==
X-Received: by 2002:a17:90b:2f8c:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3b41c93fac6mr1453272a91.30.1795163834405;
        Fri, 20 Nov 2026 00:37:14 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm3590057a91.5.2026.11.20.00.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:37:13 -0800 (PST)
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
Subject: [PATCH v2 1/2] mm/slab: restore the rcutree. prefix of the kvfree_rcu parameters
Date: Fri, 20 Nov 2026 16:37:06 +0800
Message-ID: <20261120083707.296481-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The move of kvfree_rcu() to mm/slab_common.c dropped the "rcutree."
MODULE_PARAM_PREFIX, so rcu_min_cached_objs and
rcu_delay_page_cache_fill_msec became slab_common.* and the documented
rcutree.* names are silently ignored.  Restore the prefix; the
slab_common.* names, never documented, stop working.

Fixes: bbe658d65802 ("mm/slab: Move kvfree_rcu() into SLAB")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Hao Li <hao.li@linux.dev>
---
v2: as in slab/for-next-fixes.

 mm/slab_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 01c64ef661e7..41dea01a8c1f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1367,6 +1367,10 @@ void __init kvfree_rcu_init(void)
 
 #else /* CONFIG_KVFREE_RCU_BATCHED */
 
+/* Keep the prefix inherited from RCU */
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "rcutree."
+
 /*
  * This rcu parameter is runtime-read-only. It reflects
  * a minimum allowed number of objects which can be cached

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

