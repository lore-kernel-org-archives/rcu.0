Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8D17E0FF;
	Sun, 21 Jun 2026 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782001781; cv=none; b=GtOGKzQwD+AvKhRmvv6ilU4BqkOAmMLklW3feMhieSa9/6KKTCXpi4W8yiEOtk1l7lEcwUztYFwf6Cj4dZUJRizpOs/JDgJC9UgO4UAP6wsNeYB31XaDGbbfaTVgmEX0AmxfrDLKmbZE1joUQqzuiq2egJoOSHM6sI3itlvWCdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782001781; c=relaxed/simple;
	bh=1MnWNqh0Ih//0t81t9oNMlb5t06OUcy7Zz/BNBFXUT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riHWYP6xpfRHLQr2nc37ll3ErAl8WqcBVOz2sUAC3ZC+fUfaNWHDD6ythz34j6NBfKPtFOVjCVOIRKX1okYYjF1nl3Df6aQQC31w0iuHOdRrtalGetNs006U5qPQCYF5KhqrqzRq4YRE8MHe/GlI83w/nqh5WeFthK4BdmUobNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wwydNH/N; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wwydNH/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782001776; bh=tV+HkNoqzvKpgSRnvGC6RmogVfBvelOvm7aH4UT4sWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=wwydNH/N/FlJkbysIxkx2U1DuTaZe1a8sWH0i1aPf6jpaOTAWU0BfWQvx7e+hP/aD
	 msFG6CtnKQt6VQxuevmwWUCkApnD5PIqH+syaXZTI0rnug4CdT9llNSkbnuy7XdyRr
	 6Dy0tt1wau1g0nEu9fdPW7qHKW119k4MgTlFyg78=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-XMAILINFO: MF2s0TKt0BDQ/rAu5/bVF6ZNILrc10mr2NDK5So5PZea2C0ouyc6T0AU7Lv/0m
	 M+tiChHuvcTMkEr7KxEG8VnMxxBZg/FL2VWvaGR+PVbmIS213R4X2rMZTUn0tTK8tqPcAkg54H8hm
	 MolsdFNAM21nSu+sGsS6BwabyTIUlI87LRHTYv6OC+bpdKnIYgkHyx1/8aIg+QOWQKCsFrCuAEOO2
	 ikeK44vqRz3+kEZjQZYtGJHxm7o3OOGlLSLYGaQwguUUo+5isE5F3rdwiQiijWZjrFNcwDinft0xJ
	 uk7SlLwRsMpfemvZf2tyJ/wRtmyJ42c5xoan+9jdHzbu0Fpn0ukU/uLfWzm8UBXVLWgLW68OtxZ+s
	 s7UubAhyGi2OXhd37kt3OG1hB0sUBXP2GDdavSpB4w/mabdznQ6reeBY0HrU5tjSNazw2ZvnH+27l
	 uqBEdF9IFVj65f8p9WJFtt4qO67/4cTjlD03/NsuvHON5OvsdOYj3DQLKVX3cxKysLMUcrFUicMfa
	 FRz+GSBnNjRJtKh047QqHUJ6ONmwAQ7sKinwsMjiHzBWJDzh6flXhZLfD7Qc9nuYS/aj9/xuI2mwd
	 KUiC9lDTKL4D0Tp1LKzldI1FK8ChtHutDuZSilufRP37SnjVKthlobfWZuOgNjb/kWKeFtChGZuoH
	 NIuCGmd2y1PzzrJZyjDT55awvUINzzRpq7VIEjGHNkMHYJL9ZLN8GzWrfqZupeaUNdKg9Q7aljomT
	 czs0HD+4/Bo9RHbKxfmm5qwKbCx0TrClmnshOdZFSxwK3i/Vi8XplgVonX78ZqRHzeRM9wJaZo5jW
	 GxQ+316YYUksIkDpl25GrCh8UrMjB8JQwBbhcROpPiidgoCq8VTZCJuvrlJ0NGU5k2oFk5jd4bI3/
	 x/v8/Sb9BSVlp2QtLRfJYGnW3htAUjy+MT2fam177lsNCnPgb3wNlAgG1RkN3yTeR27g8bfs7+efn
	 +N3w9NvhV6ONr0SHy1f06fEgazvq7hkv5k/ZVjvYsP/w0D4rwV+tYIpXyvr7/g6mJv4/wHNOA9YYv
	 81WKVzAZj0/KqNn4jFku/Aso0866oBomlIAXyY7yYVbBfVMCMRV4ITq3GnogfuCWqPonFdPZgNvcK
	 jcjUlIxFvNXuePoauHAU+5rTvg95QwdWsFBdxMzP9IYHeg==
Received: from [192.168.1.100] ([183.94.22.181])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 75E2FA1F; Sun, 21 Jun 2026 08:29:30 +0800
X-QQ-mid: xmsmtpt1782001770t17vm1vd5
Message-ID: <tencent_45CAE878B5922990DB102BE05A1BAD50DA09@qq.com>
X-OQ-MSGID: <213501bc-74e7-43ef-b72e-83ed5976371b@qq.com>
Date: Sun, 21 Jun 2026 08:29:30 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 7/9] mm/slab: introduce kfree_rcu_nolock()
To: "Harry Yoo (Oracle)" <harry@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-7-70a54f3775bb@kernel.org>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-7-70a54f3775bb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I noticed the Sashiko AI review [1] in this thread flagged that
kfree_call_rcu_nolock() dereferences slab->slab_cache even when
virt_to_slab() returns NULL (for large kmalloc objects that bypass
SLUB, or vmalloc addresses).  The VM_WARN_ON_ONCE fires but does not
stop execution, and the subsequent NULL dereference is deterministic.

I was able to reproduce this in QEMU with KASAN.  The trigger is as
simple as passing a large (>8KB) kmalloc buffer to the new function.

On Tue, Jun 16, 2026 at 12:06:14AM +0800, Harry Yoo (Oracle) wrote:
 > This commit introduces kfree_rcu_nolock(), a variant of kfree_rcu()
 > designed to be safely called from unknown contexts without falling
 > back to batched processing.
...
 > +void kfree_call_rcu_nolock(struct rcu_head *head, void *ptr)
 > +{
 > +    struct slab *slab;
 > +    struct kmem_cache *s;
 > +
 > +    VM_WARN_ON_ONCE(is_vmalloc_addr(ptr) || !virt_to_slab(ptr));
 > +
 > +    slab = virt_to_slab(ptr);
 > +    s = slab->slab_cache;

The problem: if ptr is a large kmalloc object (> KMALLOC_MAX_CACHE_SIZE,
which is 8 KB on x86_64), the allocation bypasses SLUB and comes from
the page allocator.  virt_to_slab() returns NULL.  VM_WARN_ON_ONCE
prints a warning but does NOT return, and the next line dereferences
NULL->slab_cache at offset 0x8.

[Reproduction]

I rebuilt the kernel with CONFIG_KASAN=y and added a small late_initcall
that allocates a 16 KB buffer and passes it to kfree_call_rcu_nolock():

   static int __init kfree_rcu_nolock_poc_trigger(void)
   {
       void *p = kmalloc(16384, GFP_KERNEL);
       struct rcu_head *head = kmalloc(sizeof(*head), GFP_KERNEL);
       kfree_call_rcu_nolock(head, p);
       return 0;
   }
   late_initcall(kfree_rcu_nolock_poc_trigger);

[Crash log — kernel 6.19.0-rc5, CONFIG_KASAN=y, CONFIG_DEBUG_VM=y]

   kfree_rcu_nolock PoC: calling kfree_call_rcu_nolock on large obj 
ffff888026c5c000

   WARNING: mm/slab_common.c:1271 at kfree_call_rcu_nolock+0x1e/0xc0
   VM_WARN_ON_ONCE(is_vmalloc_addr(ptr) || !virt_to_slab(ptr))

   BUG: kernel NULL pointer dereference, address: 0000000000000008
   #PF: supervisor read access in kernel mode
   #PF: error_code(0x0000) - not-present page

   RIP: 0010:kfree_call_rcu_nolock+0x5c/0xc0
   Call Trace:
    <TASK>
    poc_trigger_init+0x2a/0x40
    do_one_initcall+0x131/0x730
    kernel_init_freeable+0x471/0x7e0
    kernel_init+0x28/0x300
    ret_from_fork+0x2c/0xc0
    </TASK>

   Kernel panic - not syncing: Fatal exception

The crash is at offset 0x5c inside kfree_call_rcu_nolock(), which
corresponds to `s = slab->slab_cache`.  The fault address 0x8 is
exactly offsetof(struct slab, slab_cache).


[1] 
https://sashiko.dev/#/patchset/20260615-kfree_rcu_nolock-v3-0-70a54f3775bb%40kernel.org
     (Sashiko AI code review — "Null Pointer Dereference", Severity: 
Critical)

Thanks,
XIAO


