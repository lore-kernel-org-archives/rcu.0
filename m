Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC917741
	for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661056; cv=none; b=XinUIqthktQxhkuUpKJd5lY4yOiBAPyAOIkWOyIH+b7Zev3UjsYTOZYYo126Cc8Rw+dLRVUtKq8I8a9M6wj5W4EmSJvO2EBYxHrFuAzm2MDXQI2YN2iQ6Ahr+x8gSJ3IeiNj1Fk+BJxfW34V5w8IBJ+IjxCdjuDxhs4UpNk5opk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661056; c=relaxed/simple;
	bh=HyBhlpgtqOiMs5ZVNPuqkKklnLBYveORAOFj7dkKCZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1m6wovpm254HiBsyFPJCKHR11lHhQFzt2kzcHYsojZUjYRa815ajT4gfuyPBYgxzNH7ByKmc3yygE8IcvRHsZA4wJu9Zf6535g0POU+4blJ4Yi1HNq2pseZKh4V1w75o6ZvD0TO/ETRq6HMJtTkeuhGwaqSs9Ok1dkSwl7EYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=NLZCHOO6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NLZCHOO6"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467a3f1e667so8365911cf.0
        for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 11:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737661053; x=1738265853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgVwUL8cM02YfaCeU1/XMmjj0tdkjn2bwYjtAYAHIcA=;
        b=NLZCHOO64IRt7rbKyqQVaHZNxZ6UjAF1FLSQb9CA3BhSack8tjfnj7ugJhM069NpSY
         lj/wdvnYpuOhU5utJLu8PkoizFyok+aYDrXoeq43SRdRgrICoqHO48GUaubAv0mFXZQa
         GUypGdntBzuTy2ZaCE7bRwELM/RiaSuJCelUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661053; x=1738265853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgVwUL8cM02YfaCeU1/XMmjj0tdkjn2bwYjtAYAHIcA=;
        b=vIje4nObVHRh861l6XiDJr6RmmnRAy1D1vZvbwy/r/YrV1oByPxkgmuUXTQv1CQA2H
         xIRoPhpMrcwBeSYqQfHb5W8vkOTU5GQnUxDWpuhu1r1J3OxyrDwgSf2Fi9h9kMWhQonH
         S5b2jJzPbqnX5zwkQQrKUhUulMERojXrRLZOI6MxwADFgyapgVXUGL6lTE8I0afQclSf
         jLK8miSs9eCZFhCUnGuw8RzOSY7jfBPT73lixXiLPI83nCwpuh5XIYFYdkzMjyAuJjhw
         rh3X7Ql6vrtwAoBYyVVxuRefJWgrHyub+ZMAHm95jqwN+oJtsp/I240iO7pFXcZe4Mfq
         h+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfOuV/m/mdT7IQOVAYrC7vKwjMKuy6xUHzSz3ZDNg7qb8+lzSOUSTzzDZf3bp18V9rtBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp8NoggK8IhU8N0qU7HvQG+43s+HT1ks/RJKH1vm4NSSoMqddd
	PtoCWGYV2R4Y5I1zNzMRNMY29ewR0K2YhNlD1s/pa9gqMYe1tBoL+Yv9aUQT2mU=
X-Gm-Gg: ASbGncs7vRb4S3MIH1JGKzn2k337GIeOUASEzqu33KDvhw3+yS9B4HVWrF2Mb7WqUSH
	T4a7h369vDJ6zdVI5x7sYYB1N+pZy1xW2aYQnAn5fI3VFYSa6ymNWwlYWSbbLmlRPpgr2k0NKxp
	zUZNkGYvBZ7MkPekCkJV0iu2L8H5EImft5fnuWYLp/z0xZF3mqNd6iAuDVo5WMXWNp/rgn27KWG
	FGMAUWNUx0xFWW/oNIDWizbwf9U0ImQU91FvVjrZgGVxfbuFEzYk3awmdcepE56476EB5vriaCb
	Lt8NO4vOd/qp4LEUalytuMgZvpU+4wRNaNypNjvn3YD3Tg==
X-Google-Smtp-Source: AGHT+IG+8Lpc66A360D0SQ3mvU1EMoh0gkzCqIG6zTOyY5gaBn2ttLdchg/B/aWaqNgFeIHj6DJmrQ==
X-Received: by 2002:ac8:5f06:0:b0:467:53c8:7572 with SMTP id d75a77b69052e-46e12a55504mr485247851cf.13.1737661053455;
        Thu, 23 Jan 2025 11:37:33 -0800 (PST)
Received: from localhost (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e66b8700dsm2016261cf.76.2025.01.23.11.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:37:32 -0800 (PST)
Date: Thu, 23 Jan 2025 14:37:31 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] slab, rcu: move and consolidate TINY_RCU
 kvfree_rcu() to SLAB
Message-ID: <20250123193731.GA682588@joelbox2>
References: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>

On Thu, Jan 23, 2025 at 11:37:17AM +0100, Vlastimil Babka wrote:
> Following the move of the TREE_RCU batching kvfree_rcu() implementation
> to slab, we still have the simple non-batching implementation in tiny
> RCU, and RCU implementation specific ifdefs in slab code.
> 
> Finish the move and integration into slab. Allow using the simple
> call_rcu() based implementation also with tree RCU when SLUB_TINY is
> enabled, as its goal is also to limit memory footprint with less concern
> for top performance.
> 
> In order to avoid RCU having to recognize the fake callback function
> pointers (__is_kvfree_rcu_offset()) when handling call_rcu(), implement
> a callback that can calculate the object's address from the embedded
> rcu_head pointer without knowing the specific offset (previously SLOB
> would not have made it possible, but it's gone now).
> 
> After this series, AFAIK only the following kvfree_rcu specific code
> remains in RCU:
> 
> - a call to kfree_rcu_scheduler_running() from rcu_set_runtime_mode()
> 
>   - probably necessary and a generic registration interface would be
>     unnecessary bloat?
> 
> - declarations of kfree_rcu() API in include/linux/rcupdate.h
> 
>   - could be moved to slab.h after checking for/fixing up potential
>     missing includes
> 
> git tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slub-tiny-kfree_rcu

Looks good to me, except typo in third patch 'kmalloc of vmalloc allocation'
should be 'kmalloc or vmalloc allocation'.

Maybe also add some comments on top of 'kvfree_rcu_cb()'. Like:

/*
 * Given an rcu_head embedded within an object at an offset < 4k,
 * free the object in question.
 */

I like the touch with the config option in the last patch!

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel




> To: Christoph Lameter <cl@linux.com>
> To: David Rientjes <rientjes@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> To: "Paul E. McKenney" <paulmck@kernel.org>
> To: Joel Fernandes <joel@joelfernandes.org>
> To: Josh Triplett <josh@joshtriplett.org>
> To: Boqun Feng <boqun.feng@gmail.com>
> To: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: rcu@vger.kernel.org
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Vlastimil Babka (4):
>       slab, rcu: move TINY_RCU variant of kvfree_rcu() to SLAB
>       rcu: remove trace_rcu_kvfree_callback
>       rcu, slab: use a regular callback function for kvfree_rcu
>       slab: don't batch kvfree_rcu() with SLUB_TINY
> 
>  include/linux/rcupdate.h   | 29 ++++++++++++++---------------
>  include/linux/rcutiny.h    | 36 ------------------------------------
>  include/linux/rcutree.h    |  3 ---
>  include/linux/slab.h       | 14 ++++++++++++++
>  include/trace/events/rcu.h | 34 ----------------------------------
>  kernel/rcu/tiny.c          | 24 ------------------------
>  kernel/rcu/tree.c          |  9 ++-------
>  mm/Kconfig                 |  4 ++++
>  mm/slab.h                  |  2 ++
>  mm/slab_common.c           | 32 +++++++++++++++++++++++++-------
>  mm/slub.c                  | 42 ++++++++++++++++++++++++++++++++++++++++++
>  11 files changed, 103 insertions(+), 126 deletions(-)
> ---
> base-commit: e492fac3657b60b8dd78a6e8ca26d1d14706c7b3
> change-id: 20250123-slub-tiny-kfree_rcu-bd65bfe222f2
> 
> Best regards,
> -- 
> Vlastimil Babka <vbabka@suse.cz>
> 
