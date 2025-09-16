Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189832C11F0
	for <rcu@vger.kernel.org>; Tue, 16 Sep 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042574; cv=none; b=fwIB0S5FXxCLFQ2ClTBTltHQM6deGf/Jwwv45L6Ben4X9v2BE6ktFh1EcnjuonDSzRH1oVvW6lOgzQP3zClqvjPeWPviTmjwi4+rRYTEwdZmodiF7pdt47J9By27WRnFFmnRAeHfuicPtTh6jtW5AZFs5MOWUqbW5zMPtC2r5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042574; c=relaxed/simple;
	bh=W7Xl1USRfP3WXgLE3mHI0Iy7kOHxnnkysA+hsWz5+9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W95KrQEE73gKyeV96osTFvEHif+gGl+BOQdfvG+JrsCyJsZM5lz/jA3i5QR5lTTqnhkl1oG1hL446uOED+NMKo5c2X1w2iC3f+lAeGBEu0ifc2WWKS7rvCOKsnLKeQRexlZ6S1yELK3S1Tgw7t4/X74+Roi72Mun7x2++UP7aO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQGh0I8s; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQGh0I8s"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b796ff6d45so18321cf.1
        for <rcu@vger.kernel.org>; Tue, 16 Sep 2025 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758042571; x=1758647371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nObP271o7zKWD/o6CXr8B27todJQZZ/TCUsecAu7bQ=;
        b=tQGh0I8swfAsFdejLDIoUcHT5WnpwI7IHilvxlg+usrriZ3uMV0YzgUgWOMogZXugC
         di9odlk+Ak2fgtbk3It1XyWF4zGcsexBAjERuuN2+ZDCL3SeQbOX8QXrfde9BgQQdzso
         RK09VWuNnB0vJD3tGGfTsUykLz5mnLBhnsdxoV9e/HMIhV1TbfJfUlayg3SGXnT/xNfu
         spq97jNT1K4VP6RJHuQFsD9A4Iz+c2W4ABWD7pvmp/75kQQ1pQhpXCDiqAW0X9h0THAY
         ev61ozYLqVpS2obZ+yv0C4scpUqF5iHYkX6YPiEGqtlzrOQu4doHbodAoeI/CpG1GlvI
         uVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042571; x=1758647371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nObP271o7zKWD/o6CXr8B27todJQZZ/TCUsecAu7bQ=;
        b=rN/aVQUhKCHMEpjjzjkzFnLNXcPvSnIP3rnEmHv5i0hAlqH4rAREEamKacbsquG8Cu
         QzspkCoKkZ8sqsmo6S/POCAP40b6PSYrUEdnUhx90fPfaQb2y9LLvikgKVC84G29KDg5
         rdXDD7DVZHB9KSknLrIgT4n8BwKDIP1yRXxL5Lq9gH3ghKTZTBvkrGkuoDsS5/R7Dvel
         d39S7/qQpC2eurwDd/TPUzV1brf2S9BsII0xLXpnVHUkgVbwdQQdXoWvokL/UErQgrG8
         8J56lPz9tqaudIW4oUPBRhB2iSKWPpmO0ZPATtpagXD7iNCjUT4q3fVGgX595bjyVShf
         6VpQ==
X-Forwarded-Encrypted: i=1; AJvYcCULIAauyU52mcZ3wze8fS2NBxKN0xe50Muqufqo4C8xUKc/hz9SJp8XFZiUa9scAVtPKT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCHeb22aKDeidZtJUf9+qlsq45kXGL24gnCIU3VP7kws6lhvi
	jVPNkRPuSDkO2eU/UwxPuDAd766zcQMZ62xf3Xy35JEFecqOysQX/vep8lNP4sBj1y9XIqaSPxH
	FDWgWCvNTx6ZzoX14T+5FIQ3pxNRCyRUA2Xy69FM6
X-Gm-Gg: ASbGnctkXSrAAeg9QUawg+j3wUbRJX/WmNrV0d3Qo67znVHkKipvdAlDoanhqi0jpzP
	5RYVgFS+bOe2Je2mZNTsmBhDxyKnRNy1XG7XE90CSZ9aLN/63P01MD+PrFDAKzlYcK3Y+hY8jsR
	IuXjMydhR9PUPCJ6MA+4XPLld1FY3ltoMo+qY8gk7gmzagM7IqrGkIE2rWvuKx2yHrgcFJpfjpV
	4Peq8irTVVHWBo6UUEJfdMRB1gLWLOQelRYiPjbkVKr
X-Google-Smtp-Source: AGHT+IHlnZD0xzveloqY1NwivFqIQ3M/IVLjLUBP4FRJ+7Uqzu5AIbMylt6KL7+KR956Bl7yUYehkcOeC/F8nnahyEY=
X-Received: by 2002:ac8:7c56:0:b0:4b3:1617:e617 with SMTP id
 d75a77b69052e-4b7b2d81b34mr6548031cf.11.1758042570374; Tue, 16 Sep 2025
 10:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250913000935.1021068-1-sudarsanm@google.com> <qs3967pq-4nq7-67pq-2025-r7259o0s52p4@vanv.qr>
 <f5792407-d2b9-42b3-bc85-ed14eac945ec@paulmck-laptop> <d1ef1cbb-c18d-4da6-b56b-342e86dca525@suse.cz>
In-Reply-To: <d1ef1cbb-c18d-4da6-b56b-342e86dca525@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Sep 2025 10:09:18 -0700
X-Gm-Features: AS18NWBm5mFEewsCE7hgqPbGCMob1rkMeU0y4GD4Rj9Jw-SRj0_ytqyTNwX9TZE
Message-ID: <CAJuCfpEQ=RUgcAvRzE5jRrhhFpkm8E2PpBK9e9GhK26ZaJQt=Q@mail.gmail.com>
Subject: Re: Benchmarking [PATCH v5 00/14] SLUB percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: paulmck@kernel.org, Jan Engelhardt <ej@inai.de>, 
	Sudarsan Mahendran <sudarsanm@google.com>, Liam.Howlett@oracle.com, cl@gentwo.org, 
	harry.yoo@oracle.com, howlett@gmail.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maple-tree@lists.infradead.org, rcu@vger.kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:22=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/15/25 14:13, Paul E. McKenney wrote:
> > On Mon, Sep 15, 2025 at 09:51:25AM +0200, Jan Engelhardt wrote:
> >>
> >> On Saturday 2025-09-13 02:09, Sudarsan Mahendran wrote:
> >> >
> >> >Summary of the results:
>
> In any case, thanks a lot for the results!
>
> >> >- Significant change (meaning >10% difference
> >> >  between base and experiment) on will-it-scale
> >> >  tests in AMD.
> >> >
> >> >Summary of AMD will-it-scale test changes:
> >> >
> >> >Number of runs : 15
> >> >Direction      : + is good
> >>
> >> If STDDEV grows more than mean, there is more jitter,
> >> which is not "good".
> >
> > This is true.  On the other hand, the mean grew way more in absolute
> > terms than did STDDEV.  So might this be a reasonable tradeoff?
>
> Also I'd point out that MIN of TEST is better than MAX of BASE, which mea=
ns
> there's always an improvement for this config. So jitter here means it's
> changing between better and more better :) and not between worse and (mor=
e)
> better.
>
> The annoying part of course is that for other configs it's consistently t=
he
> opposite.

Hi Vlastimil,
I ran my mmap stress test that runs 20000 cycles of mmapping 50 VMAs,
faulting them in then unmapping and timing only mmap and munmap calls.
This is not a realistic scenario but works well for A/B comparison.

The numbers are below with sheaves showing a clear improvement:

Baseline
            avg             stdev
mmap        2.621073        0.2525161631
munmap      2.292965        0.008831973052
total       4.914038        0.2572620923

Sheaves
            avg            stdev           avg_diff        stdev_diff
mmap        1.561220667    0.07748897037   -40.44%        -69.31%
munmap      2.042071       0.03603083448   -10.94%        307.96%
total       3.603291667    0.113209047     -26.67%        -55.99%

Stdev for munmap went high but I see that there was only one run that
was very different from others, so that might have been just a noisy
run.

One thing I noticed is that with my stress testing mmap/munmap in a
loop we get lots of in-flight freed-by-RCU sheaves before the grace
period arrives and they get freed in bulk. Note that Android enables
lazy RCU config, so that affects the grace period and makes it longer
than normal. This results in sheaves being freed in bulk and when that
happens, the barn gets quickly full (we only have 10
(MAX_FULL_SHEAVES) free slots), the rest of the sheaves being freed
are destroyed instead of being reused.

I tried two modifications:
1. Use call_rcu_hurry() instead of call_rcu() when freeing the
sheaves. This should remove the effects of lazy RCU;
2. Keep a running count of in-flight RCU-freed sheaves and once it
reaches the number of free slots for full sheaves in the barn, I
schedule an rcu_barrier() to free all these in-flight sheaves. Note
that I added an additional condition to skip this RCU flush if the
number of free slots for full sheaves is less than MAX_FULL_SHEAVES/2.
That should prevent flushing to free only a small number of sheaves.

With these modifications the numbers get even better:

Sheaves with call_rcu_hurry
            avg                            avg_diff (vs Baseline)
mmap        1.279308                       -51.19%
munmap      1.983921                       -13.48%
total       3.263228                       -33.59%

Sheaves with rcu_barrier
            avg                            avg_diff (vs Baseline)
mmap        1.210455                       -53.82%
munmap      1.963739                       -14.36%
total       3.174194                       -35.41%

I didn't capture stdev because I did not run as many times as the
first two configurations.

Again, the tight loop in my test is not representative of a real
workloads and the numbers are definitely affected by the use of lazy
RCU mode in Android. While this information can be used for later
optimizations, I don't think these findings should block current
deployment of the sheaves.
Thanks,
Suren.


>
> > Of course, if adjustments can be made to keep the increase in mean whil=
e
> > keeping STDDEV low, that would of course be even better.
> >
> >                                                       Thanx, Paul
> >
> >> >|            | MIN        | MAX        | MEAN       | MEDIAN     | ST=
DDEV     |
> >> >|:-----------|:-----------|:-----------|:-----------|:-----------|:--=
---------|
> >> >| brk1_8_processes
> >> >| BASE       | 7,667,220  | 7,705,767  | 7,682,782  | 7,676,211  | 12=
,733     |
> >> >| TEST       | 9,477,395  | 10,053,058 | 9,878,753  | 9,959,360  | 18=
2,014    |
> >> >| %          | +23.61%    | +30.46%    | +28.58%    | +29.74%    | +1=
,329.46% |
> >> >
> >> >| mmap2_256_processes
> >> >| BASE       | 7,483,929  | 7,532,461  | 7,491,876  | 7,489,398  | 11=
,134     |
> >> >| TEST       | 11,580,023 | 16,508,551 | 15,337,145 | 15,943,608 | 1,=
489,489  |
> >> >| %          | +54.73%    | +119.17%   | +104.72%   | +112.88%   | +1=
3,276.75%|
> >>
>
