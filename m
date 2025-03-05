Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE38192D6B;
	Wed,  5 Mar 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193006; cv=none; b=Yq0Qm52VqnNXz5l4YZMnIBgfKBJgXhpwodNRwER64yuAPTGVsAzxwxolQCA3bSSGsyHeCUfLJK+CZXA9DAiD4SmTMo1Tstr6Toh/6RHjUc46asdlQla24Q+5dkbqX+r44Wcg/+DFO+0UAMrBnf18VkoRq/6uzeVXyVC2Fw68zfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193006; c=relaxed/simple;
	bh=D54brKj2k4mVzL1R3ITiF1HkdvF55vUdSel/cHLvHOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRK00sd0ORAPC1Lmer3iErl7EiedHWyys01NQfB6bT8CT7IMohE6cb6MeC9N2fSz5j5OrrVGvYyZ+/a4M4LBW093Uo0wSRBvv6H4GX9j2+x8otusw5hfrxr9hEk+7qzQZeKIBjpAPpwJfjNFDp2PLALeelrPYsXLrUg8lKAfA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae2LsT9P; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae2LsT9P"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd420f82e2so94544916d6.1;
        Wed, 05 Mar 2025 08:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741193003; x=1741797803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2DLcCiSDEUX5+u0VzLZ6yND3L4BaRlr6z3gC+ePadL4=;
        b=Ae2LsT9PMvidkMWq933b4V57PtXWXjk2vdW92oFYXstWZbNa/30ZaaNJ3wgkARKBJG
         rMo1k9pCAgXW7Tb2ljNqMJ22htBY6XkXvTNuum/HcIe4lQucQyMMoRZhvBLLZ8pVJ9l7
         TIKs9TiiByCVBYrmuIfxKN7Mvkk+QvqEVYXBF0YiU5ei4skWTPof1XtLW51x3jTVasxv
         dgZsqNkhnSD91ynmned/VYpLL4efbFusCULabjtWNiih/IxD9X8QpG7wEzti4sF+GM6K
         fiHtiGQIQXDcR8GsHDRVjtciTsE7dQxYf2XsB/E8Vhem2avt16watsfm2HVMyb6libw/
         hUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741193003; x=1741797803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DLcCiSDEUX5+u0VzLZ6yND3L4BaRlr6z3gC+ePadL4=;
        b=EPdgmgJ0xfajiAqkZhmiCgd03dKs4q7gKDfqPDriuGZECC7dwDzAvLeyMhW4lVFD2g
         AIYmxoNi0WB+YxHr2xoH4arQmI3bk3SMbDKrhgjc2dhfFNmTI6ik2e/XYrGp6pFhVFVe
         eTBc6Lo5V1t5kWf1se5Z8yzbBfUYVug4EsW37xwIBrJIt7rVGCniwk/O/jMIXArU1w6Y
         VolsRc+7weMvXcZx9ts8SX7F4LRkBlgXMGetJ0YW0xomL+3FC+boBP8FTH1h6cQBuIw9
         pckAaaM+P6dp+Cra5fqNxGiLplnel665Z3BqSFzuPf2r8zs4VmlJLgS1Sz/2hajcpOuS
         G9ig==
X-Forwarded-Encrypted: i=1; AJvYcCWvwZoHk9e9XYxK+KoG0WTh9yn/MlgHk0/nYY+MmG4PvuHgdw6WOr7PifZ4A53a+4pUmHb1wlgnIetoFX0=@vger.kernel.org, AJvYcCXgD9Gqv8uSC+prRtvSPVfrglarub3CMbtgMx/n8+of2PAVfiDPGX0/JNcJoaaWwXU0+QNq@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqwmCXwux1cMCpE7x6juq5XSYW+yKrZ33g5HwxSohtw3x9kap
	Nc+xAlDT9WfYSqmpHYdGvy9RjwaA+FJJBG5q4fe51CKF+xiB4HUo
X-Gm-Gg: ASbGncvWaD7Z0EneUJopLqfl050CgJjErR9eSVe8GageRYDq0QTdXnRrt0+AkLnAY3c
	ooRgv4LqA/zbIySY/T4h5MuF9zO6wlY7eTc863hYghM+IxZOMnVyXfcgiYQXQzYHk3LekVA7vb0
	HI2l0bnuQOAEQYhdHEQl8Yn/6q9AAs1k73HOTI6/lfYiobdZaNfE8GrS8HqeiNwDTkyoSmUdYtg
	QHsg24htWB9YwZpy5ovCsVXHM0iIiqIptYpY3RIGo1y4FPgAWP/NKNrNe/9onaKzJHz9IhGKu6e
	zyih0iMbM8XEEk+kEtpTCpPdxDpYprOYw5CeSIKOCs87P1AkIp/4iaeC7LfOUnnFa82/1il+pUD
	5/QwmUWAcRnAMYGjE0zTcnICw1KtFGxu2tEY=
X-Google-Smtp-Source: AGHT+IE5Gb/CK8RVd/6ZvOQ4Xven3y7y2MDo51ByiGhxhI4QWKkKkuyRj65VpYNLC/zrG6eRu9ONjw==
X-Received: by 2002:ad4:5aa4:0:b0:6e8:9021:9090 with SMTP id 6a1803df08f44-6e8e6ce3a47mr50940506d6.26.1741193002657;
        Wed, 05 Mar 2025 08:43:22 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89766087dsm80982956d6.52.2025.03.05.08.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:43:22 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 89E3B1200066;
	Wed,  5 Mar 2025 11:43:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 05 Mar 2025 11:43:21 -0500
X-ME-Sender: <xms:KX_IZ7FiMGOuDwawn3MTDEQm1cljk_JHtFZyAbutLianiQxgUate3g>
    <xme:KX_IZ4UnZ3XuIvL7o3KIHo0aJVK5QlrxEINdQ5foP8D_PQfXEI_EQu63hiLxGlIQz
    TFgHKpJ7ILOoyBbQA>
X-ME-Received: <xmr:KX_IZ9KpaWYII4rW-SdCpKbemK8YFRFnEnzVHNfBdresdM8WjkwkoWLDwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddt
    tddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepgffhudetvdejueetieeijeejtdduhfdv
    ffdvjeehffdtheevtdeuhfeuheehiefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlvghonhihlhhgrghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvvghr
    rghjrdhuphgrughhhigrhiesrghmugdrtghomhdprhgtphhtthhopehprghulhhmtghkse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepthhhuhhnuggvrhdrlhgvihiihhgvnheshhhurgifvghirdgtoh
    hmpdhrtghpthhtohepfhhrrghnkhhjphhlihhusehtvghntggvnhhtrdgtohhmpdhrtghp
    thhtohepkhgvrhhnvghlgihinhhgsehtvghntggvnhhtrdgtohhmpdhrtghpthhtoheprh
    gtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KX_IZ5FmC3g0nIRGtWYUd7p8oympyGeD2yjXulfK9c0oDxECzeGdiQ>
    <xmx:KX_IZxW28OJcWBjWBSzI43RLkHYu9vEaJlcZZlTu5gW_Z68zOppCJg>
    <xmx:KX_IZ0MBV3Z-N2h5vt6ugUejUbfjaIQeGaSzhachJdMaM4HlubLfyA>
    <xmx:KX_IZw1Nj0SoMcrrbz4lEDFLdJSZdNGjAyeS8KJsMG6wQJ7HjrY6Gg>
    <xmx:KX_IZ2VJ6kahZYU_9QFXMbaL5to0erOQmwMaqh8arbk6KTMKRGvDaYeQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 11:43:20 -0500 (EST)
Date: Wed, 5 Mar 2025 08:43:18 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Yongliang Gao <leonylgao@gmail.com>
Cc: Neeraj.Upadhyay@amd.com, paulmck@kernel.org, frederic@kernel.org,
	thunder.leizhen@huawei.com, frankjpliu@tencent.com,
	kernelxing@tencent.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yongliang Gao <leonylgao@tencent.com>,
	kernel test robot <lkp@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3] rcu/cpu_stall_cputime: fix the hardirq count for x86
 architecture
Message-ID: <Z8h_Joy5zCuDpHbw@tardis>
References: <20250216084109.3109837-1-leonylgao@gmail.com>
 <Z7KfIm9c4WCpm0wR@Mac.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z7KfIm9c4WCpm0wR@Mac.home>

On Sun, Feb 16, 2025 at 06:29:54PM -0800, Boqun Feng wrote:
> Hi Yongliang,
>=20
> On Sun, Feb 16, 2025 at 04:41:09PM +0800, Yongliang Gao wrote:
> > From: Yongliang Gao <leonylgao@tencent.com>
> >=20
> > When counting the number of hardirqs in the x86 architecture,
> > it is essential to add arch_irq_stat_cpu to ensure accuracy.
> >=20
> > For example, a CPU loop within the rcu_read_lock function.
> >=20
> > Before:
> > [   70.910184] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [   70.910436] rcu:     3-....: (4999 ticks this GP) idle=3D***
> > [   70.910711] rcu:              hardirqs   softirqs   csw/system
> > [   70.910870] rcu:      number:        0        657            0
> > [   70.911024] rcu:     cputime:        0          0         2498   =3D=
=3D> 2498(ms)
> > [   70.911278] rcu:     (t=3D5001 jiffies g=3D3677 q=3D29 ncpus=3D8)
> >=20
> > After:
> > [   68.046132] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [   68.046354] rcu:     2-....: (4999 ticks this GP) idle=3D***
> > [   68.046628] rcu:              hardirqs   softirqs   csw/system
> > [   68.046793] rcu:      number:     2498        663            0
> > [   68.046951] rcu:     cputime:        0          0         2496   =3D=
=3D> 2496(ms)
> > [   68.047244] rcu:     (t=3D5000 jiffies g=3D3825 q=3D4 ncpus=3D8)
> >=20
> > Fixes: be42f00b73a0 ("rcu: Add RCU stall diagnosis information")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202501090842.SfI6QPGS-lkp=
@intel.com/
> > Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
> > Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> >=20
>=20
> Thank you for the patch, I have one minor question to x86 maintainers
> (Cced): does it make sense to fold the sum of arch_irq_stat_cpu() into
> kstat_cpu_irqs_sum()?
>=20

Queued for further tests and reviews, but my question for x86
maintainers remains ;-)

Regards,
Boqun

> Regards,
> Boqun
>=20
> > ---
> > Changes from v2:
> > - Add Reviewed-by 'Neeraj Upadhyay' information
> > - Link to v2: https://lore.kernel.org/all/20250109024652.1342595-1-leon=
ylgao@gmail.com
> > Changes from v1:
> > - Fix compilation error when using arm64-allnoconfig/riscv-randconfig. =
[kernel test robot]
> > - Link to v1: https://lore.kernel.org/r/20250108065716.2888148-1-leonyl=
gao%40gmail.com
> > ---
> > ---
> >  kernel/rcu/tree.c       | 10 +++++++---
> >  kernel/rcu/tree.h       |  2 +-
> >  kernel/rcu/tree_stall.h |  4 ++--
> >  3 files changed, 10 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 475f31deed14..a0dab5923d03 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -781,6 +781,10 @@ static int rcu_watching_snap_save(struct rcu_data =
*rdp)
> >  	return 0;
> >  }
> > =20
> > +#ifndef arch_irq_stat_cpu
> > +#define arch_irq_stat_cpu(cpu) 0
> > +#endif
> > +
> >  /*
> >   * Returns positive if the specified CPU has passed through a quiescen=
t state
> >   * by virtue of being in or having passed through an dynticks idle sta=
te since
> > @@ -916,9 +920,9 @@ static int rcu_watching_snap_recheck(struct rcu_dat=
a *rdp)
> >  			rsrp->cputime_irq     =3D kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
> >  			rsrp->cputime_softirq =3D kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu=
);
> >  			rsrp->cputime_system  =3D kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
> > -			rsrp->nr_hardirqs =3D kstat_cpu_irqs_sum(rdp->cpu);
> > -			rsrp->nr_softirqs =3D kstat_cpu_softirqs_sum(rdp->cpu);
> > -			rsrp->nr_csw =3D nr_context_switches_cpu(rdp->cpu);
> > +			rsrp->nr_hardirqs =3D kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(c=
pu);
> > +			rsrp->nr_softirqs =3D kstat_cpu_softirqs_sum(cpu);
> > +			rsrp->nr_csw =3D nr_context_switches_cpu(cpu);
> >  			rsrp->jiffies =3D jiffies;
> >  			rsrp->gp_seq =3D rdp->gp_seq;
> >  		}
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index a9a811d9d7a3..1bba2225e744 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -168,7 +168,7 @@ struct rcu_snap_record {
> >  	u64		cputime_irq;	/* Accumulated cputime of hard irqs */
> >  	u64		cputime_softirq;/* Accumulated cputime of soft irqs */
> >  	u64		cputime_system; /* Accumulated cputime of kernel tasks */
> > -	unsigned long	nr_hardirqs;	/* Accumulated number of hard irqs */
> > +	u64		nr_hardirqs;	/* Accumulated number of hard irqs */
> >  	unsigned int	nr_softirqs;	/* Accumulated number of soft irqs */
> >  	unsigned long long nr_csw;	/* Accumulated number of task switches */
> >  	unsigned long   jiffies;	/* Track jiffies value */
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 925fcdad5dea..56b21219442b 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -435,8 +435,8 @@ static void print_cpu_stat_info(int cpu)
> >  	rsr.cputime_system  =3D kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
> > =20
> >  	pr_err("\t         hardirqs   softirqs   csw/system\n");
> > -	pr_err("\t number: %8ld %10d %12lld\n",
> > -		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
> > +	pr_err("\t number: %8lld %10d %12lld\n",
> > +		kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu) - rsrp->nr_hardirqs,
> >  		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
> >  		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
> >  	pr_err("\tcputime: %8lld %10lld %12lld   =3D=3D> %d(ms)\n",
> > --=20
> > 2.39.3
> >=20
> >=20
>=20
