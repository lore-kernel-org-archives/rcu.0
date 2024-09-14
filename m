Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D611FB4;
	Sat, 14 Sep 2024 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726320170; cv=none; b=aP49ctC7o0vRZE9ojm2S5+LubioXKH8llL5KOQglML0TkJXY3szBdQnA9rxW7t9A++xLQXYZrJUtwLaRETkisPGAX9Lv/qNFUwhH+hMgnqnNAjGmDrJCC/jU5ttqTibJYifAdKhNCQjuACX/GdsmVoEh8CwWO4vcH59MVXHhlF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726320170; c=relaxed/simple;
	bh=mXf3DD3nlqfRlUqoStESba5ZzvTzYvkA0CK44c1p2fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0XsFcr3541pI/Jn93cmmhzknXKBs3YbKZJ6/f1IWxg40wr8bmtjKrSD5Ai/4JDFqZyBy3S61A98l39todjrxDNYQnES84y4AIm8A52MRzm0o6dX70sXDGlh403sO/B2jNrR4T0f1CgsfUhiy70A50pqaaM0HO+4dkMj3wC0nbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzuVsNbx; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzuVsNbx"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365cf5de24so3852793e87.1;
        Sat, 14 Sep 2024 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726320167; x=1726924967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+sUBUYlwVuWfbjGxbMazluFnfi9XsaxNKbywpciuJQ=;
        b=KzuVsNbxnvQrOhGye6S+UaUilWJCwAHNCYAjibunuZclUayTrEXcjsegvYxardbPsY
         V/8wj5XiEVKZ9pIawatiLN0HxkZ19T0YuJsyl3NR9KRN7/72dwyFvjCQBoe2myp7MxJk
         tS91ocvpM7zqvgf+srZzJIfPWiUDPIJRZAQ4Oux9oOWTZEyge7hJ5rHhi9u2v29FE/hc
         J0XHZ3K3+IR/tZH2hghDA+ZWdlKdOHSa9eqzEa8t4ZzFkFHqbOsNh/iEHdU2YSrI8+Fg
         Inho11XBawYngKwvSTOCMtq+zO5tqBxfDiMmHxHm+cZZGEzz7wH4zmBb/Y29ZUVWA1tJ
         cJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726320167; x=1726924967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+sUBUYlwVuWfbjGxbMazluFnfi9XsaxNKbywpciuJQ=;
        b=AMZqYqozjVoCdDwO6PP1X1erFIkervC6jp6Yathtq624UATRP+jsv5I+xkSHk0K+7F
         suBBFyQid6ikSTseTvQupf7V1BiNdVeKn4ihz2+BjCsHdEj8YA7z7znhWvLeXNsBalr/
         VFY9uxYIosjuBO/fxJcDwspzvdMu7PNXcgjcgcvGx8mty8Xz8dVK07nIiq/Dxm7oLPHn
         0yzu7m2EHj695LTinluzQ8IFw/PqABIluuZKUYHRdICMSmD/guYSOImc65VQco2Y6DQa
         0tf4JbJnd498OgX/UyFsZEGKBg1wcBxuvxQ1obdv77t5ZW+27dmbMfEroN/YLB6xCbXC
         +6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUvbcTddeCdbIKhar1iVxOaIPeUMxHkHcSJzWcmGRS/yhDIMkbxJL8nrVMT1bQLLxdEZD+JVdzBsR8BIxQ=@vger.kernel.org, AJvYcCVo4LD6ky+H9lnkFbruN7pMTBHpqS/e/1wVLpcHA/NMtFRDTUkz8ksjHHXTeOe30dfKGQdJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwbZBX3+DR7CsApLjtzgrKtG4ciionbA8PQIFEayEQummK7l96T
	XF7TtS2tJwmTCKMYk1qnos6jF3c9Mi0EMfHm1n1yBYggd955bvbI3XECmVY1oL1j4+8QsnSbxaz
	tA7qeszwMSPSTR1jmkYcl4UouDz4=
X-Google-Smtp-Source: AGHT+IFsMiEbYRkmw/e1WA8TtKvsYa9E2dRTvJEZZePEj8T9ZqQxp5BKMRiahuZVXtqqQ0C7dt3mfLAK5T5gwu3a9cg=
X-Received: by 2002:a05:6512:3d17:b0:536:5364:bc7 with SMTP id
 2adb3069b0e04-53678fec5f7mr5021336e87.60.1726320166228; Sat, 14 Sep 2024
 06:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz> <20240807-b4-slab-kfree_rcu-destroy-v2-7-ea79102f428c@suse.cz>
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-7-ea79102f428c@suse.cz>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sat, 14 Sep 2024 22:22:33 +0900
Message-ID: <CAB=+i9RHHbfSkmUuLshXGY_ifEZg9vCZi3fqr99+kmmnpDus7Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] kunit, slub: add test_kfree_rcu() and test_leak_destroy()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:31=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> Add a test that will create cache, allocate one object, kfree_rcu() it
> and attempt to destroy it. As long as the usage of kvfree_rcu_barrier()
> in kmem_cache_destroy() works correctly, there should be no warnings in
> dmesg and the test should pass.
>
> Additionally add a test_leak_destroy() test that leaks an object on
> purpose and verifies that kmem_cache_destroy() catches it.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  lib/slub_kunit.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>

Hi Vlastimil,

I think we might need to suppress the WARN() due to the active objects
in kmem_cache_destroy()
when it's called from slub_kunit. With this change, the warning below
will be printed every time
slub_kunit is loaded, which made me wonder if there's a bug (for a while).

Actually, SLUB calls pr_err() is called by __kmem_cache_shutdown() if
there are any active objects
during destruction, and the error message is suppressed by slub_kunit.
However, kmem_cache_destroy()
still calls WARN() regardless if there is any error during shutdown.

[  147.546531] Object 0x00000000c09342ca @offset=3D640
[  147.546542] ------------[ cut here ]------------
[  147.546544] kmem_cache_destroy TestSlub_kfree_rcu: Slab cache still
has objects when called from test_leak_destroy+0x74/0x108 [slub_kunit]
[  147.546579] WARNING: CPU: 5 PID: 39703 at mm/slab_common.c:507
kmem_cache_destroy+0x174/0x188
[  147.546587] Modules linked in: slub_kunit uinput snd_seq_dummy
snd_hrtimer rfkill nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct sunrpc nft_chain_nat
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables
nfnetlink qrtr binfmt_misc vfat fat snd_hda_codec_generic
snd_hda_intel snd_intel_dspcfg snd_hda_codec uvcvideo snd_hda_core uvc
snd_hwdep videobuf2_vmalloc snd_seq videobuf2_memops snd_seq_device
videobuf2_v4l2 snd_pcm videobuf2_common snd_timer snd videodev mc
soundcore virtio_balloon acpi_tad joydev loop zram virtio_gpu
ahci_platform libahci_platform virtio_dma_buf crct10dif_ce polyval_ce
polyval_generic ghash_ce sha3_ce virtio_net sha512_ce net_failover
sha512_arm64 failover virtio_mmio ip6_tables ip_tables fuse
[  147.546646] CPU: 5 UID: 0 PID: 39703 Comm: kunit_try_catch Tainted:
G                 N 6.11.0-rc7-next-20240912 #2
[  147.546649] Tainted: [N]=3DTEST
[  147.546650] Hardware name: Parallels International GmbH. Parallels
ARM Virtual Machine/Parallels ARM Virtual Platform, BIOS 20.0.0
(55653) Thu, 05 Sep 202
[  147.546652] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
[  147.546655] pc : kmem_cache_destroy+0x174/0x188
[  147.546657] lr : kmem_cache_destroy+0x174/0x188
[  147.546659] sp : ffff80008aba3d60
[  147.546660] x29: ffff80008aba3d60 x28: 0000000000000000 x27: 00000000000=
00000
[  147.546662] x26: 0000000000000000 x25: 0000000000000000 x24: ffff800094a=
2b438
[  147.546665] x23: ffff80008089b750 x22: 0000000000000001 x21: f9cc80007c1=
782f4
[  147.546666] x20: ffff800082f9d088 x19: ffff0000c2308b00 x18: 00000000fff=
ffffd
[  147.546668] x17: 0000000046d4ed9c x16: 00000000ae1ad4db x15: ffff80008ab=
a3430
[  147.546670] x14: 0000000000000001 x13: ffff80008aba3657 x12: ffff800082f=
0f060
[  147.546679] x11: 0000000000000001 x10: 0000000000000001 x9 : ffff8000801=
652c8
[  147.546682] x8 : c0000000ffffdfff x7 : ffff800082e5ee68 x6 : 00000000000=
affa8
[  147.546684] x5 : ffff00031fc70448 x4 : 0000000000000000 x3 : ffff80029d6=
b7000
[  147.546686] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00011f1=
c8000
[  147.546688] Call trace:
[  147.546689]  kmem_cache_destroy+0x174/0x188
[  147.546692]  test_leak_destroy+0x74/0x108 [slub_kunit]
[  147.546693]  kunit_try_run_case+0x74/0x170
[  147.546697]  kunit_generic_run_threadfn_adapter+0x30/0x60
[  147.546699]  kthread+0xf4/0x108
[  147.546705]  ret_from_fork+0x10/0x20
[  147.546710] ---[ end trace 0000000000000000 ]---
