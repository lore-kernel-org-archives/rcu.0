Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970741D4CC;
	Mon,  6 Jul 2026 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337591; cv=none; b=YlVG8gcRzWW5PSpsXuZA4iEKNRAHNoQ65BaLYbdzX1Vb8YUzh/e0iYevzcAKGrGEHhdpL89CCksg+AMDVBGH7wZWLJ9hzGF6TkAJ8Lh4rWj+CA2uMfrhPGs+p+SdR7wgNPkFHEZZu+qrcovkZo/yQrQN1tW5wW5okrfSNB2pO/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337591; c=relaxed/simple;
	bh=CrAyFlNelNHVdYVgyLcMn88u7gZnj2u5kod5elb1DH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UN7hqDxz8waZg0CDWNjxbHi4SbwH8t2aRuSGHWahL3i7QGvuCCrAgnihsjn1im2gJL813mkXEtpyC/wP+MLZVilNVUHAduSBInv1fnICHldxig8BsDWowFrCCdlmluqDDUbzOw9+piKtrp+nmy56K6btTfwdXjsfQajR+hRuczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=cQmGraDO; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="cQmGraDO"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gv2K93Nwkz8838;
	Mon,  6 Jul 2026 13:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1783337565;
	bh=CrAyFlNelNHVdYVgyLcMn88u7gZnj2u5kod5elb1DH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cQmGraDOQdBWVgJ2Og2JqDPgqLdI2xwoEHZYWowjbE4fv7P1BkeFPXFRzNEzmZnUa
	 hn+tUzGcgvXY9YilBYDcA2cIVBH5hqi+KHlL1Rlhm/PW51Jk1XGob/pZ33ZEU/ozXy
	 cyE3s25knDwyIKGzC3gZDfScQzUNWbQ6CEQKXO23KD8gKKeLvdjJBkfaR5dlX+bJAt
	 Xw3yBCngwvAVGdQuEWPs9LmUpiHyAkYzzrlj/MSwSMuzS27EaJCoCQkFSrfL7SKkdp
	 lX1Nel3JBgGc9ao/F5Q+DnkDbIeWpfIahNjg+/zQyDFt/gAC98z7N3RsROJ0KkW68z
	 g7PHoATYfJCqQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gv2K92cvNz87md;
	Mon,  6 Jul 2026 13:32:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gv2K50Ys6z8tbb;
	Mon,  6 Jul 2026 13:32:41 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D6871603ED;
	Mon,  6 Jul 2026 13:32:39 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <1a9a672d-914d-43c2-b1da-6a0deede4dac@leemhuis.info>
Date: Mon, 6 Jul 2026 13:32:39 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start
 process_srcu()
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Boqun Feng <boqun@kernel.org>, Samuel Holland <samuel.holland@sifive.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org,
 neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com,
 rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrea Righi <arighi@nvidia.com>,
 Zqiang <qiang.zhang@linux.dev>, linux-riscv@lists.infradead.org,
 Sarah Emery <sarah.emery@canonical.com>,
 Indrek Kruusa <indrek.kruusa@gmail.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
 <CAJM55Z-hiNDuu5UwoBe7m0wq+_WJrRY0cwopALUgpG+r3ixj8g@mail.gmail.com>
 <ajQPAk_ALP-84obp@MacBook-0RXW5>
 <CAJM55Z_15U7GssTOims1=J34CYSj=8CDE_di1kJYs5hE3=J53w@mail.gmail.com>
 <ajlW4oSzEqav6gxc@MacBook-0RXW5>
 <CAJM55Z_7N40ARWGoZg04p-NnAy-w10v4=Em-e4Bx4+oNYMGBLg@mail.gmail.com>
 <80773b89-f333-4c82-99b5-3fca44ea93b3@sifive.com>
 <CAJM55Z_aUzPieiGKPgr_iETovgyGB0EUFau+=tLxZksT9CkpYQ@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAJM55Z_aUzPieiGKPgr_iETovgyGB0EUFau+=tLxZksT9CkpYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178333756076.763651.5475009093779181864@mxe9fb.netcup.net>
X-NC-CID: 5We4qmzXW0aQeF+1js2/uoL0nHzawYS6SjwmVksOB9uX0tTkc/8=

On 6/24/26 10:55, Emil Renner Berthing wrote:
> Quoting Samuel Holland (2026-06-23 17:53:19)
>> On 2026-06-23 4:34 AM, Emil Renner Berthing wrote:
>>> Quoting Boqun Feng (2026-06-22 17:38:10)
>>>> On Sat, Jun 20, 2026 at 05:25:25AM -0400, Emil Renner Berthing wrote:
>>>>> Quoting Boqun Feng (2026-06-18 17:30:10)
>>>>>> On Thu, Jun 18, 2026 at 08:11:36AM -0500, Emil Renner Berthing wrote:
>>>>>>> Quoting Boqun Feng (2026-03-20 23:29:16)
>>>>>>>> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
>>>>>>>> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
>>>>>>>> happen basically everywhere (including where a scheduler lock is held),
>>>>>>>> call_srcu() now needs to avoid acquiring scheduler lock because
>>>>>>>> otherwise it could cause deadlock [1]. Fix this by following what the
>>>>>>>> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
>>>>>>>> the work to start process_srcu().
>>>>>>>>
>>>>>>>> [boqun: Apply Joel's feedback]
>>>>>>>> [boqun: Apply Andrea's test feedback]
>>>>>>>>
>>>>>>>> Reported-by: Andrea Righi <arighi@nvidia.com>
>>>>>>>> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
>>>>>>>> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
>>>>>>>> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
>>>>>>>> Suggested-by: Zqiang <qiang.zhang@linux.dev>
>>>>>>>> Tested-by: Andrea Righi <arighi@nvidia.com>
>>>>>>>> Signed-off-by: Boqun Feng <boqun@kernel.org>
>>>>>>>
>>>>>>> Thanks for the patch, which is now upstream as
>>>>>>> 7c405fb3279b ("rcu: Use an intermediate irq_work to start process_srcu()")
>>>>>>>
>>>>>>> Unfortunately it seems to halt booting on the Allwinner D1 single-core RISC-V
>>>>>>> SoC both on the 7.0 and 7.1 kernels:
>>>>>>>
>>>>>>
>>>>>> By "single-core", is it only one CPU in that system?
>>>>>>
>>>>>>> https://esmil.dk/d1-7.0.txt
>>>>>>> https://esmil.dk/d1-7.1.txt
>>>>>>>
>>>>>
>>>>> Yes, the SoC only has one CPU core capable of running Linux at least.
>>>>>
>>>>>> From the callstack,
>>>>>>
>>>>>> [  243.002818] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>> [  243.010681] task:kworker/0:0     state:D stack:0     pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00000000
>>>>>> [  243.021858] Workqueue: device_link_wq device_link_release_fn
>>>>>> [  243.027587] Call Trace:
>>>>>> [  243.030079] [<ffffffff80745b66>] __schedule+0x232/0x530
>>>>>> [  243.035365] [<ffffffff80745e82>] schedule+0x1e/0x94
>>>>>> [  243.040298] [<ffffffff8074aa7a>] schedule_timeout+0x6e/0xa8
>>>>>> [  243.045929] [<ffffffff8004d6a0>] wakeup_preempt+0x8c/0x98
>>>>>> [  243.051380] [<ffffffff80746aee>] wait_for_completion+0x3a/0xb0
>>>>>> [  243.057267] [<ffffffff80087226>] __synchronize_srcu.part.0+0x4e/0x60
>>>>>> [  243.063712] [<ffffffff80084414>] rcu_tasks_get_gp_data+0xc/0x10
>>>>>> [  243.069699] [<ffffffff80490898>] device_link_release_fn+0x14/0x80
>>>>>> [  243.075850] [<ffffffff8003dbd0>] process_one_work+0xf8/0x1c8
>>>>>> [  243.081583] [<ffffffff8003e282>] worker_thread+0x11a/0x254
>>>>>> [  243.087127] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
>>>>>> [  243.092755] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
>>>>>> [  243.098381] [<ffffffff8004499e>] kthread+0xbe/0xe4
>>>>>> [  243.103231] [<ffffffff8001349e>] ret_from_fork_kernel+0x6/0xd0
>>>>>> [  243.109127] [<ffffffff800517a8>] schedule_tail+0x8/0xac
>>>>>> [  243.114410] [<ffffffff800448dc>] kthreads_online_cpu+0x0/0x4
>>>>>> [  243.120121] [<ffffffff8074be0a>] ret_from_fork_kernel_asm+0x12/0x18
>>>>>>
>>>>>> I will guess for some reasons the irq_work was missed or the IPI never
>>>>>> happened. Is it possible for you to enable trace points ipi_send_cpu and
>>>>>> ipi_entry to get more information?
>>>>>
>>>>> I have to admit I've not used tracepoints before, but it seems like only
>>>>> ipi_send_cpu and ipi_send_cpumask is available on RISC-V.
>>>>> I've now added trace_event=ipi:* and tp_printk to the command line, and this
>>>>
>>>> Thank you! Yeah, this is what I meant ;-)
>>>>
>>>>> is what I get:
>>>>> https://esmil.dk/d1-7.0-2.txt
>>>>>
>>>>
>>>>
>>>> [    0.071132] rcu:     Max phase no-delay instances is 1000.
>>>> [    0.077837] ipi_send_cpu: cpu=0 callsite=irq_work_queue+0x22/0x4c callback=srcu_irq_work+0x0/0x58
>>>>
>>>> Is this the last line you can see from your (serial?) console, or we are
>>>> missing a few more lines? Maybe it'll should the same hung task
>>>> messages?
>>>
>>> Yes, sorry for not being clear about that. This is the exact same binary booted
>>> without the two extra command line parametrs:
>>> https://esmil.dk/d1-7.0-3.txt
>>>
>>> But with the two parameters added the board reboots before getting to the hung
>>> task messages. The bootloader enables the watchdog, so I think what happens is
>>> that the kernel halts earlier with the tracepoints enabled, and doesn't get to
>>> load the watchdog driver to keep the machine from rebooting.
>>>
>>> The same happens with just trace_event=ipi:* added, just without the last
>>> message above.
>>>
>>>>
>>>> The ipi_send_cpu message means RCU was able to send an IPI, now if there
>>>> is no ipi_handler between the send and the hung task, that would mean
>>>> the IPI was missed.
>>
>> Assuming that your OpenSBI version is exactly v1.3 per the boot log, and not
>> "v1.3 + patches", then you would indeed not be receiving IPIs. You need at least
>> this commit: https://github.com/riscv-software-src/opensbi/commit/446fa65eb579
>> (included in v1.4) or alternatively to add the CLINT to the M-mode devicetree.
> 
> So then we're in a situation similar to [1], where upgrading the kernel from
> 6.19 to 7.0 requires you to update the firmware first.

Which normally should never happen to ensure users feel save to update
the kernel. But I wonder if that is relevant, as Indrek Kruusa reported
problems with that board, too -- and there is a fix that fixes it:
https://lore.kernel.org/linux-riscv/20260624220434.4183732-1-felixonmars@archlinux.org/

Does that maybe fix your problem, too (even if it was bisected to a
different commit, it might be related somehow, that's why I'm asking)?

Ciao, Thorsten

> To me and from the thread
> that seems like a really obvious regression. So the question is, how can we make
> the current kernel work like < 7.0 kernels worked?
> 
> [1]: https://lore.kernel.org/all/87jzgjnh9z.ffs@tglx/#t


