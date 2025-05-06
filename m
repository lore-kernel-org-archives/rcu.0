Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B021EFF93;
	Tue,  6 May 2025 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524723; cv=none; b=X9d3pH5dbRA3FV/NrVygD2anERT3U7/gI/v7VJxqEV2OrDx7vGAAm9mNT92aicbB8PaqTEeIGVZ4JZ8zN1aL/Y2Wqj+8doY2mV5DPvV5r5mdDG4Ymo/jCqzoDbHiLlfdgqX4LrLYChzFAK5/jnAb4lhDw7YmQMDh3iQRi2UPyvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524723; c=relaxed/simple;
	bh=EpuZPyUJ9zmAZ2c9BUZMxQY/UUSab85EVy6d2dzX2JA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c4xPJabNXIVVfWTU0RQWklXssYfAFZt3uzChyNnGW2jQwlK8pauWbcI9CFsIbeS9uTNRhkNR0XlhoQOUKpS4xz0ElRhJE6l3YbK7iRJoNYOVrgPxavrfJQshVQw0HMuqfTiV9pfgo82QnB7jMKDrXCGEEeATlP6sr5riUbWPyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b1faa09bae7so342821a12.1;
        Tue, 06 May 2025 02:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746524721; x=1747129521;
        h=content-transfer-encoding:organization:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSOD+puqL/4XqSHD2xH6JjKVLDIWqct4rkla2JcDmy0=;
        b=NPg3PEb6Saxoy5ndGmdaWw+Rqs+4bhuchUcX/eIKSDNgYByOshQYeKy1HJQAQZKIbp
         5Qi5f8oxH27JSdQcEHgJdpRmumLUL0L/EoKPjkGIRpS5yrVjtS1I+o6kRQ1f9rOruwam
         dJ1MR781QkCfSMI89QkF5bcuE5HNv/OnnOJelVCbJMG35CBQGxGK3ih29XsnGhAILNeT
         NfPsWnVhZ2j3ECedM4B/WNHtf4rOq9RyxjiXCattMeVunAlW+2dWcv3z7hZq2NHkEJCB
         0LOkKpb8kvvtrFMrEa/J65s8Tm1bCrSZRGZINaMbFB1ffisR9seTFFLs404YUrPE/Mia
         PJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbbHnWtXRQRSxWxaWoVGP2PwUSCYipiJQt9TJ6IgV379WtNlEMpzFVHygeF5D7uNW0KbiU@vger.kernel.org, AJvYcCXSk7hpPKNXK0ngckFGJmv/LqFapf+fVp2jg2ZvX7lxsZMwh2VyWoy9bm/TtiKkIwxCF51Cyq2STDGoraI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGU8oQZi3FVGEt302GJt9lX96P/JLI0G+uCmODLNc8mjl0TG2X
	lzOy1bG/XSsyke6iH509ULxQ6Gbf1D7CuApSoJlmUBELKNkqyHim
X-Gm-Gg: ASbGncs+po18ocqI8/6CC54hvvGlY7A0JgcIekiVmspjUb7BO9D1EyhKa+3PCy1hiL8
	Ba7gVF9mzf6PEXg51svhCG++ddqbqPUGtnlZx8v1Vz+lC1rsAPgHcZ41sL1YNPvoG7Z64GwMo/N
	Uug/X7afOrBBhAonEV+BnYgD6DiCnChSw51lxj9vtKS6+4qYOiVbfYMRODrEuWugZSJXWnMS/dZ
	/ccg9IGcLE+mTEke6rY1iSIfOb11I9Xz5rkuxA0jH6RM2yQduT7YIJWo52SvnI4tsgcOax7b2mu
	lpTsUoDt4aiO2uPGPgHYRQPi0nBhmj4+4Jhm46eyKxOxdHcyAbg3
X-Google-Smtp-Source: AGHT+IE4XN8fGk6NVgA2xZFj7lr1LVIAwTygyFZpdvp0wgim1KjlAv8Y9fJz8VT968dhSyQepqbBKQ==
X-Received: by 2002:a17:90b:2247:b0:2fe:b77a:2eba with SMTP id 98e67ed59e1d1-30a4e574bffmr8928554a91.1.1746524721121;
        Tue, 06 May 2025 02:45:21 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4763f992sm10672445a91.40.2025.05.06.02.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 02:45:20 -0700 (PDT)
Message-ID: <2aaa078a-100c-4974-be5b-b58a7f3a6dbb@kzalloc.com>
Date: Tue, 6 May 2025 18:45:14 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yunseong Kim <ysk@kzalloc.com>
Subject: Re: [BUG] RCU: Kernel panic on execute from non-executable memory
 (binderfs + stress-ng)
To: "Colin King (gmail)" <colin.i.king@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 byungchul@sk.com, max.byungchul.park@gmail.com, rcu@vger.kernel.org,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>, LKML <linux-kernel@vger.kernel.org>
References: <8bdfa4fc-0e4a-4965-bc29-6ab6c1573ef6@kzalloc.com>
 <6b5d7f21-459c-48c8-9fa2-d494b01bc5d8@gmail.com>
 <4eaaaf62-40a6-43f8-bcce-6e23b475e12f@kzalloc.com>
Content-Language: en-US
In-Reply-To: <4eaaaf62-40a6-43f8-bcce-6e23b475e12f@kzalloc.com>
Organization: kzalloc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I attached the vmcore with vmlinux symbol for further analysis and will share it at the following link.

Link: https://drive.google.com/file/d/1_RFdpdWNuLdO-Yx6d7vIX-WAFX4X_msH/view?usp=drive_link

On 5/6/25 9:30 오전, Yunseong Kim wrote:
> Hi Colin,
> 
>>> The crash seems to originate from rcu_do_batch(), jumping to a pointer (0xffff00003a114000) that appears to be non-executable.
>>> The PTE for the address confirms XN=1. Given the heavy binderfs workload, I suspect there may be a use-after-free or dangling pointer involved in a callback invocation.
>>>
>>> Platform:
>>>   Architecture: arm64
>>>   Virtualized environment: Apple Silicon M2 (Apple Virtualization Framework)
>>>   Kernel version: 6.15.0-rc4+
>>>   Attached Config: CONFIG_PREEMPT_VOLUNTARY=y, CONFIG_KASAN=y
>>>
>>> Reproducer:
>>>   sudo ./stress-ng --binderfs 8 --binderfs-ops 10000 -t 15 \
>>>    --pathological --timestamp --tz --syslog --perf --no-rand-seed \
>>>    --times --metrics --klog-check --status 5 -x smi -v --interrupts --change-cpu
>>
>>
>> I suspect --change-cpu is required to trigger this issue. Does it trigger without this option?  Can you reproduce the issue when reducing the number of --binderfs intances?
> 
> As you suggested, I've been testing combinations of enabling and disabling '--binderfs' and '--change-cpu' separately.
> 
> While I'm not deeply familiar with the internal mechanisms of binderfs,
> I found that the panic still occurs consistently with --binderfs, even without the --change-cpu option.
> However, the panic occurred when I used 4 instances.
> 
> Reproducer with reduced instance from 8 to 4 and without change-cpu option:
>  sudo ./stress-ng --binderfs 4 --binderfs-ops 10000 -t 15 \
>   --pathological --timestamp --tz --syslog --perf --no-rand-seed \
>   --times --metrics --klog-check --status 5 -x smi -v --interrupts

[  194.911021] Unable to handle kernel execute from non-executable memory at virtual address ffff0000312ebe00
[  194.911043] Mem abort info:
[  194.911056]   ESR = 0x000000008600000f
[  194.911065]   EC = 0x21: IABT (current EL), IL = 32 bits
[  194.911118]   SET = 0, FnV = 0
[  194.911130]   EA = 0, S1PTW = 0
[  194.911139]   FSC = 0x0f: level 3 permission fault
[  194.911149] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000163388000
[  194.911160] [ffff0000312ebe00] pgd=180000016ffff403, p4d=180000016ffff403, pud=180000016fffe403, pmd=180000016fff4403, pte=00680000712eb707
[  194.911201] Internal error: Oops: 000000008600000f [#1]  SMP
[  194.911211] Modules linked in: overlay isofs uinput snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables qrtr sunrpc virtio_snd snd_seq snd_seq_device snd_pcm snd_timer snd virtio_net soundcore net_failover virtio_balloon failover vfat fat joydev loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_common zram vmw_vsock_vmci_transport lz4hc_compress vmw_vmci lz4_compress vsock uas polyval_ce polyval_generic ghash_ce usb_storage sha3_ce sha512_ce virtio_gpu sha512_arm64 virtio_dma_buf apple_mfi_fastcharge fuse
[  194.911440] CPU: 2 UID: 0 PID: 27 Comm: ksoftirqd/2 Kdump: loaded Not tainted 6.15.0-rc4+ #1 PREEMPT(voluntary) 
[  194.911452] Hardware name: Apple Inc. Apple Virtualization Generic Platform, BIOS 2075.101.2.0.0 03/12/2025
[  194.911459] pstate: 21400805 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=-c)
[  194.911469] pc : 0xffff0000312ebe00
[  194.911492] lr : rcu_do_batch+0x2dc/0x860
[  194.911506] sp : ffff800080143c90
[  194.911512] x29: ffff800080143cb0 x28: ffff00003059e600 x27: ffff0000312ebe00
[  194.911534] x26: ffff800084442000 x25: 0000000000000000 x24: ffff8000843d9b18
[  194.911549] x23: ffff800082150ac0 x22: 0000000000000003 x21: 000000000000000a
[  194.911563] x20: ffff0000c11233c0 x19: ffff00012f0e1e00 x18: 0000000000000000
[  194.911578] x17: ffff80008214506c x16: 002c7c955b9d7f7c x15: 0000000000000000
[  194.911592] x14: 0000000000000002 x13: 0000000000ff0100 x12: ffff8000801c3410
[  194.911607] x11: 0000000000180017 x10: 0000000000ff0100 x9 : ffff80008385a580
[  194.911621] x8 : 0000000100000100 x7 : 7f7f7f7f7f7f7f7f x6 : ffff8000803f89bc
[  194.911636] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
[  194.911650] x2 : 0000000000000000 x1 : ffff800082a4aeb8 x0 : ffff00003059e600
[  194.911744] Call trace:
[  194.911747]  0xffff0000312ebe00 (P)
[  194.911759]  rcu_core+0x2a0/0x4e8
[  194.911767]  rcu_core_si+0x1c/0x30
[  194.911773]  handle_softirqs+0x1b4/0x588
[  194.911782]  run_ksoftirqd+0x5c/0xf8
[  194.911787]  smpboot_thread_fn+0x27c/0x490
[  194.911794]  kthread+0x2ac/0x318
[  194.911802]  ret_from_fork+0x10/0x20
[  194.911811] Code: 00000000 00000000 00000000 00000000 (00000000) 
[  194.911821] SMP: stopping secondary CPUs
[  194.912168] Starting crashdump kernel...
[  194.912171] Bye!

crash> kmem ffff0000312ebe00
CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
ffff0000c000cc00      512        185       576     36     8k  kmalloc-rnd-10-512
  SLAB              MEMORY            NODE  TOTAL  ALLOCATED  FREE
  fffffd7fc0f5e920  ffff0000312ea000     0     16          0    16
  FREE / [ALLOCATED]
   ffff0000312ebe00  

The address ffff0000312ebe00 is listed in the FREE list, meaning this memory slot has already been freed.

      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
fffffd7fc0f5e970  712eb000         ffffffff ffffffffffffffff  0 1 locked

This memory page itself no longer has any valid page mapping (MAPPING=ffffffff), and its reference count (CNT) is also 0. it is completely freed.

It appears that a struct rcu_head object, which had already been freed, remained in the RCU callback list, and an attempt was made to call a function using this invalid (freed) slot through the rcu_head, resulting in the error.

I think it is unusual that this memory bug was not detected even with KASAN enabled, especially since it has not been caught despite the issue occurring repeatedly.

I'll check if there are any potential issues with improper RCU usage in otherside.


Best regards,
Yunseong Kim
