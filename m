Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B613632B
	for <rcu@vger.kernel.org>; Fri, 22 Nov 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287701; cv=none; b=mbKQyFbM/mAe41vnzwsApr6bPg/4+B1Pri+s65qxhBN1RlOqprfGUaOAUPg9v5zbkk82GPzZDdU15h4i4UHMc7FLWH/LFx4HSaSaoVZoqj01RFL8D0oJq0gQxBGUPJzSKOE/v+QSM/j1JuB/naQuyDPcxFACtks5wKMDVQ4WS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287701; c=relaxed/simple;
	bh=EG21qF81vyu8kAAnYY/umSakY5DmKt3dJKGUkwVVr5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec9U1fXroARKQ6WJA12+ivOPCNRnPqYsjIQrHyR/wIxIPZfGoLTqXYThs4j/nYofK1AXSye9QtF7d73LpH80tg5t8lvFWdQAFA/yhmXSGAjNU+OPrW5cH+YK2JE0+HKvmhD6KghI2AgwxSDd9fxS49ku8Hj1P98M7k66ovovzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFE0gAtA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFE0gAtA"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-382423f4082so1451959f8f.3
        for <rcu@vger.kernel.org>; Fri, 22 Nov 2024 07:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732287698; x=1732892498; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2CBrmR/4K5+pOzn9XzmrpMtqvst0Y6UbBDGLFW9ccDE=;
        b=RFE0gAtAc0sk+V1B2HZSwyZAYj5e2/u0MDQDjF51cUD99k1VmF4Azr/esnEG9DZ7/Z
         fKics2Eb36gu5Q2P8HCD+ighi0qCZJRrc3zuHK9jOdU+xbo+kp7U7TTj0PlahdvQFmf8
         +pfN5kHN45EdaQFogSyS9SEIAseeDePbWg0E6DO+epFnu2KceZi7bF+1H2rWo05aZ8rV
         eie3fZFdPxHtefFu9VJ+YDD1QiLKp6Gs9Wmlg2DA3LsmAyYQCXeqb+jsBJs5kYH7vaqo
         bwSdF0t5YkfVgP7R5njcjf72kZh8rlmx3JQM7mMfGS0N2JN0F4audQABrFAUWdUOZ3aM
         iEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732287698; x=1732892498;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CBrmR/4K5+pOzn9XzmrpMtqvst0Y6UbBDGLFW9ccDE=;
        b=tY5LXVNwK4L4D776SghwboIUdittlUi0VHkCe3/vljypv8msO/qvDwekZG6IxZAHGZ
         1PdoYAhO4oZJcUJfFjiwLOJ/nZaQWxRzfElbLdnxSHnGdI/TXfHaInwK9ADwwUoDfh0F
         7iKq7r5Ojp0b4vKFlK53DdZdoWJAJZDTX5BgiuqdDHBo/7+PVXhSsq7XKu3+5ExqyBrk
         m8gdHB9qSF72p63GWtI3reOmUo2pHXWQNbxOOclLu/NicEqhefSc6XprTjuqi+J216PH
         jrKDUt9uTbr5wUlmLfbGMUP5SXzTrixMT3FMAoq9/3RNzAFWoDmfTGkVfLN36hfCUyRV
         ntZg==
X-Forwarded-Encrypted: i=1; AJvYcCWwi7WkDkimKXi4RX2m8yB+SJFMfr2eHsvOdlN2rlJz4XQAsqRt9PmfOnbZArszrOXv8SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQiEVDIUSX2joCRufAs6JvLeDCS/rTCkK0aume3netUoSRSCy1
	5SPylCbWosybglv1Y8UNHkV4SBYcjQCqQ99053FLAmfNqweG/rZDp3yzKJMa7A==
X-Gm-Gg: ASbGncvoTyY5WzWoJ3NUCbDo6USzFOXJO8rFZHcR3T4opnymt8MxqCxznX243OOBhIm
	IGyJqxOfsV3hV/OQimDgQgdIbf1l3VVDnkg+feyvt3yRY3E2v0XOIngOs0U2PywitaOTWWAQ0Qz
	+ImMpvs/y+UpC+BxJk4zIuVrcwfJrYhC+jLsQNCZbPWhOL9YXuMaFgDdvchOOgUuwLy7yzHXP98
	1Gf7JZ5X42IpucYTZvqcLTSczbfq150PA2cW10mJUGSg4gWJzc=
X-Google-Smtp-Source: AGHT+IFF4ahp+lojSsbIu757K7jRdjQw+mcOJ9fyXHtJSRlvd+VoIDXJnOIjlPPaqGgb9XiUJbFMLA==
X-Received: by 2002:a5d:47aa:0:b0:382:3789:191c with SMTP id ffacd0b85a97d-38260b45584mr2567216f8f.7.1732287697197;
        Fri, 22 Nov 2024 07:01:37 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:e369:a6f7:a3ea:97bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe3cbsm2583014f8f.38.2024.11.22.07.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:01:36 -0800 (PST)
Date: Fri, 22 Nov 2024 16:01:29 +0100
From: Marco Elver <elver@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
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
	Thomas Gleixner <tglx@linutronix.de>, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] kasan: Remove kasan_record_aux_stack_noalloc().
Message-ID: <Z0CcyfbPqmxJ9uJH@elver.google.com>
References: <67275485.050a0220.3c8d68.0a37.GAE@google.com>
 <ee48b6e9-3f7a-49aa-ae5b-058b5ada2172@suse.cz>
 <b9a674c1-860c-4448-aeb2-bf07a78c6fbf@suse.cz>
 <20241104114506.GC24862@noisy.programming.kicks-ass.net>
 <CANpmjNPmQYJ7pv1N3cuU8cP18u7PP_uoZD8YxwZd4jtbof9nVQ@mail.gmail.com>
 <20241119155701.GYennzPF@linutronix.de>
 <CA+fCnZfzJcbEy0Qmn5GPzPUx9diR+3qw+4ukHa2j5xzzQMF8Kw@mail.gmail.com>
 <20241122113210.QxE7YOwK@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122113210.QxE7YOwK@linutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Fri, Nov 22, 2024 at 12:32PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-11-19 20:36:56 [+0100], Andrey Konovalov wrote:
> > > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > > index 6310a180278b6..b18b5944997f8 100644
> > > --- a/mm/kasan/generic.c
> > > +++ b/mm/kasan/generic.c
> > > @@ -521,7 +521,7 @@ size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
> > >                         sizeof(struct kasan_free_meta) : 0);
> > >  }
> > >
> > > -static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
> > 
> > Could you add a comment here that notes the usage, something like:
> > 
> > "This function avoids dynamic memory allocations and thus can be
> > called from contexts that do not allow allocating memory."
> > 
> > > +void kasan_record_aux_stack(void *addr)
> > >  {
> …
> Added but would prefer to add a pointer to stack_depot_save_flags()
> which has this Context: paragraph. Would that work?
> Now looking at it, it says:
> |  * Context: Any context, but setting STACK_DEPOT_FLAG_CAN_ALLOC is required if
> |  *          alloc_pages() cannot be used from the current context. Currently
> |  *          this is the case for contexts where neither %GFP_ATOMIC nor
> |  *          %GFP_NOWAIT can be used (NMI, raw_spin_lock).
> 
> If I understand this correctly then STACK_DEPOT_FLAG_CAN_ALLOC must not
> be specified if invoked from NMI. This will stop
> stack_depot_save_flags() from allocating memory the function will still
> acquire pool_lock, right?
> Do we need to update the comment saying that it must not be used from
> NMI or do we make it jump over the locked section in the NMI case?

Good point. It was meant to also be usable from NMI, because it's very
likely to succeed, and should just take the lock-less fast path once the
stack is in the depot.

But I think we need a fix like this for initial saving of a stack trace:


diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5ed34cc963fc..245d5b416699 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -630,7 +630,15 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 			prealloc = page_address(page);
 	}
 
-	raw_spin_lock_irqsave(&pool_lock, flags);
+	if (in_nmi()) {
+		/* We can never allocate in NMI context. */
+		WARN_ON_ONCE(can_alloc);
+		/* Best effort; bail if we fail to take the lock. */
+		if (!raw_spin_trylock_irqsave(&pool_lock, flags))
+			goto exit;
+	} else {
+		raw_spin_lock_irqsave(&pool_lock, flags);
+	}
 	printk_deferred_enter();
 
 	/* Try to find again, to avoid concurrently inserting duplicates. */


If that looks reasonable, I'll turn it into a patch.
