Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D0155A21
	for <rcu@vger.kernel.org>; Mon, 24 Feb 2025 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361001; cv=none; b=h7/1jNZmiPpNAU8NXVCjqm6MgGl76KJhcwuchO2+ZSHgn+KvYE6aTnWrJ1RdHcSIoLka9UOmGxBJbr0YusT23oSCp5Xwzy5bwMj7/ODumJuZQqJMgQT4bjRWQqF8ApK6K74Jcz8B9UOnCMyJJiN3Q3DhKG5MgPzmBz7zxb8r/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361001; c=relaxed/simple;
	bh=TeWR9KLXTBmIKTfyhxrXWzdWVKnSHoMtCIlpTT/p9uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9TMLHMfLdh4eGHK32evzgYYv2tGHkIn8OYjrc78HJJC5IsL32yyzf6McPud4VVJkSNvJnceG3xhMSnl0uX+072s1SIYoEBWbVwUWWjoDLQGy05EJCxVdiDmytJ9SBi3qk76BJj1EphpuuBEBTUK+/3DG6GneKXwRsWHsplVSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ke7MIECh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ke7MIECh"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-472098e6e75so380701cf.1
        for <rcu@vger.kernel.org>; Sun, 23 Feb 2025 17:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740360999; x=1740965799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z0iilXXeFUJb8Y16LfAkZ2RuptL+aVBKvKCYUlU6uU=;
        b=Ke7MIECh1ikOMI+K4DiQjL8lL9Mlc8KaKGGvEy5lfjtQnoITHPQVrdkuA4wOgve1aF
         4rvRdrKQw43t4kuXeNtXPRyotBIXjCUZtxKMS1bx9zgukraBJLad5faAzVRY/sZprYbY
         vEXXBEGnVWtXPV9cJMIxl2EHh6Jw1nelHbvrzq1z7JLZ2wgO5/eWJcJOJrE0BaSWXUcv
         4eq49pMAQhCxt++Zv9t+Q1zEwQVttFjc0DyJqlh/arex/v7PIDbkIwo7PlbOJH1hResH
         ktmG6zUFz9Od4dXb0rMf9L7H4o7zd2P+vOMXH1GqPszcL/e3xyohVexyFmPEh3b5OiVu
         jq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740360999; x=1740965799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z0iilXXeFUJb8Y16LfAkZ2RuptL+aVBKvKCYUlU6uU=;
        b=pnxdGs4Wn3XWgqo+8Xuv21jvaTOIiS6rrXEyo7WC6ag0B9EpIn5A+u4BAVUA/LI4tM
         y7JyLb6VPivdHsYxprJuIUn+XyUtTaBRCvR3GCtvtcqQeb2EG7t5bsEzQEGujmiIR/4s
         MZp2SOQB5EKO9adFqesOXzKmsPJgv8dl7EFtzUOODNeb4aa615SInlZGIpF5e6R1clvJ
         veZpctbvTFrdPBX1DlsQcS4hVK77pdSB53cDKLhwdRlfHwr+AdgLy3effAASr602Rsro
         yq09kB4nKY7TSEeHpD21fXT8JHPHBqcXP3fK646GrGRMf2fGcagUFiatigrWtMiT82cI
         dBnw==
X-Forwarded-Encrypted: i=1; AJvYcCXzEjYLfUNH96A2uneqO9N/x/hmEeQTipQZW1WjqDdAmhciIwc2jK7akAr0B1elajvF7VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqVxged2cyT68WKwGvrHxgQ/hXTWyB6h7AAJYF+ZhzlTVCLLO
	PAcRUwOgBR7Z8R+1HKBOzV86SL8+HCmjrNXKBGogidTEaeiKoNmmuOk0Y0LjVk2K7i4o2LtbW9s
	jE3IDiwHUH76TZ/QPLiFoGX/4z9qlDeHMde10
X-Gm-Gg: ASbGnct5K8F88Oo73U4FJmFmIMMCHCsS2iE1EuQw7xA87ZvH4kkifYcYOh8JA4tsWXE
	/SyVB4ksgPEDKhmJG5v+kdQtEmiuKuPzA62qYa4JDpftgeLE+gAfKrQPltTSAfxjML3NDQq9f45
	zVMYLFjo0=
X-Google-Smtp-Source: AGHT+IHPYPjlFDSqGO+p0LMHymECdrDlqiQmBYt//urxRVRmELCUI4EioUeoj+QXByhoEOFDN8rmoDb6uqKX7u7x3vg=
X-Received: by 2002:a05:622a:3cd:b0:471:9ece:b13b with SMTP id
 d75a77b69052e-47234b4f60amr4398531cf.1.1740360998584; Sun, 23 Feb 2025
 17:36:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd> <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
In-Reply-To: <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 23 Feb 2025 17:36:27 -0800
X-Gm-Features: AWEUYZmlUqp1pDA_wMiYyR9GBcFZPosDdJv_JqLSwV5RNu8wPZMrLyH-r3FhCWM
Message-ID: <CAJuCfpEq8P4cz7HXaRVqaagONPBKrFgOSqdigEYU60sGAE4-rg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 8:44=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sat, Feb 22, 2025 at 4:19=E2=80=AFPM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Fri, Feb 14, 2025 at 05:27:36PM +0100, Vlastimil Babka wrote:
> > > - Cheaper fast paths. For allocations, instead of local double cmpxch=
g,
> > >   after Patch 5 it's preempt_disable() and no atomic operations. Same=
 for
> > >   freeing, which is normally a local double cmpxchg only for a short
> > >   term allocations (so the same slab is still active on the same cpu =
when
> > >   freeing the object) and a more costly locked double cmpxchg otherwi=
se.
> > >   The downside is the lack of NUMA locality guarantees for the alloca=
ted
> > >   objects.
> >
> > Is that really cheaper than a local non locked double cmpxchg?
>
> Don't know about this particular part but testing sheaves with maple
> node cache and stress testing mmap/munmap syscalls shows performance
> benefits as long as there is some delay to let kfree_rcu() do its job.
> I'm still gathering results and will most likely post them tomorrow.

Here are the promised test results:

First I ran an Android app cycle test comparing the baseline against sheave=
s
used for maple tree nodes (as this patchset implements). I registered about
3% improvement in app launch times, indicating improvement in mmap syscall
performance.
Next I ran an mmap stress test which maps 5 1-page readable file-backed
areas, faults them in and finally unmaps them, timing mmap syscalls.
Repeats that 200000 cycles and reports the total time. Average of 10 such
runs is used as the final result.
3 configurations were tested:

1. Sheaves used for maple tree nodes only (this patchset).

2. Sheaves used for maple tree nodes with vm_lock to vm_refcnt conversion [=
1].
This patchset avoids allocating additional vm_lock structure on each mmap
syscall and uses TYPESAFE_BY_RCU for vm_area_struct cache.

3. Sheaves used for maple tree nodes and for vm_area_struct cache with vm_l=
ock
to vm_refcnt conversion [1]. For the vm_area_struct cache I had to replace
TYPESAFE_BY_RCU with sheaves, as we can't use both for the same cache.

The values represent the total time it took to perform mmap syscalls, less =
is
better.

(1)                  baseline       control
Little core       7.58327       6.614939 (-12.77%)
Medium core  2.125315     1.428702 (-32.78%)
Big core          0.514673     0.422948 (-17.82%)

(2)                  baseline      control
Little core       7.58327       5.141478 (-32.20%)
Medium core  2.125315     0.427692 (-79.88%)
Big core          0.514673    0.046642 (-90.94%)

(3)                   baseline      control
Little core        7.58327      4.779624 (-36.97%)
Medium core   2.125315    0.450368 (-78.81%)
Big core           0.514673    0.037776 (-92.66%)

Results in (3) vs (2) indicate that using sheaves for vm_area_struct
yields slightly better averages and I noticed that this was mostly due
to sheaves results missing occasional spikes that worsened
TYPESAFE_BY_RCU averages (the results seemed more stable with
sheaves).

[1] https://lore.kernel.org/all/20250213224655.1680278-1-surenb@google.com/

>
> >
> > Especially if you now have to use pushf/popf...
> >
> > > - kfree_rcu() batching and recycling. kfree_rcu() will put objects to=
 a
> > >   separate percpu sheaf and only submit the whole sheaf to call_rcu()
> > >   when full. After the grace period, the sheaf can be used for
> > >   allocations, which is more efficient than freeing and reallocating
> > >   individual slab objects (even with the batching done by kfree_rcu()
> > >   implementation itself). In case only some cpus are allowed to handl=
e rcu
> > >   callbacks, the sheaf can still be made available to other cpus on t=
he
> > >   same node via the shared barn. The maple_node cache uses kfree_rcu(=
) and
> > >   thus can benefit from this.
> >
> > Have you looked at fs/bcachefs/rcu_pending.c?
