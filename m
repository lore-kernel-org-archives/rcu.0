Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794192024;
	b=xbus/arC4+6LUZ8hejlGzG2ev5UWCY8Y+sCrKjnUX/1fwal010bIPes9H4sk8YSOC9pd
	 PMvPp+kApi1aM5kUoTt50CXJcBAmQ8Y4fFdnnfG70aX0DCNDVD0s49LoY24GnasfkP10O
	 B/XZSNQHrQMBLXSg03WHF+bDcvD/mvHLGy5ovOOFdbVxNEwNpmbl/wZSh/KpbZAcPVyG9
	 Xj/+SV8tCNwaGG1xuIiVI2eFWvStiKr7+Zb4ZpHLXdNL1SZdZsRsEhBTP6YceNM4vRe9V
	 t/pCdPkzM6xlF1UQRWXwsOtt9E/UEUAmUNaO0sLq1M+fz6Ve5YB4GZA6JQW76YybScw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2F7vwQ+fIrmysPu/pD/++M3RDrBlwD6YHjhjHV8qY/c=;
	b=If1wnU4c6rds4faeF2OPrn+16WTWaRxkqm1vakk7zFJeH3d2qH5aYuVJpPlN0CLhGEdZ
	 1CsfHveSgst01eV8+xzTMpb7Z2dHV7vnUR5FGJNPHV/GWECqdIsLvs67KcN1Cgr2xKTMD
	 pvsO45SEDYBvYbrYl0YhPXNPmq8jr1tgg6VylS5HoAWkQAfR25+T+MWjrbjFq9sR5jCd5
	 Ks/hIitxMDqp9SJu+ZRl5t76dyecVSTNtezxoWRZXOWohzOoqHk9ur8tPPaER8fLDUlIG
	 239MKJn2biBib05wRpF9dgc6WIJaqWFhe4dnME4/KDXGY52QnCs8wk5UfDHv18tle4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jpggHbfK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C535606A321
	for <rcu@vger.kernel.org>; Mon,  9 Nov 2026 02:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C535606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jpggHbfK
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so2144035e9.1
        for <rcu@vger.kernel.org>; Sun, 08 Nov 2026 18:40:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794192023; cv=none;
        d=google.com; s=arc-20260327;
        b=pKwYT9O/eVPMj+Rmp9gXEXpNE69iMKedeoExwOLceb+ehbLny2X6259M1/b4OreH9/
         0pXK65ZgYF7xS1nqHsJOG8wGfko9iL7fDUT/8Py6UrovaH8pUg3IvoKnwizcDbchPf4p
         FOQeiqg8c4KZcnelNZnlmdyTcBGWUMpoYNQas9X112MLF7hEJvLp5TVgqQxODpTqVPdc
         Xdckxm73xfRUA5wfQoTGLDpfV+4VTS+pNqNexM4Z6qMiE0z1VYbPqKzYxv6utKEClavJ
         C7LDkmqtumIxUjivjumfuziMIs43VLdL9EPw5ppswPub3+LB1vsbfrsxLgVxzMvk9moU
         Rvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2F7vwQ+fIrmysPu/pD/++M3RDrBlwD6YHjhjHV8qY/c=;
        fh=mcR+VMpIU7EYy0ZHhORGaoI/PZ2/3wVVsDKx6+CDa68=;
        b=kMzA17A8B+sjMcB4CBct2tR8kOgsxBP+BgDzF1XlB4xUtQy6d+hOoxLIjNQLlir9gu
         VWwXY42addFSaQy2oK9316Ry987l+V1kpt8z5HKJvcNW6DbT4F97zs52G/yzltkPpi4i
         h61R1mNphWDMLYol9dGzQlBNdBu8nfg3kVCH0Zm7Fnf9T4tY1l56IqEfaNmfYN1dBNPg
         UMbILpOtC+VidDIiYX941T4DStYe+sA0tdGujUnwwN6RVqbiGMmpU8rEytkHAFLZN/CN
         bv/5VolaPpK8jrXXwwdeDscjf8zYCGpwsBQCsfOnzVnCEce+fX/wx4SspuhZVMkBT4cs
         ep1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794192023; x=1794796823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2F7vwQ+fIrmysPu/pD/++M3RDrBlwD6YHjhjHV8qY/c=;
        b=jpggHbfKJSpOUOT63/kzNkMVwRYziIugwQ7krP46th9WgszItKOeeGbOU5DrSpckd/
         IdVVP0EqUrh+TWakzBhTxigHGptKoBPGKzCab7hekJZ6swooSZk3v4drVaPYHispZPhx
         PzKsjWhfX8YJIh6Dc0jbsoPZwZ58KPfjKdUKHbvirypcUK4Tj+mFkuUJpiRtOR1pbY8r
         G1kYMcSL7YwvnbAy9+yX42wpKIxm5EI2FXuFGO9+efRXgLulnUaXR4ql0eTs8iIDxjGv
         S5oNzQe+TujYGTevvDCRKHp3IRjzh+T8etRmui/oZVz5mKf/CoBuPSoF3wEDr8TYTH48
         p2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794192023; x=1794796823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2F7vwQ+fIrmysPu/pD/++M3RDrBlwD6YHjhjHV8qY/c=;
        b=dEZB5Z1nKc/hbmLRfuIVn2qobwvgN/6x8pVgns4wX3CsfHEDb48Q5aZQaKTdO5MNJn
         QlaW3e1t9gOdl423p/GoYPNlRJnOXHMM/QRo/4kH51RT3wNao3fN4h3J/B+UmrDZXq32
         3NXxvEuMmDm0OhySRDtO2/uQEH6PrGZgMptRe3mlhd+NDZNzLyC74+Z2hAvJdFDdls6I
         RGQQuA9hUnxeMD15jRQtLTa6x3G85FVBHO3T853oWBoOxrdOVyTdiTICONO0omWFt8d1
         7oo1rUYkktwHZ/sMGu3Mx6ThR3sZ1F66Ggg5eKF0m4RPBkHp0JO+3Q4rQFaz1ZHTGHuU
         RX6w==
X-Forwarded-Encrypted: i=1; AL+hErEZcpOWhmiUaBR8y+D/WLrStIsTNzVdYfH7dYKi+gip7EcUxBN+XNsh74+QHXV1jvjJQhA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3IvFIQRPOXTCNEJfGOiK99QMY1FnMwT44bwu/nD0JF433o3HB
	O2m+MxQSPpFSpvZGTIHyUqwwbLGz3SdVzCn/jHMtOUrnohmmuh7vYsjqFnPATKSjaYG1QtQ4VdD
	HQmh9VKD/NHsQCuJHDIyF9IKOwCz+9Kk=
X-Gm-Gg: AYBFou08+oacelJ+y8g8g9ytITm054HSH+5YMhKCQmB9tTCBpTj/cCwsyyo099p0+U4
	+GChBWF0tg/4j6iwh9Syonc8oQUvxxS7Wj5cbYEX9AvwPqZD1amPxqsYZ2lWybycSnC+Uw9yB93
	AN+2V5/gEod8I0AuKfSgY+1q9ECvcKluV0oreOtXR7q+f5VqkBxj1tmH02glReuiMguOfcQGhX8
	TdPTjwtrbGyNcaCaC0Dn4sHhZYpO0pOa6/Zh0f/uXJ+2k/5XgE37rJRbgLGNQXTt+n4BSetAkKX
	03whayrYejzZoacZ/3NMv6eDhNTIn/Akz8yjtc3zbJLpKyF8bLpK7Z6gKEGGrDVuWpSq/1Pk2Cw
	0l4pRl9bvx1yqaxKfyGNT2WIfGzlBfQSiz4qTow==
X-Received: by 2002:a05:600c:1392:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4b963c72e9amr52747045e9.13.1794192021945; Sun, 08 Nov 2026
 18:40:21 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106143913.3627722-1-kunwu.chan@gmail.com>
 <7883f32c-80b8-4bfa-a4e4-f1e04da647f3@nvidia.com> <dda59546-c03a-4c4c-9df3-a107bc629e2c@paulmck-laptop>
 <2b4b213b4e9b27016982dfc517a5629f2ff5f3b8@linux.dev>
In-Reply-To: <2b4b213b4e9b27016982dfc517a5629f2ff5f3b8@linux.dev>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 9 Nov 2026 10:40:10 +0800
X-Gm-Features: AclHuK8pb_L_UpC3BJZ1KZ32a43XhwjPc70Vuz4br2IW6J-bKH9QE2SObC-xuRc
Message-ID: <CAN_Opa8+dGZtZGO934R2CQjdrTwuFyMj9=KtjcOaSpm70t_-nw@mail.gmail.com>
Subject: Re: [PATCH 0/5] rcu: Record callback enqueue stacks and add torture tests
To: Zqiang <qiang.zhang@linux.dev>, paulmck@kernel.org, 
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, boqun@kernel.org, urezki@gmail.com, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 12:20=E2=80=AFPM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> >
> > On Fri, Nov 06, 2026 at 01:49:04PM -0500, Joel Fernandes wrote:
> >
> > >
> > > On 11/6/2026 9:39 AM, Kunwu Chan wrote:
> > >  This series adds KASAN auxiliary stack recording for RCU Tasks
> > >  callbacks, rcutorture coverage for duplicate-callback detection,
> > >  and KASAN aux-stack verification tests across RCU and SRCU flavors.
> > >
> > >  This series is based on [1]. For testing, I also applied Joel
> > >  Fernandes' fix for debugobjects tracking of barrier callbacks
> > >  [2], which is needed for the barrier tests.
> > >
> > >  The changes:
> > >  - Record the enqueueing stack in call_rcu_tasks_generic().
> > >  - Enable duplicate-callback testing for the "tasks" and
> > >  "tasks-tracing" torture types.
> > >  - Add a KASAN aux-stack verification test module with a Kconfig
> > >  choice for each supported flavor.
> > >  - Add one rcutorture scenario per flavor for the verification
> > >  test.
> > >
> > >  Tested on x86_64:
> > >
> > >  - TASKS01, TASKS02, TASKS03, TRACE01, and TRACE02 completed
> > >  3-minute runs successfully.
> > >
> > >  - With CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy and
> > >  rcutorture.object_debug=3D1, duplicate-callback detection was
> > >  triggered as expected for both torture types.
> > >
> > >  - TRACE01 was run for 1 minute with
> > >  CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy and
> > >  rcutorture.object_debug=3D1. The test detected both duplicate
> > >  callback heads through the SRCU enqueue path:
> > >  [ 0.405836] rcutorture: WARN: Duplicate call_tasks-tracing() test st=
arting.
> > >  [ 0.405852] ODEBUG: activate active (active state 1) object: 0000000=
020df980d object type: rcu_head hint: 0x0
> > >  [ 0.734724] rcu: __call_srcu(): Duplicate call_srcu() CB 0000000020d=
f980d->rcu_torture_leak_cb+0x0/0x10()
> > >  [ 0.734780] ODEBUG: activate active (active state 1) object: 0000000=
06634e8c9 object type: rcu_head hint: 0x0
> > >  [ 0.776688] rcu: __call_srcu(): Duplicate call_srcu() CB 00000000663=
4e8c9->rcu_torture_leak_cb+0x0/0x10()
> > >  [ 0.779126] rcutorture: WARN: Duplicate call_tasks-tracing() test co=
mplete.
> > >  [ 65.411342] tasks-tracing-torture:--- End of test: SUCCESS: ...
> > >
> > >  Both duplicate callback heads (the stack-allocated rh2 and
> > >  the kmalloc-allocated rhp) were rejected and neither was invoked.
> > >
> > >  - With CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy,
> > >  object_debug=3D1, and n_barrier_cbs=3D4, the TASKS01 barrier
> > >  test completed 630/630 rounds without barrier errors.
> > >  The only debugobjects warnings were the four intentional
> > >  warnings from the duplicate-callback test at startup.
> > >
> > >  - All five aux-stack scenarios (TASKSKASAN01, TREEKASAN01,
> > >  SRCUKASAN01, TINYKASAN01, and SRCUTINYKASAN01) produced the
> > >  expected KASAN use-after-free reports. Each report's
> > >  "Last potentially related work creation" entry showed the
> > >  expected enqueue helper:
> > >
> > >  =3D=3D=3D=3D=3D TASKSKASAN01 =3D=3D=3D=3D=3D
> > >  [ 1.244567] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0x=
b0
> > >  [ 1.244707] Last potentially related work creation:
> > >  [ 1.244716] aux_test_call_rcu_tasks.constprop.0+0xc/0x20
> > >
> > >  =3D=3D=3D=3D=3D TREEKASAN01 =3D=3D=3D=3D=3D
> > >  [ 0.670399] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0x=
b0
> > >  [ 0.670561] Last potentially related work creation:
> > >  [ 0.670571] aux_test_call_rcu_tree.constprop.0+0xc/0x20
> > >
> > >  =3D=3D=3D=3D=3D SRCUKASAN01 =3D=3D=3D=3D=3D
> > >  [ 0.658679] BUG: KASAN: slab-use-after-free in aux_test_init+0x94/0x=
c0
> > >  [ 0.658919] Last potentially related work creation:
> > >  [ 0.658932] aux_test_call_srcu.constprop.0+0x16/0x30
> > >
> > >  =3D=3D=3D=3D=3D TINYKASAN01 =3D=3D=3D=3D=3D
> > >  [ 0.951503] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0x=
b0
> > >  [ 0.951641] Last potentially related work creation:
> > >  [ 0.951650] aux_test_call_rcu_tiny.constprop.0+0xc/0x20
> > >
> > >  =3D=3D=3D=3D=3D SRCUTINYKASAN01 =3D=3D=3D=3D=3D
> > >  [ 1.009005] BUG: KASAN: slab-use-after-free in aux_test_init+0x94/0x=
c0
> > >  [ 1.009141] Last potentially related work creation:
> > >  [ 1.009150] aux_test_call_srcu.constprop.0+0x16/0x30
> > >
> > >  I'm not feeling very excited about adding more configs just for KASA=
N. That
> > >  sounds like a maintenance burden. I believe Paul already has KASAN t=
esting in
> > >  his scripts. Is it possible to activate this testing only when those=
 are enabled?
> > >
> > The usual way that I do KASAN testing is with the --kasan argument
> > to kvm.sh. I use --kconfig and --bootargs to specify further testing,
> > usually as another option in torture.sh. This causes the testing to
> > be carried out as a matter of course.
> >
> > One good thing is that the Kconfig choice in patch 4/5 is automated so
> > that RCU_KASAN_AUX_TEST causes the right testing to happen depending on
> > what is configured.
> >
> > Is it possible to drive this from --kasan and the rcutorture.object_deb=
ug
> > kernel boot parameter or something similar? Or is there a better way
> > to make the overall testing happen?
>
> Hello, Kunwu
>
> Perhaps we can simplify this testing, similar to object_debug testing.
> double-free also should output stack (I did not actually test the
> modifications below) which record by kasan_record_aux_stack():
>
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 968343be4e0d..93b30bf90cc9 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -120,6 +120,7 @@ torture_param(bool, nmi_calls, true, "Exercise ->call=
() from NMI on nmi_capable
>  torture_param(int, nreaders, -1, "Number of RCU reader threads");
>  torture_param(bool, nwriters, 1, "Number of RCU writer threads (0 or 1)"=
);
>  torture_param(int, object_debug, 0, "Enable debug-object double call_rcu=
() testing");
> +torture_param(int, kasan_debug, 0, "Enable call_rcu() kasan testing");
>  torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplug=
s (s)");
>  torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffie=
s), 0=3Ddisable");
>  torture_param(bool, gpwrap_lag, true, "Enable grace-period wrap lag test=
ing");
> @@ -4632,6 +4633,25 @@ static void rcu_test_debug_objects(void)
>         kfree(rhp);
>  }
>
> +static void rcu_free_cb(struct rcu_head *rhp)
> +{
> +       kfree(rhp);
> +}
> +
> +static void rcu_test_kasan(void)
> +{
> +       if (!IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> +                       !cur_ops->call || !cur_ops->cb_barrier)
> +               return;
> +
> +       struct rcu_head *rhp =3D kmalloc_obj(*rhp);
> +       if (rhp) {
> +               cur_ops->call(rhp, rcu_free_cb);
> +               cur_ops->cb_barrier();
> +       }
> +       kfree(rhp);
> +}
> +
>  static void rcutorture_sync(void)
>  {
>         static unsigned long n;
> @@ -5191,6 +5211,9 @@ rcu_torture_init(void)
>         if (object_debug)
>                 rcu_test_debug_objects();
>
> +       if (kasan_debug)
> +               rcu_test_kasan();
> +
>         if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_=
unregister))
>                 cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
>
>
>
> Thanks
> Zqiang
>

Thanks Joel, Paul, and Zqiang.

I agree that we should avoid extra KASAN-specific configs and integrate the
testing into the existing KASAN/torture workflow. I'll look into how
best to do that.

Zqiang, thanks for the code suggestion.
I'll look more closely at which callback paths it covers and how the
intentional
KASAN report should be handled by the torture scripts. The important part i=
s
to make sure that "Last potentially related work creation" points to
the expected
callback enqueue helper, rather than just triggering a KASAN report.

I'll consider all these points for the next revision.

Thanks,
Kunwu

>
> >
> >  Thanx, Paul
> >
