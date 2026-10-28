Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195215;
	b=spO42nZ20KMqUCih4bJOuIcHbGnuyeCNe1LC4ahcI7vU9auZhc12Oyh3S2+XS2COdAMD
	 YjtqT+yBueXzeYzJgZEG/PoK1r2JgxnmqYdQg7heb3p13C+iE/QlPdvtMGwWST3bHuFUi
	 w/fjhFNfXB2BnqzRxvrRP1Z4aCIHINE7q0an6paeyK/pHi93O8WBq3LaLTnKX7sP4xHZS
	 XDtc3RSkuox1lr+hX1iesUysBqpwSTK51kyanC3Ye2GF5/EFnTinITP1vlOSBARZr6jB9
	 3rpNHkkSjxeV7YOdTNdWexYmLzwECR4rGcb8v0Gtgpy6M0aASRIO+p6VAZLRb0IVTFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gKFUBdSy6v7/SpB0ZQpz0JziViW1zO3RHjALuxOoURI=;
	b=DE1g1dTl5jwg2YGLNyYELdpwHao0u+dtIOowo9JQ+vXTFtSIWo9jsH5QkX5wj2sLEZQX
	 AemGKM09FXnzZMRR0tH8cPCOaSH/g6S3klAAmwnlhiRbO8eUN9Wuze0e+clstFI3kqyji
	 z2kus+GdvD53oLCX5EQ7AHNuu1R7NGH9f52e2v69kkaV3Ah82QYbRlhtgyae4aSL9BqSj
	 mAHTvH4Q1ieGztwtS6C2AaYOAZ91ce65UgPLY/T/o+zBYk8/V9gga3xPW9Yi2US3W5Vpl
	 Yo6blPbpRDFIh0Ks63RYol2la5+SjrJRVJT82krSMgYP6QGnM+rgCSJWMUBnfELyzqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ySZ8Gku6;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE9606A31C
	for <rcu@vger.kernel.org>; Wed, 28 Oct 2026 13:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BFE9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ySZ8Gku6
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so632463a91.1
        for <rcu@vger.kernel.org>; Wed, 28 Oct 2026 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793195215; x=1793800015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gKFUBdSy6v7/SpB0ZQpz0JziViW1zO3RHjALuxOoURI=;
        b=ySZ8Gku6JZsRKF/ZXOTFrtFCgptbD8XVG9rj3ueJGlb80x03uOkIGq5aO6M8NPj0BP
         yNlRhvBVMUFYF9fOTLx3i7OBp6RKuOrNgyoEhgU0GoigGfRiLJ1VlCqwHiKpna3NaSLu
         7WAxhtQK0psi264P5RMsP0WtgLDYQ7Za0pOPIgnjb1kxdO500dbIPHcWiJlBUUSliShp
         UGAlYc46JxL7/Y7Vi8M/Q5lcP4MRYX49/X+EPVOGuPPPMo5lldfAIHB98BHSkOb11WWa
         rLuBVh7PoyKZFAP2mRfdWeU3rv/GqYaWMpL23fi7phQKaECo147WvY0RMKx6gTKXvMbE
         38rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793195215; x=1793800015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKFUBdSy6v7/SpB0ZQpz0JziViW1zO3RHjALuxOoURI=;
        b=SwB1HBaqV6IlI+l2BiTnTO+PD79qBf/SlzCI3YY6SLmWZSfnki3bTiwENYhp0sZfdQ
         ppBk7WKmDW93dUo0VpaQI5wg8agV1M3e+6KBpq9KvjP7tOXZBJwOp/M/mqrsCTuB42fU
         bou9IsO1uJ2Mo7mMya34n/fivNMmmV5jWi9o6uvpdAeu+VEFGLslfWZqQB6j2ZPN4RfI
         +FOqXcuzA5zslMsPNWcsps6yJuGsq0Y9D7VlEgb6uVpGOYk2fev56AhjEJiRb3u/z4pw
         DsUwy0IoQWcD9OSCITVgfmqpr9w62xy3QyOiVd/8q4s6UWL7/wmc8aBxjDEWVxsH1JDd
         XYeA==
X-Forwarded-Encrypted: i=1; AKwUvByKjXQI4Wg18Z0p2vUykMxDhssSQV34oGbqct7MtUxfKkhMwLXqUQFFTYHsvOhdD4HF4iY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL57PKzbv807z/JymLx1JFwEM3qj8N7d4c/JyiSL/uX+tDTOP9v
	02Md1F3KKVO9tzeYWKaoWdDzdp8IyvWjuUYKp9uGypsBbC83sXlMx6XS1+n1VQ==
X-Gm-Gg: AYBFou008OEHMZRTWgw7YOfoe+qhRgBtCYIu+bTHfaLciLiTfyTiVeMWI2rsmXOF98v
	TWfHebc8gzcCZg5Eer0EadZZuIkBDlUgKJZhWzHzKmCDjlhQexUDYA0ezghflthNeXsKuHjICIi
	fqB1dGgmxGyz40ECw65Bh7NtjHaa13+F4tIlqizRlAh1OWO+WXMfMBtMnJVH102wdzA9lY3GWlt
	1iNYuq5zpvDgWd0sUp5scjWOzEXoJJI1dVkoy6LCKEoBF4Pra7kmBffi2jTouZfwRGvgXS+rkuV
	41Uyugw/KcZcc5qaikXIIyqgolmFkKDVtJNSUZXtZlc2jjOCBxB3UaH358l0m+5eULiwBq/FGiV
	VTrMSJNO9SrhfVci2zdJn/YTkhMeiviAOIFZhCrxKQzpGK8Y24Uf9lnP4t9yIPNnnNVqAZslm9r
	6yzFslum4g8SU8qjaq2NVdRFSAAY4hr/YdHW2112vXIjkRgZFICrdN7Cl6aMwYYDXvbeXKKYTqO
	1UXCe5HNh5mLuoGy4S+Y5R/cxj9ihh+zaGpf+KMoNz528tthg04vm62LsBQhKQ/E0ghzy+6nqOL
	WmFOJ+W5NufQiOSkUKI54jkL8hRpcqxMl13ljyO5vbTIRw==
X-Received: by 2002:a17:90b:4ccc:b0:3a4:9a7a:360 with SMTP id 98e67ed59e1d1-3ae58100a06mr1891992a91.29.1793195214929;
        Wed, 28 Oct 2026 06:46:54 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ca1bb2sm22014585ad.68.2026.10.28.06.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:46:54 -0700 (PDT)
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
Subject: [PATCH 1/2] mm/slab: restore the rcutree. prefix of the kvfree_rcu parameters
Date: Wed, 28 Oct 2026 21:46:46 +0800
Message-ID: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
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
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 mm/slab_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 01c64ef661e7..3729aa7a6156 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1373,6 +1373,10 @@ void __init kvfree_rcu_init(void)
  * per-CPU. Object size is equal to one page. This value
  * can be changed at boot time.
  */
+/* These used to be rcutree parameters; keep their documented names. */
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "rcutree."
+
 static int rcu_min_cached_objs = 5;
 module_param(rcu_min_cached_objs, int, 0444);
 

base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
-- 
2.43.0

