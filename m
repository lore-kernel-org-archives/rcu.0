Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037624C090
	for <rcu@vger.kernel.org>; Tue,  4 Mar 2025 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113327; cv=none; b=Aw1qvPhUx2eyV+j1EdI91slcpmvJ0R7rQZef9DcjhJWI6lP4BkBGJsBtL2FQCUUTqMXzaPlF6ObfhZZa++UYWbFv56ZLltbO1Mkgx6aG3YHKzLOmZ+4FJUWr8gptstnb1l/KZs/k95H5agyJ56ouTLW+anlpWCa8NR2MKFh2vMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113327; c=relaxed/simple;
	bh=rmqIxeLRyZ4MRFodNpW8/HMglrn0z0awEKd7PNYXyd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ievPYguC+ygsQtY9pOMCrJ/+eunfyCLehiOphsgj8zEcTyZPXxRi/BrjPAXfscLMZGGTZv89n+MP/Xd/qEpjEf3yTDJZ+1/elmOr4zTs5GBteYySqQ7KMDnNWvzJJkWP9pRNtlErdCYUbzFqApc5lqfcN4MsEA0q99JzODanPbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEWyyATP; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEWyyATP"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-472098e6e75so12841cf.1
        for <rcu@vger.kernel.org>; Tue, 04 Mar 2025 10:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741113324; x=1741718124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE5nK4GFeJJ6OO4073CP21uOwPN4nuaYHAb6WJCLI3A=;
        b=uEWyyATPX4JAjzb+sX/y3erQfjZ3XKhdIM80A6faJF0wXQw3WwvDzs2cqxlJotQtvc
         0NKSmj76X+eNHmVkgWv25DQHFrrMJ+Oh87zVkZbJsj0fS+/JOYUuhMgUswzYVNkbyR5U
         oiEDpjK9p2maW7FHr0063Nc6x45i+z1ImFXF1mJyhF3NkEng08WcGfeh80uhYDaqq8sW
         ZRgcgBWNp324hEkQ4QIvSg3HxoSUERU/j6ejxgE4jtAvKUyd1Mz/B+CX4XGHmzGwdJgL
         BGgflHg6/6497T/iFEy4T+W+fN/os87MSllbhV6Au1NumJmeVt2GbKI67m5g6EcxOswi
         gSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741113324; x=1741718124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE5nK4GFeJJ6OO4073CP21uOwPN4nuaYHAb6WJCLI3A=;
        b=ZITAqjNzSRLII6jKwoqlngVRJpXGbdOMQRj4nGffmTZ33rs2zPzM7pyGgdp3kqlu0Y
         gIJ9M6RPVGOapbr1Hydu3ZAyMPaKuT15GkoKOxgC5y3Cv4xq60MQpmHjIcFgpcahhPd5
         ACj86D7HL0gpiYJBD3R3CKSnfqhOHnKluIQZRXesznifHkbENDV2gCRldq3xK4hq1Tf6
         cJUf9cV9Etr9cJ+5RTj+F0QFgq3aIANY6LnOeVItD5g555eIcMVrbUcGw1Azkq2iKm6C
         x3OisUlZ9g5jzZX96Y1ExVMrqBIcfR5exDRJYKK+advucDyZrwDA2EPXCcP8raFuNN1R
         jxkw==
X-Forwarded-Encrypted: i=1; AJvYcCVYdp8IvinBaUGkIJbVOIUo0YWU1yaUqs6Ii1VY/bDbAmxqKwzUVMnr/Vtme5T1hxMQbPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Gv9cMKz+2yxMpxg9QHqXm6ShQDPY/JMO650KHsFLhiJ9ALRm
	kvFq3Sz04hMzXmg2sYUku6h5LCTaFik6/XdGpSgIcPYUEBGTULmSuhtjHtDCCnbXInVbPvQwtmD
	FUjMI/kp/4aDooBXjddKc3EwbHdZudpbhLLHL
X-Gm-Gg: ASbGnctDHF6p9EOvFs80xN7s7y9NR20R/e2QgF8cDVJ0cF5FzU40jB47Ohj+swTic/4
	FFer3vbuE27omvoKbjk9RAZFW0xip6V/tzY7VsKNd3fxca92EyMA9Xe7O45U4NTYEnENAkvyVN9
	Q3XXhmhEZjgsEEdd8QKT+no4ypv93etg7ayCPTb3eZz/C0RdMZdJm4vE9E
X-Google-Smtp-Source: AGHT+IE0ojfFK56Nsc3hks2mutUiZjNncnjFf0jJTwub5pXkrgW/XbWDNcjElNzyhKr+WIvjR4oqHA7Mz9eABlzihIM=
X-Received: by 2002:ac8:5e49:0:b0:472:8ac:7d3d with SMTP id
 d75a77b69052e-4750a596138mr793651cf.29.1741113323385; Tue, 04 Mar 2025
 10:35:23 -0800 (PST)
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
 <CAJuCfpE7t83PKWw+8XJLE5538kKJnbhirLg2siDSw=F4sw=9uA@mail.gmail.com> <19df9218-c984-4cbc-8b5d-4e0f7658935f@suse.cz>
In-Reply-To: <19df9218-c984-4cbc-8b5d-4e0f7658935f@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 4 Mar 2025 10:35:12 -0800
X-Gm-Features: AQ5f1JouTAVSQFXAmbLWqUnRspW1HmqjJwV-_XkDFpiV6uDsQZI3IuNVoE7yJ74
Message-ID: <CAJuCfpG2U0DW2PubJw6aAwf2VLdy8Y9ov5iwt7nkn9XskBc6Ww@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 2:55=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 2/25/25 21:26, Suren Baghdasaryan wrote:
> > On Mon, Feb 24, 2025 at 1:12=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> >
> >> > > The values represent the total time it took to perform mmap syscal=
ls, less is
> >> > > better.
> >> > >
> >> > > (1)                  baseline       control
> >> > > Little core       7.58327       6.614939 (-12.77%)
> >> > > Medium core  2.125315     1.428702 (-32.78%)
> >> > > Big core          0.514673     0.422948 (-17.82%)
> >> > >
> >> > > (2)                  baseline      control
> >> > > Little core       7.58327       5.141478 (-32.20%)
> >> > > Medium core  2.125315     0.427692 (-79.88%)
> >> > > Big core          0.514673    0.046642 (-90.94%)
> >> > >
> >> > > (3)                   baseline      control
> >> > > Little core        7.58327      4.779624 (-36.97%)
> >> > > Medium core   2.125315    0.450368 (-78.81%)
> >> > > Big core           0.514673    0.037776 (-92.66%)
> >
> > (4)                   baseline      control
> > Little core        7.58327      4.642977 (-38.77%)
> > Medium core   2.125315    0.373692 (-82.42%)
> > Big core           0.514673    0.043613 (-91.53%)
> >
> > I think the difference between (3) and (4) is noise.
> > Thanks,
> > Suren.
>
> Hi, as we discussed yesterday, it would be useful to set the baseline to
> include everything before sheaves as that's already on the way to 6.15, s=
o
> we can see more clearly what sheaves do relative to that. So at this poin=
t
> it's the vma lock conversion including TYPESAFE_BY_RCU (that's not undone=
,
> thus like in scenario (4)), and benchmark the following:
>
> - baseline - vma locking conversion with TYPESAFE_BY_RCU
> - baseline+maple tree node reduction from mm-unstable (Liam might point o=
ut
> which patches?)
> - the above + this series + sheaves enabled for vm_area_struct cache
> - the above + full maple node sheaves conversion [1]
> - the above + the top-most patches from [1] that are optimizations with a
> tradeoff (not clear win-win) so it would be good to know if they are usef=
ul
>
> [1] currently the 4 commits here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/=
?h=3Dslub-percpu-sheaves-v2-maple
> from "maple_tree: Sheaf conversion" to "maple_tree: Clean up sheaf"
> but as Liam noted, they won't cherry pick without conflict once maple tre=
e
> node reduction is backported, but he's working on a rebase
>
> Thanks in advance!

Sure, I'll run the tests and post results sometime later this week.
Thanks!

>
> >> > >
> >> > > Results in (3) vs (2) indicate that using sheaves for vm_area_stru=
ct
> >> > > yields slightly better averages and I noticed that this was mostly=
 due
> >> > > to sheaves results missing occasional spikes that worsened
> >> > > TYPESAFE_BY_RCU averages (the results seemed more stable with
> >> > > sheaves).
> >> >
> >> > Thanks a lot, that looks promising!
> >>
> >> Indeed, that looks better than I expected :)
> >> Cheers!
> >>
> >> >
> >> > > [1] https://lore.kernel.org/all/20250213224655.1680278-1-surenb@go=
ogle.com/
> >> > >
> >> >
>
