Received: from mta0.migadu.com (out-42.mta0.migadu.com [91.218.175.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D02BFC85
	for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787712999; cv=none; b=CuPh+MnjyyVmDcGVKeyuh8ieCEijFTLfB9BqXS/nHDLHhFuz9dtGfieM7foKDQdVKRfnLA0mLitr8gNMlVsk17jepk+yKrennB+wwPZLOAJ5MIRHsmSIYL6DqT3x1AJBP5fChgVEbcoiiLIdAlCl5+U/OC+W7j4mODrw5OLaGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787712999; c=relaxed/simple;
	bh=HZYjrb8/ZziX4qSQKv1N6qCU+IzCO6UVMJye9TdsnNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9n51CBVZuffxfBtQMIvgYO7DOrRSaEPksD+BpJzzlCWmOC7/KPHFtzlXSoo9fY83zrf4opx4pUyA5nW7FfMgNZ7JBvM4ii7PdrMaGp28e+9387VUH6u8JAPnZb7l42RssO9Cgb7B7vE05Vpt5hYxY45g0TnstnuheKAmX7SDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qXtSa9YS; arc=none smtp.client-ip=91.218.175.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qXtSa9YS"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HZYjrb8/ZziX4qSQKv1N6qCU+IzCO6UVMJye9TdsnNw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787712995; v=1; x=1788317795;
 b=qXtSa9YS7HTMxaA9YcQRbK8hOG1X8APePregnSzV+vWusRnQO0yEqeOS0UGMkd/cdGekTRXC
 lY+pgmmfOapO9pALU0MKlrYIZvGNmgf25Bs4PrsVvleKYPHj2uQoHM2xbRKvQ9gS5vcihjj4Ie6
 eHcqWvSziJpJLWAabdguuzpU=
X-Envelope-To: rcu@vger.kernel.org
Received: from fedora (117.129.78.49)
	by smtp.migadu.com with ESMTPS id c7d4d76eb3de895d;
	Wed, 26 Aug 2026 02:56:25 +0000
X-Mizu-Trace-ID: c7d4d76eb3de895d
X-Migadu-Flow: FLOW_OUT
Date: Wed, 26 Aug 2026 10:56:19 +0800
From: Hao Li <hao.li@linux.dev>
To: Longlong Xia <xialonglong2025@163.com>
Cc: vbabka@kernel.org, harry@kernel.org, akpm@linux-foundation.org, 
	cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, paulmck@kernel.org, 
	rcu@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>
Subject: Re: [PATCH 1/1] mm/slab_common: fix shrink budget underflow in
 kfree_rcu_shrink_scan
Message-ID: <ao5UqBL4iPh8zlpG@fedora>
References: <20260824091838.1692153-1-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824091838.1692153-1-xialonglong2025@163.com>

On Mon, Aug 24, 2026 at 05:18:38PM +0800, Longlong Xia wrote:
> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> The kfree_rcu shrinker decremented sc->nr_to_scan (unsigned long)
> and then tested the result with <= 0. When a single CPU's object
> count exceeds the remaining budget, the subtraction wraps to a large
> positive value and the <= 0 comparison, which is equivalent to == 0
> for an unsigned type, never fires again. The scan loop then iterates
> through every possible CPU instead of honouring the reclaim budget.
> 
> Reorder the logic to compare count against nr_to_scan before
> subtracting, so the loop exits as soon as the budget is met.
> 
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
> ---
>  mm/slab_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 657fd75776ea..95ddbab290d4 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -2172,11 +2172,11 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		count += drain_page_cache(krcp);
>  		kfree_rcu_monitor(&krcp->monitor_work.work);
>  
> -		sc->nr_to_scan -= count;
>  		freed += count;
>  
> -		if (sc->nr_to_scan <= 0)
> +		if (count >= sc->nr_to_scan)
>  			break;
> +		sc->nr_to_scan -= count;

thanks, this is indeed a problem.
I think we could make the code more better, for example:

1. remove `count` variable
2. add count to freed directly (also change type to unsigned)
3. check `if (freed >= sc->nr_to_scan)` then break.

How does this sound to you?

-- 
Thanks,
Hao
