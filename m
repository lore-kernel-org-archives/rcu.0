Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89904268C45;
	Fri, 14 Feb 2025 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557694; cv=none; b=YJpH5uSgC3Exn2jMh53foLm7wP6qscAh4CQtumTEvhiP+DxGNF2Fanx3N+y9ZdXvvtKrL6g/snKHsnndxSSBwR4Ee+zvvGjBYKRpogK0ZFAuj0xdX+uYNYHQRz5ET+/PKXif6yfIZn6tGzbyAc1isS6pjqhnyv1dSvJoMD0AFPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557694; c=relaxed/simple;
	bh=tsQoV1mQsqNq6InM3wdlxDCaycM+dXDK7QEIVPJAyVo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SzyW5xKwzi1RatinaBWswRAStnJs9LGwOyTddFm1FAOjeHAWknMzbKWpmFNDrE55WtEXDihxtUYVKbQ8iRR4NOkgMjjMz1pH/CGM4T1kPyNQCTlpeJUZotfeAAXdHNMAUFT4LdBBtcJtMbusS0xzlyWztHrhRxqlpAiavIAawww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=KxzOWGoV; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="KxzOWGoV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1739557691;
	bh=tsQoV1mQsqNq6InM3wdlxDCaycM+dXDK7QEIVPJAyVo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KxzOWGoVA3Lr0vtA4YT+TzVPhfYb9BsfsHOyVp+5PPESOR3vMPic7JfF32YCtAJUx
	 nTjuVhfNs/Gh2B5SWRc+NGWWlsv58yJx7PNsPKzOQN2YTI9lglVzQ1d6cWmONjCmHQ
	 tQXqy3+Xc+RjB2zzg8hn/5bmUPApiYFbkkhLxSzY=
Received: by gentwo.org (Postfix, from userid 1003)
	id B29CE40A17; Fri, 14 Feb 2025 10:28:11 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B1984400C6;
	Fri, 14 Feb 2025 10:28:11 -0800 (PST)
Date: Fri, 14 Feb 2025 10:28:11 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Suren Baghdasaryan <surenb@google.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
    maple-tree@lists.infradead.org, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
In-Reply-To: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
Message-ID: <d731cf1b-a594-983e-90e1-9380410e38fc@gentwo.org>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 14 Feb 2025, Vlastimil Babka wrote:

> - Cheaper fast paths. For allocations, instead of local double cmpxchg,
>   after Patch 5 it's preempt_disable() and no atomic operations. Same for
>   freeing, which is normally a local double cmpxchg only for a short
>   term allocations (so the same slab is still active on the same cpu when
>   freeing the object) and a more costly locked double cmpxchg otherwise.
>   The downside is the lack of NUMA locality guarantees for the allocated
>   objects.

The local double cmpxchg is not an atomic instruction. For that it would
need a lock prefix.

The local cmpxchg is atomic vs an interrupt because the interrupt can only
occur between instructions. That is true for any processor instruction.

We use the fact that the cmpxchg does a RMV in one unbreakable
instruction to ensure that interrupts cannot do evil things to the fast path.

