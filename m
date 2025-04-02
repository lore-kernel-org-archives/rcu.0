Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239571D7E57;
	Wed,  2 Apr 2025 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596163; cv=none; b=RGDWPEaW48p+3CRG8VyMdMnVa7pHilz9S9yPYwTbTBsCcuuQMoktklmFCcvttNOok2/ZJwVk7Cfbu4l3pJNdCWLEEFAxyCOT92VcvtymUkoQ55qG9S5id07R2JawT05sBEbWvnP4z8gT6Sv8E5xiGI5n62oouGDRKHF0/Qlbl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596163; c=relaxed/simple;
	bh=bragV+WTzdL/c9vNJ+1QqjdmQXYGV8qCXeArKFxTLas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqxtY8qjqMzXYSg+2Xmxt9qm2GrRDLEjTSrRodq8z6qypuBmdNv92cRPuDc9/rRk8Rr9HnxUzhOPo953REwJ3ULjN++DUQqueoqg6t7qJFf/gIMshmPcmWFtdSuk0v+7PiC/U54gmLtVxxWylzeo+VqBqQ8wez6R8g8jWwsYik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD7SD12/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD7SD12/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281E2C4CEDD;
	Wed,  2 Apr 2025 12:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743596162;
	bh=bragV+WTzdL/c9vNJ+1QqjdmQXYGV8qCXeArKFxTLas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GD7SD12/G6fev+tod6kN6ErBNmKqccqwS8EmmdJJYu2zlpE6Gq/wHSmbLBiWA0t3/
	 GBgC2RbF9lqmRdvzteW2BYGKIbpQaY64wvOnhsDhrMHsVspdorlyJ81/zyzptJ1QEd
	 6XQTdBOEY8cTZzl43qPzyS54jAJAafvy6W4JQu6uzDkdrRMGZT6OOEa0QjYBGtIvX6
	 tRW+SWPqMvXE+ScajEqX13SXK3Borv18i11eucQtRPonUiDdNdVdHCjurrLKtXqYYD
	 fWrqW1KvixJ+rh29rwcuXm/Ad01fZ88yQ7tg++CJHtb1W0vV2WIQ69oT+ff5Ud7/PX
	 JACIRnPpgGy4Q==
Date: Wed, 2 Apr 2025 14:15:59 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Kuyo Chang =?utf-8?B?KOW8teW7uuaWhyk=?= <Kuyo.Chang@mediatek.com>
Cc: Walter Chang =?utf-8?B?KOW8tee2reWTsik=?= <Walter.Chang@mediatek.com>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"vlad.wing@gmail.com" <vlad.wing@gmail.com>,
	Cheng-Jui Wang =?utf-8?B?KOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	Alex Hoh =?utf-8?B?KOizgOaMr+WdpCk=?= <Alex.Hoh@mediatek.com>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"neeraj.upadhyay@amd.com" <neeraj.upadhyay@amd.com>,
	"leitao@debian.org" <leitao@debian.org>,
	Freddy Hsin =?utf-8?B?KOi+m+aBkuixkCk=?= <Freddy.Hsin@mediatek.com>,
	"urezki@gmail.com" <urezki@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	Xinghua Yang =?utf-8?B?KOadqOWFtOWNjik=?= <Xinghua.Yang@mediatek.com>,
	"joel@joelfernandes.org" <joel@joelfernandes.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	Chun-Hung Wu =?utf-8?B?KOW3q+mnv+Wujyk=?= <Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH v4] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
Message-ID: <Z-0qf40pziDG-rJo@localhost.localdomain>
References: <20250117232433.24027-1-frederic@kernel.org>
 <a7cb64fb-1c17-4316-abf8-e6a7e07ba4d1@paulmck-laptop>
 <ef6cf6aaf981aa2035828e55bd66d56b88e70667.camel@mediatek.com>
 <Z-Qu0stgvwHF9n3q@localhost.localdomain>
 <ce8ec4491cfd17a374177918537a6b3be34dbb43.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce8ec4491cfd17a374177918537a6b3be34dbb43.camel@mediatek.com>

Le Wed, Apr 02, 2025 at 06:53:24AM +0000, Kuyo Chang (張建文) a écrit :
> Hi,
> 
> By review the get_nohz_timer_target(), it's probably making an offline
> CPU visible at timer candidates, maybe this patch could fix it?
> 
> 
> [PATCH] sched/core: Exclude offline CPUs from the timer candidates
> 
> The timer target is chosen from the HK_TYPE_KERNEL_NOISE.
> However,the candidate may be an offline CPU,
> so exclude offline CPUs and choose only from online CPUs.
> 
> Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
> ---
>  kernel/sched/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cfaca3040b2f..efcc2576e622 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1182,7 +1182,7 @@ int get_nohz_timer_target(void)
>         struct sched_domain *sd;
>         const struct cpumask *hk_mask;
> 
> -       if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE)) {
> +       if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE) &&
> cpu_online(cpu)) {
>                 if (!idle_cpu(cpu))
>                         return cpu;
>                 default_cpu = cpu;

It can't choose the current CPU because get_target_base() prevents that:

	if (!hrtimer_base_is_online(base)) {
		int cpu = cpumask_any_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TIMER));

		return &per_cpu(hrtimer_bases, cpu);
	}

> @@ -1197,13 +1197,16 @@ int get_nohz_timer_target(void)
>                         if (cpu == i)
>                                 continue;
> 
> -                       if (!idle_cpu(i))
> +                       if (!idle_cpu(i) && cpu_online(i))
>                                 return i;

CPUs within the domain hierarchy are guaranteed to be online.
sched_cpu_deactivate() -> cpuset_cpu_inactive(cpu) is supposed to
take care of that. Unless there is another bug lurking here, which is
my suspicion. But it's hard to know as we are dealing with a kernel
with out of tree patches.

>                 }
>         }
> 
> -       if (default_cpu == -1)
> +       if (default_cpu == -1) {
>                 default_cpu =
> housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
> +               if (!cpu_online(default_cpu))
> +                       default_cpu = cpumask_any(cpu_online_mask);

housekeeping_any_cpu() only returns online CPUs.

Thanks.
