Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173D7359A6D;
	Mon, 22 Jun 2026 05:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106136; cv=none; b=Wx9sPm7iq0q8t4n2SPsAl7vnAXGdbhh7n1oRr7UwQTt5ncDyk4LLfohr0Wxgf55Zg+R16GmMavv1PpGMNR90X08ae+nvU+hvowpGwcbodr1UePQVLzV9tRlte1/FYjIxAmjjgHVDHswY4vlk3KFoA5WjGGLMilZX/t30WDzbotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106136; c=relaxed/simple;
	bh=ewFX1J5r9BOcftZkvXmGDF13VYIMWuo+fB74CRrpi9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrVyE8XVPswDbyID87+Uar9dRrHJV/xIBqyhiC5LY1Dgv5NjlpUjynV0P5eW8Ls5kRKPN1XDHQSFNtB96jVRkPaFZuricotOdijWZttjFX8M7HTknysjmhcGYjMYyGDkoexhPwBnn1KhkgI7q6JMpyyxCmSOpXwzgF5QX8yPalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZdfY7lw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZdfY7lw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC5D1F000E9;
	Mon, 22 Jun 2026 05:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782106134;
	bh=6AoqeIgtsoIEotLsuT/6S5kA35HKRcKnzuszYGA9cSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jZdfY7lwrXHdCZrH4e7gAQhZZ7JXmuA+oGmtDtuFw7JIfOkwv8aT4Th3uO/RA+qPH
	 Zv3GJjDK9oEYKuSYIexqQ/T1oCye9QpWGn80r6l5mZwVA78VRELY3ulL9fPWPogz6w
	 Ba0Onckl6/+59VNCO7iW92MoCuttpHcavMkmU7bbUW71La5yo1XzLR/YFWP0v0VBE3
	 dm0t2Xv3323e/fpD4ESeQqz5xFT+hQ02lmNy/o2exeientP2rluE4VtuDMXOxVaPt8
	 d9BQfttxOj1KZZme9/oCYX5c0eTyZ3v3bLRL/d8/gmoa+3RYhXcZuSRfkDDHttJauN
	 mKB2Kdclqnwfg==
Message-ID: <e54ce8be-9480-4583-9c6a-d0dbe1378f53@kernel.org>
Date: Mon, 22 Jun 2026 14:28:44 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 7/9] mm/slab: introduce kfree_rcu_nolock()
To: XIAO WU <xiaowu.417@qq.com>, Vlastimil Babka <vbabka@kernel.org>,
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
 <tencent_45CAE878B5922990DB102BE05A1BAD50DA09@qq.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <tencent_45CAE878B5922990DB102BE05A1BAD50DA09@qq.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0bA2sXgPSFRAxm6IZvk0FJpS"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0bA2sXgPSFRAxm6IZvk0FJpS
Content-Type: multipart/mixed; boundary="------------FtmCIR510BgenahTU3dM406w";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: XIAO WU <xiaowu.417@qq.com>, Vlastimil Babka <vbabka@kernel.org>,
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
Message-ID: <e54ce8be-9480-4583-9c6a-d0dbe1378f53@kernel.org>
Subject: Re: [PATCH for-next v3 7/9] mm/slab: introduce kfree_rcu_nolock()
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-7-70a54f3775bb@kernel.org>
 <tencent_45CAE878B5922990DB102BE05A1BAD50DA09@qq.com>
In-Reply-To: <tencent_45CAE878B5922990DB102BE05A1BAD50DA09@qq.com>

--------------FtmCIR510BgenahTU3dM406w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/21/26 9:29 AM, XIAO WU wrote:
> Hi,

Hi Xiao,

> I noticed the Sashiko AI review [1] in this thread flagged that
> kfree_call_rcu_nolock() dereferences slab->slab_cache even when
> virt_to_slab() returns NULL (for large kmalloc objects that bypass
> SLUB, or vmalloc addresses).  The VM_WARN_ON_ONCE fires but does not
> stop execution, and the subsequent NULL dereference is deterministic.

Thanks for taking a look, but this was intentional.

I should have documented that only kmalloc_nolock() ->
kfree_rcu_nolock() is allowed and kmalloc() -> kfree_rcu_nolock()
is not allowed (yet).

> I was able to reproduce this in QEMU with KASAN.  The trigger is as
> simple as passing a large (>8KB) kmalloc buffer to the new function.
>=20
> On Tue, Jun 16, 2026 at 12:06:14AM +0800, Harry Yoo (Oracle) wrote:
>> This commit introduces kfree_rcu_nolock(), a variant of kfree_rcu()
>> designed to be safely called from unknown contexts without falling
>> back to batched processing.
> ...
>> +void kfree_call_rcu_nolock(struct rcu_head *head, void *ptr)
>> +{
>> +    struct slab *slab;
>> +    struct kmem_cache *s;
>> +
>> +    VM_WARN_ON_ONCE(is_vmalloc_addr(ptr) || !virt_to_slab(ptr));
>> +
>> +    slab =3D virt_to_slab(ptr);
>> +    s =3D slab->slab_cache;
>=20
> The problem: if ptr is a large kmalloc object (> KMALLOC_MAX_CACHE_SIZE=
,
> which is 8 KB on x86_64), the allocation bypasses SLUB and comes from
> the page allocator.  virt_to_slab() returns NULL.  VM_WARN_ON_ONCE
> prints a warning but does NOT return, and the next line dereferences
> NULL->slab_cache at offset 0x8.

Since kmalloc_nolock() does not support large kmalloc, the warning
is not supposed to trigger. That is why I added only debug warnings.

> [Reproduction]
>=20
> I rebuilt the kernel with CONFIG_KASAN=3Dy and added a small late_initc=
all
> that allocates a 16 KB buffer and passes it to kfree_call_rcu_nolock():=

>=20
>   static int __init kfree_rcu_nolock_poc_trigger(void)
>   {
>       void *p =3D kmalloc(16384, GFP_KERNEL);
>       struct rcu_head *head =3D kmalloc(sizeof(*head), GFP_KERNEL);
>       kfree_call_rcu_nolock(head, p);

As mentioned ealier, kmalloc() -> kfree_rcu_nolock() is not supported.

--=20
Cheers,
Harry / Hyeonggon

>       return 0;
>   }
>   late_initcall(kfree_rcu_nolock_poc_trigger);
>=20
> [Crash log =E2=80=94 kernel 6.19.0-rc5, CONFIG_KASAN=3Dy, CONFIG_DEBUG_=
VM=3Dy]
>=20
>   kfree_rcu_nolock PoC: calling kfree_call_rcu_nolock on large obj
> ffff888026c5c000
>=20
>   WARNING: mm/slab_common.c:1271 at kfree_call_rcu_nolock+0x1e/0xc0
>   VM_WARN_ON_ONCE(is_vmalloc_addr(ptr) || !virt_to_slab(ptr))
>=20
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>=20
>   RIP: 0010:kfree_call_rcu_nolock+0x5c/0xc0
>   Call Trace:
>    <TASK>
>    poc_trigger_init+0x2a/0x40
>    do_one_initcall+0x131/0x730
>    kernel_init_freeable+0x471/0x7e0
>    kernel_init+0x28/0x300
>    ret_from_fork+0x2c/0xc0
>    </TASK>
>=20
>   Kernel panic - not syncing: Fatal exception
>=20
> The crash is at offset 0x5c inside kfree_call_rcu_nolock(), which
> corresponds to `s =3D slab->slab_cache`.  The fault address 0x8 is
> exactly offsetof(struct slab, slab_cache).
>=20
> [1] https://sashiko.dev/#/patchset/20260615-kfree_rcu_nolock-
> v3-0-70a54f3775bb%40kernel.org
>     (Sashiko AI code review =E2=80=94 "Null Pointer Dereference", Sever=
ity:
> Critical)
>=20
> Thanks,
> XIAO

--------------FtmCIR510BgenahTU3dM406w--

--------------0bA2sXgPSFRAxm6IZvk0FJpS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajjIDAAKCRCGXBN6rc5S
1lXTAQD/UF6jRRFlByYwyRtFV1aCLkXuvtjzk07gG5EFoGXyowEAsd0BXdoNNnRS
u74XP6LNkEXRVCalQe/Jc0H5N9M0EQw=
=oppK
-----END PGP SIGNATURE-----

--------------0bA2sXgPSFRAxm6IZvk0FJpS--
