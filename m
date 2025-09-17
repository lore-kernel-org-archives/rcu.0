Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4442ABA45;
	Wed, 17 Sep 2025 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108973; cv=none; b=ePy+pEhd5XZ5+sTqsJxqu0AY7qYpUNQYitxDHX52WbzpR3vbhuIkJEwwEWHPGNUul7bu7MOK1PqZVsu4mQO13rJcl0QYmqITDNKj5eOsDVeWzlrXZ4EIY2BaIBgnfZtTRgp4ZsyOH0ZSBNRu1Jn6bzkRWL3YzFzBP9BxhIpx5KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108973; c=relaxed/simple;
	bh=NwEiTfpgf+XTMOx0qaKYlHuyF0sM6sOxEUWxLoQPSSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP3nEXtujmTD1SwPp9hEKi+CqIVCbIiMOnrXRKQbd5rf8urRsuRrT99rbK1J4p9d5vXMrV4r4OYsTcFh8hofe+sylj8HjejWp4Cekz90cMxuRRNMPfavmsvx6av38qXtMWzJknTiBT5KW23sQrrE3S5AJaOlVsbAb2eNORSEvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SV9r/9JX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SV9r/9JX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2138C4CEF0;
	Wed, 17 Sep 2025 11:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758108972;
	bh=NwEiTfpgf+XTMOx0qaKYlHuyF0sM6sOxEUWxLoQPSSA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SV9r/9JXKIcmnOEZMb51WiDXHCOhHj+aXNaj2OPTpFJO2xs+tVmBeZ13GVmBJG4HY
	 pYOPZQcL5ByXlhy9Ck3vCF3DjE6HbEDubm1VfpGdaHn/7P/bYRPm0y2m5oy+HwuO3w
	 suJ0Pfc2QadTM0xkTUuji1xz5ThlJelyR8rjnQu9vhCYeHSPKwiG17nCVR2VUFxUNj
	 omw1y/kq02xlQyU5VECjXEGwaG/XdwXYya9npYizCi6k8DJ6mKUAOuipL5Dnn4QuUV
	 Ts7drRnN0RtxIG6icTkn/3hWdKGyjJiESLomoQEK+xiT9nt3ZvJgEvRxYT2wB6b6Dp
	 jgq2ng2Rv6cwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2222ECE0836; Wed, 17 Sep 2025 04:36:12 -0700 (PDT)
Date: Wed, 17 Sep 2025 04:36:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Uladzislau Rezki <urezki@gmail.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <8e7055a9-f899-4aad-8ed7-6543077c05d1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>
 <aMpxnACqmsQl-lp0@hyeyoo>
 <bbda8c25-b575-4e98-b1ae-b103c6598d38@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbda8c25-b575-4e98-b1ae-b103c6598d38@suse.cz>

On Wed, Sep 17, 2025 at 11:55:10AM +0200, Vlastimil Babka wrote:
> On 9/17/25 10:30, Harry Yoo wrote:
> > On Wed, Sep 10, 2025 at 10:01:06AM +0200, Vlastimil Babka wrote:
> >> +/* needed for kvfree_rcu_barrier() */
> >> +void flush_all_rcu_sheaves()
> >> +{
> >> +	struct slub_percpu_sheaves *pcs;
> >> +	struct slub_flush_work *sfw;
> >> +	struct kmem_cache *s;
> >> +	bool flushed = false;
> >> +	unsigned int cpu;
> >> +
> >> +	cpus_read_lock();
> >> +	mutex_lock(&slab_mutex);
> >> +
> >> +	list_for_each_entry(s, &slab_caches, list) {
> >> +		if (!s->cpu_sheaves)
> >> +			continue;
> >> +
> >> +		mutex_lock(&flush_lock);
> >> +
> >> +		for_each_online_cpu(cpu) {
> >> +			sfw = &per_cpu(slub_flush, cpu);
> >> +			pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
> >> +
> >> +			if (!pcs->rcu_free || !pcs->rcu_free->size) {
> > 
> > Is the compiler allowed to compile this to read pcs->rcu_free twice?
> > Something like:
> > 
> > flush_all_rcu_sheaves()			__kfree_rcu_sheaf()
> > 
> > pcs->rcu_free != NULL
> > 					pcs->rcu_free = NULL
> > pcs->rcu_free == NULL
> > /* NULL-pointer-deref */
> > pcs->rcu_free->size
> 
> Good point, I'll remove the size check and simply pcs->rcu_free non-null
> means we flush.
> 
> >> +				sfw->skip = true;
> >> +				continue;
> >> +			}
> >>
> >> +			INIT_WORK(&sfw->work, flush_rcu_sheaf);
> >> +			sfw->skip = false;
> >> +			sfw->s = s;
> >> +			queue_work_on(cpu, flushwq, &sfw->work);
> >> +			flushed = true;
> >> +		}
> >> +
> >> +		for_each_online_cpu(cpu) {
> >> +			sfw = &per_cpu(slub_flush, cpu);
> >> +			if (sfw->skip)
> >> +				continue;
> >> +			flush_work(&sfw->work);
> >> +		}
> >> +
> >> +		mutex_unlock(&flush_lock);
> >> +	}
> >> +
> >> +	mutex_unlock(&slab_mutex);
> >> +	cpus_read_unlock();
> >> +
> >> +	if (flushed)
> >> +		rcu_barrier();
> > 
> > I think we need to call rcu_barrier() even if flushed == false?
> > 
> > Maybe a kvfree_rcu()'d object was already waiting for the rcu callback to
> > be processed before flush_all_rcu_sheaves() is called, and
> > in flush_all_rcu_sheaves() we skipped all (cache, cpu) pairs,
> > so flushed == false but the rcu callback isn't processed yet
> > by the end of the function?
> > 
> > That sounds like a very unlikely to happen in a realistic scenario,
> > but still possible...
> 
> Yes also good point, will flush unconditionally.
> 
> Maybe in __kfree_rcu_sheaf() I should also move the call_rcu(...) before
> local_unlock(). So we don't end up seeing a NULL pcs->rcu_free in
> flush_all_rcu_sheaves() because __kfree_rcu_sheaf() already set it to NULL,
> but didn't yet do the call_rcu() as it got preempted after local_unlock().
> 
> But then rcu_barrier() itself probably won't mean we make sure such cpus
> finished the local_locked section, if we didn't queue work on them. So maybe
> we need synchronize_rcu()?

Do you need both rcu_barrier() and synchronize_rcu(), maybe along with
kvfree_rcu_barrier() as well?  It would not be hard to make such a thing,
using workqueues or some such.  Not sure what the API should look like,
especially should people want other RCU flavors to get into the act
as well.

							Thanx, Paul
