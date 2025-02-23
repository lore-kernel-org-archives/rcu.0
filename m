Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D42CA52;
	Sun, 23 Feb 2025 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740269990; cv=none; b=Ve0tsXXPDPewAgDrS6Z9p+vkCNfuLnRRwM/JwUHSFgBHWDfEeJaGr8mwzoCpOBpVwuJqrLr3HiDtIjCooxnWNOazb5fIwAn+8sV1J7GCdQGJCGcdnqcaoezw9hs9B0kbq6dWb8hyqzc4vpmPb9XhNo0iLux6elTrJ+PhCpifpPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740269990; c=relaxed/simple;
	bh=ttpei0CTJwf9mFqTMoTLWxmzKFMlrjTM6z1mU+GejGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQFnjhcnz3pM2uO4DddMFT7vBcz8QBIqHJsStcPhOWZMeQk743mByE/qRyuyxJOv2BhHQoR0a7D76EyhSLJ8W1kP+yPp3dKR0fqKkpTI8/sOefp524ErVDY6jGI9iJBI7EHqj5Q0u7svtCX05NtTtKzeWLSq5cEj/KPOw7JIEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bCAlKTiO; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bCAlKTiO"
Date: Sat, 22 Feb 2025 19:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740269985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlL2mb66tqt9VKll+fCmLoFBo/AMjLtJs7I7sdBGVFE=;
	b=bCAlKTiOsll53nHxgYXw1Hxh6MUAI6jL+TqWD0CaOcCYOl69d8KDcQs1lvFpc4ex5f79T8
	IdcoIVXNJK/jTptXsuYwyiQkeX9AR7OtOot6t4UW27NWM5FdqYglg2qFDNkqU0N9hdoL27
	B8tfPWryWXwiJGvevR7ZSnOzkav3SEA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
Message-ID: <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 14, 2025 at 05:27:36PM +0100, Vlastimil Babka wrote:
> - Cheaper fast paths. For allocations, instead of local double cmpxchg,
>   after Patch 5 it's preempt_disable() and no atomic operations. Same for
>   freeing, which is normally a local double cmpxchg only for a short
>   term allocations (so the same slab is still active on the same cpu when
>   freeing the object) and a more costly locked double cmpxchg otherwise.
>   The downside is the lack of NUMA locality guarantees for the allocated
>   objects.

Is that really cheaper than a local non locked double cmpxchg?

Especially if you now have to use pushf/popf...

> - kfree_rcu() batching and recycling. kfree_rcu() will put objects to a
>   separate percpu sheaf and only submit the whole sheaf to call_rcu()
>   when full. After the grace period, the sheaf can be used for
>   allocations, which is more efficient than freeing and reallocating
>   individual slab objects (even with the batching done by kfree_rcu()
>   implementation itself). In case only some cpus are allowed to handle rcu
>   callbacks, the sheaf can still be made available to other cpus on the
>   same node via the shared barn. The maple_node cache uses kfree_rcu() and
>   thus can benefit from this.

Have you looked at fs/bcachefs/rcu_pending.c?
