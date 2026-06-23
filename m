Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6029ACC5
	for <rcu@vger.kernel.org>; Tue, 23 Jun 2026 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230004; cv=none; b=OvD7qHelkhcSiKbX0HCT6XDU+9N4+T9cUwhKdcDf3af6ADm+q/amePX9L/uYFONPwxXUch8gCswYK7G5YYGU7MgP7HhKgMGItaYQUc2fOkU6DPLPgGvORYbZaeP4eWnqEof2870Njeb6PM9/P+dhd3yQPbiBTaK21e8fZK6TeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230004; c=relaxed/simple;
	bh=qg8Q4pPpQnxud7NKEnlhS/5pG7tACOI7Eg6wHVaj1xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcpxCzEkw1PtyePpTQIQLjEj5X9WHQ2yOoiqDdjAvm2gCrYrMCfxpvan6GzAs8YEwKapyzJEpBmtRViJjdMnOSVq1FyXwhARdQPLFj6QDHExAGbRBkegHAH8M4wacZ1jRG6IBJVDALwehnPG88h452N1AHQrL3F1YGLegQc6iEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Q3C1qlEA; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q3C1qlEA"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9784666b3so31460a34.1
        for <rcu@vger.kernel.org>; Tue, 23 Jun 2026 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782230002; x=1782834802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I++JfVnVFsPw1yoo9hJi6dyEkF7CGlb7WVfrcCKidlU=;
        b=Q3C1qlEAuUdByjbtiU4taJBMdpdtsLQgcyATnZw9GHaGWSrEMK0wspYgEbaaEaKpNQ
         qnblcQTc4XJXD/QRrC/TwHXu0kBRdW6p5pdyzjCgfZS+4AfMtzjqRAUvm9TcvppOX945
         96fha+9KRqGZ7sXjVWxGSXEmzwGKq1hl7LnLJxpysaXCjNTexaFv6V19hTBp2TfdTWdz
         AF1HfHJnqWWWrz1WzWFVpX5u/BexlLP+RwXRljEy3b6r/YkrI3iBRpyMp6N5EPgKL6Hu
         a4jdcok+NxDTVfYyukyjUJ7fPOuqz94oOx47be4LiEd+n11dpi7KNHXV/gzPO+iRX4uM
         71Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230002; x=1782834802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I++JfVnVFsPw1yoo9hJi6dyEkF7CGlb7WVfrcCKidlU=;
        b=WzZ4vq5u3EAwPFrWCksBczPAifOPCqrOm1iZ82NCFZ5NPqJRTJSB44UgbN8G+I2kdN
         IINsDOLoCfkinwRMbeiMdK4VI3CifGPyr09VzxbuXiEZEtmdvYvbYqodtmb5+/ex80NO
         CXpjfdg/Qbp2QjWUM5P+gx5dgvtxG4jN9Nhxm9J8HMZY2qUlOuK25BbEMuoIK7cgZU8M
         dedmsHAhTh0kvrQSFxmXNzP8N61nswW4nGsRHjwm6syUMGMofElOyv3CxoD8yxm5mevQ
         TT6I2cWN+4/lU5xJeQ8a+oJ8obLHukVGL57rzqkfzQDMcB8+0sWCKJJwPfkKuxkg4/45
         Ej3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+dErt4Uf7uHrV+Hx6RzNZpOHoMUjjeBXzpTsRRTQFdD0irciEQdUqAI1rragmtpOFaEdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBFHACP/Q63MCTvUSoNnGr+/Z1WIjoR+tgsGkZhSS3JGkhoNxd
	ASahMtXoUmRkxze0PVhQAC4B2r4M1SMrzeevLL3YmhiZEKOJPEG3ORGZTmLcnZHJyn4=
X-Gm-Gg: AfdE7ckYS9HlOWCUKqFLqHpekHCb+NMQujnQSeOPfbhAL0GCnMXpcM6xjiWUqHLeyT3
	yWO1lkYpfgG9hqjNEVuvigopp73B6pkWfIB7CeHKoOMkQsz6+B0ccz0Y42nJ6jCK3l1Rboos3Am
	J8LXKT9uv7mkW3FG02yaIJszJ/lQIKit2dha/gpP228cdagls9cl/1dwHbr+mVPhbGewC0FHrIR
	Iw2w+8bOFUCkIp/9U2UFPGwoCqFyGTgOGAdk/nc1jlIXEyLVotAokCBVgAtZyuWZsH9jlB3TFax
	XUApNgpJ78sK6zqpqvrtdJwxRDnQrU7wGMs/yMvPi80kthOa3QFko9SF12ybnDTc62yhc9bIBle
	3KVOFJZvP6q3p9Wt9I21if+R/h5dcFjIWltxI0fysdDTaCZHN9PKGW4QdEUcNsh/fpGKvPLhlTp
	qPJJ7xbJ6Tssd2DEtbatgcoKLalXyNp24Y62zmkHwoIbXP9FI=
X-Received: by 2002:a05:6830:6a94:b0:7e6:e0ab:416a with SMTP id 46e09a7af769-7e940b27070mr15147982a34.18.1782230001699;
        Tue, 23 Jun 2026 08:53:21 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.100.209])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9442e98e9sm9126112a34.25.2026.06.23.08.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 08:53:21 -0700 (PDT)
Message-ID: <80773b89-f333-4c82-99b5-3fca44ea93b3@sifive.com>
Date: Tue, 23 Jun 2026 10:53:19 -0500
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
 Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org,
 neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com,
 rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrea Righi <arighi@nvidia.com>,
 Zqiang <qiang.zhang@linux.dev>, linux-riscv@lists.infradead.org,
 Sarah Emery <sarah.emery@canonical.com>
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
 <CAJM55Z-hiNDuu5UwoBe7m0wq+_WJrRY0cwopALUgpG+r3ixj8g@mail.gmail.com>
 <ajQPAk_ALP-84obp@MacBook-0RXW5>
 <CAJM55Z_15U7GssTOims1=J34CYSj=8CDE_di1kJYs5hE3=J53w@mail.gmail.com>
 <ajlW4oSzEqav6gxc@MacBook-0RXW5>
 <CAJM55Z_7N40ARWGoZg04p-NnAy-w10v4=Em-e4Bx4+oNYMGBLg@mail.gmail.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAJM55Z_7N40ARWGoZg04p-NnAy-w10v4=Em-e4Bx4+oNYMGBLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Emil,

On 2026-06-23 4:34 AM, Emil Renner Berthing wrote:
> Quoting Boqun Feng (2026-06-22 17:38:10)
>> On Sat, Jun 20, 2026 at 05:25:25AM -0400, Emil Renner Berthing wrote:
>>> Quoting Boqun Feng (2026-06-18 17:30:10)
>>>> On Thu, Jun 18, 2026 at 08:11:36AM -0500, Emil Renner Berthing wrote:
>>>>> Quoting Boqun Feng (2026-03-20 23:29:16)
>>>>>> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
>>>>>> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
>>>>>> happen basically everywhere (including where a scheduler lock is held),
>>>>>> call_srcu() now needs to avoid acquiring scheduler lock because
>>>>>> otherwise it could cause deadlock [1]. Fix this by following what the
>>>>>> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
>>>>>> the work to start process_srcu().
>>>>>>
>>>>>> [boqun: Apply Joel's feedback]
>>>>>> [boqun: Apply Andrea's test feedback]
>>>>>>
>>>>>> Reported-by: Andrea Righi <arighi@nvidia.com>
>>>>>> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
>>>>>> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
>>>>>> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
>>>>>> Suggested-by: Zqiang <qiang.zhang@linux.dev>
>>>>>> Tested-by: Andrea Righi <arighi@nvidia.com>
>>>>>> Signed-off-by: Boqun Feng <boqun@kernel.org>
>>>>>
>>>>> Thanks for the patch, which is now upstream as
>>>>> 7c405fb3279b ("rcu: Use an intermediate irq_work to start process_srcu()")
>>>>>
>>>>> Unfortunately it seems to halt booting on the Allwinner D1 single-core RISC-V
>>>>> SoC both on the 7.0 and 7.1 kernels:
>>>>>
>>>>
>>>> By "single-core", is it only one CPU in that system?
>>>>
>>>>> https://esmil.dk/d1-7.0.txt
>>>>> https://esmil.dk/d1-7.1.txt
>>>>>
>>>
>>> Yes, the SoC only has one CPU core capable of running Linux at least.
>>>
>>>> From the callstack,
>>>>
>>>> [  243.002818] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>> [  243.010681] task:kworker/0:0     state:D stack:0     pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00000000
>>>> [  243.021858] Workqueue: device_link_wq device_link_release_fn
>>>> [  243.027587] Call Trace:
>>>> [  243.030079] [<ffffffff80745b66>] __schedule+0x232/0x530
>>>> [  243.035365] [<ffffffff80745e82>] schedule+0x1e/0x94
>>>> [  243.040298] [<ffffffff8074aa7a>] schedule_timeout+0x6e/0xa8
>>>> [  243.045929] [<ffffffff8004d6a0>] wakeup_preempt+0x8c/0x98
>>>> [  243.051380] [<ffffffff80746aee>] wait_for_completion+0x3a/0xb0
>>>> [  243.057267] [<ffffffff80087226>] __synchronize_srcu.part.0+0x4e/0x60
>>>> [  243.063712] [<ffffffff80084414>] rcu_tasks_get_gp_data+0xc/0x10
>>>> [  243.069699] [<ffffffff80490898>] device_link_release_fn+0x14/0x80
>>>> [  243.075850] [<ffffffff8003dbd0>] process_one_work+0xf8/0x1c8
>>>> [  243.081583] [<ffffffff8003e282>] worker_thread+0x11a/0x254
>>>> [  243.087127] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
>>>> [  243.092755] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
>>>> [  243.098381] [<ffffffff8004499e>] kthread+0xbe/0xe4
>>>> [  243.103231] [<ffffffff8001349e>] ret_from_fork_kernel+0x6/0xd0
>>>> [  243.109127] [<ffffffff800517a8>] schedule_tail+0x8/0xac
>>>> [  243.114410] [<ffffffff800448dc>] kthreads_online_cpu+0x0/0x4
>>>> [  243.120121] [<ffffffff8074be0a>] ret_from_fork_kernel_asm+0x12/0x18
>>>>
>>>> I will guess for some reasons the irq_work was missed or the IPI never
>>>> happened. Is it possible for you to enable trace points ipi_send_cpu and
>>>> ipi_entry to get more information?
>>>
>>> I have to admit I've not used tracepoints before, but it seems like only
>>> ipi_send_cpu and ipi_send_cpumask is available on RISC-V.
>>> I've now added trace_event=ipi:* and tp_printk to the command line, and this
>>
>> Thank you! Yeah, this is what I meant ;-)
>>
>>> is what I get:
>>> https://esmil.dk/d1-7.0-2.txt
>>>
>>
>>
>> [    0.071132] rcu:     Max phase no-delay instances is 1000.
>> [    0.077837] ipi_send_cpu: cpu=0 callsite=irq_work_queue+0x22/0x4c callback=srcu_irq_work+0x0/0x58
>>
>> Is this the last line you can see from your (serial?) console, or we are
>> missing a few more lines? Maybe it'll should the same hung task
>> messages?
> 
> Yes, sorry for not being clear about that. This is the exact same binary booted
> without the two extra command line parametrs:
> https://esmil.dk/d1-7.0-3.txt
> 
> But with the two parameters added the board reboots before getting to the hung
> task messages. The bootloader enables the watchdog, so I think what happens is
> that the kernel halts earlier with the tracepoints enabled, and doesn't get to
> load the watchdog driver to keep the machine from rebooting.
> 
> The same happens with just trace_event=ipi:* added, just without the last
> message above.
> 
>>
>> The ipi_send_cpu message means RCU was able to send an IPI, now if there
>> is no ipi_handler between the send and the hung task, that would mean
>> the IPI was missed.

Assuming that your OpenSBI version is exactly v1.3 per the boot log, and not
"v1.3 + patches", then you would indeed not be receiving IPIs. You need at least
this commit: https://github.com/riscv-software-src/opensbi/commit/446fa65eb579
(included in v1.4) or alternatively to add the CLINT to the M-mode devicetree.

Regards,
Samuel

