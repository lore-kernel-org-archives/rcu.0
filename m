Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E754343D75
	for <rcu@vger.kernel.org>; Wed, 11 Feb 2026 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829548; cv=pass; b=J2vcXlX68b1qPoxZQSCns41Ms5TUdpFt7NPAvOs1rpoAOlLON+GT59JG/ycLMcu/k0EdbLGE/MnOdNZQdQM7+BIvzZY/m9+Mq/OliQt3gw7tIvqpd/Lb4njoEYhW5iEl7Ix/Qyz7MfvRJbqKtr3QypScEOtIC1JhhPLiK3J1erg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829548; c=relaxed/simple;
	bh=436b2tZ8/NBvfm/4AtoMT5MgV6A+YuG2ZoDj9TOQggI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHnRniJ7EJPJRnOulmvojugI2+V3PeMsk6NXypOpfZ7lRiCKSx7pOzR2sCaL8fdv34AWzH7rD7UL4VPEvwT8cvuYLzBnkH0gcCr4wW7TYRDFpemUrWB7Yujf8Pliow4RfKPYh/BqCO1+vPtd+KTdMWnKG4UABv4+Cl9pT7eg9n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEKgh7Uj; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEKgh7Uj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so33044395e9.0
        for <rcu@vger.kernel.org>; Wed, 11 Feb 2026 09:05:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770829544; cv=none;
        d=google.com; s=arc-20240605;
        b=SEI5hSgiDali8fu9c/bgodZrzFcvALUpCkGOz9X+B7medN4exDZXUZ9nkX1pC0dnRs
         4fFR83NqXncVq+8YgJQlWmvHxJ2XjayeiO1CJobdu7HJt+CQVcKO/z6CJBFRyKv98B0k
         AInUXjIxf/3f+Qb0H+WrAfSshUuWKbdHzP7kwxeI/vIo5/mB0KmmCRCJaRZIHhX93GWp
         ff+Ylk98WHx9Ynxt9Ouy6k2GAW/tTaw/q6VaewteATsEmiIoFtUNqM1VgQlsF3coLeg5
         u/xSLJsR6orEZNlb/cv1SjFKrGF1O9sJ5AEpMqLk1hHrhyBhwutEwj18syd8w0piZBC0
         A4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qhsgB31/ghAQLiMpXxxQYUueF6pRoQ5LWy5bH9EPYkU=;
        fh=RKGyNypIodrqEML94K4yLvLCKRuzGZs0wZOIKHj5rTk=;
        b=bsnYtU6eXrzMIddfe5u/J2DSyrQv+Lzpb8pnVj57tX2mlOm8as6NkdupMXcnL5vm2F
         nUnUupowFh8MOybxQdkAYCbaQd0dBJ0W8NwfSGiv69QnjRSe+XNz9KewCf2C5G9uzI2G
         lcMFDkwjk8LNg24am7faxiuC0iFbuc0AqLmtVrAQhKQDWiBFV4EDuTzoAIKTI9D+rvQh
         AVuaDsr5SZtuUQTYPnsd6G8jE4GeVVTOzvG5bqC3KMpjEstp/f/TY4nE2EtjTHH7zkmF
         nYDAM1dhLlDK6hvSp8jl/5+p0UYdmVDQSwTqHhMpZMjnUmHavTOdFDFRsm/OTtP7AO97
         fJzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770829544; x=1771434344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhsgB31/ghAQLiMpXxxQYUueF6pRoQ5LWy5bH9EPYkU=;
        b=EEKgh7Uj85bBDsFliaTmZx5NTZ0DhCF0wk4DLvyQuaIJpj0G3+wiSMjnSUwnPifEfa
         iaHYjg6YfSogtL45+sqS/GGkAmz34YuSb9kyG5MG9XIGOwMJL5uSfSc/pPMSHrEIxBh1
         XR2n0YhAHge0Edk8gOscGcfxzcK1pBYkOuad3LASPtZhsr6hLqp7jeDhTHRYRWRM1SL5
         PZJOrMzO3+BlRtck49+D4RoGvuNyJJcy7l1yOKhaXaU7qeenTtsj6HhuLuMRRlRBdiss
         Bl0o2GWxVw46M+Dlcp3vHXx/5zyvqe54IP7kdjxfO2LEwVcILVa9hXcBJ9JNkG/k9PpK
         r0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770829544; x=1771434344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qhsgB31/ghAQLiMpXxxQYUueF6pRoQ5LWy5bH9EPYkU=;
        b=IdBlDqfGHqN+rMQ7Z1/GKQvefLdtGNxgE+Lb+YB8nt531qWJhns2mwM4vsoVQ2iplH
         MRjB8rku4WlZYWXN/nMwjA1Lm2pj9GKKecxaTuO5fbb5ed1ucnZdbqb+UQ2TsjexFV31
         2WhnfshoIXnUKMkgUdvPKpKlYAK1vbs/m5OGgem3gmAiVK6sxrJSdc1ka8HUawj/7NR9
         tOYkenIZ5uIO+LP8MYDjCFfeE6IIIwp+PZ4frtMkyMPDqbxRzZ8caiB9rjdDZCT+9KYo
         hPgrV9gEbIVdKWw8K7IRaFPSDkBiriWL5yGTPjsfhRVmrpAzkwkDVnabxdY+N0YdlgFI
         cn2w==
X-Forwarded-Encrypted: i=1; AJvYcCXucLgUxTMAk+4WYFMQGoqZu/RVfZ3L4KYHOLznvwBxwuAP4ufS+oLSZmCXmgdScsLFlXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvNJ3UEgSqYuXAB7Fe72yLAdcWfA1JJehuIIzRCH97QA5XKTzw
	WXADtjhof0/wed8N0xuMTjJHHLPxRGG4bh17nXm0ak2iGuha3ahVNvU1DaSjIqaeTY009oEpI+v
	Jwcj/xEU92yXpoz6LvUHMSQcX4a30HlM=
X-Gm-Gg: AZuq6aKSWdyCS8ur/2pZX6rMl5i8sxNDrG77qFA9WSCRClsjyb8g0Q6SKDnWn+W1fof
	HHAGh1rYFAm6lYRAkoCuRlH/QMAG4pWPtKltJbiFXdVZ6AiwSSeWNx5a14E3RdgS9ueZGUZ0pMU
	ebSXvfCtn1xl8BtabsxOp1HBSgchcl1gSskSHcuysKRk1gOLox60gYNl0VVKYoifv0eO+6r0pUa
	p6WZGT5dSQ2OjUo4TcrfJrGz0t/u5JM5oEh2dyBjZudut0+6E2bdGRdtaxccGyfBxwt9xYvV/Ld
	QeKzdxGZUzQvza+woO0LVfihFddGZkbqvA1WF57SX9Df6MX+eWIDoeAYlwISMWk2SXwbt5ruzuP
	r6AjpHqPH9rewWSwmuRjBkA2peA==
X-Received: by 2002:a05:600c:3e87:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-4832020025bmr266578595e9.2.1770829543582; Wed, 11 Feb 2026
 09:05:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206093410.160622-1-harry.yoo@oracle.com> <20260206093410.160622-2-harry.yoo@oracle.com>
 <aYxXE6CC0XQr1KNK@milan> <aYxdleYc7_TWj9To@hyeyoo> <aYxfumz5IlwBDS4n@milan> <aYxnfk6kCZ66CaOJ@hyeyoo>
In-Reply-To: <aYxnfk6kCZ66CaOJ@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 09:05:32 -0800
X-Gm-Features: AZwV_QiDUaUdudmrkVUWLFGKFv0zB3qmz_v6ysYrl7sGxUVKWt-RqFUZSJsWWZ0
Message-ID: <CAADnVQKk_Bgi0bc-td_3pVpHYXR3CpC3R8rg-NHwdLEDiQSeNg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] mm/slab: introduce k[v]free_rcu() with struct rcu_ptr
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Dave Chinner <david@fromorbit.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 3:27=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Wed, Feb 11, 2026 at 11:53:46AM +0100, Uladzislau Rezki wrote:
> > On Wed, Feb 11, 2026 at 07:44:37PM +0900, Harry Yoo wrote:
> > > On Wed, Feb 11, 2026 at 11:16:51AM +0100, Uladzislau Rezki wrote:
> > > > If this is supposed to be invoked from NMI, should we better just d=
etect
> > > > such context in the kvfree_call_rcu()? There are lot of "allow_spin=
" checks
> > > > which make it easy to get lost.
> > >
> > > Detecting if it's NMI might be okay, but IIUC re-entrancy requirement
> > > not only comes from NMI but also from attaching bpf programs to
> > > kernel functions, something like:
> > >
> > > "Run a BPF program whenever queue_delayed_work() is called,
> > >  ... and the BPF program somehow frees memory via kfree_rcu_nolock()"=
.
> > >
> > > Then, by the time the kernel calls queue_delayed_work() while holding
> > > krcp->lock, it run the BPF program and calls kfree_rcu_nolock(),
> > > it is not allowed to spin on krcp->lock.
> > >
> > >
> > > > As i see you maintain llist and the idea is simply to re-enter to t=
he
> > > > kvfree_rcu() again with allow-spin=3Dtrue, since then it will be "n=
ormal"
> > > > context.
> > >
> > > It tries to acquire the lock and add it to krcp->head, but if somebod=
y
> > > is already holding the lock, it re-runs kvfree_rcu() with irq work.
> > >
> >
> > Check no_spin on entry, if true, llist_add, queue-irq-work. Re-enter.
>
> That is much simpler! Actually, I tried this way during the initial
> implementation. I like its simplicity.
>
> But I wasn't sure about performance implications of the approach
> and switched to current implementation.
>
> It'd be nice to hear Alexei's thoughts on this; I think he'd have some
> insights on performance aspect of this, as we have something similar
> in slab (defer_free).

It's not a good idea. !allow_spin doesn't mean that we're in in_nmi
or reentering. It means that the running context is unknown,
but 99% of the time it's fine to go normal route and try to lock
and everything will proceed as usual.
if (!allow_spin) irq_work() will 100% hurt performance.
In kfree_nolock() (before sheaves) we have a fallback to irq_work
that we thought would be rare in practice. Turned out that even
relatively rare spikes of irq_work hurt overall throughput by 5%
for that workload. So, no, irq_work must be absolutely the last resort.
