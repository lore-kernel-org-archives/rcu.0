Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8212943F;
	Tue, 25 Feb 2025 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503150; cv=none; b=WAii9pDUkUDz1EwDUF+sMsyGPd2a6uqOaj8G8ounTPMTlanI903agE0NqQlnOnM3Qe6NnugZiQbqgPYrZVF0ZaZT3eTMxvQJCV+aOopR834/RotBjtZu+PU13KqrgJ86yeveDWo0ZymDFAAfy/1Sd47cd7nmSrZo0ywvhTpaYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503150; c=relaxed/simple;
	bh=AHjVZHAx9j1NzqkNbb+pYYYK7INXzAwVGFl0ef+03eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UX1tdF1B58rL0Y6zcnN8Iztinb0b0dn9Shm3BJ/zQHq0h1epxPLqFo1YAEeXxbS2Ok82Kh2GhVY0jZ/hRuXq59S/oMd7Xlgeg1qtq75EDbFx5/cqkePNPg7FK0aBogLir8eecibwhDXC3NR8LliPHxJnuxf2Ylmu3DAAT9a7I60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HywG1Vx0; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HywG1Vx0"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d2b08175f1so1466355ab.0;
        Tue, 25 Feb 2025 09:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740503148; x=1741107948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VYV21KgAAK9DCaC1N/igtqqjHAXsIGmsKhB8/dHzdzw=;
        b=HywG1Vx0Uk/W4W5B6iy8e47fctUF1DxTzRyeJf+JquFajdvh0dHCvo5kG2YTCSlJJb
         JebGK2Jy/Fwd0GMpVJ7+oz7NWAk8EBmVbL+mQEmUgY9nb2hcQIma3qKX9Yg6ynw3gVWy
         SSfTXnlGDrvWLNumNEms6i+DYA+2ix7Y02xPNehbn+KykwjVCfFPZhDkBPBvRfFbLeU4
         rDGMMdIs0hkL9t6/bBT3BcgD7xn3x5g5Teqf5AjBc3m7k8JTiOk8fOeN4Z3wYUvfYj/r
         5JCLXLgfzh7/4JYtR7Hnvma05wdLfzSjGVz3Oz80vWlx0ZVbBkJpLLINhn6yzfkmGSQf
         ny4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503148; x=1741107948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYV21KgAAK9DCaC1N/igtqqjHAXsIGmsKhB8/dHzdzw=;
        b=YnfKNUbx18ZqqI0nOjRnsuM5MB/sO1TMI0u6Hi6o5tIw5+Dhj9+95cnIcqW+2gW/L+
         RhyiflhZxK/LL5lq/QNoZSqBowpNhWBoSi12RwKff40cAzT3Wy/AozY4zB2pqQsR6PEh
         Rb6+og9VBi1XMw91W7rFSjRWA6UFPx4LsaE3ChXv8JsYbko8SXtUe21L2jZ9vEv7oqqA
         ilDk4jh84QEVOTBRvXhdYXT8/+dB/RQOWk27zZCWaMs5QKDt2/44oZOjWTDP2MXIATvi
         CR7vs5W4iAvM/cQbv6A2DlPSc46Rb1jNhzJC86tZerwG+0jQN5QFbf/tR8TsMceraaPg
         1wQg==
X-Forwarded-Encrypted: i=1; AJvYcCU9y+6hLXkhEdGObLMR0OL9+wYXLE3FuSym3JspDRSlx/LICTjfLaRHuhnX3xYVeB7sUV7I@vger.kernel.org, AJvYcCVqkzfv4pqzTGGiQcqsBylsJkRvZdiXSzsX9eScFaLgx3ZFoES889WW27Pp/AxIPKh4/O84ZcXG9Mk+pA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk/7yufiHt+zzLCNiKxzuVB/lrcFtd02w/oO4LbKIbpQ00mlUd
	bg+PqpfdZRqYqVZlZXpPL9XDMtWktndW7DrfUIdPtGUA2mF33tOrYopE1D/iVWwHwtlbiH0kbG0
	qKkCaqWfN90+Io/YU0bk0js8ssJ0=
X-Gm-Gg: ASbGnct3oCtuQec2ll8AQ9nLSgBNnt9r3LUG1vvsqnHHyIHc78VmRnuWncGflhDVGU1
	mgL8GbGypX+ALZVGFzBO+6eqEwsF+5OKXCClxZ5JGk4sIzRXXiB4gsbhNtN+VNJu8xQlltgmBNP
	DHWjkBjQ==
X-Google-Smtp-Source: AGHT+IF93EFtJ6oPsAu3p+R2151Bs9lgZsKeK3XtmcLvapwsdOCh6mvoMCN5/c279RrUn/GUfkqIUe5+Fw08pLAioIU=
X-Received: by 2002:a05:6e02:1646:b0:3d0:4ae2:17b6 with SMTP id
 e9e14a558f8ab-3d2cad72c9fmr48331585ab.0.1740503148188; Tue, 25 Feb 2025
 09:05:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp> <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636> <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz> <Z73p2lRwKagaoUnP@kbusch-mbp>
In-Reply-To: <Z73p2lRwKagaoUnP@kbusch-mbp>
From: Keith Busch <keith.busch@gmail.com>
Date: Tue, 25 Feb 2025 10:05:37 -0700
X-Gm-Features: AQ5f1Jrz3qY3MDeCKERua2dr5bSa2550jia32PBjWFTFKImY0jy7IP8cCbQl7FM
Message-ID: <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>, linux-nvme@lists.infradead.org, 
	leitao@debian.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 25, 2025 at 09:03:38AM -0700, Keith Busch wrote:
> On Tue, Feb 25, 2025 at 10:57:38AM +0100, Vlastimil Babka wrote:
> > I tried to create a kunit test for it, but it doesn't trigger anything. Maybe
> > it's too simple, or racy, and thus we are not flushing any of the queues from
> > kvfree_rcu_barrier()?
>
> Thanks, your test readily triggers it for me, but only if I load
> rcutorture at the same time.

Oops, I sent the wrong kernel messages. This is the relevant part:

[  142.371052] workqueue: WQ_MEM_RECLAIM
test_kfree_rcu_destroy_wq:cache_destroy_workfn [slub_kunit] is
flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
[  142.371072] WARNING: CPU: 11 PID: 186 at kernel/workqueue.c:3715
check_flush_dependency.part.0+0xad/0x100
[  142.375748] Modules linked in: slub_kunit(E) rcutorture(E)
torture(E) kunit(E) iTCO_wdt(E) iTCO_vendor_support(E)
intel_uncore_frequency_common(E) skx_edac_common(E) nfit(E)
libnvdimm(E) kvm_intel(E) kvm(E) evdev(E) bochs(E) serio_raw(E)
drm_kms_helper(E) i2c_i801(E) e1000e(E) i2c_smbus(E) intel_agp(E)
intel_gtt(E) lpc_ich(E) agpgart(E) mfd_core(E) drm_shm]
[  142.384553] CPU: 11 UID: 0 PID: 186 Comm: kworker/u64:11 Tainted: G
           E    N 6.13.0-04839-g5e7b40f0ddce-dirty #831
[  142.386755] Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
[  142.387849] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  142.390236] Workqueue: test_kfree_rcu_destroy_wq
cache_destroy_workfn [slub_kunit]
[  142.391863] RIP: 0010:check_flush_dependency.part.0+0xad/0x100
[  142.393183] Code: 75 dc 48 8b 55 18 49 8d 8d 78 01 00 00 4d 89 f0
48 81 c6 78 01 00 00 48 c7 c7 00 e1 9a 82 c6 05 4f 39 c5 02 01 e8 53
bd fd ff <0f> 0b 5b 5d 41 5c 41 5d 41 5e c3 80 3d 39 39 c5 02 00 75 83
41 8b
[  142.396981] RSP: 0018:ffffc900007cfc90 EFLAGS: 00010092
[  142.398124] RAX: 000000000000008f RBX: ffff88803e9b10a0 RCX: 0000000000000027
[  142.399605] RDX: ffff88803eba0d08 RSI: 0000000000000001 RDI: ffff88803eba0d00
[  142.401092] RBP: ffff888007d9a480 R08: ffffffff83b8c808 R09: 0000000000000003
[  142.402548] R10: ffffffff8348c820 R11: ffffffff83a11d58 R12: ffff888007150000
[  142.404098] R13: ffff888005961400 R14: ffffffff813221a0 R15: ffff888005961400
[  142.405561] FS:  0000000000000000(0000) GS:ffff88803eb80000(0000)
knlGS:0000000000000000
[  142.407297] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  142.408658] CR2: 00007f826bd1a000 CR3: 00000000069db002 CR4: 0000000000772ef0
[  142.410259] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  142.411871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  142.413341] PKRU: 55555554
[  142.414038] Call Trace:
[  142.414658]  <TASK>
[  142.415249]  ? __warn+0x8d/0x180
[  142.416035]  ? check_flush_dependency.part.0+0xad/0x100
[  142.417182]  ? report_bug+0x160/0x170
[  142.418041]  ? handle_bug+0x4f/0x90
[  142.418861]  ? exc_invalid_op+0x14/0x70
[  142.419853]  ? asm_exc_invalid_op+0x16/0x20
[  142.420877]  ? kfree_rcu_shrink_scan+0x120/0x120
[  142.422029]  ? check_flush_dependency.part.0+0xad/0x100
[  142.423244]  __flush_work+0x38a/0x4a0
[  142.424157]  ? find_held_lock+0x2b/0x80
[  142.425070]  ? flush_rcu_work+0x26/0x40
[  142.425953]  ? lock_release+0xb3/0x250
[  142.426785]  ? __mutex_unlock_slowpath+0x2c/0x270
[  142.427906]  flush_rcu_work+0x30/0x40
[  142.428756]  kvfree_rcu_barrier+0xe9/0x130
[  142.429649]  kmem_cache_destroy+0x2b/0x1f0
[  142.430578]  cache_destroy_workfn+0x20/0x40 [slub_kunit]
[  142.431729]  process_one_work+0x1cd/0x560
[  142.432620]  worker_thread+0x183/0x310
[  142.433487]  ? rescuer_thread+0x330/0x330
[  142.434428]  kthread+0xd8/0x1d0
[  142.435248]  ? ret_from_fork+0x17/0x50
[  142.436165]  ? lock_release+0xb3/0x250
[  142.437106]  ? kthreads_online_cpu+0xf0/0xf0
[  142.438133]  ret_from_fork+0x2d/0x50
[  142.439045]  ? kthreads_online_cpu+0xf0/0xf0
[  142.440428]  ret_from_fork_asm+0x11/0x20
[  142.441476]  </TASK>
[  142.442152] irq event stamp: 22858
[  142.443002] hardirqs last  enabled at (22857): [<ffffffff82044ef4>]
_raw_spin_unlock_irq+0x24/0x30
[  142.445032] hardirqs last disabled at (22858): [<ffffffff82044ce3>]
_raw_spin_lock_irq+0x43/0x50
[  142.451450] softirqs last  enabled at (22714): [<ffffffff810bfdbc>]
__irq_exit_rcu+0xac/0xd0
[  142.453345] softirqs last disabled at (22709): [<ffffffff810bfdbc>]
__irq_exit_rcu+0xac/0xd0
[  142.455305] ---[ end trace 0000000000000000 ]---
