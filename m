Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795515097;
	b=SWk9UpGO78YFg2v+XPVX1M+pNgCpIg//Oa/iCwVBkuVl9xU8AlG4eOrgh+qRV6us+E0Y
	 Sd0ZXZiCzF7FVZzfwJbQIuFMEuQbAsc8TeeZ6dEqVb/JLXIDyZhqISZjP04tUuQdQRfOo
	 kowL5QXsmwqTyLdzfKzpLZp+2xvp66etljaaCZNis/AqXDOIEoKMyb+1x98wvEwSWvyHP
	 Zc+lPIDQs+XWuA37ZqyAsALVajIv1IvrGo0LxsYT1NoiRHJJibNPvQImvcEfg3bilO7BG
	 eBAZjlDNbMbhzx/X1ejIwcEBUwV0dWRX8/cKXD8HI/Pn4t+14ZvCWbCkir07x9j3mRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515097;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XAjHpOoHzD/5/0Qvp1Ofl3iGJdTZMSnNgw4bsE73GGg=;
	b=SVan39QCedmZkT55aUFGj21lSSt0A9GZ8Koumw0Yr9/HVjJ4EC3cjYf6UbtuB/FcHfCq
	 J5DXC/rWLN08isAyAKFNEyIlJVCYJnyrusrBiBPNQ8WmddWU5pJKqSLdG331URAD5Hq5I
	 dzct837o4N321FnLMRI8dI0pZSiqcD7+Ml1tY0P/uD8jqkqqGYTcNdwS0El0X5rXX1T1F
	 ORyecGsE/Y8wKo8IKJrGB4bheUsNcEeVeZ3yvKzUuE4eF7Vdq92tlKtnNKiFKu2n+LWpV
	 8IXDaMGr2qLTVCh1gxggx6NRkZOupYCsvB6WAXnhh6Fv/sXsFil9/DlR/VVMVsTkVWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Qa/Y8Xrc";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=h7gEJN8O;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4D606A31E
	for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 10:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBC4D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qa/Y8Xrc;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=h7gEJN8O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795515095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XAjHpOoHzD/5/0Qvp1Ofl3iGJdTZMSnNgw4bsE73GGg=;
	b=Qa/Y8XrcwT8WUAv2GuNiOcaeaxuzHHoqMuR/T2uTsLnHD7a2apBcOaZ0bEFkDniPhjEdHl
	CmJogIBJkAuwsLvsJNNBJkpqWOQKnkNlF8gDKfoQjZxJexoXqWSxATzgidPXq/eE9lpiBB
	vAGKtT6WbszcPLRp5X2VPwBC8+YqHB8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-GjQHmy7kNl-SSMs2dlgBWQ-1; Tue, 24 Nov 2026 10:11:33 +0000
X-MC-Unique: GjQHmy7kNl-SSMs2dlgBWQ-1
X-Mimecast-MFC-AGG-ID: GjQHmy7kNl-SSMs2dlgBWQ_1795515093
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a204f135ffso22584715e9.1
        for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 02:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795515092; x=1796119892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XAjHpOoHzD/5/0Qvp1Ofl3iGJdTZMSnNgw4bsE73GGg=;
        b=h7gEJN8OBgFNUHMdvcvxCov1aoor2h//nVUcZ4O1IeANH5Uw9lTCw81D8dSFXQYQuI
         TlFGbh5jsTUr3qC9NYY48D7BnE563i6L1gwsCg9YhdYf7Jzd+TpwNdve2e1UufSUTfva
         A+0M1ayAJ70R1B6OGnMQLNUYZoBrNcfGhTH/xQIH0rdcBiY7+0fYEGzzya8Jye5F4nvW
         d7MaqcsOAhuqmC9y24fkr9lszPYSwZMLlqWAPxhCCwAMAnWUvD0guVB9/JsSNKWHwz36
         L2y4QQIiLlJu1kz76Rvpo2bVQIZrTT3QQhZ2FwhtkjVFMM0Dn+cGWemtLuAYiZjR7SZB
         FeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515092; x=1796119892;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XAjHpOoHzD/5/0Qvp1Ofl3iGJdTZMSnNgw4bsE73GGg=;
        b=ojOJSs50YAfbjlHdCZYPvdLdpb5tyeve66RiWpUQMOyY+3NOA6LZF314PTZ8oAjCZ9
         B0o8uSet5CdlbmOZz1Q3HqEABx/8/9ckeUh1miR604BompduUFZAw+JQvu4gUih7qtmq
         GwDPuLmkfsIGLL7ibbHI9N5c5YbxLsYds5sFicYyj369hfqGcjdaFtNzHMsI82cYxZU7
         ZZjKrhXz53+RwmtV9EvITGhxaYWT+FWK7sQDG9PPSDDjNVB0iLnIZYyBxS/jmS2gXgBk
         BowBuoJoqgK7PS10Ogz6kbSQxnjMbvYSdwy7DDkbFf5SywZUV2X5/T2u9kOYJ8kk4xij
         pb9A==
X-Forwarded-Encrypted: i=1; AL+hErHWiEH1d7LW1RUtrNNOwvnHbpwc6gRAo0EXcR7okwyyDEMW15DFK1PZQ2uVyU6voJIvl3g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9T+RxrJDf53IQh/Mnt6AF3ll9CEI5KoN4TSRkyNeKEqVQ+8onL
	fD24yveENJHbcMnPe80zH0/K5sn2Dr7UjbILtPiQRrhV5VF0j2zejUQfbKDtda5p1aHgBDpS+Dc
	9d9Ja+9x6W+2yk2Q69c/fV0DZDUxqgUWSsiF1HUH2NDDNjMS+jM56oA==
X-Gm-Gg: AZFdTZdu3jkfDoAvQMtCkq9ChM6g7E4eTh9+6ItZTenhlI8w6G/g8lOLPzpCD39fuOC
	nt3EHAhkrBYA1A2tc6KELqh7Je/zms5fh5S8dGwOZgu4RGwtxkg1XHs0XBteer/Q8B+4u0Uo0sl
	Bhr2ewemNXkfh4UO8vuxC0pw+NLfOTCoSDRho5tEhGUqjg5ouvaNj2Hq7d1R6M1jG4VklElAv4n
	tuuf+C/JfakcVZcx535IkkWhfvwtqIQeK9qxol1nQhVytK3N+MhV6H6AcjhB57feFiR1+Rwzi6G
	pnEQBKsHgMxG/P0/9fyFgUQwnnICm0Fe/zfgsue50FhR1YzZ5BReu99h1fSD6Qc2B3LjgXYJOfM
	jaUXs5sBNQGOe6BmGqJ5lCSoprbOSEvk1TUh9XMQ1gj8lmDPxzl87du6R7lCCXkqjsU060EAEwK
	FMxXI=
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr294991455e9.34.1795515092635;
        Tue, 24 Nov 2026 02:11:32 -0800 (PST)
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr294991115e9.34.1795515092291;
        Tue, 24 Nov 2026 02:11:32 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm28093795f8f.59.2026.11.24.02.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 02:11:31 -0800 (PST)
Date: Tue, 24 Nov 2026 11:11:29 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	luca abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 4/6] sched: Limit sysctl sched_rt_{period|runtime}_us
 to RT_GROUP_SCHED
Message-ID: <awVi0VQJCBNYc8u9@jlelli-thinkpadt14gen4.remote.csb>
References: <20261123-sched_dl-v4-0-d523e4d960d3@linutronix.de>
 <20261123-sched_dl-v4-4-d523e4d960d3@linutronix.de>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-sched_dl-v4-4-d523e4d960d3@linutronix.de>

Hello,

On 23/11/26 14:41, Sebastian Andrzej Siewior wrote:
> The admission control for SCHED_DL has been moved to sysfs and RT
> throttling has been moved (long ago) to the fair_server and its debugfs
> interface.
> 
> This file remains to have an impact only on RT_GROUP_SCHED. Keeping it
> for ABI/ compatibility reasons makes no sense because its original
> purpose (RT throttling) is no longer served. Anyone changing this file
> and hoping to change the throttling behaviour will be surprised.
> 
> Limit sysctl sched_rt_{period|runtime}_us to RT_GROUP_SCHED so everyone
> using this outdated file is aware.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

It looks like subject and changelog still describe the previous version,
as we are not removing the interface anymore?

>  kernel/sched/rt.c    | 8 ++++++++
>  kernel/sched/sched.h | 5 +++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index bd37dbf2bebbe..258b187459bb9 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2877,6 +2877,14 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>  
>  	if (!ret && write) {
> +		if (!IS_ENABLED(CONFIG_RT_GROUP_SCHED)) {
> +			const char *msg =
> +			"Please note that DL admission control (via sched_rt_period_us, sched_rt_runtime_us) moved to sysfs.\n"
> +			"This update will be mirrored. Controls for RT throttling moved to the fair_server.\n"
> +			"This will not be mirrored. The fair_server settings are under /sys/kernel/sched/cpuX/.\n";

I am not sure a user who hasn't followed this thread will understand
what "mirrored" means in this context. What about something like (names
depending on the unit discussion):

 sched_rt_{period,runtime}_us only control SCHED_DEADLINE admission control,
 now also available in /sys/kernel/sched/dl_{period,runtime}_us.
 RT throttling is done by the fair server, see /sys/kernel/sched/cpuX/fair_server_{period,runtime}.

Thanks,
Juri

