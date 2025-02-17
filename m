Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3431D52B;
	Mon, 17 Feb 2025 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759399; cv=none; b=XPWu3Ne9k8G8e/7jdV8g9XcIkrWCK8ZUbX4Ze4Hlp1uIg001PpCFZRQyFDM2/z+FHkfhRI1aoDc6DG/tRLkc1FzIHXt4Nt5uUw1Q/nR4wIJmviS6Y/9JTgB+aa+yuDyZKJfdiLiS2UcCbIqMHVtnvZfuKSGAQWOuuI7Kn1tv4UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759399; c=relaxed/simple;
	bh=Ptnz1FJNvwpGG91Baz2EqmetLnOwypETNjNv0JyRnGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcltMC0D3eM+IIM6bTu4rJI5OJXyaIN6ZKWxENRmI7m0KyJo5mA4JOvg40TMVSMEdfjzVWEAYCQ1tlhCbMjacUZ+0+bDFIBGiD/wi62ugcQIYOuvYurOXyBZyZpVlQgROY5YtnVzTf4UrtUUj/iS7ug3/QpuNUa5E2rsuZMNwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZROQZPJ/; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZROQZPJ/"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0818add57so284762585a.3;
        Sun, 16 Feb 2025 18:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739759397; x=1740364197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sczDWLjLZXk3cJR1H+2fP30EHAuo7bRrQXtML7RJhbk=;
        b=ZROQZPJ/+al5PYrAVxgL7X6PHxEf0kwkDts4SVsigHc/PALHmwTBIc34h9ggLlf33I
         BikFY03qDAP1M5ExfLhbUe6CIpbkgITMA986K24X6QXWtc8y+H+lUK/jP5Engjy6qjU8
         Vlp5rEWVdLzrSfoT3aTUy7wVY5Vebhmac535GrKh0bgj+mlnTk0n0wOS541G1+3hYiwT
         BFy7maQ7s+OxSWdnhSw2SE/ArIciaiPTlANWGxfoZVyZbNR03Saec8KhjSTid81KmHls
         HUjwy5AvgrbW7rJYvh+6IwC3ZEb3EH9haOw33JNqFBTcAfiPnngbEPk3DVNzHXQp7ej/
         YyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739759397; x=1740364197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sczDWLjLZXk3cJR1H+2fP30EHAuo7bRrQXtML7RJhbk=;
        b=rd3KUNEyPQpJE8U6Seow1FOB410HBClV/IXTH3hlp+pttlhE75/MG/XZxAnVcaxjjQ
         tkJLoWSJCh5/QQVFox6hJrmiRtybL0S9H6SfaYIoAEwTKQaNl2Sy+pICCWI6B52tamD9
         QFfjvS5NnUd5R5WMRHXWDcTfQx8iupBLVQLr9TwUmwOVAP7uonWEyp1rPPvIsW+F2Ey6
         9lmFMRa2PYOVh8e9b7kwYs4MybqGHWpml00vBa1fCLdzIz/5nXOiAEhUHlif9xO7hOdQ
         1MK7vlk+W8QKEh3yEIlOdyi7GnwAw1hM4snMQJaQt9EPlbOBHCIidr/OEj4N5vmM4QT9
         UmHg==
X-Forwarded-Encrypted: i=1; AJvYcCW3cVd6EELRNyFuh57hQ6T/9VXWWSBznA1vXdiXfsF2PAmvMV3IcavO/CLJz+gbpzBj8rLOCKQScDl7AhQ=@vger.kernel.org, AJvYcCXRCqRogr6UIpRxT4EPkvSJjiQ5mY9BqZZGVx28SU2TeB4eY7Kjiy4i13JUcHnMMgMFmxS1@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNnsQnK4rNkvfO9JBFD8gP61+/E+FVvTyRjBrwONLn0RMNj00
	9Z5E+hPMQup1xeSkjSB9cTOW5730UxIa4pqsN1V0d/NLzPiYj5Zy
X-Gm-Gg: ASbGnctLyC1nxwHec95cmbb3sMeIyReqKZrcLVzpxXNiH85l15QV9B3IDPbFQAF8AF9
	WwydTkpHENDzmg3iW3f0AQcawyi2aqV3pCurHEGfVpoZf5wFB/Hc3HJdb3uI8T5gxfHCQQiUpW+
	M1QJXPmQkK2lQ3Y0dwTGthe08vQKdalGy3tfnolHPvtfrD8u0n7CZi1ViBrJvUbsbXlC4bAhy+p
	Ui9PpeG6Mz3/SAumucwe/1g58Sj1VVTbytjztJMdf5zmDvFORJgDY55K/ImqmGmEp8VltUGxXl4
	qpMsviniZz57YMZIKoLGKqO19swHJw4jesh6IpdxbK/0x14YHUn31Ut7c/QILX4Lgh+XQsZIrK6
	4jHqlJw==
X-Google-Smtp-Source: AGHT+IHVUU0T/P9TucIsHYi/FJKJpFO7Ep2OpRN0Be7yfBCnLpZD0NumK1YtdyvfNPuN56gWcZbHSA==
X-Received: by 2002:a05:620a:17ab:b0:7c0:6081:f89c with SMTP id af79cd13be357-7c08aac5efamr1221611485a.51.1739759396685;
        Sun, 16 Feb 2025 18:29:56 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c608291sm482196585a.43.2025.02.16.18.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 18:29:55 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 66F4B1200043;
	Sun, 16 Feb 2025 21:29:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 16 Feb 2025 21:29:55 -0500
X-ME-Sender: <xms:I5-yZ0aQS2pC7POMhg_O43ftZc-tgfKI5FFPdokcrzW2qLXQoxvJnw>
    <xme:I5-yZ_ZtSSKh_9xG5xktCUuJL36-odRTenrQVOIltdofNFsc43kSa7LhkXILdMjNq
    Ft1PIXnFiIqXyTMww>
X-ME-Received: <xmr:I5-yZ-8tNzxhdxgFNaMGVQLJi-fBICFJZRUfIFJR9syDmhF08ckRaJ_2oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehjedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehlvghonhihlhhgrghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvvghrrghj
    rdhuphgrughhhigrhiesrghmugdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthhhuhhnuggvrhdrlhgvihiihhgvnheshhhurgifvghirdgtohhmpd
    hrtghpthhtohepfhhrrghnkhhjphhlihhusehtvghntggvnhhtrdgtohhmpdhrtghpthht
    ohepkhgvrhhnvghlgihinhhgsehtvghntggvnhhtrdgtohhmpdhrtghpthhtoheprhgtuh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:I5-yZ-q0-hVH4RtKL6UQqA5964_we47LoRhfPu3S2u4KF0Kchem6ng>
    <xmx:I5-yZ_oHRYrKyoIp8UX3tAyWM3c-cRk2CifF3DTBXR0IZ7-UT7b-eQ>
    <xmx:I5-yZ8Sd7YtyMtYUVZbX7_EWzsHKX5lKdWeZD2MN3SJvhLzeUbdkNA>
    <xmx:I5-yZ_rVN-tt7J02N3PmKqsBQgvuAudpz11GGfHa7rhAFTOtEfx_xA>
    <xmx:I5-yZ06ELWjjwPCrNtMUGcgeg22v7s-NyS57AEeGU9fvy3qwINKWuIDu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Feb 2025 21:29:54 -0500 (EST)
Date: Sun, 16 Feb 2025 18:29:54 -0800
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
Message-ID: <Z7KfIm9c4WCpm0wR@Mac.home>
References: <20250216084109.3109837-1-leonylgao@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216084109.3109837-1-leonylgao@gmail.com>

Hi Yongliang,

On Sun, Feb 16, 2025 at 04:41:09PM +0800, Yongliang Gao wrote:
> From: Yongliang Gao <leonylgao@tencent.com>
> 
> When counting the number of hardirqs in the x86 architecture,
> it is essential to add arch_irq_stat_cpu to ensure accuracy.
> 
> For example, a CPU loop within the rcu_read_lock function.
> 
> Before:
> [   70.910184] rcu: INFO: rcu_preempt self-detected stall on CPU
> [   70.910436] rcu:     3-....: (4999 ticks this GP) idle=***
> [   70.910711] rcu:              hardirqs   softirqs   csw/system
> [   70.910870] rcu:      number:        0        657            0
> [   70.911024] rcu:     cputime:        0          0         2498   ==> 2498(ms)
> [   70.911278] rcu:     (t=5001 jiffies g=3677 q=29 ncpus=8)
> 
> After:
> [   68.046132] rcu: INFO: rcu_preempt self-detected stall on CPU
> [   68.046354] rcu:     2-....: (4999 ticks this GP) idle=***
> [   68.046628] rcu:              hardirqs   softirqs   csw/system
> [   68.046793] rcu:      number:     2498        663            0
> [   68.046951] rcu:     cputime:        0          0         2496   ==> 2496(ms)
> [   68.047244] rcu:     (t=5000 jiffies g=3825 q=4 ncpus=8)
> 
> Fixes: be42f00b73a0 ("rcu: Add RCU stall diagnosis information")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501090842.SfI6QPGS-lkp@intel.com/
> Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
> Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> 

Thank you for the patch, I have one minor question to x86 maintainers
(Cced): does it make sense to fold the sum of arch_irq_stat_cpu() into
kstat_cpu_irqs_sum()?

Regards,
Boqun

> ---
> Changes from v2:
> - Add Reviewed-by 'Neeraj Upadhyay' information
> - Link to v2: https://lore.kernel.org/all/20250109024652.1342595-1-leonylgao@gmail.com
> Changes from v1:
> - Fix compilation error when using arm64-allnoconfig/riscv-randconfig. [kernel test robot]
> - Link to v1: https://lore.kernel.org/r/20250108065716.2888148-1-leonylgao%40gmail.com
> ---
> ---
>  kernel/rcu/tree.c       | 10 +++++++---
>  kernel/rcu/tree.h       |  2 +-
>  kernel/rcu/tree_stall.h |  4 ++--
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 475f31deed14..a0dab5923d03 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -781,6 +781,10 @@ static int rcu_watching_snap_save(struct rcu_data *rdp)
>  	return 0;
>  }
>  
> +#ifndef arch_irq_stat_cpu
> +#define arch_irq_stat_cpu(cpu) 0
> +#endif
> +
>  /*
>   * Returns positive if the specified CPU has passed through a quiescent state
>   * by virtue of being in or having passed through an dynticks idle state since
> @@ -916,9 +920,9 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
>  			rsrp->cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
>  			rsrp->cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
>  			rsrp->cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
> -			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
> -			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
> -			rsrp->nr_csw = nr_context_switches_cpu(rdp->cpu);
> +			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu);
> +			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(cpu);
> +			rsrp->nr_csw = nr_context_switches_cpu(cpu);
>  			rsrp->jiffies = jiffies;
>  			rsrp->gp_seq = rdp->gp_seq;
>  		}
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index a9a811d9d7a3..1bba2225e744 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -168,7 +168,7 @@ struct rcu_snap_record {
>  	u64		cputime_irq;	/* Accumulated cputime of hard irqs */
>  	u64		cputime_softirq;/* Accumulated cputime of soft irqs */
>  	u64		cputime_system; /* Accumulated cputime of kernel tasks */
> -	unsigned long	nr_hardirqs;	/* Accumulated number of hard irqs */
> +	u64		nr_hardirqs;	/* Accumulated number of hard irqs */
>  	unsigned int	nr_softirqs;	/* Accumulated number of soft irqs */
>  	unsigned long long nr_csw;	/* Accumulated number of task switches */
>  	unsigned long   jiffies;	/* Track jiffies value */
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 925fcdad5dea..56b21219442b 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -435,8 +435,8 @@ static void print_cpu_stat_info(int cpu)
>  	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
>  
>  	pr_err("\t         hardirqs   softirqs   csw/system\n");
> -	pr_err("\t number: %8ld %10d %12lld\n",
> -		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
> +	pr_err("\t number: %8lld %10d %12lld\n",
> +		kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu) - rsrp->nr_hardirqs,
>  		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
>  		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
>  	pr_err("\tcputime: %8lld %10lld %12lld   ==> %d(ms)\n",
> -- 
> 2.39.3
> 
> 
