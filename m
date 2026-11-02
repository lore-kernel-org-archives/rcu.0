Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629687;
	b=wZFzUD5h54dQ/u/3qzUdYS1DMkibvAmvTXhjyakjTBMfmso5ZswoqFXgT67sVgKpmOrY
	 uOa8+PhR7+naHvnIst3ebNRrJ38ijhbtaWuEZ9UK7+KE8j7Oxl3bzkQBCFR8zVmjwhBLA
	 r1LZGt0vVHGH5A5MEx1oWj1OIVj0xKPbRxve+XdeSXbHQWapIbvX0McsBNwS1VAatgQK0
	 gATiZklXR7HKfSKmkcBtANIzvrQ0RwPUNOzE1IopUKilEJ6C3FhSm/1oZ61+NQFXGxbx5
	 apLoJwwvv4Pg7jPdHuI/EIUo3/u7QsnbzDln3Y1UXakFZM/6PeRtm4/pDBwcBmAP32Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629687;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SmlPnk2wIc+2RmsDQ6+3x1hdmOJyfBWq+EeZH9+2Pdo=;
	b=BuQ2/xd8s64rBXCxxLMxdZCgxtmmAQH/yLHUOM8I7rDK+DZlNYOxt1ugZ4UFDsj9E9gM
	 gbDE0/puQTwD3+mfxE0TEOhJGL38K1Rt4g9Hna6GxypjyVXOHrWLae4JiZQuVOlUwFD6k
	 Gt24Vg4BivCQtds/q5XBwzABnNxXC5jqlF64gbWeOuLuwC2cL8/oUUtrPl3geGYg1ZQfE
	 dxn+E03Q8YyP+ZZKHbt0ZIIvLLwG/19AM0txpVwMtL5x13+yo2SipFnmy/TIbX0HWY8aQ
	 rNd534h71tYFsL4O9DAA4YqobQNQOJZM8pI5it98hWtLIoBu7WVWU0IxRFRKrBxgKrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozsxDQ7T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EC607F6EC;
	Mon,  2 Nov 2026 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozsxDQ7T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF001F00A18;
	Mon,  2 Nov 2026 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629687;
	bh=SmlPnk2wIc+2RmsDQ6+3x1hdmOJyfBWq+EeZH9+2Pdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ozsxDQ7TFt8FaRNdBHVg8EK9LBcs52tCdGEamZhy9C8FSY3O9WZlcUgYYOBn0CLsm
	 2xNWL2Dlvr/tzOxorcjPR/2qoAvHVKNijWST3EBsJSIQtvTQU0Ds5Vag7FTYz8JQDl
	 hOcyyW6CrW9t++ywa6HB+EJm6hgJs8HPJXg3CEi2kgM/u+SEJfG7YAt9BYD4Vm5afr
	 eJ2eYCOQiOVdPjmYOEu99/tG++7WJTCKNObBYH9RCd8wjA+vMTsXLbA1K+D/hYt7px
	 dRuclJCvEm02PM1Iev0r4Tbp1aCaNqj/OwSukfQe7UfhGJmtHI+hvoLS5RHJrYm/po
	 tN6IIpLwU5nDQ==
From: "Harry Yoo (Meta)" <harry@kernel.org>
To: vbabka@kernel.org,
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: kernel-team@meta.com,
	urezki@gmail.com,
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
Subject: Re: [PATCH 1/2] mm/slab: restore the rcutree. prefix of the kvfree_rcu parameters
Date: Mon,  2 Nov 2026 14:27:57 +0000
Message-ID: <179362967059.3922839.8161883636909403176.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 21:46:46 +0800, Zhan Xusheng wrote:
> The move of kvfree_rcu() to mm/slab_common.c dropped the "rcutree."
> MODULE_PARAM_PREFIX, so rcu_min_cached_objs and
> rcu_delay_page_cache_fill_msec became slab_common.* and the documented
> rcutree.* names are silently ignored.  Restore the prefix; the
> slab_common.* names, never documented, stop working.
> 
> 
> [...]

Applied to mm/slab.git slab/for-next-fixes, thanks!

[1/2] mm/slab: restore the rcutree. prefix of the kvfree_rcu parameters
      commit: e6316aa3c7aec549e3ab017a9c49fca52194fd4a
[2/2] mm/slab: don't queue the page cache work under krcp->lock
      commit: 03a176b9248c4513bb705ed3d931af3a7e9c2a08

-- 
Cheers,
Harry / Hyeonggon

