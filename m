Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793153860;
	b=J6nkpFQ0fj2zqGoPoJrqgKNdkqinQaACtdb2q4+qaL4B5VpIKej+KFTOsWlM/AuhQZdo
	 XG+eUHUtebRAnmprqHhAO9Kpqo1cbQ3/esx09NqI7lJRTWCiu1+gxxTjSu4Kp07I/Z9SV
	 MgQ0gWXlChp6XEvX11iqWUD4gbuMJ+UsfwPHQ55eyxJN53kPFw4d8iogwcmricNlALWcR
	 LEZ+BK7M+Bcb8CwKMzQ0MYJ0mDg5UGckq3wRd/UYtMwT2SXGWXv68oIoHgUTzyHrTHlsI
	 Iq40bTzGUrSYUO8dzOTqQe09MuG81uFOsAq6eN5fbqEDXofQ88q5QyJV1p7BSCRZOZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=75/rV3MuGn+QlyFkS3b8E6MzH+wxlD9J56EXGGNEdag=;
	b=K9hnABHzSXGM9qir8npGPCMVaWan4iAsM+1WYG2TvpiPESjpqfBUCIggWoVlFbTaCXh0
	 0RW9wVxlaEv+ZyutEU4sSeqhLw4XEEnADVGAkRo9o0Hnx25X2t+X2qttaYIyFzZavYqWk
	 tJF9dIgumi7W8bxZj7e6o7ntxv7rL9vCF4MRZUuKBQX/AmyxHINzWYzX3p89wxED8w+gh
	 tB64nnEK++ZkFmF9v25prDu/dMXL21VUMWAjpJdVxHIj+i92kGdvaz4CM02PFhQNO/qFn
	 CSsRCAeUghp/AExLrB4r9Wrth3TJYjq88eyxdChpnQOsSWDjab4P+lTpHr4MmVl58rA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jehQ+UIv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0B606A325
	for <rcu@vger.kernel.org>; Wed, 28 Oct 2026 02:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF0B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jehQ+UIv
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso3048405e9.2
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 19:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793153858; cv=none;
        d=google.com; s=arc-20260327;
        b=lRuO/dlr/pjTWJ2cr3K1iN07qH0a4FqZ7/1U6+2BOd6NtulF4cjyRHxTngLCI+LJ5N
         0VwlSUVbC0SfPlnZNA/UeLdUdU4DED1gXUfiPW4NML3oh5b764lOladg3LKDhN6h98hE
         E4hmRznHiB8AaSJdWxBfHSNAdcockUE4PZiMeCZaynDICrs9sqREMMJCcDk6MDuf90PC
         8r5jJTykGBtzok3wnzrcxGvlJGKFP9elgFREqtumeTyQTm8JHxlzpRCuD4c1BrX2hVop
         cAWJLJZM94rxVUszblKIOkznuCCElagNp8ET9vxFnT7MGVnMBZzF8bZ2Rfqspcgv++pU
         Sr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=75/rV3MuGn+QlyFkS3b8E6MzH+wxlD9J56EXGGNEdag=;
        fh=NUIoA0PFPQq55pP6Hqkj3tKBerIsAVILserpE5PFbF4=;
        b=fy0K7JuGKmxF1peGkxWi4+Szd8ofx/JrxYYIuKjSz2RF86p2WDlmwWaGLEnuUvA+iO
         6rOsQHkPIHfzrgFL65GvRY7Nxz/d56lEfUz3P98uB7IzAl8LWVrtN6a4/eYQdC8exl/s
         R39Qu7whxatNxh/b3IMAh70Di4OU/65x/2+Ch5SiR5xK4246u6aakDfHTYOIvwc2VMSb
         PeiC5iCv3UyipALWiVqt62CZmG68ivMqkCnO0Uzu+6ZmrdZrwdPETy2bvl0GTOVA1Sxb
         tMRL9JqJkvl7Ifn53zwERd3alOEXaV6/TwpSI/C/V37ReA0OxOXMp/Bgj0aY+sKXg9L/
         dAEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153858; x=1793758658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=75/rV3MuGn+QlyFkS3b8E6MzH+wxlD9J56EXGGNEdag=;
        b=jehQ+UIvvhz/ikT+6UkrkYGYoAMsZppHqw6XC2bXKio8sXZYxwoz8WVrcr0BKFefM/
         Ra7nmTUNgvcAb/rwtBwg5MQz5tknhGe4tjCsUbMR9lgZFG/sSs02Waz9gtdQhJRG8wn/
         oGue+ho22hpsgYEUKnvNSIOgo/E61bNVcBG9eVqHkD966NL2dTPBey7QGAREzGBLucrf
         tKwNGF2e+ATBu4IhLuwrtGlry9tNlYHR8SNjsk169ZR3ePpFgqCWnFuBOWWwc2Qtgjw1
         ccznn/47kSSwuqe1NItoYPPX0Wq8EZAvjr86o1uZemjqMy5GUoUgWy5EmDCwQ5ico+4/
         0xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153858; x=1793758658;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75/rV3MuGn+QlyFkS3b8E6MzH+wxlD9J56EXGGNEdag=;
        b=0aqnwueW1Cocjpq5obo/kb2lWbJr7HNI/P+timuaVoTVs9MdVJtiSEEI/GN1PKFuqe
         w7uToKKlUUFljRJO95W1JCkXmfB9UUeILqkGJtZ7KJWR2dJfgSZJqLwS5GA5HsfdXxxB
         7aqAF1sJh50oQAc6WIz2xvXMrfkFLJcCOlpYas0/K9IO5CRgj9VeyO4CUmA8n3VboUTu
         VF4nfpd8RxQXPslNG8BDabqKHczbSm8xumzjyUohnE0V4TFkWqb2b6BMACpQ7jBWHxnR
         jl/HcQqXI5+EhRYTWSb3na6YOTLKQXQqDzYXLELmRfpYiHzCvP2QVDNwiF1DzXvge1Q5
         vdoA==
X-Forwarded-Encrypted: i=1; AKwUvBzOg3vmpMZYH02A99B/TX7JjZyfMIWP2RKz6uErzYR/K8cIqqIoEVpiR6b39wVQ+SzTnoo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1OYucOvYvBk300NxYwL9oiMPNfID6jfaXaBjJpvfuyuc6hKnk
	q1VN8wp9eagoKJ5nFqQh+V4PwSaVJDmQ9P6F82XKSX32DvlgK8JmSn6cMo9SqVpcdti+CzuXrps
	PhWzo8IP1DNh0u5DeNCLFAyPlZzcp1FE=
X-Gm-Gg: AYBFou00GxNa89/WdFsWVPkZmX02bu2YJaGfGBm/41TobcHyvmyrtxJTQ5I9+6+JLZX
	4VUqe5YzWLmmD/5wPvQ5Q3D9yp5ZJj9gNuBSftt+wOq5YtEeE3o03d5mWQBVdAmugYv7kuwhH9N
	Tse1voJmIpIGJWSATrzbZeQ0qDM3UotJhC5WzoZKHYyJS5eKMFMgpJI9vM1aCUGwMXBYuwJMa3Q
	O51fd/87Z+B1tFUU0CFR0MXPep3E8XsXj9MmNkk7eTGtXkLNfnrPkKZSvqkrSJ223JnTYw8FJT9
	+sHCRxuzr5/6FuzfQAlUVtGQVu3t1pYvxVkX6d7qFbQRSy06uUtdmgDRXCzsus74A58M1v9tFC4
	I3xWh1hBvN571GJQhBjT0UXyjABLNTt6NJtG1UIEKk1RJL3Ucda7npYXyVAtlPyqvM4Ht9A==
X-Received: by 2002:a05:600c:6989:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4a9640f38bcmr17926875e9.1.1793153857997; Tue, 27 Oct 2026
 19:17:37 -0700 (PDT)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027070923.3054462-1-kunwu.chan@gmail.com> <20261027231315.GA3580680@joelbox>
In-Reply-To: <20261027231315.GA3580680@joelbox>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 28 Oct 2026 10:17:25 +0800
X-Gm-Features: AclHuK89zdU2dhzaFrjvPFZJZcFsH9NI5CzwsDVal3jyUsdF9giWMS2YSMVjliQ
Message-ID: <CAN_Opa9n-iqRgQczQ5_ZpTMHFbjmW-6+ZYsCgCYdNfuprXLyFw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] rcu: Improve callback diagnostics and validation
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org, 
	work@onurozkan.dev, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	boqun@kernel.org, urezki@gmail.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang@linux.dev, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 7:13=E2=80=AFAM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> On Tue, Oct 27, 2026 at 03:09:13PM +0800, Kunwu Chan wrote:
> > Hi,
> >
> > This series improves callback diagnostics and validation across RCU,
> > SRCU, and RCU Tasks.
> >
> > Patches 1-3 record callback registration stacks for KASAN in Tree
> > SRCU, Tiny SRCU, and Tiny RCU.  KASAN prints the recorded auxiliary
> > stack when reporting a use-after-free.
> >
> > Patches 4-6 add rcu_head alignment and NULL callback-function checks.
> >
> > Patches 7-10 detect duplicate callback enqueue attempts before
> > queueing, using the RCU head debug-object mechanism.  A duplicate
> > registration is rejected at entry and __ratelimit() controls the
> > diagnostic output group (pr_err, mem_dump_obj, dump_stack).
> > Detection requires CONFIG_DEBUG_OBJECTS_RCU_HEAD.
> >
> > Changes since v1:
> > - Patches 7-9: __ratelimit() + dump_stack() instead of hard-coded limit
> > - Patch 10 (new): same change for Tree RCU's rcu_do_enqueue()
> > - Patch 9: fixed log format to avoid pseudo-function names
> > - Tags: Reviewed-by (4-6), Suggested-by (7-10)
> > - v1: https://lore.kernel.org/all/20261023101841.2910719-1-kunwu.chan@g=
mail.com/
> >
> >
> > Testing:
> >   rcutorture with KASAN (SRCU-N, SRCU-P, SRCU-T, SRCU-U, TINY01,
> >   TINY02, TREE03, 3min each): all exitcode 0.
> >
> >   KASAN aux stack (QEMU, CONFIG_KASAN_GENERIC=3Dy):
> >     Last potentially related work creation:
> >      kasan_save_stack+0x33/0x60
> >      kasan_record_aux_stack+0x8c/0xa0
> >      call_srcu+0xb2/0x390
> >
> >   Duplicate enqueue (QEMU, CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy):
> >     call_srcu(): Duplicate call_srcu() CB ... ->cb
> >     dump_stack_lvl+0x47/0x60
> >     call_rcu_tasks_generic(): Duplicate CB for RCU Tasks, ... ->cb
> >     dump_stack_lvl+0x47/0x60
> >     rcu_do_enqueue(): Double-freed CB ... ->cb  slab kmalloc-16 ...
> >
> >
> > Kunwu Chan (10):
> >   srcu: Record callback registration stack for KASAN
> >   srcutiny: Record callback registration stack for KASAN
> >   rcu: Record callback registration stack for Tiny RCU
> >   srcu: Validate callback arguments
> >   rcu: Validate callback arguments in Tiny RCU
> >   rcu-tasks: Validate callback arguments
> >   srcu: Detect duplicate callback enqueue at registration
> >   srcutiny: Detect duplicate callback enqueue
> >   rcu-tasks: Detect duplicate callback enqueue
> >   rcu: Improve duplicate callback diagnostics
>
>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks, Joel.

>
> All look good to me, applying for further testing and review for 7.5. Did=
 you
> also test double-call-srcu and confirm intended behavior? Thanks!
>

Yes, I tested double call_srcu() under QEMU with
CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy.
Both Tree SRCU (direct and deferred paths) and Tiny SRCU triggered the expe=
cted
duplicate-enqueue diagnostic with the callback symbol and dump_stack() outp=
ut.

BTW, I'm working on follow-up rcutorture support for
duplicate-callback testing and
KASAN aux-stack verification.

Thanks for review.
Kunwu

> thanks,
>
> Joel Fernandes
>
>
> >
> >  kernel/rcu/srcutiny.c | 34 ++++++++++++++++++++++++++++++++++
> >  kernel/rcu/srcutree.c | 36 ++++++++++++++++++++++++++++++------
> >  kernel/rcu/tasks.h    | 27 +++++++++++++++++++++++++++
> >  kernel/rcu/tiny.c     | 11 +++++++++++
> >  kernel/rcu/tree.c     |  9 +++++++--
> >  5 files changed, 109 insertions(+), 8 deletions(-)
> >
> >
> > base-commit: 940793b926aa94bf65ec404043050888e3053188
> > --
> > 2.43.0
> >
