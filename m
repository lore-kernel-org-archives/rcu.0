Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78C62E36F7;
	Fri, 18 Jul 2025 03:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752808909; cv=none; b=IZ7KaVRmMdKeeEQIS9xL3Hb1rn1OW3JVa2QYkJmDekZ9H9fhjEuu27j1tFFKIJN9A5uBRUjbdGwJV5E/UKlDh1faQBgvDSb5GZfChvjECm4dpC2JWwr2LaVyER6Y3mftcptLODhQEga5fhK0GY4lOvng7C7T08d1/26fy4I2cag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752808909; c=relaxed/simple;
	bh=b2fD2BgLJEesI7wAkvlo1CATxqClIgP1m/8XnzokmrE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r13xkIznx3IqX2BQUBjiitgXpi3ZGSIJVn12VJBIuEz4w0hXpW6XSkZCRgr25aMA8xjbE4ANEheLluL4Mo/0FyqxBcbzfjBnK/6Nd64xvqP4U3nNG2Vn3CY7IUnDfa61F4PR7ITCmWWNtUn/ForpnGoAzrG7oopE1KtwuBaVsBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jlNW1CGI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jlNW1CGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEADC4CEE3;
	Fri, 18 Jul 2025 03:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752808908;
	bh=b2fD2BgLJEesI7wAkvlo1CATxqClIgP1m/8XnzokmrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jlNW1CGIaibg8DSdi2tsfY+SrzOqS4pUiDUhamKUUFtNSOUILmVESWfDTNGEiEcit
	 jPxHcPHUT96CedlGF/3+jpPVlLbKR7xLPfMgz7Z0JxkTxZ0EvPcb1D1MsF1YihXovC
	 ou/ufVwEmgitX0yudX6RwAqpy8sVaogA2/8KsTVE=
Date: Thu, 17 Jul 2025 20:21:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, Davidlohr Bueso
 <dave@stgolabs.net>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett
 <josh@joshtriplett.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau
 Rezki <urezki@gmail.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Zi Yan
 <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, Nhat Pham
 <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Chris Li
 <chrisl@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org
Subject: Re: [PATCH] mm: Replace (20 - PAGE_SHIFT) with common macros for
 pages<->MB conversion
Message-Id: <20250717202146.0b9b8f59eae21da8529af559@linux-foundation.org>
In-Reply-To: <20250718024134.1304745-1-ye.liu@linux.dev>
References: <20250718024134.1304745-1-ye.liu@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 10:41:32 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace repeated (20 - PAGE_SHIFT) calculations with standard macros:
> - MB_TO_PAGES(mb)    converts MB to page count
> - PAGES_TO_MB(pages) converts pages to MB
> 
> No functional change.
> 
> ...
>
> +/*
> + * Convert between pages and MB
> + * 20 is the shift for 1MB (2^20 = 1MB)
> + * PAGE_SHIFT is the shift for page size (e.g., 12 for 4KB pages)
> + * So (20 - PAGE_SHIFT) converts between pages and MB
> + */
> +#define PAGES_TO_MB(pages) ((pages) >> (20 - PAGE_SHIFT))
> +#define MB_TO_PAGES(mb)    ((mb) << (20 - PAGE_SHIFT))
> +
>  #ifdef CONFIG_SYSCTL
>  extern int sysctl_legacy_va_layout;
>  #else
>
> ...
>
> @@ -796,7 +796,7 @@ kfree_scale_thread(void *arg)
>  		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
>  		       (unsigned long long)(end_time - start_time), kfree_loops,
>  		       rcuscale_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
> -		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
> +		       PAGES_TO_MB(mem_begin - mem_during));
>  
>  		if (shutdown) {
>  			smp_mb(); /* Assign before wake. */

But, but, but, obscure hard-coded magic numbers are there for our job
security!

Oh well, we got caught.  Applied, thanks.
