Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630026;
	b=gUWdO6wHMg26bt2qkt80gnSazlLGhYSuTOD9cqpRp27MVR8eCKMwBjrW9A7V26TX/rVF
	 Th/l0v3uDmigcyd3mylgz2Foh7peFd93NIchIOcfcMGXkMvdew6oCHR3pMbkWhh5J8hYj
	 VG4E86yiNUapP4o5iOyDluB2soZIyqQTdadmkVpUeXbHtXj3WaI1an2XJ/sT6QiFrFV8S
	 qijHNsZWabEipc4BgbwVT06KhIq8sSF1T3CJUJQgnC0n7hjmPl4M0QIwdV3bBH1VLqoQt
	 NVR6gZwZIG+Cv6ibQucFNSm3/U4i1fQBlqUa6J4CIanDrfwOHbSMimzAni0Ay8cB5bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630026;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+VBk2hdhwXO8szEGD9UTxz92a8YICR7g5qxYYzqkKWQ=;
	b=FkoDB4iYLlZjxn7awhLC46tmkC6L1lFJH/HkENvPlhPfwgncio0SLLNmeE3VEtfgByae
	 /B7Lb5h3X/DVgiTXwr7jHA2q6N1PRhLa/NhVOaIOcLedA9pk2Wp4xHY7CVlPEpZb0qWBe
	 NIqKJJPMGMRjeXr9kL/PCrclTG6txwL0b7DIeIoEq6WQpA8HKYjGs5NTuuh7GmSz0N9KO
	 4viquehm2bWtVURmX331d0gmsE0Qlv7JbYoYV9mb47yvoYPCJklOzpdQ92+Tjeqt5WDtn
	 Wy6wLZmbRXUopqwJn/B/f5CZjuCsVAuRRAKZRr2H/gr1JjwANnR4rvhYfArmOmXvXpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikXvDapO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6D606B0ED;
	Mon,  2 Nov 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikXvDapO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027CA1F00A16;
	Mon,  2 Nov 2026 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793630025;
	bh=+VBk2hdhwXO8szEGD9UTxz92a8YICR7g5qxYYzqkKWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ikXvDapO6W9ZeW/A3wJsYfsdPuZwHI3H6LV9ZWqRIupnrtTe4LG9YmSY/Znif43ww
	 MymWgELuK4BRPZtPItmDlHu3VH07iGWSR8cZdsdoUe73ORWJjxovO+MG5y3ZxL/2Bk
	 bGgv0DZikHZlbS73Ni8Knx/8lbqwvXHo+wmaVR4JJefVH7ZzTfWb3FnwxfcGPyP8Ib
	 k7v++FY/xWfD6pDfirYI1RCUrETldZuzPyVWx9HpNBDiJiIaVBw7nsG/dIqemJ3kon
	 DhR3LQyFCT0bD02xOnVW7AwrRn5aXoKyzBi852JIl8bie/9uw0nXBHNmm0PPer+m45
	 rlNCPHVOb4HqQ==
Date: Mon, 2 Nov 2026 14:33:43 +0000
From: Harry Yoo <harry@kernel.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: vbabka@kernel.org, urezki@gmail.com, paulmck@kernel.org, 
	qiang.zhang@linux.dev, akpm@linux-foundation.org, hao.li@linux.dev, cl@gentwo.org, 
	rientjes@google.com, roman.gushchin@linux.dev, linux-mm@kvack.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, zhanxusheng@xiaomi.com
Subject: Re: [PATCH 1/2] mm/slab: restore the rcutree. prefix of the
 kvfree_rcu parameters
Message-ID: <auiedkWD41Ok95TT@thinkstation>
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
 <auIRU802S4Z4yAmo@thinkstation>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auIRU802S4Z4yAmo@thinkstation>

I adjusted my feedback. End result:

mm/slab: restore the rcutree. prefix of the kvfree_rcu parameters

The move of kvfree_rcu() to mm/slab_common.c dropped the "rcutree."
MODULE_PARAM_PREFIX, so rcu_min_cached_objs and
rcu_delay_page_cache_fill_msec became slab_common.* and the documented
rcutree.* names are silently ignored.  Restore the prefix; the
slab_common.* names, never documented, stop working.

Fixes: bbe658d65802 ("mm/slab: Move kvfree_rcu() into SLAB")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Link: https://patch.msgid.link/20261028134647.3176080-1-zhanxusheng1024@gmail.com
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
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
-- 
2.54.0
