Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656704206B;
	Wed, 13 Nov 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507503; cv=none; b=hlZXcNpphUqzSgB/umz7XJ2/7G20pNdM5ex2XOdW1na9xnhXVBx+G68dkM4J5WlZRtXR2DWZjTcqd9P2HVeZq49En2RJ+LHlDWUmYg4RE+pBCUpNC+t6H6pn4asdly7nT6VIk3NcEHfXgRScp981anc7SdachBmRugmh+GWhSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507503; c=relaxed/simple;
	bh=VTLzchnhjgjlI226ZCHfEBm2YUpKULDHnBuBWCqYXN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyxEm5tgV5P41dTog1hRMYNvsJqwIPFVEXsxzmnTPVoGqOhKeOA8ooDAL2ssxiyUNHeZuEBrnrVtVX9dosJHEo4P2OJbwtDp2OX4eQUzO/KlgpbcTXpbjxg84Vq+gNNOvq6UD6l4IeVByJUwqBGdlrFHul/82aCcX+v3aZcNMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qg4YBcGY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MfIeSrsS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qg4YBcGY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MfIeSrsS"
Date: Wed, 13 Nov 2024 15:18:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731507500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1NnsfkLq2HnmImLt4DvLhPon1Pe+zCIYBq+XyGR0FY=;
	b=Qg4YBcGYpL9DGABYZpbXY74B3Ojg19jAzxfo+nYOpfEcllXDgfHhjvMPQQQyygAeSGKIu3
	Mc2eDoGMvfIqGxqbthlEgQGPvXFA6DHZaprm/PPwd4kxf8h/dttI5MffqpuyvtgXXyOHVQ
	fdtDfFudxB73WbSu8ZVc2TTW5givvfAUb9I+cNkfuPdt2UZcxwpU6PUlZMtoNcJTOnKgBB
	fB9PbQajEOdX+TuVZ+UN73CXfKEAwfIe/VVeX50I0M8sn14vzppOwd1krDz5ztWj/PE/fS
	V3dmGK92WWQ5Upm7e12g2EGmWCVWi7kBKXLPP7F3NbwY07yTi0fQclW8dCmQqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731507500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1NnsfkLq2HnmImLt4DvLhPon1Pe+zCIYBq+XyGR0FY=;
	b=MfIeSrsSxZAO22WT5Pi7FoVbFQRk5lMcLq+XH/Do9UQLMx1SqmDib6eQ37wa9YZ/1Eodre
	feF9z7vLPk5wHPCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	kasan-dev <kasan-dev@googlegroups.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Waiman Long <longman@redhat.com>, dvyukov@google.com,
	vincenzo.frascino@arm.com, paulmck@kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, rcu@vger.kernel.org
Subject: Re: [syzbot] [mm?] WARNING: locking bug in __rmqueue_pcplist
Message-ID: <20241113141818.eQfGt53n@linutronix.de>
References: <67275485.050a0220.3c8d68.0a37.GAE@google.com>
 <ee48b6e9-3f7a-49aa-ae5b-058b5ada2172@suse.cz>
 <b9a674c1-860c-4448-aeb2-bf07a78c6fbf@suse.cz>
 <20241104114506.GC24862@noisy.programming.kicks-ass.net>
 <20241104114726.GD24862@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104114726.GD24862@noisy.programming.kicks-ass.net>

On 2024-11-04 12:47:26 [+0100], Peter Zijlstra wrote:
> On Mon, Nov 04, 2024 at 12:45:06PM +0100, Peter Zijlstra wrote:
> > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > index 6310a180278b..ac9f6682bb2f 100644
> > --- a/mm/kasan/generic.c
> > +++ b/mm/kasan/generic.c
> > @@ -521,12 +521,12 @@ size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
> >  			sizeof(struct kasan_free_meta) : 0);
> >  }
> >  
> > -static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
> > +void kasan_record_aux_stack(void *addr)
> >  {
> >  	struct slab *slab = kasan_addr_to_slab(addr);
> >  	struct kmem_cache *cache;
> >  	struct kasan_alloc_meta *alloc_meta;
> > -	void *object;
> > +	void *object
> 
> Clearly I'm still struggling to type ... *sigh*

Should I put all this in a patch or is already been done?

Sebastian
