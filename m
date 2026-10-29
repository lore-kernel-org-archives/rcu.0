Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793267922;
	b=4giY2JycKiDF1gsPC1ggGcc0PB9Y2bEFvw51h6xuQgVZ16GIXQbNDaFIsSk7OvnBsEvt
	 PygUDMJXNiv/okiYUTwqP29yn7Gfnr3eCTNNI+IyhS6Hp9wvc54ClU7gaF/0uDdTIFLL8
	 gKXn7pK7fQc2s3CKy7RynKFpYsR6CQVnau4QGOFBPImTV9EN+dehnckDmR/A25PsQURvz
	 SbpgbWiffB0iWMt9UnADyxv3qrafDG6K9PFyYUqsERrtUnO+/wZiOIbmdxGCni58xyZil
	 kzhTpQqBYAT4eyls2l2ZD0fqvb9miGYHH3CLGruZ+MNzlCrXUuV8pzG6z3PhoAgTnwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Yc7WBDeLmx1ji0neslzEETIhjNOOqtjOzqoUjWpHAsA=;
	b=dL3KHoKAtqs/J9WfYt88ommCAK/JynOEWyhS9bp6U42anfElGEq0aflSVzKG/+4NMN5e
	 OBQjbx0LuNP7jVSGYLD6dhhREwGOeRoz+KPEOKw061zHET7QKHe6Kezw0c4aFtoM0XtIt
	 B1Hpn8OYcgsARWgImKtnZAwXys1sKJbkx7n+EhlNk3Y0GiSeotlw2GQWffs6ks8FDea/5
	 fRi7TM+Fs6NPqegFNt2JDF67r5eFANvLG9CjwIWZWYasgldKsUKB/SIC8pBxMRtvr5BNR
	 Hn1LC5bC+HCGYstmaRONWv7qLU9zn7iTBnsVfVuaodW8E9ZnolAZBN3jy1Ru2b6IYuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KmLH3ecd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA31606A326
	for <rcu@vger.kernel.org>; Thu, 29 Oct 2026 09:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BA31606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KmLH3ecd
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso14430485e9.2
        for <rcu@vger.kernel.org>; Thu, 29 Oct 2026 02:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793267919; cv=none;
        d=google.com; s=arc-20260327;
        b=CEHUKjEubgMtsyiptCXzxTC3GlG+AsN2w0WfUsbDmck6Zk6nYCf6SiMoy2FxAC8d/O
         RoKdIqv0Fqd/Bj+OWrX/cI1ez6LGWJnCPZZ7TAUHmLvihb19UVG7Xr+u7VbW9v7N1C+J
         6/Ycbw4yQjCiuULh3Hx/ulb5sQSctLKP4jImfCtyyoJCXC1cYQU5W4lOmaAE0bmHEDjN
         ukE1mtWUFqwwddI5iQhOnc8HHAcCbLIMw6CvQenNAj9DpSe0B+X7/5ra41b5rqIn6/np
         /DkQZErj3xfbp39Bb73++Orcp96ii9DiZIvYrMR4LdUmxC+K4EQUbopWQNBH/w2XTKhl
         zWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yc7WBDeLmx1ji0neslzEETIhjNOOqtjOzqoUjWpHAsA=;
        fh=QK9au5WxxIZ0v8dyBM4h13+t1RvQrTUab01+o2/httg=;
        b=jAo54hy2pnN+YFK2GK/x7MQ+qRDmXg7fzWAvb03E5cw2uuB7FHsjjczBWo/ehbb2uu
         vWL5JFZkmNO5MHZIY440av+9vWgJQPuf7ApeYr8kHVtek8NB6BJEZ4vN8sWZpLYRkt+l
         lqEAqzydTMPO5UX+jOozLvhvh43rZ5Rui2S6volAj+hjwrJuzHsQh7RpN8BirauEFXMI
         RKJSMnroN1DgaznEUK3PnXi0DY1QIoi9PmhBjcJpsOyPhaFC7Szg5cyR78CbrQnPhbUR
         PG+THMUYDd3l56FKvIHHX5GndOqmpF8mzpLDC5hRZ/MP6nLNp/pT5UX45gKnp6trZojO
         3Aow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793267919; x=1793872719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yc7WBDeLmx1ji0neslzEETIhjNOOqtjOzqoUjWpHAsA=;
        b=KmLH3ecdsMA0FV9WSna7IrJggs/oMBbI0RXE7j/puUJUTtpgiG5IDBjca+s4vOHPnr
         kvx869iJiE2LVmA6UYSGhuGvnRfOQQnfg/sq9B/RtW7ccLaZboZM4cAaVLTzhaHt60Dj
         IE8lVgypJmRoDx2dCQI04ERcHnieV4aC83BsTOm3FIULqhHt0VmaSHd0e97SRf3ObA/D
         zik5mqCmO6uRmlsC0/R5taodK8l4x0+dJBPJM5JRDFjh2s9ZqD1d0gNe+dgddpyFhvRH
         s5VOQSAaCN81fctaLNX3sRG6DGOJcsaEGxQM06ZYmO/IlIUXws4BDBf/Dj93AYo90HQK
         cMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793267919; x=1793872719;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yc7WBDeLmx1ji0neslzEETIhjNOOqtjOzqoUjWpHAsA=;
        b=HRhP9EyYmLOWRWlgfBhRlJfNlr6q58fKJeVafE+jN+b/8lTdmo7sKcru5GCPyWmgpI
         d+0NyhO8mqjkhgNGUZCEVdyCDG5SH7nD8tcRsOLiuHI5hIejee2VvDpFShMe3JrJ0VKm
         M/lQ3SvfTcs5wnKDNRzBDitcOPRZUSdbHj/5nLKqRf8xfII5uLvuPlr9EROgXrH4V4cX
         EEYkHyJKDRCWearS2agoYaoLhoujRqqArwMWKkbbLL/07VnHGJ2+hdCsCCwsqa/MbLmi
         659EW3kmd78SR9vQ5A4ghpN1AKIdTEHuxJ4BZ8LDVODhB67HUxA2vXTQvh4YzbEbW7Dv
         OasQ==
X-Forwarded-Encrypted: i=1; AKwUvBwO0hwfl/poofoNDMgJFVzrkfg/THBYiRCG0Lq2PWvb/W9BXTUpDnJOwzCklaMOHymLghs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKS4bG2VYvKUxOKm3HwjWQutDeM8frYMoee/4R8lRRPpiwOXV+
	4Kloob9Sp0ymAIERCGVSp1wuuEOvrRr94BVwQ6ORYam51m+Ns92DCnwEYdEMgMTT0XxFlUo2MRC
	Xoo+lymELDeSAptY5jWNWTaN7XbKt5TUO8NjeGxu1pQ==
X-Gm-Gg: AYBFou3xHxUJhcX512SehY0QGOMCLu+TlVAYr6yiChrdmU5xN+1GXBWAuNd+ZKRjM6/
	GL+JqnXXx2vWZsfjTL4pxmbIIz/moP31CZ9mHJcKJMomE+Yc2G3EmHarOFDwwErJcdXlgEtzHmq
	RCVLH7BARZdp+/rbQ33YpSRywqJTb9C2TYRy+lreD3RP3hP/4CU8tlYmqiQrrZKUme05clrzAWP
	dZtHV13EOWp2Fxw77cOVwcmV6myNEOcyWOuqVknllpHAxy8NgoWQJO98MEMiJiDMih6aWGNkpvg
	d2bIyxRpgxK1AK1b5UgCvCAktcOTSMKzefyY7w2AkQnWWQj1/9MfVswPu7+Lc96jI1rfHGZ+8P1
	jcfkdNxI7t+dAsKsDMwMmALdkx0UF7CaKf4XmOcoGK4jFAKBqASjXbvhK/ZlUomWvifyHBRI=
X-Received: by 2002:a05:600c:a103:b0:4a3:5d5d:48d9 with SMTP id
 5b1f17b1804b1-4a967ab127emr88000115e9.35.1793267918857; Thu, 29 Oct 2026
 02:58:38 -0700 (PDT)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027163811.2470569-1-parri.andrea@gmail.com>
In-Reply-To: <20261027163811.2470569-1-parri.andrea@gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 29 Oct 2026 17:58:27 +0800
X-Gm-Features: AclHuK-PyU47NuYgIA0zE-mZxiBBfVoQmUb043GP6GTroV1D35cedFeNfUB49NM
Message-ID: <CAN_Opa8OyyuveYo7VyfQb4rDtUmw_m-25OSXSqwpzfOnGqwEpQ@mail.gmail.com>
Subject: Re: [PATCH -rcu/dev 0/4] hazptrtorture: Fix shutdown hang and catch
 slot owner race
To: Andrea Parri <parri.andrea@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Gary Guo <gary@garyguo.net>, 
	Bradley Morgan <brads@mainlining.org>, rcu@vger.kernel.org, lkmm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I ran into both issues independently while developing new shared-scan
hazptr series and its torture-test scenarios.

For patch 1, I reproduced a shutdown hang on 16-CPU ARM64 KVM with
`CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH=3Dy`, `nreaders=3D16`,
and `defer_modulus=3D4000`. The readers remained in D state, with
deferred-context stall reports reaching 147 seconds.

My prototype uses the same all-CPU drain operation, but keeps the writer
ahead of the readers in the cleanup order. With that change, the same test
unloaded in seconds. The upstream configuration was harder to trigger; I di=
d
not reproduce the hang in a 3-minute run on the unmodified `origin/dev`
baseline with `defer_modulus=3D100`.

Paul's concern about `torture_must_stop()` is valid: `fullstop` can make th=
e
drainer exit before the readers have stopped, so its exit-time flush is not
necessarily final. The reader-exit approach looks worth testing against bot=
h
the forced-slowpath case and the PREEMPT scenario Andrea reported.

I also saw the patch-3 warning during ARM64 `PROVE_LOCKING` testing,
although I have not reproduced it consistently. The warning count dropped
from 3 to 0 when the relevant fixes were applied together, so I cannot attr=
ibute
 that change to patch 3 alone.

These tests independently reproduced both issues in my setup. I'll check th=
e
final cleanup approach against the forced-slowpath scenario as the
series settles.

Thanks,
Kunwu

On Wed, Oct 28, 2026 at 12:38=E2=80=AFAM Andrea Parri <parri.andrea@gmail.c=
om> wrote:
>
> Patch 1 fixes a shutdown hang in hazptrtorture with deferral enabled, as
> in the PREEMPT scenario: hazptr_torture_cleanup() stops the kthread that
> releases deferred hazard pointers before the writer, which can then
> wait in ->sync() forever.  It now stops the readers before that
> kthread, which releases what is left once the readers have stopped, and
> that kthread before the writer.
>
> Patches 2 and 4 make hazptrtorture catch the race fixed by "hazptr:
> Record per-CPU slot owner after claiming the slot" (now on -rcu/dev)
> should it come back, as Paul asked [1] and agreed to [2].  Patch 2
> adds two CONFIG_HAZPTR_DEBUG checks of the recorded slot owner, in
> hazptr_release_debug() and hazptr_note_context_switch().  Patch 4 adds
> the nest_acquire module parameter, which makes readers take a second,
> nested hazard pointer that goes through __hazptr_acquire() while the
> first is in slot 0.
>
> Patch 3 fixes a false positive of an existing CONFIG_HAZPTR_DEBUG
> check, which the nesting of patch 4 exposes with CPU hotplug: a hazard
> pointer that __hazptr_acquire() puts directly in the backup slot warns
> if the task migrates before releasing it.  It comes before patch 4,
> which would otherwise make runs with CPU hotplug warn.
>
> The series applies on -rcu/dev.  30-minute hazptrtorture runs of the
> PREEMPT and NOPREEMPT scenarios pass on x86_64 with 8 CPUs, as do a
> 30-minute NOPREEMPT run with torture_type=3Dhazptr and three 10-minute
> PREEMPT runs: one with irq_acquire=3D100 and nest_acquire=3D1, one with
> CONFIG_HAZPTR_DEBUG=3Dn, and one with torture_type=3Dhazptr-stack.  The
> 30-minute PREEMPT run ends with as many hazard pointers released from
> the pending lists as were deferred (reldefer: 650385 relundefer
> 650385).  With kthread_do_pending_ms=3D10000, two 3-minute PREEMPT runs
> shut down in 100 and 130ms, well within one period.
>
> Without patch 4, hazptrtorture passes even without the slot-owner fix:
> its readers hold one hazard pointer each, so they reach the slow path
> only when the ptr_eq() check fails or the pointer is NULL.  With
> patches 2 and 4 but without the fix, PREEMPT and NOPREEMPT report the
> race 6.3 and 6.0 seconds after boot, and with nest_acquire=3D0 both run
> 10 minutes without a report.
>
> The nesting costs about a third of the outer reader iterations at the
> default nest_acquire=3D2.  If that is too much for every run, it could
> default to zero and be enabled from the scenario files instead.
>
> Patches 2 and 4 stand in for the KUnit reproducer mentioned in the RFC
> notes of the fix, which needs a test-only hook in
> __hazptr_try_acquire().  The checks can miss one case that the KUnit
> test covers: an interrupt handler that acquires and releases the slot
> instead of detaching it, then a context switch before the task's
> release, when no other hazard pointer claims the slot in between.
> hazptrtorture does not produce that case either, as
> hazptr_torture_acquire() always detaches.
>
> Patch 2's release check also warns about a second hazptr_release() of
> a ctx whose per-CPU slot another hazard pointer has claimed since.  The
> hazptr_release() kernel-doc permits that second release, but it clears
> the other hazard pointer, and a second release of a backup slot oopses
> even without this series.  Nothing in-tree releases a hazard pointer
> twice.  I will follow up separately on the kernel-doc.
>
> An LLM found the hang fixed by patch 1, the crash shown in patch 2 and
> the false positive fixed by patch 3.  It also helped write all four
> patches and their changelogs, and ran the tests above.
>
> ---
> Changes since RFC:
> - Patch 1: stop the readers, then do_pending, then the writer, and
>   release all deferred hazard pointers after torture_kthread_stopping(),
>   instead of keeping do_pending in its loop until it is stopped (Paul).
>   Paul suggested changing the "while (!torture_must_stop())" condition
>   to "while (!kthread_should_stop())"; this keeps it, for the reason in
>   [3].  The changelog also says when kthread_stop() can still delay the
>   exit of do_pending by a full kthread_do_pending_ms sleep (Paul).
>   Bradley's Acked-by is not carried over, as the patch changed.
> - Post patch 1 in a series (Bradley), now with patches 2 and 4, so
>   that hazptrtorture catches the race fixed by the slot-owner RFC patch
>   (Paul).
> - Patch 3: new, for the false positive that patch 4 exposes.
> - Do not repost the slot-owner RFC patch, which Paul has queued.
> - Drop the Assisted-by tags, following mainline commit 1e035297ffda
>   ("docs: remove Assisted-by references"), and describe the LLM use
>   in the changelogs and above instead.
>
> [1] https://lore.kernel.org/r/fa16d2b1-594e-494b-8cfc-9b8c13f2c223@paulmc=
k-laptop/
> [2] https://lore.kernel.org/r/e0145c14-9d6a-4c91-816c-57dabd98879b@paulmc=
k-laptop/
> [3] https://lore.kernel.org/r/20261023120755.2463384-1-parri.andrea@gmail=
.com/
>
> RFC patch 1: https://lore.kernel.org/r/20261019162005.12888-1-parri.andre=
a@gmail.com/
> RFC slot-owner fix: https://lore.kernel.org/r/20261019161852.12783-1-parr=
i.andrea@gmail.com/
>
> Andrea Parri (4):
>   hazptrtorture: Release all deferred hazard pointers before stopping
>   hazptr: Check per-CPU slot owner with CONFIG_HAZPTR_DEBUG
>   hazptr: Do not warn when a backup slot is released on another CPU
>   hazptrtorture: Nest a second hazard pointer in readers
>
>  .../admin-guide/kernel-parameters.txt         |  6 +++
>  include/linux/hazptr.h                        | 13 ++++++
>  kernel/hazptr.c                               |  4 ++
>  kernel/rcu/hazptrtorture.c                    | 40 ++++++++++++++++++-
>  4 files changed, 61 insertions(+), 2 deletions(-)
>
>
> base-commit: 633f91e3408cc65a5237752a3265b031c389e43e
> --
> 2.53.0
>
