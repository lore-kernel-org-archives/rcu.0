Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2A3BFE44;
	Mon,  7 Sep 2026 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770184; cv=none; b=k4iaE1/6TuD8XqI/8VaUGh4yOoGATR++32BoCkeOsXqHEWcqL4TsmwdlXm3SrVzApfSM3wGyGJmhGpDYLnbJp3C/qqz+J/erc64Tmud/cCYDde5P5B/1beJkQP0TiaEIbCx+itBJP0QjdAc+nenMQyJca8jgLeHxHhrEEpdamFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770184; c=relaxed/simple;
	bh=uMTvUCwc59sZReO8eeICFfbvfT5nEs56k9BYkw2vJjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJlWmp0pkrNOmJXl/Msef9zazOyeTzleqBap+x+EKSWhju7Wc3KE63UwaRjAQyBziseiH0Ep19JuaFpsVD1Ucp9SYudHeHubsg6FKM5vUMMrgCmMzuse/GjRKtQOXRvPutBOE1YjWIRPBFJdJ13x43LbMYV+HWpAURIlFtxP19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt1YvAUg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt1YvAUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC8F1F00A3D;
	Mon,  7 Sep 2026 08:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788770183;
	bh=nSKYKv9+IpmrXK+SaXRNeOF2fLG9l/6KPt7ur+clwx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dt1YvAUg6NQDSEDvgG9mbQNggE1DpbwJYzMW4bcdlZql+uP+sMxqkUWIYAXsCyIq5
	 coopp1kNdFyVaxSNXMEYuqQdamxoZARBxr6/t2IIpNcq7WwRE/IdJAYLPCVwlAJaWH
	 tA5XXCdJgaMjyMpblDZk2E8jRfJIlW4C3XdTPPmivDkJqXxdgp1VDXYfAUR4AvdZ/g
	 HNsX23T6/YieZlixieteuyT8T5FyobPtxs21tLst44lvW5pzaO1hrglEyJ5O9AFNG8
	 q/mvBXkYa3rmnye/abn6dOoOlhqDPg3K7lRJlgZIbKtr/PzWNIFK6M9D4REDm265Pf
	 ALtpygYtu6h/Q==
Date: Mon, 7 Sep 2026 09:36:07 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	SJ Park <sj@kernel.org>, peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, 
	rostedt@goodmis.org, jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, 
	tglx@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
	gnoack3000@gmail.com, rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, tony.luck@intel.com, 
	reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, pavel@kernel.org, lance.yang@linux.dev, mhiramat@kernel.org, 
	pmladek@suse.com, longman@redhat.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, dietmar.eggemann@arm.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/8] mm/ksm: convert process iterator to
 for_each_process_rculock
Message-ID: <ap53cJ9c4oN1wQao@gremlin>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-4-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-4-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:29PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process() loop in mm/ksm.c with for_each_process_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
>
> No functional change.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: SJ Park <sj@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> Changes in v2:
>   - Rename *_rcu to *_rculock
>  mm/ksm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 49d48d1e0998..69d30e80a090 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -3280,8 +3280,7 @@ void collect_procs_ksm(const struct folio *folio, const struct page *page,
>  		struct anon_vma *av = rmap_item->anon_vma;
>
>  		anon_vma_lock_read(av);
> -		rcu_read_lock();
> -		for_each_process(tsk) {
> +		for_each_process_rculock(tsk) {
>  			struct anon_vma_chain *vmac;
>  			const unsigned long addr = rmap_item->address & PAGE_MASK;
>  			const unsigned long index = rmap_item->linear_page_index;
> @@ -3298,7 +3297,6 @@ void collect_procs_ksm(const struct folio *folio, const struct page *page,
>  				}
>  			}
>  		}
> -		rcu_read_unlock();
>  		anon_vma_unlock_read(av);
>  	}
>  }
> --
> 2.25.1
>

--
Cheers, Lorenzo
