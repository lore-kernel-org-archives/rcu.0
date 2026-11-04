Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793774560;
	b=la2ZP8u0m7Xh2VjAedWAEpXRRvQDHiWH6KbX7wYT5OJWRyeBF/4ZrWMNFgkNPUqLdmvC
	 9otZAtAGSKFnjNzV0R+OzHsKwNlrDuViZ2fJNY7y2APS9av/RX/QIjM9pCIQFf6CvSn0U
	 6GvTUwd3/6A4lLSM4U96O02w5wqK+RlFNCN2vSUm03Nzs92lXwBgntasnPA3Gmv1emVLK
	 M9nTvJ7OhRIUecfBA4Zr+RLJvyxjl18V8lVxulm2pogj+FEc7VgN5fejlFbGnlRByHR68
	 J3IZtni7dxuRx2BMhD55i5eE4CNaNKJpf/C2uiWotfpxN0MfdR9PY+RCMnnIeQz0x0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5n+r4UyGB7Tdo+MNozKBddmm1+/g2UOW7XY9LCACxjk=;
	b=r1EVjBQL5M0NcOyTwFHifZJ77LjDaRpuc34DnKdScvSeutVprxbJnvJ/cSuT7Hlc/VVX
	 j0p6u+XBNIlK3aSBzHYXKxZfPCzYbe3wkEDX+accqkxdis8ZXzQ/Grje5D7+QMi3bCrsp
	 CJV+Ccs3EYW4IjtPftQ/bXgLxcvPkZgOcMhGpkBhExfVO2kEME2nICUOyLrE2n4qJStdv
	 D7IDuK3EXTZDncfWcS1yszg3zbX47p+ypwfIq4qDtQHZt2j0n9yWFClV+t5RjrMV9JUPR
	 osBLF5bGhqN4JEyDnd+mLwS+ZpfR/5Ne9uKj9TPGi8A9dFVQadI4zm7ydaoP8F1hJhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jkXFLKeO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A723606A326
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 06:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A723606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jkXFLKeO
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a208d93758so2743285e9.3
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 22:42:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793774558; cv=none;
        d=google.com; s=arc-20260327;
        b=ZrVpYJpt/X3Y4MYT2MqgJhVCEL0LErULRf+iOgXDqClSA+7h46g7ri34qI7DwZqxJl
         EyyqSmvroOJZSxNwX2feoiveI1V8HKtCbr9tUDLPIWA+ivJpPTdQH5LmmMb2y8Go2i7E
         n09H1ch1BBgBUc64swPc4harpILh+khK/y6CLrKPJGbqviJHkYx5RD2nQaMzivpcVQwu
         gKz1ckxkNQSVckKx6C2kVxfv2zDr8RL8JTAXiL6B1Smk4x/hqt9TwHXuOJISnyGbANCG
         7bRKoE41FmEbr+4oNWjOcQVAs9lh9Pi/0yHke/L5UkBVemsLFk18nXQlJSm8rQ98SG8l
         lPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5n+r4UyGB7Tdo+MNozKBddmm1+/g2UOW7XY9LCACxjk=;
        fh=u0PJ5yek+loOoQ/OPhmrsibE5FUaUW1U0W6Gu26Gf/I=;
        b=LJpsdGqd+JrDi9k8fEKcEifD8aA3qhS4oMPPv4zwWyX3MQsxqnEX9g8LTy2eNBz7cg
         mAguuHAd+8fU6PBG3cGMqLKWN4XD7bD52Dt9P+vrrl4IS8HiyUBPuxi30KuEcC5oSDlR
         3KsymfNoV2xDXOIEied81b/aBl73pFD/chs1XgyZgpeWSLr3o7S2tnSFU0sY4JnobA9O
         +9bEiuS0vo0phGbdpnQmIh5lgt1FskZrV2r3yYuXnNRt2iQfRRW5dheX+Qtl0bW/GKiM
         kHdZVIJbPqwSZ/rpZy946FcR5qQXapapgPaps6mf1Lat5QLlmIPYZjPqIaiFTUc69dMj
         U73Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793774558; x=1794379358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5n+r4UyGB7Tdo+MNozKBddmm1+/g2UOW7XY9LCACxjk=;
        b=jkXFLKeO77pdT/qIDmF5qrqpgic1gJvQhZyDAOggS5EQfHgcq5J+Q5wp55YAM5s0LK
         szRd1fTYtttwpxTO49OJA7RCugyJTkz0dcTBuqITu4P+k1yjECjT6B6bMM3R3BYNsP6n
         i3VciX3WO/J13wfistWWjEaU5LvDW4GxwlS7U+BFiL/mJ+KI4bkqu7xviq8yUehnL3Ap
         1gZFFhUVyncpJXFzR6GenXbVrQBEqOeklwF3nhxRKDgNio0v61c5OJH4fRQ3EUbdUrQ9
         HTvDYEbMX7ftTIJpZ5IDcGnJisUavB5Ek5IyNtIi+4ajDr/Jh71r95+MujeFKgPpyR08
         q3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793774558; x=1794379358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5n+r4UyGB7Tdo+MNozKBddmm1+/g2UOW7XY9LCACxjk=;
        b=2V5H69XF0ZEYAX2R0NBD1mZkfADuYLeD9GXQF3y0MbQATf8zeeTRg85AukpH9P/1Ca
         TVQmeP7JtBlWQOYpX8fm8RasBDXlJ0P7ohQoAkbEU0DTzIW1lXNrzmmG53tBCS8Y9T+c
         uTqLU/80nZVovN/xHSdbnmmUBzG7gsyLhyx352n503/9dOe5TWxOhoxNAPLpd0WVUDLJ
         zjN2DKeceZPAAwFmGOBaVOf06hMjOzfDz9RokgblAw6DXhFVacFijrdt7SmuL9odjEay
         swp3HwAYTf2N6wgylrh9Us0fxJnUXK8bODF5uk+IrS5tIkEl353rX1oSCSEJdg6fhgLE
         9luQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMROKO2MqrCP1fvybj28s6QH9xDOv+e315hF5HtUwro7eGpuGS/tNyg5CGPP4AGql+e8g=@vger.kernel.org
X-Gm-Message-State: APuU4Z82BbfwDHFNKp+1LQ4tekAi8VSPT5HxlT+SHImO1kEVIK/eyvWH
	0yqLhlQ6SX2q7TiIJ9Gu7KAOWKlwK1rZ6RpPgPesNoVZQblxN4rworj233fAnPDk7+2iW7jjqB2
	QKYye0J+wRKD3W73gwTtHynazq7GYfNU=
X-Gm-Gg: AYBFou1sUzt04gpX9+ZpIsMPw5GqA//krjV4PMsuVDzUHl6p9meC3yGJZq1zkLt11M6
	2LCa8/uNt3fPBStrDYhRhQ/nR1TIB6kocTZnX5UqoTX0m4k+/VSGZx/b1rE43NNUhTOvxxF+1l1
	RLrRKmfmMtU9nB4ijlLISk2/fbncEE1CMGFgBz+8/Qwi9LpmqYvh8AOn146ZwwRyPIlmU5awFWV
	vkV2mwfo51IPhQYIAGttzMWpkBNDg0wNvRUCj65Y5Fc5XJqIpWnyUyju4loiz4eto0Un6dRTRjH
	Im6TpNuubpuh2L+ujM0Zm+gjujJyIa/UVA4Yq4ghiG/02xP3oNJvVseuu/HuwVoiudNvpFuUXfQ
	w6Y9KNzl1YyRVFW39vFVXGDaNS6zt8g0epeA1OdEwXEfySTc1+MvJzBOI+Fw=
X-Received: by 2002:a05:600c:34d4:b0:4a2:d7e:5ccb with SMTP id
 5b1f17b1804b1-4ac182dca99mr384459045e9.15.1793774557911; Tue, 03 Nov 2026
 22:42:37 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027070923.3054462-1-kunwu.chan@gmail.com>
 <20261027231315.GA3580680@joelbox> <CAN_Opa9n-iqRgQczQ5_ZpTMHFbjmW-6+ZYsCgCYdNfuprXLyFw@mail.gmail.com>
 <20261103235643.GA4146834@joelbox>
In-Reply-To: <20261103235643.GA4146834@joelbox>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 4 Nov 2026 14:42:16 +0800
X-Gm-Features: AclHuK-H1NWCP-gLadIbH3Oi-1sHQtn9NQ7r1_MFVefSoDpVfPMBRLFZY4vEJG0
Message-ID: <CAN_Opa_5Q6R584rS6TWuvbmaVBodUteUG=iEMEOTjm-_AO57Pw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] rcu: Improve callback diagnostics and validation
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org, 
	work@onurozkan.dev, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	boqun@kernel.org, urezki@gmail.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang@linux.dev, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 7:56=E2=80=AFAM Joel Fernandes <joelagnelf@nvidia.co=
m> wrote:
>
> On Wed, Oct 28, 2026 at 10:17:25AM +0800, KunWu Chan wrote:
> > On Wed, Oct 28, 2026 at 7:13=E2=80=AFAM Joel Fernandes <joelagnelf@nvid=
ia.com> wrote:
> > >
> > > On Tue, Oct 27, 2026 at 03:09:13PM +0800, Kunwu Chan wrote:
> > > > Hi,
> > > >
> > > > This series improves callback diagnostics and validation across RCU=
,
> > > > SRCU, and RCU Tasks.
> > > >
> > > > Patches 1-3 record callback registration stacks for KASAN in Tree
> > > > SRCU, Tiny SRCU, and Tiny RCU.  KASAN prints the recorded auxiliary
> > > > stack when reporting a use-after-free.
> > > >
> > > > Patches 4-6 add rcu_head alignment and NULL callback-function check=
s.
> > > >
> > > > Patches 7-10 detect duplicate callback enqueue attempts before
> > > > queueing, using the RCU head debug-object mechanism.  A duplicate
> > > > registration is rejected at entry and __ratelimit() controls the
> > > > diagnostic output group (pr_err, mem_dump_obj, dump_stack).
> > > > Detection requires CONFIG_DEBUG_OBJECTS_RCU_HEAD.
> > > >
> > > > Changes since v1:
> > > > - Patches 7-9: __ratelimit() + dump_stack() instead of hard-coded l=
imit
> > > > - Patch 10 (new): same change for Tree RCU's rcu_do_enqueue()
> > > > - Patch 9: fixed log format to avoid pseudo-function names
> > > > - Tags: Reviewed-by (4-6), Suggested-by (7-10)
> > > > - v1: https://lore.kernel.org/all/20261023101841.2910719-1-kunwu.ch=
an@gmail.com/
> > > >
> > > >
> > > > Testing:
> > > >   rcutorture with KASAN (SRCU-N, SRCU-P, SRCU-T, SRCU-U, TINY01,
> > > >   TINY02, TREE03, 3min each): all exitcode 0.
> > > >
> > > >   KASAN aux stack (QEMU, CONFIG_KASAN_GENERIC=3Dy):
> > > >     Last potentially related work creation:
> > > >      kasan_save_stack+0x33/0x60
> > > >      kasan_record_aux_stack+0x8c/0xa0
> > > >      call_srcu+0xb2/0x390
> > > >
> > > >   Duplicate enqueue (QEMU, CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy):
> > > >     call_srcu(): Duplicate call_srcu() CB ... ->cb
> > > >     dump_stack_lvl+0x47/0x60
> > > >     call_rcu_tasks_generic(): Duplicate CB for RCU Tasks, ... ->cb
> > > >     dump_stack_lvl+0x47/0x60
> > > >     rcu_do_enqueue(): Double-freed CB ... ->cb  slab kmalloc-16 ...
> > > >
> > > >
> > > > Kunwu Chan (10):
> > > >   srcu: Record callback registration stack for KASAN
> > > >   srcutiny: Record callback registration stack for KASAN
> > > >   rcu: Record callback registration stack for Tiny RCU
> > > >   srcu: Validate callback arguments
> > > >   rcu: Validate callback arguments in Tiny RCU
> > > >   rcu-tasks: Validate callback arguments
> > > >   srcu: Detect duplicate callback enqueue at registration
> > > >   srcutiny: Detect duplicate callback enqueue
> > > >   rcu-tasks: Detect duplicate callback enqueue
> > > >   rcu: Improve duplicate callback diagnostics
> > >
> > >
> > > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> >
> > Thanks, Joel.
> >
> > >
> > > All look good to me, applying for further testing and review for 7.5.=
 Did you
> > > also test double-call-srcu and confirm intended behavior? Thanks!
> > >
> >
> > Yes, I tested double call_srcu() under QEMU with
> > CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy.
> > Both Tree SRCU (direct and deferred paths) and Tiny SRCU triggered the =
expected
> > duplicate-enqueue diagnostic with the callback symbol and dump_stack() =
output.
>
> Great!
>
> >
> > BTW, I'm working on follow-up rcutorture support for
> > duplicate-callback testing and
> > KASAN aux-stack verification.
>
> Nice! How is that coming along?
>

It's currently in testing. I expect to send it out later this week!

Thanks,
Kunwu

> thanks,
>
> Joel Fernandes
>
>
> >
> > Thanks for review.
> > Kunwu
> >
> > > thanks,
> > >
> > > Joel Fernandes
> > >
> > >
> > > >
> > > >  kernel/rcu/srcutiny.c | 34 ++++++++++++++++++++++++++++++++++
> > > >  kernel/rcu/srcutree.c | 36 ++++++++++++++++++++++++++++++------
> > > >  kernel/rcu/tasks.h    | 27 +++++++++++++++++++++++++++
> > > >  kernel/rcu/tiny.c     | 11 +++++++++++
> > > >  kernel/rcu/tree.c     |  9 +++++++--
> > > >  5 files changed, 109 insertions(+), 8 deletions(-)
> > > >
> > > >
> > > > base-commit: 940793b926aa94bf65ec404043050888e3053188
> > > > --
> > > > 2.43.0
> > > >
