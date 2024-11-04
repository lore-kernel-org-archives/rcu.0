Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA291AF4F6
	for <rcu@vger.kernel.org>; Mon,  4 Nov 2024 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722646; cv=none; b=AAg31rHVKbh00KRCf3d8ARfTKMViuiytTKmtxdP6ep4VCHSH4l2mozGlad9EHaTBsK9ShNl+UrvNmNlywT8Zibn+/7JRGR7A+gkUSsHEHGOvQAvgtsmP4cAgpJp22I6mB+2l/VTL/HVml5VoqLimkk44KdNu7w696aWELZbHD/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722646; c=relaxed/simple;
	bh=/UhFzu8yWBE3BjF/oPbXDjeBIAvYu4E4/NaYNakjbR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jp07zWVZabmV0G9y4TmBdF3FgwqQVjEckEdkrgJ/r3qao6bSkNudIL3EcLhHr9iLOOUc768wIFiMZgYrom8dYBH0bQhCdOHUhfrJ7iBXB9zUe60+UCI8gDgf/E7lq1/4lFNfNh/CPLASiZVsm6YpoW1TEdKDzU9BO5n/OsCr41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xoHTRAOm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xoHTRAOm"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ce5e3b116so31195685ad.1
        for <rcu@vger.kernel.org>; Mon, 04 Nov 2024 04:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730722645; x=1731327445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5kQZWCzIhxI9ZXfcfMMtM58/ZtX8V/ECMx6VB6xWUdw=;
        b=xoHTRAOmXNumWKiP+jACHiND/rUbOUNkDE2XETvRgaC3zPC04i/aSnzwqfrSKmokij
         He30GUEYxKdH3fones5tUQchbsBE9NEc/JdJgIUz8Q5w9VcaKfM9cGlEVm8vG2Bn4mLj
         RLSeg4Jl3O3qDbo9QAOwn4wIzY1aWKqdnQTxRZSIpHzoXgsemF5TbYE/rrgVl/ytHpla
         pt2jivuN+M4LJ0k7sKLghK6dYsXbir/63pn5cJ2QObbM+ecS70B9YgbFpFYCjVNL3MlB
         zMfLrsHJLZvIRhNj7ec1efirA/bBX1JLbx2gJuvCmHFY9Z4FlTkQ/pxQ5EDHJl4gbUtz
         jXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730722645; x=1731327445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kQZWCzIhxI9ZXfcfMMtM58/ZtX8V/ECMx6VB6xWUdw=;
        b=Y/JmWqjs/NapDP2+Oo0bYowpd0t2DO3rHu0spEz/W+jfhXlsgxv5EmhWtcmKLZsJct
         EG3+0+gh75D/TIKZkF+G1sywPHupILV06ux0246VnFL+SEUxPx/aeOoHzeWetktkeADW
         1Ryll1UvDu5IM18IHt/7Sk9keraTMrruEU6Da5R4pm34RSMzkVmBoJBia4Z7eo/RnCdZ
         YnsI7mxdviJQU0wIYlKL9NPea+NKi8FRYNegxZar0GlYzM3kpulFaAhV1HxPV5Zkhhsq
         H32HAdBwJ0SxxAtL8mq11GNlY0c3qztbUKnwsIw2osPpH+/PW/aO8on0voAdb9obYShT
         rw1w==
X-Forwarded-Encrypted: i=1; AJvYcCXO4HW0JvkTsi9H7sxVkQPXH4Es+r0g1LiHC5K/HZEHyNRXXTBJwz4ne0IfT/7wtXOUgSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcqODBb4oLO1PRnupB+H5qNxlIky5Z2trD/18K0p09wNnEyJK
	Ph0onGQbQXwm2A+qnJaJZJvMotZSOSzu89uPBvZxofqmkAlIBXdEVTz2vkW+cHymp6Mr08757f7
	j4wELZBTrkTtbgfOUL1HDrAW3V4jU83qsOJ1l
X-Google-Smtp-Source: AGHT+IHvf51l5Fhl0nIdVQ+m8T/XcjQYNb/wYNbXZ2oFtF4pT5gjR2FO3JZi9f58vxAaXuMVA2M5H3KK5yq06FN+nBo=
X-Received: by 2002:a17:902:e884:b0:20b:3f70:2e05 with SMTP id
 d9443c01a7336-2111afd6c99mr175024815ad.41.1730722644347; Mon, 04 Nov 2024
 04:17:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67275485.050a0220.3c8d68.0a37.GAE@google.com> <ee48b6e9-3f7a-49aa-ae5b-058b5ada2172@suse.cz>
 <b9a674c1-860c-4448-aeb2-bf07a78c6fbf@suse.cz> <20241104114506.GC24862@noisy.programming.kicks-ass.net>
In-Reply-To: <20241104114506.GC24862@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Mon, 4 Nov 2024 13:16:48 +0100
Message-ID: <CANpmjNPmQYJ7pv1N3cuU8cP18u7PP_uoZD8YxwZd4jtbof9nVQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: locking bug in __rmqueue_pcplist
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andrey Konovalov <andreyknvl@gmail.com>, 
	kasan-dev <kasan-dev@googlegroups.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Waiman Long <longman@redhat.com>, dvyukov@google.com, 
	vincenzo.frascino@arm.com, paulmck@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org, josh@joshtriplett.org, 
	boqun.feng@gmail.com, urezki@gmail.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang1211@gmail.com, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, cl@linux.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 12:45, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 04, 2024 at 12:25:03PM +0100, Vlastimil Babka wrote:
> > On 11/4/24 12:11, Vlastimil Babka wrote:
>
> > >>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4771
> > >>  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
> > >>  stack_depot_save_flags+0x666/0x830 lib/stackdepot.c:627
> > >>  kasan_save_stack+0x4f/0x60 mm/kasan/common.c:48
> > >>  __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
> > >>  task_work_add+0xd9/0x490 kernel/task_work.c:77
> > >
> > > It seems the decision if stack depot is allowed to allocate here depends on
> > > TWAF_NO_ALLOC added only recently. So does it mean it doesn't work as intended?
> >
> > I guess __run_posix_cpu_timers() needs to pass TWAF_NO_ALLOC too?
>
> Yeah, or we just accept that kasan_record_aux_stack() is a horrible
> thing and shouldn't live in functions that try their bestest to
> locklessly setup async work at all.
>
> That thing has only ever caused trouble :/
>
> Also see 156172a13ff0.
>
> How about we do the below at the very least?

I'd be in favor, it simplifies things. And stack depot should be able
to replenish its pool sufficiently in the "non-aux" cases i.e. regular
allocations.

Worst case we fail to record some aux stacks, but I think that's only
really bad if there's a bug around one of these allocations. In
general the probabilities of this being a regression are extremely
small - same as I argued back in
https://lore.kernel.org/all/20210913112609.2651084-1-elver@google.com/
