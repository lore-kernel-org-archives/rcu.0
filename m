Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E31D31B833
	for <rcu@vger.kernel.org>; Thu,  8 Oct 2026 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791423606; cv=pass; b=IIduEBalhSQP+OYlKjbVVIArlnwLNOmxI0YJJ/JL0kERuOJvy4hKqdZaY/3DKnWdafxgnWO7K57ny29gTy6OgcjorLcNXQHnxdXBtc3EWPnOwbqy4GoaFFfxL3uXpHxwkkldN3MHKDV6T7q6cDnRpMHpo0ZoPAtO61qEqS0qImQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791423606; c=relaxed/simple;
	bh=vgeD/CCNHXF5B3Y7rvo7pRgxfu0AYySgREmlRCTZcrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JguxBvkjw6rvRGYYbWPQ04gnLVZaTFC7LSyt0S6qdkTuJqdwl9LerCKDUJeG4yKD+x4C0cCqL1cuSICZnq28zmNdZ3g+rmRD+kzY1OGGxhaWCioJvUc6SAxmqXZopUr34yIAhiFBB+5p7VFjrfabrG6ijy/PQeCxIit4dpE9x7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3ZH4T7g; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3ZH4T7g"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so15777185e9.2
        for <rcu@vger.kernel.org>; Wed, 07 Oct 2026 18:40:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791423602; cv=none;
        d=google.com; s=arc-20260327;
        b=kvBG3NyvOZK1KgqHmlN/6pBmuwKA5+5Thw2AWRUiKC93YArt7ClwxVoVJGt49hI8Hb
         8DYYdATYoxoE5f5O+NCElh3eqps8QJ6JGMAbSMeQEqeCwZXUQ5mQZZV70aDZLckxxuuA
         Jhw/6TWFNR41a06WjiIvQAJ2HSvA6SGwaAnRNXr0yCzq8UXWkc1rsHqT0H2m/GjJNf2D
         uyHXln1tNZXmpB6HzuhgBqDFacUlSg+QfQrmFj2qPSLN6Q14uykkmgcVY0EVna2tuPS7
         6OB5jVQuY7Ed9EMgDjGlBXhHlbZ+0xEZPTx7c9yB19eu3eiKleOXdCthDf/zA42Hf9Ws
         qEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XaP/lWYAkUDMrQpIwwi1VCtvGPGT/0Qr06FMQnFh5xI=;
        fh=Arymc/EiqLH1rQ/ey8nt2aWLzZTiu60ybuAebrCrTIc=;
        b=h+EdbBUyVvIFJKE3yuHtSFuQuP5FH1+ZgNiXdulK9xxmBCB5pNHO9ARNtM+LmfEAES
         DN1dC+iZ81OINH+EDqGjfYSHCrJSs+vwVrlUY6mUd56MGOSNhLIc8l6eTu5crB2awTPn
         0sqXmWFlO87ISl17pHSJN30VaUV16XeLIeK8drT5w48IpxjtvSZPNW1araX8x17w9pux
         i3t1+yszVOKa56IG2Gc7FD1Phi5sfW2aCsfHxFOq0pZIybMpPudQ8ZX0ltlifSL4P5nG
         M2cJIbPQDBOtZBc+KVym9JK81ze+eQmak8E/AHzoYaxzbtrW+0Ql/kfLiw02eg0y7Kkq
         EdOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791423602; x=1792028402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XaP/lWYAkUDMrQpIwwi1VCtvGPGT/0Qr06FMQnFh5xI=;
        b=g3ZH4T7gDa8iBseMopZFvv6bEUUmE5Su212M6oHGtsU7Pc5YV/qN++PWdvb2J35q3e
         7DZALR/tB0+ivjm5M7Y+UJQMBSN5RiYXVw2c6bj/sZFMpzTRhAtfoGfKyQy4pSiMAQ0M
         x4Ccfoqvy9IChMgGPkgSfO2d1z7Jc0z68rPM5DPuhsE5Jk55HjMCC0aI+2yp6ailz8Wa
         AVWTU5o3cVmUirjqh6b5fglBNbcLgAfX1bh6J2MpBJVTRfZayywhhFcOQcagzfZQBgd4
         LDLlV5EYI1CSh9skSvUpQIElEIksCl6s4y7UOrlUbS7sWOjsKa8GYpS1eD5oYC3wC2wu
         VN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791423602; x=1792028402;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XaP/lWYAkUDMrQpIwwi1VCtvGPGT/0Qr06FMQnFh5xI=;
        b=V65h4rvq8DcXtGQnMiyynn5YfgmTMa1kWQV9gIXAQILUEgNN+XvFF3PVYOrtd4Yrkv
         aPnQgEj/D8C4oFXZEKw3NoySz5QUwPMekUoeDNKcVmzOi9/U/jI4GWFSoFN/YfR+gjjC
         eQEcQmtTTamENEQ3yy8X4VLkz14wOPYbFwAIBk/WVE02v8kGrg59KSXM4E5ch8p7yn8G
         re9RgiNeoHfkk3I9/wCYO2MfPUG3ZzuO33Y7SdtvPkoOUEcNiZtlVXdsDZcmndxHXKNA
         YbuXFdOj2Yce9/YQ9BL9wG2xK3rLasQoHzjktIaeROvYibfR7g2+Ai1RRoLjuDd5QNhI
         FZHw==
X-Forwarded-Encrypted: i=1; AKwUvBwKGCh+ELvsA40RkWyNJ0scLH6Cxc8hfqrnf0F3sbej9mvwBYr1baFt4nJzo4H5bZmT4xE=@vger.kernel.org
X-Gm-Message-State: AFuF++mgdt44B7HTVC3OrXrk3De52aqai0HWtadWFj5amR2fe3rjZI+C
	upKhtPaoNIaGp6k5HcE1Pf98j+C+4sx72Uzlw5N34BeKtCwTSlv4/JvUbDyyVl37sHjsLFxn3uM
	kDRXGX1CG26boFsQY3pG4isaleEKWT6U=
X-Gm-Gg: AYBFou0QOctkrUinrPLi1MmnQYB36qVKymrrgJc9FrcsP33iWuUVWaqX2ilK0Paxfaj
	ffqRE0T3790ThYPomXMSWYu+rPMybx8h7CB8y2vjDjPxkBjROBp9WKYl1yp8z1cd7vEwHvSmcmU
	XPin7Jbd6Z+5MPAgrU8wUFvKBpV7+uWQBaM8O/9FmBsCuvSoV98NrhFMqDd/KTJPMAGJxpSemZc
	xKxnAqq6bAYZDKUMQJUk3MNc/uKWspenc6mOqcGCKDsZreD3IHh3rVBAPDMvEeD4qXNRXu8UIeO
	Wvy5DAsReg9/qu3Ql0j05Q8/lFAoIJqtanH4YB6FxjlPTV6ATsw4F0mqbjjxDNt0Js4=
X-Received: by 2002:a05:600c:3155:b0:4a1:7093:40c7 with SMTP id
 5b1f17b1804b1-4a18041b914mr58355095e9.8.1791423601861; Wed, 07 Oct 2026
 18:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f885062-4905-4d9c-9293-615c145d2d6b@paulmck-laptop>
 <5b5dbb90-69ad-4a8f-8583-f5ba162744d3@efficios.com> <631c13bc-671e-4cf3-b466-0408d7600ab2@paulmck-laptop>
In-Reply-To: <631c13bc-671e-4cf3-b466-0408d7600ab2@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 8 Oct 2026 09:39:50 +0800
X-Gm-Features: AclHuK9PnH-9rZa3AKa6_3ER7MkRB5AzhK4CnrD_48-c-nzwxYKb6uxjrsgCpw4
Message-ID: <CAN_Opa_a5MbG_50DTg=Eu_f5X_ZiYUdyzVGiAzHGhP__xDpxnw@mail.gmail.com>
Subject: Re: [BUG] Splat during modest hazptrtorture run
To: paulmck@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng <boqun@kernel.org>, 
	Wang Lian <lianux.mm@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Bradley Morgan <brads@mainlining.org>, rcu@vger.kernel.org, lkmm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 11:59=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Oct 07, 2026 at 03:09:27AM -0400, Mathieu Desnoyers wrote:
> > On 2026-10-06 19:40, Paul E. McKenney wrote:
> > > Hello!
> > >
> > > This is all new code, so the bug could be anywhere.  So you all need
> > > to know.  ;-)
> > >
> > > I got this from the NOPREEMPT variant of hazptr during a nominal
> > > "--duration 60" run of torture.sh on x86 with the guest OS split acro=
ss
> > > two NUMA nodes:
> > >
> > > [  137.765104] WARNING: kernel/rcu/hazptrtorture.c:658 at hazptr_tort=
ure_stats_print+0x25b/0x4f0, CPU#1: hazptr_torture_/136
> > > [  137.768647] Modules linked in:
> > > [  137.768891] CPU: 1 UID: 0 PID: 136 Comm: hazptr_torture_ Not taint=
ed 7.3.0-rc5-00661-ga1f1e4890d1d-dirty #193 PREEMPTLAZY
> > > [  137.769683] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS 1.16.3-6.el9 11/05/2023
> > > [  137.770319] RIP: 0010:hazptr_torture_stats_print+0x25b/0x4f0
> > > [  137.770735] Code: 48 83 c4 20 e8 86 44 fe ff 41 83 fd 01 7e 23 48 =
c7 c6 6e 85 17 b0 48 c7 c7 db 27 17 b0 e8 6d 44 fe ff f0 ff 05 76 6e 0a 02 =
90 <0f> 0b 90 4c 8b 64 24 70 48 c7 c7 73 85 17 b0 e8 51 44 fe ff 48 8b
> > > [  137.772061] RSP: 0018:ffffa738004ffdf0 EFLAGS: 00010202
> > > [  137.772435] RAX: 0000000000000004 RBX: ffffa738004ffe08 RCX: 00000=
00000000027
> > > [  137.772950] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000=
00000000001
> > > [  137.773455] RBP: ffffa738004ffe60 R08: 4000000000001236 R09: fffff=
fffb01727df
> > > [  137.773980] R10: 0000000020212121 R11: 0000000020212121 R12: 00000=
00000000000
> > > [  137.774479] R13: 0000000000000002 R14: 000000000002ffd6 R15: 00000=
00000034f03
> > > [  137.775000] FS:  0000000000000000(0000) GS:ffff999c2e502000(0000) =
knlGS:0000000000000000
> > > [  137.775578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  137.776001] CR2: 0000000000000000 CR3: 0000000008830000 CR4: 00000=
000000006f0
> > > [  137.776512] Call Trace:
> > > [  137.776700]  <TASK>
> > > [  137.776863]  ? __pfx_hazptr_torture_stats+0x10/0x10
> > > [  137.777207]  hazptr_torture_stats+0x25/0x70
> > > [  137.777508]  kthread+0xd9/0x110
> > > [  137.777751]  ? __pfx_kthread+0x10/0x10
> > > [  137.778017]  ret_from_fork+0x1bd/0x220
> > > [  137.778285]  ? __pfx_kthread+0x10/0x10
> > > [  137.778560]  ret_from_fork_asm+0x1a/0x30
> > > [  137.778849]  </TASK>
> > > [  137.779007] ---[ end trace 0000000000000000 ]---
> > >
> > > I have not yet seen this during a PREEMPT run.  Line 658 of
> > > hazptrtorture.c is the WARN_ON_ONCE() below:
> > >
> > >     if (i > 1) {
> > >             pr_cont("%s", "!!! ");
> > >             atomic_inc(&n_hazptr_torture_error);
> > >             WARN_ON_ONCE(i > 1); // Too-short grace period
> > >     }
> > >
> > > Any thoughts on what might be causing this?
> >
> > Hi Paul!
> >
> > Can you share which tree and branch (commit) this is running ?
> >
> > Does it include my fix from this series ? That would be patch 1 of:
> >
> > https://lore.kernel.org/lkml/20260927155134.4740-1-mathieu.desnoyers@ef=
ficios.com/
>
> Ah, no, I somehow got the impression that this series was going to be
> updated, so did not apply it.  Apologies!
>
> I will pull these in.
>
> > Does it run the additional series from Kunwu Chan found at
> > https://lore.kernel.org/lkml/20261002170847.3653663-1-kunwu.chan@gmail.=
com/ ?
>

Hi Paul,

I have posted v3 of the series since then. The link in Mathieu's
question points to v2.

Please use the latest v3 series here:
https://lore.kernel.org/all/20261005171529.1378809-1-kunwu.chan@gmail.com/

I wasn't able to reproduce the warning with my current setup(without
my series).
Could you share the .config and the exact command line you used to run the
test? That may help me reproduce it.

Thanks,
Kunwu

> No, but if you are good with it I will pull it in.
>
> May I add your Acked-by or Reviewed-by?
>
>                                                         Thanx, Paul
>
> > Thanks,
> >
> > Mathieu
> >
> > >
> > > For that matter, can anyone else reproduce this?
> > >
> > >                                                             Thanx, Pa=
ul
> >
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > https://www.efficios.com
