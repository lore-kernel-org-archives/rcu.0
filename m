Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951999;
	b=ZMfHNUrFQczcO5eyFSg64vcQY2VOQOvHMp0vGPpaYpHaEjJ0X2ryHgTCCGqBJOTVia5O
	 Qm8LtrId20fLC/tP++G9au6J9r7KGqFvq1ZOc79CAjnAHQVR1gnTqSERJeip7pBe8jEt2
	 MjOsZ97NwwTf+O1riAl400Ea/nCyJfgnju0eBv9Nsn8rl4+2uLuV+6VKnQu+yk6+EIeyR
	 Z6miZPvfw6FwP49DGr7K8zWHQE7dtaAghd+cuUHyj3vQKNHFoFWbjkSG37GznWKt1yW2j
	 w5e3yCaYdKgGW/vqu8Bdrf4NTbHbRxNKgH/APW39Piqt8xIIRmr/XI7CtUTAuBm8g7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951999;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qdnMAlZZHT0XekQPrSCiPCqqcTykoSAZA6qRfBxzlM4=;
	b=WpUpevKzmuyLxnmXQ2SwoSFCqraOs6GagIM9CFOeLRrwKdcEmQHz/a1LScIQpAtkqwQC
	 ikrGSE+fN77Cf0AVP2IrI1+1+kyB3zxxhEEG9fGYjOs255r+tBUyrSADHKPojzpWI0VIL
	 gaxv+wdBUfLchUxUdZpz5DYdjp6yUmb7HWTPNR8J66ugJlkS3W1GGh5TRVNSqqOKAVaG7
	 +ZatS5Xi+/gV0A0+WYZrv8Ui3knuBvW2Q1yH1rA8ZkPB2EJD61aHKsWRxrduov0Kr3ZTi
	 mgl1MS51OoMZtfiaZco/3G6SsEXgzLcIXvfHTrk4y7oFX/5+FdEaF1a2oqk80+YzSfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="lf/nuMDL";
	arc=none smtp.remote-ip=95.215.58.26
Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F5606D806
	for <rcu@vger.kernel.org>; Fri,  6 Nov 2026 07:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D72F5606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lf/nuMDL
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kjWEZaRnpbQPyxgJ4wJyDqlnc6ape3Q8i+3y7DTnhuw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793951996; v=1; x=1794556796;
 b=lf/nuMDLhdHEGz7N/90PMi8Zhq1R4O7Q2gfomdmMKV/p5eAr+mABjvFH92eWmk72Gn5lMgdh
 Ox+q1+gqywov5PzBo/b+f8XRdS9W8X7HsJgSjmpRrcxI4IYM2AV+MD79M+vD2jB8mqbJTvips8n
 fS9+wRImgSdkEeHpoaq3OA+s=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8a365bbfc61020ef;
	Fri, 06 Nov 2026 07:59:56 +0000
X-Mizu-Trace-ID: 8a365bbfc61020ef
X-Migadu-Flow: FLOW_OUT
Date: Fri, 6 Nov 2026 15:59:45 +0800
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry@kernel.org>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, vbabka@kernel.org, 
	urezki@gmail.com, paulmck@kernel.org, qiang.zhang@linux.dev, 
	akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH 1/2] mm/slab: restore the rcutree. prefix of the
 kvfree_rcu parameters
Message-ID: <au2IvrBEimc68XVl@fedora>
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
 <auIRU802S4Z4yAmo@thinkstation>
 <auiedkWD41Ok95TT@thinkstation>
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
In-Reply-To: <auiedkWD41Ok95TT@thinkstation>

On Mon, Nov 02, 2026 at 02:33:43PM +0000, Harry Yoo wrote:
> I adjusted my feedback. End result:
> 
> mm/slab: restore the rcutree. prefix of the kvfree_rcu parameters
> 
> The move of kvfree_rcu() to mm/slab_common.c dropped the "rcutree."
> MODULE_PARAM_PREFIX, so rcu_min_cached_objs and
> rcu_delay_page_cache_fill_msec became slab_common.* and the documented
> rcutree.* names are silently ignored.  Restore the prefix; the
> slab_common.* names, never documented, stop working.
> 
> Fixes: bbe658d65802 ("mm/slab: Move kvfree_rcu() into SLAB")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
> Link: https://patch.msgid.link/20261028134647.3176080-1-zhanxusheng1024@gmail.com
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
