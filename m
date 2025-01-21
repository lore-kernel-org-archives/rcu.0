Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9268C1E4113;
	Tue, 21 Jan 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737466389; cv=none; b=G4Lj7RMXH9ieSHPnnLxFTCkUR7qgxc5t7dHXOyWT/XewTye8FrTrvbVaDSdiYzRqTb7gYq2T/KyGyP90ewEztEssKvEfbsfwpDCHh10qQdUkgJnufJVk9x1WDUbkvvqE9lUDITz7B/P44GeuRqyo3bwKzOCABg0XFCMseq41bC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737466389; c=relaxed/simple;
	bh=9yn6+/WSed90FUn2N7Wtpz4B67lwSkQlZ87Gn3gVGqY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uni0euCFPUlUi9Ujie72/CSsBAwuyAaltVujSCRZ/qFLKgdeJdc37t1bAUIYmh9fOKO37bO7c6WgAUCi9W1GKEawsPb8yKoHO23k+tCskGDW4GSdEfFB4UT7vrqf7ljhkp9T7ZNCwGo1n7II7VVtowVdQAV43EyxnxNix6KgHgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KemH71lQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KemH71lQ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401ab97206so5518451e87.3;
        Tue, 21 Jan 2025 05:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737466385; x=1738071185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6YQZcvL/hb1ak8eMBU8kvwQ3lsLC5xoPU1usRdV2ko=;
        b=KemH71lQW2R0IxIvrT4J0B+pvUyfcHIZeWKYEmoIjl/Ri1pvKuBeF7Iunf8ygEfQt/
         tOR4JbwgxuQBXaToLD0z8G1FnAIbujI6eADDVS3lppKub2hPwiZshLOPqGN91/lNd1we
         d5qMTzLgjGU3tNyJZ+S77BKbkc6gto4LF/IAXf0EQpIM3vtOLLgCmbTOJbxcA3deL70b
         RLxm6jpSlVv+kn9RERcpQNMf2QKwR9caRnXxPWCskffKKxzoaZJOz4mUtULjILqg5Maf
         ShTFpSfSIgBMblMiVm+5v2hIdDkini9+lmj9dqKSf7kz0WKB9seMZeB13pY+odEaP/0W
         Uw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737466385; x=1738071185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6YQZcvL/hb1ak8eMBU8kvwQ3lsLC5xoPU1usRdV2ko=;
        b=O1Gl7UEC6AjxGk5brr0bDeUvIwpgDfUCUKwUZo2UouKWVP98xtgJ6Z0FOG56jnKRu8
         fGSa0zkXUK6LzB3V6k3+5/7ypJ2XDPRN9jxfwN3MHwaovmX2kn/gqhI8hglfwtXJubeg
         ZHgr+6RQURs50H/RuNDKyiZ6yQkjKawAwaifws3z4qpxAJtzBqfUxyO200EF6DFV5kvs
         QVtDSkiCWp1hFPpRladgn8QLJfpy5d/TEK3gJRu2fX3Zmui1VNSg8HeNkeUJ0f89ZVK9
         UkSvaADjGMKOq4ip+F1NmDmOOZxhl5G2hzDA48EvQXdjvzx9bHPtioZMStB8qD9OEaDA
         gvLA==
X-Forwarded-Encrypted: i=1; AJvYcCUp5CQfnYYG3jYMpEdGEwh8RiWXmXqAX3PO4buPbCn0fAbdls1ZNcoT1CTMutXkYoZmaVJv@vger.kernel.org, AJvYcCWfGbk/awCiTN8GAmzgr8/npXCSYnpue3NaqG7jWYH7c9JTKdSdfpw6Ev7R/zRzNigpmNzvJ0YoZC9ZJFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxszPyJ8BQmc+1ljGTTreQexpJhwiResWIKhnLq+7wG/3pvOWAC
	9miHnKrVOx/UCPs5BHeEzWPcYWRlwZS6Z3DJ8jzv2e0f4GPzqZE8
X-Gm-Gg: ASbGnctyzqk7/B54rn5v7EVYd2hpuHXqirJLmYiXeSm2EOfkkbMLmfqqWDByKe3jQAu
	6Wtsj6QOcrX8PrqbKdP0erBeDIbpGjZnIN4JxWZ4r6hEFOapCbWn3mfv/wwo47paSxt+Ip9a0Tn
	oJgBB+4ZWf29Lz/VdY3g36Td3ZtL5iJ79t8IgymmVEikhHaJUy2HpfQOrRKmOmo5JPExSXji+/Y
	s3kASEVpj7Ma5t9VyR8qI3ACoFUXeE/1w/2//cMhQkRcFGvZEqayiMt5BXyQ5dBu6j2/8eyqgIp
	mxHHFZc9EwUxat92Ij5TL7dA
X-Google-Smtp-Source: AGHT+IEWRgo+ReUKAkJ9PkPVROxv9CETjK2Gy5AIbsrK2I/+SsvbCKgDeeAoWpbEioPsZ5Zd8p90HA==
X-Received: by 2002:ac2:5541:0:b0:542:2335:c43a with SMTP id 2adb3069b0e04-5439c246321mr4253597e87.21.1737466384231;
        Tue, 21 Jan 2025 05:33:04 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af7914esm1849117e87.254.2025.01.21.05.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 05:33:03 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 21 Jan 2025 14:33:00 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Message-ID: <Z4-iDAONPyf7ljBU@pc636>
References: <20241212180208.274813-1-urezki@gmail.com>
 <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz>
 <Z2AJCI3cIR9ETFFu@pc636>
 <d352db4f-4bb8-4300-b235-bbd1bdb3aa21@suse.cz>
 <Z2BKLzOGv_Ki_7fj@pc636>
 <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz>
 <Z2BNWpkruY6rJv6A@pc636>
 <5bb80786-220d-45d2-bd35-51876df4203c@paulmck-laptop>
 <55931fdd-1d5f-4ffd-8496-fe436171dee2@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55931fdd-1d5f-4ffd-8496-fe436171dee2@suse.cz>

On Mon, Jan 20, 2025 at 11:06:13PM +0100, Vlastimil Babka wrote:
> On 12/16/24 17:46, Paul E. McKenney wrote:
> > On Mon, Dec 16, 2024 at 04:55:06PM +0100, Uladzislau Rezki wrote:
> >> On Mon, Dec 16, 2024 at 04:44:41PM +0100, Vlastimil Babka wrote:
> >> > On 12/16/24 16:41, Uladzislau Rezki wrote:
> >> > > On Mon, Dec 16, 2024 at 03:20:44PM +0100, Vlastimil Babka wrote:
> >> > >> On 12/16/24 12:03, Uladzislau Rezki wrote:
> >> > >> > On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wrote:
> >> > >> > 
> >> > >> >> Also how about a followup patch moving the rcu-tiny implementation of
> >> > >> >> kvfree_call_rcu()?
> >> > >> >> 
> >> > >> > As, Paul already noted, it would make sense. Or just remove a tiny
> >> > >> > implementation.
> >> > >> 
> >> > >> AFAICS tiny rcu is for !SMP systems. Do they benefit from the "full"
> >> > >> implementation with all the batching etc or would that be unnecessary overhead?
> >> > >> 
> >> > > Yes, it is for a really small systems with low amount of memory. I see
> >> > > only one overhead it is about driving objects in pages. For a small
> >> > > system it can be critical because we allocate.
> >> > > 
> >> > > From the other hand, for a tiny variant we can modify the normal variant
> >> > > by bypassing batching logic, thus do not consume memory(for Tiny case)
> >> > > i.e. merge it to a normal kvfree_rcu() path.
> >> > 
> >> > Maybe we could change it to use CONFIG_SLUB_TINY as that has similar use
> >> > case (less memory usage on low memory system, tradeoff for worse performance).
> >> > 
> >> Yep, i also was thinking about that without saying it :)
> > 
> > Works for me as well!
> 
> Hi, so I tried looking at this. First I just moved the code to slab as seen
> in the top-most commit here [1]. Hope the non-inlined __kvfree_call_rcu() is
> not a show-stopper here.
> 
> Then I wanted to switch the #ifdefs from CONFIG_TINY_RCU to CONFIG_SLUB_TINY
> to control whether we use the full blown batching implementation or the
> simple call_rcu() implmentation, and realized it's not straightforward and
> reveals there are still some subtle dependencies of kvfree_rcu() on RCU
> internals :)
> 
> Problem 1: !CONFIG_SLUB_TINY with CONFIG_TINY_RCU
> 
> AFAICS the batching implementation includes kfree_rcu_scheduler_running()
> which is called from rcu_set_runtime_mode() but only on TREE_RCU. Perhaps
> there are other facilities the batching implementation needs that only
> exists in the TREE_RCU implementation
> 
> Possible solution: batching implementation depends on both !CONFIG_SLUB_TINY
> and !CONFIG_TINY_RCU. I think it makes sense as both !SMP systems and small
> memory systems are fine with the simple implementation.
> 
> Problem 2: CONFIG_TREE_RCU with !CONFIG_SLUB_TINY
> 
> AFAICS I can't just make the simple implementation do call_rcu() on
> CONFIG_TREE_RCU, because call_rcu() no longer knows how to handle the fake
> callback (__is_kvfree_rcu_offset()) - I see how rcu_reclaim_tiny() does that
> but no such equivalent exists in TREE_RCU. Am I right?
> 
> Possible solution: teach TREE_RCU callback invocation to handle
> __is_kvfree_rcu_offset() again, perhaps hide that branch behind #ifndef
> CONFIG_SLUB_TINY to avoid overhead if the batching implementation is used.
> Downside: we visibly demonstrate how kvfree_rcu() is not purely a slab thing
> but RCU has to special case it still.
> 
> Possible solution 2: instead of the special offset handling, SLUB provides a
> callback function, which will determine pointer to the object from the
> pointer to a middle of it without knowing the rcu_head offset.
> Downside: this will have some overhead, but SLUB_TINY is not meant to be
> performant anyway so we might not care.
> Upside: we can remove __is_kvfree_rcu_offset() from TINY_RCU as well
> 
> Thoughts?
> 
For the call_rcu() and to be able to reclaim over it we need to patch the
tree.c(please note TINY already works):

<snip>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b1f883fcd918..ab24229dfa73 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2559,13 +2559,19 @@ static void rcu_do_batch(struct rcu_data *rdp)
                debug_rcu_head_unqueue(rhp);

                rcu_lock_acquire(&rcu_callback_map);
-               trace_rcu_invoke_callback(rcu_state.name, rhp);

                f = rhp->func;
-               debug_rcu_head_callback(rhp);
-               WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
-               f(rhp);

+               if (__is_kvfree_rcu_offset((unsigned long) f)) {
+                       trace_rcu_invoke_kvfree_callback("", rhp, (unsigned long) f);
+                       kvfree((void *) rhp - (unsigned long) f);
+               } else {
+                       trace_rcu_invoke_callback(rcu_state.name, rhp);
+                       debug_rcu_head_callback(rhp);
+                       WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
+                       f(rhp);
+               }
                rcu_lock_release(&rcu_callback_map);

                /*
<snip>

Mixing up CONFIG_SLUB_TINY with CONFIG_TINY_RCU in the slab_common.c
should be avoided, i.e. if we can, we should eliminate a dependency on
TREE_RCU or TINY_RCU in a slab. As much as possible.

So, it requires a more closer look for sure :)

--
Uladzislau Rezki
