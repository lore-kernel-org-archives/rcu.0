Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298522E54A3
	for <rcu@vger.kernel.org>; Thu, 23 Apr 2026 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908218; cv=none; b=tZWQ6hrQ3fHqgUyWfaa6BA0Ef4vHjWseJfq34B5EY+aYBYj+jvSkln5IuPTfd6m1WhmXRssGLKokliQJa1dFRtU9szF+B2HPQIdMAwXMJm5k2tDOzLsoD4d4WlHwazIkqqOSQAj6O9BbP3XNmNUK5P7tu50TQN/6CdVpUjIgI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908218; c=relaxed/simple;
	bh=5ophnTHEismmvQWNDghkIVI1SEYQ74JbW+R8huYXPOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFkDer0M9HxRjeGLH33uIzTNrGCZqlKVrKVwaOQ/8cZaTOSGozRKOmakfwxHKSE2rSu0FfSL6McEY4N9QdUmX2zJtFpJsOJmZCXOxFnyZxtPaPiRgHSjSP6plJ9DjBMW8dh7tvmzkmCh7f2K+6jtPLJNLnzbHDoJX5/g1FBmnAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpBZ9xFo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpBZ9xFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCC0C19425;
	Thu, 23 Apr 2026 01:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776908217;
	bh=5ophnTHEismmvQWNDghkIVI1SEYQ74JbW+R8huYXPOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpBZ9xFo4lrMYIv2dAKyfjTO3L6bLC2iCu3G7ON2vbR0UXNKVfoEANFwoO8wK6jYj
	 dHfzZHBRKqFJfJiqqbQj1qm9E4c/TT37ZYF1hTGWv1Dsv3CZ9lud5na2bzE+w4QSRc
	 zljvenWVB3/E4Dre38b3Dl9/sSfu/zN3nSjLMFLAMGfrHosVkymFJTJ8GMS4Lq0uL0
	 Q7Flq6XNN59TPudpqGyVBUBK6TdeGqyOuKiThb5HDSXdJxnQb3aDupwW0NOAncpptZ
	 RflO7D+IGXpmneLUwhs0WLQsV/ZIRe0lch1K9DNHfAjngAaN8DSJFdyazTBjTn4jLe
	 sx/hSs2pqSFjQ==
Date: Thu, 23 Apr 2026 10:36:55 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/8] mm/slab: introduce k[v]free_rcu() with struct rcu_ptr
Message-ID: <ael3t-hiRrJEPyIi@hyeyoo>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-2-harry@kernel.org>
 <baa235a3-59c4-420e-8f1e-40c8526f3bf2@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa235a3-59c4-420e-8f1e-40c8526f3bf2@kernel.org>

On Wed, Apr 22, 2026 at 04:41:19PM +0200, Vlastimil Babka (SUSE) wrote:
> On 4/16/26 11:10, Harry Yoo (Oracle) wrote:
> > @@ -1523,18 +1522,34 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
> >  }
> >  
> >  static void
> > -kvfree_rcu_list(struct rcu_head *head)
> > +kvfree_rcu_list(struct rcu_ptr *head)
> >  {
> > -	struct rcu_head *next;
> > +	struct rcu_ptr *next;
> >  
> >  	for (; head; head = next) {
> > -		void *ptr = (void *) head->func;
> > -		unsigned long offset = (void *) head - ptr;
> > +		void *ptr;
> > +		unsigned long offset;
> > +		struct slab *slab;
> >  
> > +		if (is_vmalloc_addr(head)) {
> > +			ptr = (void *)PAGE_ALIGN_DOWN((unsigned long)head);
> > +		} else {
> > +			slab = virt_to_slab(head);
> > +			if (!slab)
> > +				ptr = (void *)PAGE_ALIGN_DOWN((unsigned long)head);
> > +			else if (is_kfence_address(head))
> > +				ptr = kfence_object_start(head);
> > +			else
> > +				ptr = nearest_obj(slab->slab_cache, slab, head);
> > +		}
> 
> It seems a bit wasteful to do this... (especially the virt_to_slab()) part.
> 
> > +
> > +		offset = (void *)head - ptr;
> >  		next = head->next;
> >  		debug_rcu_head_unqueue((struct rcu_head *)ptr);
> >  		rcu_lock_acquire(&rcu_callback_map);
> > -		trace_rcu_invoke_kvfree_callback("slab", head, offset);
> > +		trace_rcu_invoke_kvfree_callback("slab",
> > +						(struct rcu_head *)head,
> > +						offset);
> >  
> >  		kvfree(ptr);
> 
> ... and then throw it all away and let kvfree(ptr) do it again. So maybe we
> could then call something more internal and specific based on the result of
> the above.

Good point, will do.

-- 
Cheers,
Harry / Hyeonggon
