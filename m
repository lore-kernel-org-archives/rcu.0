Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758A3386D3
	for <rcu@vger.kernel.org>; Tue,  6 May 2025 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746491431; cv=none; b=PP4ZryfAS/oUaeNbBLr4ofPI7puD4Id88jC+IJAgCa26giuXp46sq9Lt++cSo0QfjpKCifzFu3vum7jbrDasJw/6sbERuHvz0vcSrHSQtiWA6oGvZlkAJpgcRRu3/BzS/Q/6N/ktA+oaARZ/GNLWM4OPx2T5PsnX67rhE8CBeBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746491431; c=relaxed/simple;
	bh=WEKjtKkpZssuWc+/QqRBywTJGO0vQg2TrdXdtyJq1Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVuY0bIGHgVDAJlsNoPROKKCmeov3eZdp2wm18M2h9P0gXBeSzbAVW4RWfkFXR4YZXS5zy6eGDwO+TAA5jB3MGPE8rvInbnsGk0rTcLbvJ1G3T+BnT7OphNPTJ7dAlPx/wSum2R80wWgav12NpqMbYG9JGJy1Trb4PBqrK1cWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73b71a9a991so968325b3a.2
        for <rcu@vger.kernel.org>; Mon, 05 May 2025 17:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746491429; x=1747096229;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dC8FQz1UwOtwaYiDQH+mx1aJtgD1UxCwJHRxzRq7QM=;
        b=WLYBFwEnR8uAgKZ0NA/bxHEExUay49Fn7iA011/f1qI/MKCziVjtIEAtsKglIIlzev
         nsi6flXhX7vS3iKzWQyJY5sgRzSxtVn3WwvgGgp8SPksLfw2MIqo9l+ddqgVk9xUmbTU
         iQm8xMKziBZCUqpegTeDHfVt3w8ckFHszkJ+qYOkmEq51CLk0obWN6NCOjAIF0CMSP9H
         U/sKi/0LvCf5TSXOzevaxIpk7BGQgDm2+wjGDpqlQc9tajBlMm+8itjHIYYDztM8b3jF
         CUH7tVRePcn/n4znLxgL4TlG1H5icKJYw9X+8WnmEk0NGkDtz9SnqRa+qUiJieMlKJL8
         tMfg==
X-Forwarded-Encrypted: i=1; AJvYcCW7FqCJt8u3Zd2ppQqSeHwfkfpEYtESG0Mw3jtsQZFlVculdXcs9dldwAb6F/YG4kQHbGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wlJCLu4HIgy9L/eufZE54MckLULza9Pa8W8FxOewab+q31As
	z6UHKhptiUZvNEX49jX9xu7nKrp5/RRI59ZcjK0tyxZOlYDJEF4vgmxMUQ==
X-Gm-Gg: ASbGncu9nIaxeZPbda0k8qY3kz7Yy5mkR+XNg2lQkNKx+NOvak3VHLG8XcwxdL7FFlo
	YmHdxZzeoUnU/AB+WKtZUe8Zr+GKn8icy5nXcoxApJ28PGwT9X5BRNNwbWAS0GhVQBDA4a7czr9
	pvSZWQz/sJtkbQueyaaJO7axL9klV78V2H+493EiQpTPUqoA7hPi62wurX3t/ZTiS1TA9c8hBKX
	IqfXFKADKjzGoNAysZ+GfUOqjo0grsumtVJHTK+K7Az9+SXmd1QoKPPLrRqkqFRiH0Hw207XcRM
	lA0CY30/aWyEfz/CVIIOdj9gU56ElgPuzfKRwH1Dq3YPq36YrSz7ztjBOckpIAQ=
X-Google-Smtp-Source: AGHT+IFFm2fGyLIA5UNF6QZ+3SsdQINwG3JK/Q0TuKPxLSLrkQRc014arTdYAPV6AoC4jkeLAiUpIA==
X-Received: by 2002:a05:6a00:4ac5:b0:730:8c9d:5842 with SMTP id d2e1a72fcca58-74058b4e906mr6926615b3a.5.1746491428850;
        Mon, 05 May 2025 17:30:28 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dbb8c1sm7555777b3a.49.2025.05.05.17.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 17:30:28 -0700 (PDT)
Message-ID: <4eaaaf62-40a6-43f8-bcce-6e23b475e12f@kzalloc.com>
Date: Tue, 6 May 2025 09:30:23 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 byungchul@sk.com, max.byungchul.park@gmail.com, rcu@vger.kernel.org
References: <8bdfa4fc-0e4a-4965-bc29-6ab6c1573ef6@kzalloc.com>
 <6b5d7f21-459c-48c8-9fa2-d494b01bc5d8@gmail.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <6b5d7f21-459c-48c8-9fa2-d494b01bc5d8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Colin,

Thank you for the insights.

On 5/6/25 8:16 =EC=98=A4=EC=A0=84, Colin King (gmail) wrote:
> On 05/05/2025 23:29, Yunseong Kim wrote:
>> Hi all,
>>
>> I encountered a kernel panic in the RCU core subsystem while running a=
 stress-ng on a virtualized ARM64 system.
>>
>> This panic consistently occurs regardless of whether I increase or dec=
rease the memory size.
>>
>> The crash seems to originate from rcu_do_batch(), jumping to a pointer=
 (0xffff00003a114000) that appears to be non-executable.
>> The PTE for the address confirms XN=3D1. Given the heavy binderfs work=
load, I suspect there may be a use-after-free or dangling pointer involve=
d in a callback invocation.
>>
>> Platform:
>> =C2=A0 Architecture: arm64
>> =C2=A0 Virtualized environment: Apple Silicon M2 (Apple Virtualization=
 Framework)
>> =C2=A0 Kernel version: 6.15.0-rc4+
>> =C2=A0 Attached Config: CONFIG_PREEMPT_VOLUNTARY=3Dy, CONFIG_KASAN=3Dy=

>>
>> Reproducer:
>> =C2=A0 sudo ./stress-ng --binderfs 8 --binderfs-ops 10000 -t 15 \
>> =C2=A0=C2=A0 --pathological --timestamp --tz --syslog --perf --no-rand=
-seed \
>> =C2=A0=C2=A0 --times --metrics --klog-check --status 5 -x smi -v --int=
errupts --change-cpu
>=20
>=20
> I suspect --change-cpu is required to trigger this issue. Does it trigg=
er without this option?=C2=A0 Can you reproduce the issue when reducing t=
he number of --binderfs intances?

As you suggested, I've been testing combinations of enabling and disablin=
g '--binderfs' and '--change-cpu' separately.

While I'm not deeply familiar with the internal mechanisms of binderfs,
I found that the panic still occurs consistently with --binderfs, even wi=
thout the --change-cpu option.

I've also tried replacing --binderfs with other core stressors like --pro=
cfs, --ramfs, and --file...,
but so far the issue does not reproduce with these alternatives =E2=80=94=
 the kernel panic seems exclusive to binderfs.

I ran tests for --binderfs intance 1 through 3 about three times each, an=
d the panic did not occur in those runs.

However, the panic occurred when I used 4 instances.

Reproducer with reduced instance from 8 to 4 and without change-cpu optio=
n:
 sudo ./stress-ng --binderfs 4 --binderfs-ops 10000 -t 15 \
  --pathological --timestamp --tz --syslog --perf --no-rand-seed \
  --times --metrics --klog-check --status 5 -x smi -v --interrupts

Here's the panic log from the test with the options mentioned above,
the call stack looks nearly identical to what I observed in the previous =
crash:

[ 1517.764550] stress-ng-thras (18990): drop_caches: 3
[ 1535.016245] stress-ng-thras (18990): drop_caches: 1
[ 1549.753497] stress-ng-thras (18990): drop_caches: 2
[ 1562.702095] stress-ng-thras (18990): drop_caches: 3
[ 1612.728092] stress-ng-thras (18990): drop_caches: 1
[ 1674.033654] stress-ng-thras (18990): drop_caches: 2
[ 1977.262956] Unable to handle kernel execute from non-executable memory=
 at virtual address ffff00003a114000
[ 1977.262980] Mem abort info:
[ 1977.262988]   ESR =3D 0x000000008600000f
[ 1977.262998]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
[ 1977.263008]   SET =3D 0, FnV =3D 0
[ 1977.263017]   EA =3D 0, S1PTW =3D 0
[ 1977.263026]   FSC =3D 0x0f: level 3 permission fault
[ 1977.263036] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000dfd8=
8000
[ 1977.263047] [ffff00003a114000] pgd=3D18000000effff403, p4d=3D18000000e=
ffff403, pud=3D18000000efffe403, pmd=3D18000000effad403, pte=3D006800007a=
114707
[ 1977.263088] Internal error: Oops: 000000008600000f [#1]  SMP
[ 1977.263097] Modules linked in: pcbc lrw xcbc wp512 nhpoly1305_neon nhp=
oly1305 libpoly1305 michael_mic md4 streebog_generic rmd160 crc32_generic=
 twofish_generic twofish_common serpent_generic fcrypt cast6_generic cast=
5_generic cast_common camellia_generic blowfish_generic blowfish_common e=
crdsa_generic des_generic libdes aegis128 overlay isofs uinput snd_seq_du=
mmy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_in=
et nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_re=
ject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack rfkill nf_d=
efrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr sunrpc virtio_snd snd_seq=
 snd_seq_device snd_pcm virtio_net snd_timer snd virtio_balloon net_failo=
ver soundcore failover vfat fat joydev loop nfnetlink vsock_loopback vmw_=
vsock_virtio_transport_common zram lz4hc_compress lz4_compress vmw_vsock_=
vmci_transport vmw_vmci vsock uas polyval_ce polyval_generic usb_storage =
ghash_ce sha3_ce sha512_ce sha512_arm64 virtio_gpu virtio_dma_buf apple_m=
fi_fastcharge
[ 1977.263372]  fuse
[ 1977.263387] CPU: 2 UID: 0 PID: 27 Comm: ksoftirqd/2 Kdump: loaded Not =
tainted 6.15.0-rc4+ #1 PREEMPT(voluntary)=20
[ 1977.263398] Hardware name: Apple Inc. Apple Virtualization Generic Pla=
tform, BIOS 2075.101.2.0.0 03/12/2025
[ 1977.263406] pstate: 21400805 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D-c)
[ 1977.263416] pc : 0xffff00003a114000
[ 1977.263443] lr : rcu_do_batch+0x2dc/0x860
[ 1977.263457] sp : ffff800080143c90
[ 1977.263462] x29: ffff800080143cb0 x28: ffff000048608000 x27: ffff00003=
a114000
[ 1977.263478] x26: ffff800084442000 x25: 0000000000000000 x24: ffff80008=
43d9b18
[ 1977.263492] x23: ffff800082150ac0 x22: 0000000000000007 x21: 000000000=
000000a
[ 1977.263506] x20: ffff000030e08000 x19: ffff0000af4cfe00 x18: 000000000=
0000002
[ 1977.263521] x17: 0000000000000000 x16: 0000000000000001 x15: 000000000=
0000017
[ 1977.263535] x14: 0000000000000004 x13: ffff0000af4cfed0 x12: 000000000=
0000002
[ 1977.263549] x11: 0000000000110009 x10: 0000000000ff0100 x9 : ffff80008=
385a580
[ 1977.263563] x8 : 0000000100000100 x7 : 0000000000000000 x6 : ffff80008=
03f89bc
[ 1977.263577] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 000000000=
0000002
[ 1977.263591] x2 : 0000000000000000 x1 : ffff800082a4aeb8 x0 : ffff00004=
8608000
[ 1977.263605] Call trace:
[ 1977.263611]  0xffff00003a114000 (P)
[ 1977.263623]  rcu_core+0x2a0/0x4e8
[ 1977.263635]  rcu_core_si+0x1c/0x30
[ 1977.263646]  handle_softirqs+0x1b4/0x588
[ 1977.263661]  run_ksoftirqd+0x5c/0xf8
[ 1977.263670]  smpboot_thread_fn+0x27c/0x490
[ 1977.263683]  kthread+0x2ac/0x318
[ 1977.263697]  ret_from_fork+0x10/0x20
[ 1977.263714] Code: dff29fc3 00200000 dff28fc3 00200000 (48608000)=20
[ 1977.263723] SMP: stopping secondary CPUs
[ 1977.264081] Starting crashdump kernel...
[ 1977.264090] Bye!

Please let me know if there's any specific option or debugging mechanism =
you'd recommend to help isolate this further.

Best regards,
Yunseong Kim

