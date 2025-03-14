Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023F017579
	for <rcu@vger.kernel.org>; Fri, 14 Mar 2025 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972237; cv=none; b=rEsUAZrLZRTc88wM7a5zhq00LCdVICtgiV1eYDs6LLrZ5ZemUt+i+NakMePZ8Tn89sscoWAZnCir348S1SeAalE6Dc7Ixm4IoCDRqEnp7KntUQ1OIHAULEV/pBAsKZXzk9V2fLtMpWWM9OAewLKwNDefQQl5e5pPNNqDxRCToSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972237; c=relaxed/simple;
	bh=fZLD1w5OTYWmuxjNNme0MtrVD/MUya9rZScKtXEj+Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=g7ckuUh19KUok0CWb8u5sVFTB2H0bkeMgtEyVJPgiNyjLWlSAOfuS3GLrJzDOoXcyrgDuR30TWztqdz9hVSe/+vNYoI1kQR2Fx8W0eUgvMb0mT9tALxhabRWrczbrihExdHp2WHlC+iLTRcUuO6f7XMISKvQ2+ZUeX0bSlNVj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lLYY5z8f; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLYY5z8f"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47681dba807so7511cf.1
        for <rcu@vger.kernel.org>; Fri, 14 Mar 2025 10:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741972235; x=1742577035; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EWHBV9blsC4VUtgf9tmLM/z12+DckHNCkeHcX1VEX4=;
        b=lLYY5z8flTTN5c3nalYVYrQijq8OfRlu2JYGFi7QJG/s1W/45sybU+iO6x+pBuWYnF
         rPnr3M1sgOfthnyYJsZyQ7+dK2wJvINCievh0SriaaGpamgbZh665Fb3HM7IC1UnwtKF
         WGHgNk74UDWCRhe4XfNW0RkuWkIXLNqoI5l6c/noDEhYWQQ4xjRbIJwooyLCR573ULIl
         sL8f63cYRsDxCL9a9wD6BU98+Dx//8hVGfRIo0V2UfJiorg3nJlBQ9ysu2xZRjiYdvDU
         36eFhYjhTHV6tcbMbWiV6rqd6DqRKLPWG2d3CnWaDK92XWPh+qE3A/jLti3zXWRLXgQW
         wPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741972235; x=1742577035;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EWHBV9blsC4VUtgf9tmLM/z12+DckHNCkeHcX1VEX4=;
        b=m2PZfHvedw0nkyMOTHE7TRAINFm9iZLxFlqiYiXKZ5PrTSQX38/aFfTkWyb5j2FWEO
         dJYib64dqBgxYFhv5m/GqxeOX/0c9RDbQQe+jS6q3TxLTcLV9jM95DKUJ+3XegTwQN8u
         n7Vs3KKvNF4RVeOdFQFq9BGhVhu00JHFa8Qv79UxWo8rlbXxgQYdJwpdHLgAxpXDnKOM
         whaTcAQfnkFa8RAivH0r/WXZYCfFpsYAJnpDweSuRI5GGLoK8XOOAEV/F1NsHiv/oFaT
         3YJeLgZ9hBwJILw5koqzO9SujBPkg0bdMwM405vTz02NI+6pP/bpyRpS//BggzxXdy0r
         tMww==
X-Forwarded-Encrypted: i=1; AJvYcCVI1iCLjQTfGQeEA80GdXCvsZ+koAsplbvZeFyle7V42ZBitn2hjQXa3pVTpkCDUNa7lck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAt5aWiDK+h7CFx/3/gPVwFhrDOg6ut3pEiT8I8UkpxfrwHlA
	IhM02KKYhn29kQ+fyJ944cwCOiMWuGMlxeo8l8OUVz7PiHi6cKisB5xqN5IGEqZlo2TEP9HLjHA
	kMFNDCeZkwkS7NZF+ALGoX9esdC7THR58NBLU
X-Gm-Gg: ASbGncucI/5LAwkANQbkKOh4B6ALv77Agx2gnKFXu6hLsHw8ZzApSDgknlPDFMmwxr7
	wmbcRCcIQPR24hZDzVmTaGU7r8AY1+yTTZTp1n3p3GAbVbwdc0IASQ4dZ9LrwIlXUCO/rIe4xhZ
	y4tpfhqJ24/PCqQTMDPqhUbkJuXg==
X-Google-Smtp-Source: AGHT+IGJHHQF4NTn6NB5LyU5PLdvXbvdu8URRo9QL8eVBvNhUTnHirCkG4lnLyzQ9QiIKZuvzTbY1DBtZlnZfbcpR3A=
X-Received: by 2002:ac8:7d0a:0:b0:466:8887:6751 with SMTP id
 d75a77b69052e-476c7fe8345mr3392701cf.23.1741972234384; Fri, 14 Mar 2025
 10:10:34 -0700 (PDT)
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
In-Reply-To: <ape445nrqgod4ivtzcwacmfdshi3fgcqmmu54iascbjsk3sluo@w4jjihiz5jzr>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 14 Mar 2025 10:10:23 -0700
X-Gm-Features: AQ5f1JrG8no_e7JHX8g1zQia30PtCt7dt-uwm8dg_Hv_0Iod5LHZmZ0lPg9sYMk
Message-ID: <CAJuCfpFVopL+sMdU4bLRxs+HS_WPCmFZBdCmwE8qV2Dpa5WZnA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 11:08=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Vlastimil Babka <vbabka@suse.cz> [250304 05:55]:
> > On 2/25/25 21:26, Suren Baghdasaryan wrote:
> > > On Mon, Feb 24, 2025 at 1:12=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > >>
> > >> >
> > >> > > The values represent the total time it took to perform mmap sysc=
alls, less is
> > >> > > better.
> > >> > >
> > >> > > (1)                  baseline       control
> > >> > > Little core       7.58327       6.614939 (-12.77%)
> > >> > > Medium core  2.125315     1.428702 (-32.78%)
> > >> > > Big core          0.514673     0.422948 (-17.82%)
> > >> > >
> > >> > > (2)                  baseline      control
> > >> > > Little core       7.58327       5.141478 (-32.20%)
> > >> > > Medium core  2.125315     0.427692 (-79.88%)
> > >> > > Big core          0.514673    0.046642 (-90.94%)
> > >> > >
> > >> > > (3)                   baseline      control
> > >> > > Little core        7.58327      4.779624 (-36.97%)
> > >> > > Medium core   2.125315    0.450368 (-78.81%)
> > >> > > Big core           0.514673    0.037776 (-92.66%)
> > >
> > > (4)                   baseline      control
> > > Little core        7.58327      4.642977 (-38.77%)
> > > Medium core   2.125315    0.373692 (-82.42%)
> > > Big core           0.514673    0.043613 (-91.53%)
> > >
> > > I think the difference between (3) and (4) is noise.
> > > Thanks,
> > > Suren.
> >
> > Hi, as we discussed yesterday, it would be useful to set the baseline t=
o
> > include everything before sheaves as that's already on the way to 6.15,=
 so
> > we can see more clearly what sheaves do relative to that. So at this po=
int
> > it's the vma lock conversion including TYPESAFE_BY_RCU (that's not undo=
ne,
> > thus like in scenario (4)), and benchmark the following:
> >
> > - baseline - vma locking conversion with TYPESAFE_BY_RCU
> > - baseline+maple tree node reduction from mm-unstable (Liam might point=
 out
> > which patches?)
>
> Sid's patches [1] are already in mm-unstable.
>
>
> > - the above + this series + sheaves enabled for vm_area_struct cache
> > - the above + full maple node sheaves conversion [1]
> > - the above + the top-most patches from [1] that are optimizations with=
 a
> > tradeoff (not clear win-win) so it would be good to know if they are us=
eful
> >
> > [1] currently the 4 commits here:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/lo=
g/?h=3Dslub-percpu-sheaves-v2-maple
> > from "maple_tree: Sheaf conversion" to "maple_tree: Clean up sheaf"
> > but as Liam noted, they won't cherry pick without conflict once maple t=
ree
> > node reduction is backported, but he's working on a rebase
>
> Rebased maple tree sheaves, patches are here [2].

Hi Folks,
Sorry for the delay. I got the numbers last week but they looked a bit
weird, so I reran the test increasing the number of iterations to make
sure noise is not a factor. That took most of this week. Below are the
results. Please note that I had to backport the patchsets to 6.12
because that's the closest stable Android kernel I can use. I measure
cumulative time to execute mmap syscalls, so the smaller the number
the better mmap performance is:

baseline: 6.12 + vm_lock conversion and TYPESAFE_BY_RCU
config1: baseline + Sid's patches [1]
config2: sheaves RFC
config3: config1 + vm_area_struct with sheaves
config4: config2 + maple_tree Sheaf conversion [2]
config5: config3 + 2 last optimization patches from [3]

               config1     config2     config3     config4     config5
Little core    -0.10%      -10.10%     -12.89%     -10.02%     -13.64%
Mid core       -21.05%     -37.31%     -44.97%     -15.81%     -22.15%
Big core       -17.17%     -34.41%     -45.68%     -11.39%     -15.29%

[1] https://lore.kernel.org/linux-mm/20250227204823.758784-1-sidhartha.kuma=
r@oracle.com/
[2] https://www.infradead.org/git/?p=3Dusers/jedix/linux-maple.git;a=3Dshor=
tlog;h=3Drefs/heads/sheaves_rebase_20250304
[3] https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/lo=
g/?h=3Dslub-percpu-sheaves-v2-maple

From the numbers, it looks like config4 regresses the performance and
that's what looked weird to me last week and I wanted to confirm this.
But from sheaves POV, it looks like they provide the benefits I saw
before. Sid's patches which I did not test separately before also look
beneficial.
Thanks,
Suren.

>
>
> >
> >
> ...
>
> Thanks,
> Liam
>
> [1]. https://lore.kernel.org/linux-mm/20250227204823.758784-1-sidhartha.k=
umar@oracle.com/
> [2]. https://www.infradead.org/git/?p=3Dusers/jedix/linux-maple.git;a=3Ds=
hortlog;h=3Drefs/heads/sheaves_rebase_20250304
