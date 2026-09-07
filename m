Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF81469832;
	Mon,  7 Sep 2026 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779121; cv=none; b=E/dAURwvlj5BYrIvIY6T2aXiAQLwvbeBWvQhvNhTnX7/mkyoNN1yjq1/gxSmCs5j48fd1wg11oqEaxENTVYZhSmRxpAOaFad3nXNu83i2JHB5/GPHQzFBJLsakkLN2EelXt0ypMMHGv7Whg4uBbc1Qo2wTqrDjNe/90+Ar10obw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779121; c=relaxed/simple;
	bh=gAhPEThI5K+PeUzhYbnNEzwW7sHKMRTi0p//YdseykA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbS8hWF6qPNFAID/1cUDDm+nVabDTE8wBlv2WEXPGcYI9M+cu0KIPZeDSz3DGksrbVUMm+CDqPQfBQfqRACkceVWQSE2XDkRVMzLsTTRPXn6tkhF7xxg2bEpebd7hOSYP5YV/tK3Z7vNSs9e0Pc8IQ07lHdsjHibu7O89ptJyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoyOKEVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoyOKEVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716671F00A3D;
	Mon,  7 Sep 2026 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788779120;
	bh=vJW6MPhOnN8P0SEk/mBUWKuIt9Xcv/RQpni+Df40/kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PoyOKEVNRy4VXTHA+NBiLBYDZc6Sblto8Kaz7UsiOV0QrOkd+U6KphTUovSDNjhCz
	 q7m+nudOTVg3uWbyUbQ1K/0rmRM9xZxyvl43eHr+m/KaV8/+Bt+iJP1qA+qLRmwqhY
	 kfkrd57WJ4utnJF9Yh+A7rU8ghy9VxqBexyWkFemv+rw9RK9Yx+kL/BjPy8/0iVJlH
	 fxK3oXlu/CBuDfkAR/y75njkvq7DNeDTYUABFhtRrfHzBERdZHQzIwGgUnsJnZN8fb
	 r6NYrwXxiUhaMsRCpUBMelI1o26+9ocIx7No45lfOZwm841rcd19HgskuKzFteika5
	 sC5hUTUEN4gvA==
Date: Mon, 7 Sep 2026 12:05:04 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org, 
	jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, tglx@kernel.org, 
	david@kernel.org, nao.horiguchi@gmail.com, rafael@kernel.org, gnoack3000@gmail.com, 
	sj@kernel.org, rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
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
Subject: Re: [PATCH v2 4/8] mm/memory-failure: convert process iterator to
 for_each_process_rculock
Message-ID: <ap6aWlC9RoAMILb7@gremlin>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-5-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-5-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:30PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
> with for_each_process() loop in mm/memory-failure.c with
> for_each_process_rculock(), which scopes the RCU read lock to the
> loop body via scoped_guard(rcu).
>
> In collect_procs_file(), the page_pgoff() call now falls outside the
> RCU read-side critical section.  This is safe because page_pgoff()
> only reads folio->index and does not traverse any RCU-protected
> structures.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> Changes in v2:
>   - Rename *_rcu to *_rculock
>   - Clarify page_pgoff() safety outside RCU lock (SJ Park)
>  mm/memory-failure.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a8b03e2920ba..7d93deb1f7b3 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -555,8 +555,7 @@ static void collect_procs_anon(const struct folio *folio,
>  		return;
>
>  	pgoff = page_pgoff(folio, page);
> -	rcu_read_lock();
> -	for_each_process(tsk) {
> +	for_each_process_rculock(tsk) {
>  		struct vm_area_struct *vma;
>  		struct anon_vma_chain *vmac;
>  		struct task_struct *t = task_early_kill(tsk, force_early);
> @@ -572,7 +571,6 @@ static void collect_procs_anon(const struct folio *folio,
>  			add_to_kill_anon_file(t, page, vma, to_kill, addr);
>  		}
>  	}
> -	rcu_read_unlock();
>  	anon_vma_unlock_read(av);
>  }
>
> @@ -589,9 +587,8 @@ static void collect_procs_file(const struct folio *folio,
>  	pgoff_t pgoff;
>
>  	i_mmap_lock_read(mapping);
> -	rcu_read_lock();
>  	pgoff = page_pgoff(folio, page);
> -	for_each_process(tsk) {
> +	for_each_process_rculock(tsk) {
>  		struct task_struct *t = task_early_kill(tsk, force_early);
>  		unsigned long addr;
>
> @@ -611,7 +608,6 @@ static void collect_procs_file(const struct folio *folio,
>  			add_to_kill_anon_file(t, page, vma, to_kill, addr);
>  		}
>  	}
> -	rcu_read_unlock();
>  	i_mmap_unlock_read(mapping);
>  }
>
> @@ -635,8 +631,7 @@ static void collect_procs_fsdax(const struct page *page,
>  	struct task_struct *tsk;
>
>  	i_mmap_lock_read(mapping);
> -	rcu_read_lock();
> -	for_each_process(tsk) {
> +	for_each_process_rculock(tsk) {
>  		struct task_struct *t = tsk;
>
>  		/*
> @@ -653,7 +648,6 @@ static void collect_procs_fsdax(const struct page *page,
>  				add_to_kill_fsdax(t, page, vma, to_kill, pgoff);
>  		}
>  	}
> -	rcu_read_unlock();
>  	i_mmap_unlock_read(mapping);
>  }
>  #endif /* CONFIG_FS_DAX */
> @@ -2288,8 +2282,7 @@ static void collect_procs_pfn(struct pfn_address_space *pfn_space,
>  	struct address_space *mapping = pfn_space->mapping;
>
>  	i_mmap_lock_read(mapping);
> -	rcu_read_lock();
> -	for_each_process(tsk) {
> +	for_each_process_rculock(tsk) {
>  		struct task_struct *t = tsk;
>
>  		t = task_early_kill(tsk, true);
> @@ -2303,7 +2296,6 @@ static void collect_procs_pfn(struct pfn_address_space *pfn_space,
>  				add_to_kill_pgoff(t, vma, to_kill, pgoff);
>  		}
>  	}
> -	rcu_read_unlock();
>  	i_mmap_unlock_read(mapping);
>  }
>
> --
> 2.25.1
>

--
Cheers, Lorenzo
