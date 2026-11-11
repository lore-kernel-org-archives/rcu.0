Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364523;
	b=RlieoZjlVimJoVMzyN5JaD2aS4UhSTCl040GayujCD6HOaHjiXyJAOIsSk3YgoF3V0Z6
	 RBoRK7w4HAo+wzIhysgeb+rqtA6D5OtDy0GEYFXmatw7SMNYOJfKqTsHoK4H4Im+19/mA
	 wbLzOoP4MAJfyGUoTlu7CnHpJd9NkDLaa4o5TritQ8VG3H8LL8D8jCMjI1LNOtaVK33WY
	 ERb6dqKvAHSzgQJzDnR/Goi4vEDidSsQcIcSBYXC8gefVtV2UIW+KWazJdqLZhbHIF9Qw
	 BkODWemBldeH0YD46y9M5cvGThmJAcA+/FXl352n8mfFdJfB+HzNzxCItM9KbngnuZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364523;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=euuwGDlTqbNLwuO6W0jOczwpzF/Do0MJ09kIFghbAFs=;
	b=knhYeUhyNjOC5Zi45U0Q2QxChQwvjahY4t0GB9PRDCOjhRJKukpzv+6J+KMH/Cy+n4Wo
	 Nvxwc6WV6g3WtfVd3K1XXvS5uosmtLsvTR5O7QwhXknjMXYq8gx2MECXtzHgnuoxM9B3B
	 CNz1Tua3jQjqzpB4oxzuLQY3j/yE9QsjS0DCTxEzdZzCCMs2DWflQhrCDgZhxhGaUeM0b
	 Iybq8WY1uXhMoclACSXNm4HRGHa1EQt6ibfuMeDFI4K8bqaioit7nfUmJraLhb1i/9epy
	 8WzzaGnOrbGThQ/tEovwZufBV4E47tvQPxIk0GalZxv3D/wPw7wnp6oZXQldeYrMCLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OyAbTRqz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C090606A31C
	for <rcu@vger.kernel.org>; Wed, 11 Nov 2026 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OyAbTRqz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A341F00A06
	for <rcu@vger.kernel.org>; Wed, 11 Nov 2026 02:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794364523;
	bh=euuwGDlTqbNLwuO6W0jOczwpzF/Do0MJ09kIFghbAFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OyAbTRqzDvdvc9L0om6YO/BDcXMr2jkDjvFTo1ymA1fLPp00MuBvCEpdYjghFuJKg
	 VjqasRpK+SmIJ1v7DkkDSkZL7aR8kVhuK/AUAP3Gu6QNw/2DAT3ZrdvcsY8zuYH7BY
	 pi44Rg6eXRR9gL7pCNmVr+4jiEYpR0ZfUbcgPQ5kp0o8g4wsa+56GCmt2oCc+DyoMx
	 1r45Wu0V/Na//zgBjITzg/0VOrKwvkkLmXxpSep4v8qemZmJ2Q33uAGZ6k6At6DMfs
	 1TmNu2pI9fuAIZTmAy4tS21CIGdU8Skah7HLXAI5BSqQQaV8rf+RbO0Pw11kEVvDw7
	 66uOPTl2l+R+A==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93ece7a73b9so295109085a.3
        for <rcu@vger.kernel.org>; Tue, 10 Nov 2026 18:35:23 -0800 (PST)
X-Gm-Message-State: APuU4Z/KbzitN7D+xwr7dAmvVlB62unQGdrHH6q+YsE8VCrqJdivJYRM
	MwLFp7SRsPBxCH+mAYgJfMTbW67RpqrZ9ycC3mLB5d2gXtfY1JMrb8jZFxpU8EBAiusSVz8OV9o
	XsCRs7j990kkZUR4x2qXxJOMYRdpZNuM=
X-Received: by 2002:a05:620a:4412:b0:93e:dcb4:c73e with SMTP id
 af79cd13be357-947afcd2eeamr185055985a.5.1794364522335; Tue, 10 Nov 2026
 18:35:22 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop> <20261007204511.1982646-9-paulmck@kernel.org>
In-Reply-To: <20261007204511.1982646-9-paulmck@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 10 Nov 2026 18:35:10 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6jBj1Sjm8SO_HO13oBgq-5gqKptgT_h3OWYoLDQggL7w@mail.gmail.com>
X-Gm-Features: AclHuK-OOja6wKy_OP1KXngfb4J3ZR0GNHjQEnFWxc0Auk9QilRAjp2JWvzu5uU
Message-ID: <CAPhsuW6jBj1Sjm8SO_HO13oBgq-5gqKptgT_h3OWYoLDQggL7w@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] rcu-tasks: Disable callback contend/collapse
 messages by default
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Breno Leitao <leitao@debian.org>, David Dai <david.dai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 1:45=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
[...]
> index 627295396cd91..fcac7361ec51e 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -178,6 +178,8 @@ static int rcu_task_contend_lim __read_mostly =3D 100=
;
>  module_param(rcu_task_contend_lim, int, 0444);
>  static int rcu_task_collapse_lim __read_mostly =3D 10;
>  module_param(rcu_task_collapse_lim, int, 0444);
> +static bool rcu_task_collapse_debug __read_mostly;
> +module_param(rcu_task_collapse_debug, bool, 0644);
>  static int rcu_task_lazy_lim __read_mostly =3D 32;
>  module_param(rcu_task_lazy_lim, int, 0444);

Rookie question: Instead of adding a new module_param and gating the
pr_info with it, can we use pr_debug here?

Thanks,
Song


> @@ -390,7 +392,8 @@ static void call_rcu_tasks_generic(struct rcu_head *r=
hp, rcu_callback_t func,
>                         WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
>                         WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_=
ids);
>                         smp_store_release(&rtp->percpu_enqueue_lim, rcu_t=
ask_cpu_ids);
> -                       pr_info("Switching %s to per-CPU callback queuing=
.\n", rtp->name);
> +                       if (data_race(rcu_task_collapse_debug))
> +                               pr_info("Switching %s to per-CPU callback=
 queuing.\n", rtp->name);
[...]
