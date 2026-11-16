Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852670;
	b=2PBEq9BKp2ruak70chPwU1tbiPmIJ5NX/1GVdQoFa8AF4fhbMVsKmox4U44p6kVctvwl
	 J/ww+r3MryUFJRlUiCkBe5wWm92/UQJLs3CSaLwhJzXKra6nj2VHzjM++xWGl81LRxoKm
	 Q9O0zRvYYgIgAOwa6l8NUZ3tTn6Ze9OTEkWvJRE1AIaZ98o4JYBeq40+kgDOc6yq8Le3/
	 1iJH+YrTJHwoh9ry+Ly5Y9WcEz19h0puc9u4CGaTleTwN/rbVM7LfVdgy79glQE6qdZko
	 umfnfCQacydLMowlWNGdKi4EbNSSZNFRRZLq1pa4N4C8/eFolGP7bLctF8Wj1hFAUEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852670;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Cw9zGt+6BcAAxGXLKuxEpnFTLz0hNmcrTc0x1UP3Om0=;
	b=a1h+skjxNkVqhoqZoxGDWxWNln6c7W3rD94ZVYk0Teby5clxTS2yFnJTlLg88GHxzqpK
	 JkfMWoSukLXQILadIjOZCZTMQgjMrUxPpo8Yh6YBC+13LACEzjxwAzrrY4/MUaDueDQPa
	 E6JUSJ+nM6F5AYgRgKNdtZikgv4xbjQSp4V0ip7PBYbAgT0rX5tMbVrIc/ODE69e3o6QE
	 WFhHgXsBr7wL1WFa8ejzMvX9I7RtQs9TY38gzmElJaU5k6M5Lw7Qlu1wumZ35xmSMuZAW
	 9j//uEd44UnWlLV6Mqc26/xLrg2l97UG0eP3m8ZzyPPnskVHSqA9DmyW2XwpjUaR39w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oN7MEyFk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13E606A322;
	Mon, 16 Nov 2026 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oN7MEyFk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B791F000C4;
	Mon, 16 Nov 2026 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794852669;
	bh=Cw9zGt+6BcAAxGXLKuxEpnFTLz0hNmcrTc0x1UP3Om0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=oN7MEyFkmcArK3z2TUAxOyshqkJz25MvGPIiGf0a4czyOSLZD9y/DBC1EJHVojx6o
	 v8NT0Sq5e5m/H+NpIcvklduHLyP2XPEdwbIEaeMAW1XeyrqFGSXDTRL5+6lt25rnZX
	 fnH2BYKwFdFY6ZwKptVYd1NnNrRTn9UKWzdDz9L/2sOd6iDXWgF8qQfuHImENT+VDq
	 BFyOHyqfUrFqkb5Uoe8QkRGKz57tQ/VxLa3R9QPJFsRAM0Hl9YrKb39oUrsHtOq/7D
	 9NWMlp3LX/+499UJF935UscbrhGCAFDjaiLCFm2MISnqq1NcRuZBHXV1A3/g2EflJZ
	 ld8R34R9KAOIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 85D66CE097D; Mon, 16 Nov 2026 10:11:09 -0800 (PST)
Date: Mon, 16 Nov 2026 10:11:09 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Guikun Yang <yangguikun19@qq.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	rcu@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Bug report] srcu_module_coming() dereferences unvalidated
 ___srcu_struct_ptrs entries - wild kernel-memory write on module load
Message-ID: <9e56774c-abf3-49bc-b6e8-34ae1db4cf9d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <mod-r-offset-oob-20261113@qq.com>
 <tencent_0836A27053A7BED946E49CE04D27A31E7D09@qq.com>
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
In-Reply-To: <tencent_0836A27053A7BED946E49CE04D27A31E7D09@qq.com>

On Sat, Nov 14, 2026 at 09:30:00AM +0800, Guikun Yang wrote:
> From: Guikun Yang <yangguikun19@qq.com>
> To: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
>     rcu@vger.kernel.org, linux-modules@vger.kernel.org,
>     linux-kernel@vger.kernel.org
> Subject: [Bug report] srcu_module_coming() dereferences unvalidated
>  ___srcu_struct_ptrs entries - wild kernel-memory write on module load
> 
> Hi Paul, Luis,
> 
> The module loader hands the contents of the ___srcu_struct_ptrs section
> to SRCU as an array of absolute struct srcu_struct * pointers, with no
> validation of any entry. srcu_module_coming() then writes through each
> one during the MODULE_STATE_COMING notification, inside init_module().
> A crafted module whose synthetic section contains an arbitrary 64-bit
> value therefore gets a kernel-heap pointer written to an
> attacker-chosen address.
> 
>   Oops: general protection fault, probably for non-canonical address
>   0xe00006aaa0000021: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
>   KASAN: probably user-memory-access in range
>   [0x0000555500000108-0x000055550000010f]
>   RIP: 0010:srcu_module_notify+0x480/0x610
>   RAX: 0000607f57d191c0   (alloc_percpu return, the value being written)
>   RBX: 0000555500000100   (the section entry, verbatim from the file)
>   RDI: 0000555500000108   (&ssp->sda)
>    notifier_call_chain
>    blocking_notifier_call_chain_robust
>    load_module
>    __do_sys_init_module
> 
> ## The three pieces
> 
> Loader, zero validation (kernel/module/main.c):
> 
>   mod->srcu_struct_ptrs = section_objs(info, "___srcu_struct_ptrs",
>                                        sizeof(*mod->srcu_struct_ptrs),
>                                        &mod->num_srcu_structs);
> 
> section_objs() counts entries and returns sh_addr; the bytes' validity
> is entirely up to the ELF file.
> 
> Generator, absolute pointer (include/linux/srcutree.h):
> 
>   struct srcu_struct * const __srcu_struct_##name
>         __section("___srcu_struct_ptrs") = &name
> 
> Unlike __tracepoints_ptrs (PREL32 self-relative on x86), this is a
> link-time absolute address. In a hand-built section the bytes are
> whatever the attacker writes, and since no .rela entry targets them,
> apply_relocations() never touches them either.
> 
> Consumer, write on load (kernel/rcu/srcutree.c, unchanged from 7.3 to
> mainline 2026-11-14):
> 
>   ssp = *(sspp++);
>   ssp->sda = alloc_percpu(struct srcu_data);       /* wild write */
>   if (WARN_ON_ONCE(!ssp->sda))
>           return -ENOMEM;
>   ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];        /* second write */
> 
> ssp->sda sits at offset 8, so an entry value V makes the kernel write
> a freshly allocated percpu pointer to V+8, and a pointer derived from
> it to V. The unload/rollback path (srcu_module_going()) dereferences
> ssp->srcu_sup and frees ssp->sda through the same unchecked entries.
> 
> ## Why this is more than a crash
> 
> The write value is a kernel heap address and the target is a fully
> attacker-chosen 64-bit address. Pointing the entry at a
> userland-readable mapping leaks the percpu allocation address directly
> to userspace, defeating percpu-base randomization and contributing to
> KASLR defeat. Pointing it at any zero-filled kernel address lands the
> write. A non-canonical target gives the deterministic #GP above
> (reproduced 7.3.0, KASAN inline, DEBUG_PAGEALLOC).
> 
> ## The fix has an in-tree precedent
> 
> jump_label.c validates exactly this class of pointer in the same
> module-notification path (kernel/jump_label.c:716):
> 
>   if (within_module((unsigned long)key, mod)) {
>           static_key_set_entries(key, iter);
>           continue;
>   }
> 
> The suggested fix mirrors it in srcu_module_coming() and
> srcu_module_going():
> 
>   for (i = 0; i < mod->num_srcu_structs; i++) {
>           ssp = *(sspp++);
> +         if (!ssp || !within_module((unsigned long)ssp, mod))
> +                 return -EINVAL;
>           ssp->sda = alloc_percpu(struct srcu_data);

Good catch, thank you!

I presume that srcu_module_going() would instead do something like this?

> +         if (!ssp || !within_module((unsigned long)ssp, mod))
> +                 continue;

Either way, would you be willing to send a proper patch?

							Thanx, Paul

> __tracepoints_ptrs and __bpf_raw_tp_map are sibling pointer sections
> with the same exposure; a shared check in find_module_sections()
> would cover the class, but the SRCU entries are the concrete
> write-what-where primitive demonstrated here.
> 
> This is the second report in this series: the relocation r_offset
> bounds gap went out as <mod-r-offset-oob-20261113@qq.com> yesterday.
> Both are cases of the module loader consuming section contents that
> its ELF validity layer never checked.
> 
> ## Reproducer
> 
> Carrier is a real xt_mark.ko built from the same tree as the test
> kernel (vermagic, this_module size, 11 undefined symbols all
> matching). A section synthesizer appends an 8-byte
> ___srcu_struct_ptrs entry (0x0000555500000100), fixing shstrtab,
> e_shnum and e_shoff. Same boot, three steps:
> 
>   1. load original xt_mark.ko   -> 0
>   2. unload                     -> 0
>   3. load synthesized module    -> the Oops above
> 
> The A/B pair, the synthesizer and the reproducer are available on
> request.
> 
> Tested on 7.3.0; kernel/rcu/srcutree.c and the loader path are
> unchanged in mainline as of 2026-11-14.
> 
> Thanks,
> Guikun Yang
> 
> 
