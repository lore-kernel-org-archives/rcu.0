Received: from mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F9391E5B
	for <rcu@vger.kernel.org>; Wed, 14 Oct 2026 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948704; cv=none; b=WyM2NE1SEbPqDT7hwSeSKJDggADV6cv3jBoCmIAyF4oPGgjuU0ED94gECWq+VbtsCxSMb2yGoiPD1XCFqxAJAXz47wll3GqaBFj7l3b0301Q3BIJj36EJksXdYXdcnSMtTrVRcBrXskNmK5VEpLnZYycvcLNzqZvNoD/bPSSIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948704; c=relaxed/simple;
	bh=7nLeFA/bAdRYnvnosyy/9MVUz4nRvM/yvpEd+4hsF5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lxgjx8zdd/lbiy8uy48xcCxYCrjz+daW+oaEdvFNxBTm1ST+CKVLiSW63hqll0ifTjiLiC84Ucs7TF5Ogb7LXivSulvFpIyIKdu18lfBehn0Hn7113XhaFlbn/sAXeIS8wYPrX+pV6F7W8n8FHerjrHsG9bunpMuH0QjsKVB/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dqsuMLWK; arc=none smtp.client-ip=91.218.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dqsuMLWK"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7nLeFA/bAdRYnvnosyy/9MVUz4nRvM/yvpEd+4hsF5Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791948699; v=1; x=1792553499;
 b=dqsuMLWKV1Bh36Oi/Q9HJSIYL5K0M/MnheGi/uUI2/s0Bf4viMF6g/31p69WzwuggTpixiRu
 UAyFCQaPzJoyFTsso3Kl4Ppe1FBLNTMB7dBaTEQJKs/z5lh5hbAL+Z4Eyk11EGxlzPFvNDlkgCV
 aVLaF3xR2ntQ7nkVPQEk7Q00=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a6e6d0226f5ae1d2;
	Wed, 14 Oct 2026 03:31:38 +0000
X-Mizu-Trace-ID: a6e6d0226f5ae1d2
X-Migadu-Flow: FLOW_OUT
Message-ID: <a64f6a98-de70-4004-aac0-312cb05aaf92@linux.dev>
Date: Wed, 14 Oct 2026 11:31:29 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm/mglru: cache the last memcg node, make tail
 insertion constant time
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <20261012205447.2717801-1-max.kellermann@ionos.com>
 <20261012205447.2717801-4-max.kellermann@ionos.com>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20261012205447.2717801-4-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/2026 4:54 AM, Max Kellermann wrote:
> Rotating or onlining a memcg currently uses hlist_nulls_add_tail_rcu()
> which walks the destination bin to find its tail while holding
> `memcg_lru.lock` with interrupts disabled.  With thousands of cgroups,
> this takes a long time and causes severe lock contention.
> 
> Cache a pointer to each bin's last node, making tail insertion O(1).
> This requires remembering the bin number (but the new struct field
> occupies a hole, so it does not grow).
> 
> In a micro benchmark that creates 1500 cgroups and repeatedly writes
> `1024M swappiness=0` to `memory.reclaim` in 8 threads, the request
> rate increases by a factor of 9.5 and the average duration of each
> write request is reduced by 89%.
> 
> All writes return EAGAIN in both runs; the benchmark measures the cost
> of reclaim attempts that cannot meet their requested target, not
> reclaimed throughput.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   include/linux/mmzone.h |  4 ++++
>   mm/vmscan.c            | 24 +++++++++++++++++++++---
>   2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 94f9c3ff5416..9c1c1f153d1f 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -586,6 +586,8 @@ struct lru_gen_folio {
>   	u8 gen;
>   	/* the list segment this lru_gen_folio belongs to */
>   	u8 seg;
> +	/* the memcg bin, protected by memcg_lru.lock */
> +	u8 bin;
>   	/* per-node lru_gen_folio list for global reclaim */
>   	struct hlist_nulls_node list;
>   };
> @@ -683,6 +685,8 @@ struct lru_gen_memcg {
>   	unsigned long nr_memcgs[MEMCG_NR_GENS];
>   	/* per-node lru_gen_folio list for global reclaim */
>   	struct hlist_nulls_head	fifo[MEMCG_NR_GENS][MEMCG_NR_BINS];
> +	/* last entry in each bin, or NULL if empty */
> +	struct hlist_nulls_node *tail[MEMCG_NR_GENS][MEMCG_NR_BINS];
>   	/* protects the above */
>   	spinlock_t lock;
>   };
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 3d4bc12cf18e..69976df5d537 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4384,21 +4384,37 @@ static void lru_gen_add_memcg(struct lru_gen_memcg *memcg_lru,
>   			      int gen, int bin, bool at_head)
>   {
>   	struct hlist_nulls_head *head = &memcg_lru->fifo[gen][bin];
> +	struct hlist_nulls_node *last = memcg_lru->tail[gen][bin];
>   
>   	lockdep_assert_held(&memcg_lru->lock);
>   
> -	if (at_head)
> +	lrugen->bin = bin;
> +
> +	if (at_head || !last)
>   		hlist_nulls_add_head_rcu(&lrugen->list, head);
>   	else
> -		hlist_nulls_add_tail_rcu(&lrugen->list, head);
> +		hlist_nulls_add_behind_rcu(&lrugen->list, last);
> +
> +	if (!at_head || !last)
> +		memcg_lru->tail[gen][bin] = &lrugen->list;
>   }
>   
>   static void lru_gen_del_memcg(struct lru_gen_memcg *memcg_lru,
>   			      struct lru_gen_folio *lrugen,
>   			      int gen)
>   {
> +	const int bin = lrugen->bin;
> +	struct hlist_nulls_head *head = &memcg_lru->fifo[gen][bin];
> +
>   	lockdep_assert_held(&memcg_lru->lock);
>   
> +	/* pprev points to head->first for the only entry, otherwise prev->next. */
> +	if (memcg_lru->tail[gen][bin] == &lrugen->list)
> +		memcg_lru->tail[gen][bin] = lrugen->list.pprev == &head->first
> +			? NULL
> +			: container_of(lrugen->list.pprev, struct hlist_nulls_node, next);
> +
> +	/* Keep next intact for readers that still hold this entry. */
>   	hlist_nulls_del_init_rcu(&lrugen->list);
>   }
>   
> @@ -5883,8 +5899,10 @@ void lru_gen_init_pgdat(struct pglist_data *pgdat)
>   	spin_lock_init(&pgdat->memcg_lru.lock);
>   
>   	for (i = 0; i < MEMCG_NR_GENS; i++) {
> -		for (j = 0; j < MEMCG_NR_BINS; j++)
> +		for (j = 0; j < MEMCG_NR_BINS; j++) {
>   			INIT_HLIST_NULLS_HEAD(&pgdat->memcg_lru.fifo[i][j], i);
> +			pgdat->memcg_lru.tail[i][j] = NULL;
> +		}
>   	}
>   }
>   

Hi Max,

I've also submitted an RFC patch that addresses this issue.

https://lore.kernel.org/all/20251119083722.1365680-1-chenridong@huaweicloud.com/

-- 
Best regards
Ridong

