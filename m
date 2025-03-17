Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0401F3BA5
	for <rcu@vger.kernel.org>; Mon, 17 Mar 2025 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237799; cv=none; b=OON0V9FiIoH3/28xmOOCPeORn4tr+cAC56b/Y7BNV5wH4qIfQ7F6IG7T1F1g93mqy5IfYAaq2/2zuGN/ScXvgO+FS9cvVBWwPegdYlfz1g42iJwGPkFHWUSehXcGOwSIAu0PMLRhSG7DKrNS2lJMAJJ1ujPjZ6ZlffsuGPL0pwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237799; c=relaxed/simple;
	bh=vXj8w8zR7Sq1MWJW/6r9lxEz7+J7BwlENjdhca4E7s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lnb3YmVbVquph/lYgTRMpfWJQcGmrEOTcTeOnhAiZSTF5T9DgpoynhLj737sj3Zdivz/yh9vv0VADYk+9SRaxAOI5gfSOC5k7svl4edFNQOREdFWjbnUs4U6Gy8YcMs6osmFO3hEjjxy+BXze7tt//h7b5HMT5nedOxoitibVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ETtzQQMi; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETtzQQMi"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47666573242so30301cf.0
        for <rcu@vger.kernel.org>; Mon, 17 Mar 2025 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742237796; x=1742842596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2MTPS82nJIqHJWWsdQh9wX6LNPhF+HHONa8cgA7jlY=;
        b=ETtzQQMib1bkRIsCqh+H1wOGvBOSmFdmyiuzsfPq2e0PSy1blGjD0Y1PS7ESkiv/nq
         IzribXyxd93LcBBtt0nZR/aR8z53R0apWzRd0f4WKfLsZ7G6TG5OCtWsasWHc/MiUXcB
         YIM8rSIA9s7fS7QthCO2uqCf9oMEInPhyrX0isUn4R8v5o53ItJaNf0vvE+IW6v9XYgH
         VhS8I2j58F1NlgikGWJ0opuvDZ+j3n1zIZis44j4B+vn8TKkBsdn1FQS1AMtLXatc41F
         UURJa5goW4ZnZ2UytmsGgwDsDSgNR3qAlkkiPJQ5Mrlcv1z/raYWIsb/TwaeBkTOWGZV
         +0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237796; x=1742842596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2MTPS82nJIqHJWWsdQh9wX6LNPhF+HHONa8cgA7jlY=;
        b=leZeha8hXhVm0/pkmcxxjzyYLFtoU11FyburtCfmYFNWPn3poDcIRgrMwwewvCZ15U
         Utxzhv8zzKt7JDfWsLou72vfVMGVYo+UaJcucyrLMMKo5d0YZ9T/PhVUCrAVEVkkp+HY
         HWc0fj6FiIdlC5Nj3jy0qN4lqEQ+8IE2eHMA/j5LuPXFl4oAUhKy/NrSxwH8pDkVDz4m
         /dPHToCOT8t0QQ0uwhlcKygZz8rpKaz+dVZvEBpVdO6S7hx4DKBmXoqgiXOkRORicW2C
         5PpNUL/r7WA8E82LkSDA5XnH53nLtHePgOhUp7mfw9hooXIlh6HDlq0kZ/umY6nyA3RC
         qXXA==
X-Forwarded-Encrypted: i=1; AJvYcCUGkqZlHa2MxEx+CdEb2yCGN1pgwDJREYzmGqDhIrz3xuwLNpb6jtxwrI10uWJ70muLuM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrClW891rI7dt/ypB2qM74838Oh3zB5rKM4M2tRFayDmel5Pof
	PuYawuZpLKJ7KDNaTvBkn+M6FOI0FOVkhVUKvRjiiivCdl1yrRPPypH5EReWoHP6TmrI6Z/ueWF
	LZ/kv+VJ0jimQZPS0Klg66yW7M630NhDY1UhVec5FfYRkc7KulA==
X-Gm-Gg: ASbGncvkwtclv0MzsGrhztD/5V97JnDqgXhFzAvugMFKEzjMQdkuScy7qSWmyf/cOyf
	0I2u9BYcSXaF7ZTuU87v/MpQKfYtQfBOWRAMbL8Au5tDRLRX/rXJ1GehJn7qU1MQd4auNzUigff
	G4MywPwMem0T9Zi0RYp2J1rkok9Q==
X-Google-Smtp-Source: AGHT+IHxhS0AFsGqJ63tw+5kUuQHboEma7CDZGelSpyScNouLrAfX+0ci2TYwytV6GKLPy+KpPN2c1zrWAZQtugNxN8=
X-Received: by 2002:a05:622a:418d:b0:476:d64c:3a4 with SMTP id
 d75a77b69052e-476fd7352a9mr482611cf.0.1742237796062; Mon, 17 Mar 2025
 11:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
 <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
 <CAJuCfpEq8P4cz7HXaRVqaagONPBKrFgOSqdigEYU60sGAE4-rg@mail.gmail.com>
 <173d4dbe-399d-4330-944c-9689588f18e8@suse.cz> <CAJuCfpHHXYKGjaOxHcuJcuQbUVO7YqLMpcYeF3HM5Ayxy1fE+g@mail.gmail.com>
 <CAJuCfpE7t83PKWw+8XJLE5538kKJnbhirLg2siDSw=F4sw=9uA@mail.gmail.com>
 <19df9218-c984-4cbc-8b5d-4e0f7658935f@suse.cz> <ape445nrqgod4ivtzcwacmfdshi3fgcqmmu54iascbjsk3sluo@w4jjihiz5jzr>
 <CAJuCfpFVopL+sMdU4bLRxs+HS_WPCmFZBdCmwE8qV2Dpa5WZnA@mail.gmail.com> <e728af67-4f7b-43ef-8fe5-0eec4064c625@suse.cz>
In-Reply-To: <e728af67-4f7b-43ef-8fe5-0eec4064c625@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 17 Mar 2025 11:56:24 -0700
X-Gm-Features: AQ5f1Jp-bP5tyLKVEt7RtnCv14x5n4T-1IJfdl8gDBhMeAIjP-Cb1869hDZGiPk
Message-ID: <CAJuCfpGW1mf9H6FW-6rDT1C4=78frOfD2Mftj_83QdfK=S2O5Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 4:08=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 3/14/25 18:10, Suren Baghdasaryan wrote:
> > On Tue, Mar 4, 2025 at 11:08=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> >>
> >> * Vlastimil Babka <vbabka@suse.cz> [250304 05:55]:
> >> > On 2/25/25 21:26, Suren Baghdasaryan wrote:
> >> > > On Mon, Feb 24, 2025 at 1:12=E2=80=AFPM Suren Baghdasaryan <surenb=
@google.com> wrote:
> >> > >>
> >> > >> >
> >> > >> > > The values represent the total time it took to perform mmap s=
yscalls, less is
> >> > >> > > better.
> >> > >> > >
> >> > >> > > (1)                  baseline       control
> >> > >> > > Little core       7.58327       6.614939 (-12.77%)
> >> > >> > > Medium core  2.125315     1.428702 (-32.78%)
> >> > >> > > Big core          0.514673     0.422948 (-17.82%)
> >> > >> > >
> >> > >> > > (2)                  baseline      control
> >> > >> > > Little core       7.58327       5.141478 (-32.20%)
> >> > >> > > Medium core  2.125315     0.427692 (-79.88%)
> >> > >> > > Big core          0.514673    0.046642 (-90.94%)
> >> > >> > >
> >> > >> > > (3)                   baseline      control
> >> > >> > > Little core        7.58327      4.779624 (-36.97%)
> >> > >> > > Medium core   2.125315    0.450368 (-78.81%)
> >> > >> > > Big core           0.514673    0.037776 (-92.66%)
> >> > >
> >> > > (4)                   baseline      control
> >> > > Little core        7.58327      4.642977 (-38.77%)
> >> > > Medium core   2.125315    0.373692 (-82.42%)
> >> > > Big core           0.514673    0.043613 (-91.53%)
> >> > >
> >> > > I think the difference between (3) and (4) is noise.
> >> > > Thanks,
> >> > > Suren.
> >> >
> >> > Hi, as we discussed yesterday, it would be useful to set the baselin=
e to
> >> > include everything before sheaves as that's already on the way to 6.=
15, so
> >> > we can see more clearly what sheaves do relative to that. So at this=
 point
> >> > it's the vma lock conversion including TYPESAFE_BY_RCU (that's not u=
ndone,
> >> > thus like in scenario (4)), and benchmark the following:
> >> >
> >> > - baseline - vma locking conversion with TYPESAFE_BY_RCU
> >> > - baseline+maple tree node reduction from mm-unstable (Liam might po=
int out
> >> > which patches?)
> >>
> >> Sid's patches [1] are already in mm-unstable.
> >>
> >>
> >> > - the above + this series + sheaves enabled for vm_area_struct cache
> >> > - the above + full maple node sheaves conversion [1]
> >> > - the above + the top-most patches from [1] that are optimizations w=
ith a
> >> > tradeoff (not clear win-win) so it would be good to know if they are=
 useful
> >> >
> >> > [1] currently the 4 commits here:
> >> > https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git=
/log/?h=3Dslub-percpu-sheaves-v2-maple
> >> > from "maple_tree: Sheaf conversion" to "maple_tree: Clean up sheaf"
> >> > but as Liam noted, they won't cherry pick without conflict once mapl=
e tree
> >> > node reduction is backported, but he's working on a rebase
> >>
> >> Rebased maple tree sheaves, patches are here [2].
> >
> > Hi Folks,
> > Sorry for the delay. I got the numbers last week but they looked a bit
> > weird, so I reran the test increasing the number of iterations to make
> > sure noise is not a factor. That took most of this week. Below are the
> > results. Please note that I had to backport the patchsets to 6.12
> > because that's the closest stable Android kernel I can use. I measure
> > cumulative time to execute mmap syscalls, so the smaller the number
> > the better mmap performance is:
>
> Is that a particular benchmark doing those syscalls, or you time them wit=
hin
> actual workloads?

I time them inside my workload.

>
> > baseline: 6.12 + vm_lock conversion and TYPESAFE_BY_RCU
> > config1: baseline + Sid's patches [1]
> > config2: sheaves RFC
> > config3: config1 + vm_area_struct with sheaves
> > config4: config2 + maple_tree Sheaf conversion [2]
> > config5: config3 + 2 last optimization patches from [3]
> >
> >                config1     config2     config3     config4     config5
> > Little core    -0.10%      -10.10%     -12.89%     -10.02%     -13.64%
> > Mid core       -21.05%     -37.31%     -44.97%     -15.81%     -22.15%
> > Big core       -17.17%     -34.41%     -45.68%     -11.39%     -15.29%
>
> Thanks a lot, Suren.
>
> > [1] https://lore.kernel.org/linux-mm/20250227204823.758784-1-sidhartha.=
kumar@oracle.com/
> > [2] https://www.infradead.org/git/?p=3Dusers/jedix/linux-maple.git;a=3D=
shortlog;h=3Drefs/heads/sheaves_rebase_20250304
> > [3] https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.gi=
t/log/?h=3Dslub-percpu-sheaves-v2-maple
> >
> > From the numbers, it looks like config4 regresses the performance and
> > that's what looked weird to me last week and I wanted to confirm this.
> > But from sheaves POV, it looks like they provide the benefits I saw
> > before. Sid's patches which I did not test separately before also look
> > beneficial.
>
> Indeed, good job, Sid. It's weird that config4 isn't doing well. The prob=
lem
> can be either in sheaves side (the sheaves preallocation isn't effective)=
 or
> maple tree side doing some excessive work. It could be caused by the wron=
g
> condition in kmem_cache_return_sheaf() that Harry pointed out, so v3 migh=
t
> improve if that was it. Otherwise we'll probably need to fill the gaps in
> sheaf-related stats and see what are the differences between config3 and
> config4.
>
> > Thanks,
> > Suren.
> >
> >>
> >>
> >> >
> >> >
> >> ...
> >>
> >> Thanks,
> >> Liam
> >>
> >> [1]. https://lore.kernel.org/linux-mm/20250227204823.758784-1-sidharth=
a.kumar@oracle.com/
> >> [2]. https://www.infradead.org/git/?p=3Dusers/jedix/linux-maple.git;a=
=3Dshortlog;h=3Drefs/heads/sheaves_rebase_20250304
>
