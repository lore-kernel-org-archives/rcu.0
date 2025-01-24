Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244CD13BC0E
	for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728380; cv=none; b=A7x6Pizsa5wUWgxiyJaVwJfWIm6jK23jTaZ0yGfgDut9qo6xhOsRaSPJh7JCgj1XWAUxJ/uMGQ4lg1D7kYYl51VWizjLcg2GJ2PuxkfWuJ3347XMGn4+ACnbKVfit4nnwuEFTzssovqSF/e+KzeWnIe7KncEEg+XUNkjNOAXJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728380; c=relaxed/simple;
	bh=RDcFKzCK0BGqkQnUJhB7F92fHYwkANWemnG86MqEPco=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQSuIoAkQr8RKB8yRhjA3KUhNpt/CdI6gxBHca64iE+Q1hy9UQKXqIIybQ3WGHpz3OBpHCH9VlJx+3fRwJRQgzBXYGOAJ3CcII3TnHXVP/cjNcPvFHEbgGO06IO5tyTSbtqtBGXn/oIrxAPbf/ov5ETsarZbNiJOkRTrgMysglw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoNvVX++; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoNvVX++"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-305d840926fso17352061fa.2
        for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737728376; x=1738333176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s4yfLGMF4DRRR4uiSdjsJIEX/vDRt9QEVPWz6odNLKc=;
        b=QoNvVX++RpfiJFmAOTxiOm+tZMsfSH3MXtO80gM1uDfP1HnVnEKrIvCXSwg6A1ns4f
         pbDIvX3A8IMyvhyZr3nNcw/MM8cm9D7RvyR1rADp3CmpHMew0l6JGc57u0DE1om2Ewta
         KUchIB6VvxXtXK18JxPo5LDUS5ywDsDa1NFD+yh5QOdEEwzDSiCwBIGZfvqvlz/kkEi/
         elwS7rXlVPpABR/1qfylVlKsj42DFhLInVEfwJBIwG29IuhMANW0qcfHC32JSlKFYEAZ
         1zOebhMww5kR/Lp3vQttkihkueQRi5OE3ItdDwxutL4zoipsM+Jx8MPGCJ7YBHW2MeuR
         H59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737728376; x=1738333176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4yfLGMF4DRRR4uiSdjsJIEX/vDRt9QEVPWz6odNLKc=;
        b=uLSoJfyderktYPRqd4daIESsa5WFNyh6xI5F2BHcoTqjTXUUnBK0QrRwndlM3lJ8p9
         sngn27hNB7S+bey+jrSzvPiuikhFB/Y1JrC3xQnaIqInAr9971Zj5/j2u/ZmIhH0vBsc
         M9m1asmWzt28wcG/vwrtmOFOlrlSsaXak8vYSq1BY9EeMTvevk1hqGkYe64qwWziHzqn
         tdVg3UvnlIFW/TDcCZ5QReye7w713KER2r2ywHMZm01GqjbfUx0S2rylkL2qGT+bRPcJ
         EB9dEqqix9cKDwf+BtKxlgraONXrdzbIMfmwmNO6KeQ7lXuR/h+E7/cuoqdrmuFwpY1R
         cXlw==
X-Forwarded-Encrypted: i=1; AJvYcCU3DJtF0aHKetR+HuZAx+H957VIu7/ez7O3u9/h2x9jkSSlyUhKzggxXCJc3Q7GxyfGwfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kPu5s8egiyp0tcGbOkK5azh9S0Q3KUsdI0vPs6YFr44REChm
	Z2pIxpzcefvy8z2PC6vxNAS6vXiSl4u7xxf6FcaAgwup9a3Dy6uu
X-Gm-Gg: ASbGncsv4ezqXnxKi21v7szLgQrwo6TVeMKF5otlj/q3jt69PELf0BJpqt6ZNWtzlNi
	oDSNYuA87V6rF17ZotUXrIixszxmscN4xuCN+nECKzVWXsOuaAv4esnybG2rGntbrC2+J2UOouK
	51tkvUC+rvMtyLq/jGblyeiJiMLBNYvMMb+U7Ev/SNIx8johYwijc0S37Sfjw7qe+DHiuiBb6SC
	8/0V5SzRQXogSQLbDk2+V02Qe/KdtRLU/ee2DsuyDZFIpa6OX6guCx60QC98PFtm6c6MMXKQA0B
	fFWWmymqTUqqjPuWKb02v/7YO8RMUgrRZANC3OWXfGdWqQ==
X-Google-Smtp-Source: AGHT+IE6TMIsR+8dZQqKWBCDc/C/osFhUt1LkBxJItfLi+LIuu7MXwX133y9q3x+eQYeYB0WY1sdIQ==
X-Received: by 2002:ac2:48a1:0:b0:540:1d6c:f1af with SMTP id 2adb3069b0e04-5439c27d0d8mr9216959e87.44.1737728375627;
        Fri, 24 Jan 2025 06:19:35 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c822f965sm307666e87.91.2025.01.24.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 06:19:34 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 24 Jan 2025 15:19:32 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] rcu, slab: use a regular callback function for
 kvfree_rcu
Message-ID: <Z5OhdK0OqIgT7qXU@pc636>
References: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>
 <20250123-slub-tiny-kfree_rcu-v1-3-0e386ef1541a@suse.cz>
 <Z5OL_OeL8olMaeml@pc636>
 <e8bcc4bd-3e3b-4a96-8183-4af1fbb14211@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8bcc4bd-3e3b-4a96-8183-4af1fbb14211@suse.cz>

On Fri, Jan 24, 2025 at 03:16:05PM +0100, Vlastimil Babka wrote:
> On 1/24/25 13:47, Uladzislau Rezki wrote:
> > On Thu, Jan 23, 2025 at 11:37:20AM +0100, Vlastimil Babka wrote:
> >> RCU has been special-casing callback function pointers that are integers
> >> lower than 4096 as offsets of rcu_head for kvfree() instead. The tree
> >> RCU implementation no longer does that as the batched kvfree_rcu() is
> >> not a simple call_rcu(). The tiny RCU still does, and the plan is also
> >> to make tree RCU use call_rcu() for SLUB_TINY configurations.
> >> 
> >> Instead of teaching tree RCU again to special case the offsets, let's
> >> remove the special casing completely. Since there's no SLOB anymore, it
> >> is possible to create a callback function that can take a pointer to a
> >> middle of slab object with unknown offset and determine the object's
> >> pointer before freeing it, so implement that as kvfree_rcu_cb().
> >> 
> >> Large kmalloc and vmalloc allocations are handled simply by aligning
> >> down to page size. For that we retain the requirement that the offset is
> >> smaller than 4096. But we can remove __is_kvfree_rcu_offset() completely
> >> and instead just opencode the condition in the BUILD_BUG_ON() check.
> >> 
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  include/linux/rcupdate.h | 24 +++++++++---------------
> >>  kernel/rcu/tiny.c        | 13 -------------
> >>  mm/slab.h                |  2 ++
> >>  mm/slab_common.c         |  5 +----
> >>  mm/slub.c                | 42 ++++++++++++++++++++++++++++++++++++++++++
> >>  5 files changed, 54 insertions(+), 32 deletions(-)
> >> 
> >> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> >> index 3f70d1c8144426f40553c8c589f07097ece8a706..7ff16a70ca1c0fb1012c4118388f60687c5e5b3f 100644
> >> --- a/include/linux/rcupdate.h
> >> +++ b/include/linux/rcupdate.h
> >> @@ -1025,12 +1025,6 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
> >>  #define RCU_POINTER_INITIALIZER(p, v) \
> >>  		.p = RCU_INITIALIZER(v)
> >>  
> >> -/*
> >> - * Does the specified offset indicate that the corresponding rcu_head
> >> - * structure can be handled by kvfree_rcu()?
> >> - */
> >> -#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
> >> -
> >>  /**
> >>   * kfree_rcu() - kfree an object after a grace period.
> >>   * @ptr: pointer to kfree for double-argument invocations.
> >> @@ -1041,11 +1035,11 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
> >>   * when they are used in a kernel module, that module must invoke the
> >>   * high-latency rcu_barrier() function at module-unload time.
> >>   *
> >> - * The kfree_rcu() function handles this issue.  Rather than encoding a
> >> - * function address in the embedded rcu_head structure, kfree_rcu() instead
> >> - * encodes the offset of the rcu_head structure within the base structure.
> >> - * Because the functions are not allowed in the low-order 4096 bytes of
> >> - * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
> >> + * The kfree_rcu() function handles this issue. In order to have a universal
> >> + * callback function handling different offsets of rcu_head, the callback needs
> >> + * to determine the starting address of the freed object, which can be a large
> >> + * kmalloc of vmalloc allocation. To allow simply aligning the pointer down to
> >> + * page boundary for those, only offsets up to 4095 bytes can be accommodated.
> >>   * If the offset is larger than 4095 bytes, a compile-time error will
> >>   * be generated in kvfree_rcu_arg_2(). If this error is triggered, you can
> >>   * either fall back to use of call_rcu() or rearrange the structure to
> >> @@ -1091,10 +1085,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr);
> >>  do {									\
> >>  	typeof (ptr) ___p = (ptr);					\
> >>  									\
> >> -	if (___p) {									\
> >> -		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));	\
> >> -		kvfree_call_rcu(&((___p)->rhf), (void *) (___p));			\
> >> -	}										\
> >> +	if (___p) {							\
> >> +		BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);	\
> >> +		kvfree_call_rcu(&((___p)->rhf), (void *) (___p));	\
> >> +	}								\
> >>
> > Why removing the macro? At least __is_kvfree_rcu_offset() makes it
> > clear what and why + it has a nice comment what it is used for. 4096
> > looks like hard-coded value.
> 
> Hmm but it's ultimately shorter. We could add a short comment to
> kvfree_rcu_arg_2() referring to the longer explanation in the kfree_rcu()
> comment?
> 
Sounds good to place or keep the comment.

> > Or you do not want that someone else started to use that macro in
> > another places?
> 
> And also that, since this has to be exposed in a "public" header.
> 
> >> diff --git a/mm/slab.h b/mm/slab.h
> >> index e9fd9bf0bfa65b343a4ae0ecd5b4c2a325b04883..2f01c7317988ce036f0b22807403226a59f0f708 100644
> >> --- a/mm/slab.h
> >> +++ b/mm/slab.h
> >> @@ -604,6 +604,8 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> >>  			    void **p, int objects, struct slabobj_ext *obj_exts);
> >>  #endif
> >>  
> >> +void kvfree_rcu_cb(struct rcu_head *head);
> >> +
> >>  size_t __ksize(const void *objp);
> >>  
> >>  static inline size_t slab_ksize(const struct kmem_cache *s)
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index 330cdd8ebc5380090ee784c58e8ca1d1a52b3758..f13d2c901daf1419993620459fbd5845eecb85f1 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -1532,9 +1532,6 @@ kvfree_rcu_list(struct rcu_head *head)
> >>  		rcu_lock_acquire(&rcu_callback_map);
> >>  		trace_rcu_invoke_kvfree_callback("slab", head, offset);
> >>  
> >> -		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
> >> -			kvfree(ptr);
> >> -
> > This is not correct unless i miss something. Why do you remove this?
> 
> Oops, meant to remove just the warn check, and unconditionally call
> kvfree(), thanks for noticing :)
> 
> The warning could really only trigger due to a use-after-free corruption of
> the ptr pointer, because the BUILD_BUG_ON() would catch misuse with a too
> large offset, so we don't need to keep it.
> 
> >> +void kvfree_rcu_cb(struct rcu_head *head)
> >> +{
> >> +	void *obj = head;
> >> +	struct folio *folio;
> >> +	struct slab *slab;
> >> +	struct kmem_cache *s;
> >> +	void *slab_addr;
> >> +
> >> +	if (unlikely(is_vmalloc_addr(obj))) {
> >> +		obj = (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
> >> +		vfree(obj);
> >> +		return;
> >> +	}
> >> +
> >> +	folio = virt_to_folio(obj);
> >> +	if (unlikely(!folio_test_slab(folio))) {
> >> +		/*
> >> +		 * rcu_head offset can be only less than page size so no need to
> >> +		 * consider folio order
> >> +		 */
> >> +		obj = (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
> >> +		free_large_kmalloc(folio, obj);
> >> +		return;
> >> +	}
> >> +
> >> +	slab = folio_slab(folio);
> >> +	s = slab->slab_cache;
> >> +	slab_addr = folio_address(folio);
> >> +
> >> +	if (is_kfence_address(obj)) {
> >> +		obj = kfence_object_start(obj);
> >> +	} else {
> >> +		unsigned int idx = __obj_to_index(s, slab_addr, obj);
> >> +
> >> +		obj = slab_addr + s->size * idx;
> >> +		obj = fixup_red_left(s, obj);
> >> +	}
> >> +
> >> +	slab_free(s, slab, obj, _RET_IP_);
> >> +}
> >> +
> > Tiny computer case. Just small nit, maybe remove unlikely() but you decide :)
> 
> Force of habbit :)
> 
:)

--
Uladzislau Rezki
