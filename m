Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1C295DA6
	for <rcu@vger.kernel.org>; Wed, 22 Apr 2026 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840389; cv=none; b=HQXCZ3AxAUnPX9/CPRw9MQuvfMtCkKfaiuRazoiPJ7tvlf56GvIXGELTzDVEZZIgPIX5yNbkDC6emabUxc4YV2SVP6oE2onRNIEhqk5Y8WPId7L8Yi33pNYaeApm5BTaIKKDxgVwiocEo6T+RJse36+vBqAD3h/7vZq7R0oXFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840389; c=relaxed/simple;
	bh=ckFnFpf7EY4k05pzvEaBOfkZIuezMOHmoXRs8+shPkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=De6Gwa1Df2BKCrolVUhE5rMKB02xKE7uZL7LyW0zeYjaSYst0FxswqWhC+4O/vbmdQ0ljlK4l49eohW3A8hFe+Mbz0vdoGDmIk3nnTHG+f5z9cCYvCoeDienjVZdkNXLHqq0eeHFi+TRk+OouQamH+f+QiqOjZi/QdmQ40VUuPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlTEg11R; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlTEg11R"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so3262134a91.1
        for <rcu@vger.kernel.org>; Tue, 21 Apr 2026 23:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776840388; x=1777445188; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/aDT6I0ezsGEbJ8F9hURK4tUtAhZV+DQ8q+1PG94JQ=;
        b=AlTEg11RxxvXXd9gm8I+OrJ0kLX2kGygbpJZjBNA8wW7emSquuiE/I+BeBmc5vG9ZS
         FaDkC/N+b8caLEkv20CyM9EOCUhIbP3gwh6/tu+JirXax7r+FSc+1/7763ky69C6Klq+
         0Nmrh9md3i9ZRCV20M5s1u9VENifCDF4isfHjgJwy8wt3Y72mU+oP24L57da3tCWsuXn
         ORLiHZddYUUGL4h44rDjyu6TRO5x3tlGEo5gnSy8dFP/qr9R9CEEdk3doSin5bDKl1oi
         5snaXdgj/pbCAv3mhTg8NkaUO2uuD203L59szYzaW/tA/vX7GuXEbpS6woBPDSjuOsO2
         GDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776840388; x=1777445188;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d/aDT6I0ezsGEbJ8F9hURK4tUtAhZV+DQ8q+1PG94JQ=;
        b=aziLxRb/KC7g2KaU/oMZFdE/sxn7UqZe16DSVfc6JOHliJVyAQ0W0U/0xl5+d2AFSg
         qhK4xtPLxMlcTiQ6YLioG03UxAs6plBNqND2/4enB7j/PSCIBCht8AXQN6zGYO3TlMFP
         dK9zm9shbRZrc6h8/5oeN7lYWFbif7KgQAdCbuL3v+ODbAJS1vMhMjKgu/v7RZs8LV/0
         tKo3g4Lxr+ARfNR34SvLU2AjlGhyeDgrRuR2Zdsg3WmLggnjJNRvpnmQKkJXrZCYlOst
         OwmzDinj3U/gkKU43veON6hiJC5U5DQ/UiRH5L4+lRXE2df4FKVIjETQfIz30K59BZFe
         0WOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tjsTP2Mg5J9tIDeMb+NoTXSFQapagN4xdtiSHlArDTUjiVWntQWfrUQyqlb4xXvchU30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNoMYU6+UzFSa4Z1MbBgDTtfjDs/JR5Du9s3MkCMdNZee4Npeb
	gJiClczLCBPHvxr/GOxLabMFzgOdr2fxuXZfoFVtvbS0UnMe/o15stC7
X-Gm-Gg: AeBDiev/vYaE9jJjwU2IeVBD8bpCX6uhzi1++Z+BLGUG2JTODjw0J1rUurH5C95Syb8
	XcM9i4eDkppYhznH6caIealmLm7KcSvcozn+KYrUts5VxVrFDQvfZEocxdbJhabC8Y0r3GUWtYE
	yVG/RqE1kegb+U1P5/da5RluCFI/F7WoEhhrM2Uypf74sX+13ukdc5gGyq0/c5PW96AcJZn7/S5
	/waXrDtnwHkXSdogEEx4hG0k0UnDBq/RVgigDAedap1xZDtTt3VBb15Ohx7CwrUwxLNQLonfIeC
	Yv3CQGY3Sf/mK83789QZbfj3Y5KheNh//HdYxLvJynxsdwe6A8xjnv6Yo/RF6vWRqS6Wg8o/I4+
	CRF0WWFodjJUXB/e8ljWmr9VndOLDxifroKRv/Zk6OunTNujALhNRmb8GizAhf9/pJRxHUNbFC4
	aKRF+4E8bcnHDWqiC4hcqqZtdp9dRsacAhi9uNJc2L
X-Received: by 2002:a17:90b:2e46:b0:359:8dfd:64c8 with SMTP id 98e67ed59e1d1-361404a81e0mr20221334a91.24.1776840387546;
        Tue, 21 Apr 2026 23:46:27 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361417748aesm15531760a91.0.2026.04.21.23.46.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2026 23:46:27 -0700 (PDT)
Date: Wed, 22 Apr 2026 14:45:36 +0800
From: Jiazi Li <jqqlijiazi@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org, "mingzhu.wang" <mingzhu.wang@transsion.com>
Subject: Re: [PATCH] rcu: use NMI to dump backtrace of blkd-task running on
 other cpu
Message-ID: <20260422063525.GA3155@Jiazi.Li>
References: <20260417013816.3653-1-jqqlijiazi@gmail.com>
 <7a46efa3-3d11-45df-8d73-5af8b87a4b84@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a46efa3-3d11-45df-8d73-5af8b87a4b84@paulmck-laptop>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Apr 21, 2026 at 04:20:54PM -0700, Paul E. McKenney wrote:
> On Fri, Apr 17, 2026 at 09:38:13AM +0800, Jiazi Li wrote:
> > sched_show_task cannot dump backtrace of blkd-task running on other
> > cpu:
> > [117421.286553][    C0] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [117421.286579][    C0] rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-7): P2280
> > [117421.286595][    C0] rcu:    (detected by 0, t=5252 jiffies, g=751845, q=66318 ncpus=8)
> > [117421.286604][    C0] task:android.imms2   state:R  running task     stack:0     ...
> > [117421.286617][    C0] Call trace:
> > [117421.286622][    C0]  __switch_to+0x1a0/0x318
> > [117421.286636][    C0]  0x0
> > 
> > So use NMI to dump backtrace:
> > [  390.584143] rcub/0: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [  390.585156] rcub/0: rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-7): P6816
> > [  390.586207] rcub/0: rcu:     (detected by 5, t=52532 jiffies, g=7405, q=63942 ncpus=8)
> > [  390.587320] rcub/0: Sending NMI from CPU 5 to CPUs 4:
> > [  390.588111] rcu_stall_threa: NMI backtrace for cpu 4
> > [  390.588116] rcu_stall_threa: CPU: 4 UID: 0 PID: 6816 Comm: rcu_stall_threa Tainted: P...
> > [  390.588120] rcu_stall_threa: Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
> > [  390.588122] rcu_stall_threa: Hardware name: MT6858 (DT)
> > [  390.588123] rcu_stall_threa: pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [  390.588125] rcu_stall_threa: pc : _raw_spin_unlock_irqrestore+0x1c/0x44
> > [  390.588131] rcu_stall_threa: lr : ___ratelimit+0xd4/0x110
> > [  390.588134] rcu_stall_threa: sp : ffffffc08464bdf0
> > [  390.588135] rcu_stall_threa: x29: ffffffc08464bdf0 x28: 0000000000000000 x27: 0000000000000000
> > [  390.588138] rcu_stall_threa: x26: 0000000000000000 x25: 0000000000000000 x24: 00000000000004e2
> > [  390.588140] rcu_stall_threa: x23: ffffffd82ae77000 x22: ffffffd82af1fae8 x21: 000000000000000a
> > [  390.588142] rcu_stall_threa: x20: 0000000000000000 x19: 0000000000000000 x18: ffffffc08456d020
> > [  390.588144] rcu_stall_threa: x17: 000000008c623181 x16: 000000008c623181 x15: 0000000000000010
> > [  390.588146] rcu_stall_threa: x14: 0000000000000100 x13: ffffffc084648000 x12: ffffffc08464c000
> > [  390.588148] rcu_stall_threa: x11: 5e2da9f91a08d800 x10: ffffffd8299b39fc x9 : 0000000100005874
> > [  390.588150] rcu_stall_threa: x8 : 0000000000000000 x7 : 0000000000000001 x6 : fffffffebea2b0a0
> > [  390.588152] rcu_stall_threa: x5 : 0000000000000000 x4 : 0000000000000402 x3 : 0000000000000000
> > [  390.588154] rcu_stall_threa: x2 : ffffff81ca8d9680 x1 : 0000000000000000 x0 : 0000000000000001
> > [  390.588156] rcu_stall_threa: Call trace:
> > [  390.588157] rcu_stall_threa:  _raw_spin_unlock_irqrestore+0x1c/0x44
> > [  390.588159] rcu_stall_threa:  ___ratelimit+0xd4/0x110
> > [  390.588161] rcu_stall_threa:  rcu_thread_func+0x90/0xa8
> > [  390.588164] rcu_stall_threa:  kthread+0x110/0x1a4
> > [  390.588167] rcu_stall_threa:  ret_from_fork+0x10/0x20
> > 
> > Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
> > Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>
> 
> This looks like an arm64 stack trace.  Are there any arm64 systems in
> production that do real NMIs?  (Don't get me wrong, it would be nice if
> there are!)
> 
From commit 331a1b3a836c ("arm64: smp: Add arch support for backtrace using pseudo-NMI"), ARM64 using
pseudo-NMI, it's actually an IPI.
> > ---
> >  kernel/rcu/tree_stall.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index b67532cb8770..5806f9a43579 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -289,7 +289,12 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
> >  		 * Avoid triggering hard lockup.
> >  		 */
> >  		touch_nmi_watchdog();
> > -		sched_show_task(t);
> > +		if (unlikely(t->on_cpu && t != current) &&
> 
> What if task t blocks or migrates to some other CPU at this point?
> 
Yes, that's indeed a concern. We can identify such scenarios by checking
whether the PID reported by RCU matched the PID captured in the NMI
backtrace.
Do you have any suggestions?
> > +				trigger_single_cpu_backtrace(task_cpu(t))) {
> > +			/*Successfully triggered remote backtrace*/
> 
> Wouldn't inverting the condition save a couple of lines of code here?
> And make it a bit more straightforward?
> 
> 							Thanx, Paul
> 
Do you mean something like the following code?
		if (!unlikely(t->on_cpu && t != current) ||
			!trigger_single_cpu_backtrace(task_cpu(t)))
			sched_show_task(t);

> > +		} else {
> > +			sched_show_task(t);
> > +		}
> >  	}
> >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  }
> > -- 
> > 2.49.0
> > 
