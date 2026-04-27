Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED8531F98B
	for <rcu@vger.kernel.org>; Mon, 27 Apr 2026 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302531; cv=none; b=rAfMP/Ct03lt29T04HxUfo0Yzwa1QsAfcaiNYSUZYCSLtP4SMXiZUAKx6tcsR3XGUoV0rVzLmKNpUUK0WLlhNz3aUkappe02x3LRMNG9w+xXS1/KTqDFKekHpNzct6yJ/9A9lfEKIKVOGSev397aivPUbA7RBxxWpqA7h/T65Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302531; c=relaxed/simple;
	bh=DGNTE2ObghVxBxWjipSbc5ELG8n2Tma9SvBr8kxeivk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtPMa0AvMiF0gpFippOMWrd7B+NBhe2F8JJ9ujlWMfSHsPd4boYukIP1QrxR79Y8nbV5BH2Z/BP04yTIBB9WvEOmf/jgXZUGzUqpeDRQVpxvI2gQp5Tgl+joFkH00FbeJARsY267FAJwBzzZFl696GrOX0xIPbZeJ4Fji4YJ3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uR9XjItI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uR9XjItI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE68C19425;
	Mon, 27 Apr 2026 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302531;
	bh=DGNTE2ObghVxBxWjipSbc5ELG8n2Tma9SvBr8kxeivk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uR9XjItIqVDi8Bce3rum/9uj8K9FNsIxp6xDK74Xg+XygXLaqqDTVmbBPlU04KYCE
	 lnQTeWG2aJzRkPLAJqaE1KG1fiKn+DRVpaLAS2JcwqhywMmT8xEUk6g9wXhE4gQFzI
	 oVZ3M4IcLXyZ/dg1Y/ci1u6j49nMsQPFlPhlUBfaPc2mK9SEp7ZyQHqQDz3tqwMTXT
	 gQyHKDQWPNGwg7qKmc+9LHpyb2ud6GUn7Zrboj0IAKWc9iy3U8CbbCKpHRjqVWTi7v
	 LcoC3/F9Rx8Wl6tnTPLSLBA4kI67ZBSKP9M0GN7YrkrnUj7W1iwuwdsTGpImCjBlXW
	 1CZNfSio813pA==
Message-ID: <6811cc17-8ee4-48c8-8cbf-6bf4d9f98162@kernel.org>
Date: Mon, 27 Apr 2026 17:08:45 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mm/slab: make kfree_rcu_nolock() work with sheaves
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Zqiang <qiang.zhang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-6-harry@kernel.org>
 <56381493-214b-406d-9121-f80be7658445@kernel.org>
 <7101d55e-ba43-4df9-a345-2af579f8e940@kernel.org>
 <CAADnVQL6iajm6L+VzqRB4b-u8OPhQSnUASnfciKGeRR4EDOutA@mail.gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <CAADnVQL6iajm6L+VzqRB4b-u8OPhQSnUASnfciKGeRR4EDOutA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/27/26 16:45, Alexei Starovoitov wrote:
> On Mon, Apr 27, 2026 at 2:53 PM Vlastimil Babka (SUSE)
> <vbabka@kernel.org> wrote:
>> >> @@ -5973,6 +5977,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>> >>      if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>> >>              rcu_sheaf = NULL;
>> >>      } else {
>> >> +            if (unlikely(!allow_spin)) {
>> >> +                    /* call_rcu() cannot be called in an unknown context */
>> >> +                    rcu_sheaf->size--;
>> >> +                    local_unlock(&s->cpu_sheaves->lock);
>> >> +                    goto fail;
>> >> +            }
>>
>> ... this part, so an unconditional allow_spin=false on RT would only fill
>> the rcu_sheaf once and then stop working.
>>
>> However, can we condition this on in_nmi() or something, and pretend the
>> other cases of "unknown context" exist? Installing BPF hooks
>> allocating/freeing memory into call_rcu() internals sounds crazy, no?
> 
> Unfortunately no. People attach to tracepoint lock contention
> which can be inside call_rcu.
> As discussed call_rcu_nolock() is only way forward.

Alright. But we assume those tracepoint-attached callers know to use
kfree_rcu_nolock(), while kfree_rcu() callers under PREEMPT_RT can still
assume it's not called in NMI or tracepoint-attached context, right?

So I think what __kfree_rcu_sheaf() could do is
- with CONFIG_PREEMPT_RT, treat allow_spin == true as allow_spin == false
for purposes of barn_get_empty_sheaf() and to bail out before trying
alloc_empty_sheaf() - this is to avoid any lock activity that's not a trylock.
- allow_spin controls ability to do call_rcu() as above, regardless of
PREEMPT_RT, to avoid it from kfree_rcu_nolock()
