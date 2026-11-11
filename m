Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418353;
	b=SUHwdDctKdLFl4lhteSYwlOS/WQhSwoGoWHceUc8UcIavNuQ6wNr3I8llhCBGAfZ3HZt
	 ws+ZEKnSJrA4VM11QuT/4mtczVrlyj232I0iIjJOGUm1WtyH2L+D3mfzWoPKMhut1iZ1q
	 dIYr1KtsZnGs8OXghmD2iGsWCeqG6rd9ZE0ZsUsJqRx7U2Fm5PNCf3jxQZEIlPw36yUXB
	 04Borr2kvpzBMorZeZtrkIa5/5EBPJjv8ZxfY8x73RmJ56HEmK6Lojqpa+hyIHPZmZEPM
	 TNY6STQ4zb7XHNvD0riGg2VsofMAi5ZDJ+CBkkgULCdg+BfJaNn1NvUjiYajGh7bF3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418353;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ywa8GwVt/KmL5oJA+4U2uk95z2A84lRU6JltZ9dFa1g=;
	b=NlMRI3qIC/j2OIN1gFD7cBk4/DcDHZN7Dj8m2z/MmoT+tGSzckzWQK78S6wpZY2J8QOU
	 qDaW9vdi+qClGZVOg60DjC+ybWXZDNya1OT6YemIshs8oZ6wAmZWcOaa4scrO3FuIYt0u
	 eK1eAYT88Rje8HwAAtUTRddKt4V63r1ZQgNUQdfsIpHt16NGqvvXcXiaLBXpDHrIySL7P
	 YcEwVZOz8SJYlYCTMbQ44+g8TzHB0oWZK88/6h+BW2lEiA2oI1j7s6Lj8CzMs1PMXz5nm
	 s5bNQX4bTVb8QjQO+tLquqpP7+TQiSJ66sZF3S/54phE95x4OxAGGBxF7V5ckuQboTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGcmfYsV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C8D606A327
	for <rcu@vger.kernel.org>; Wed, 11 Nov 2026 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGcmfYsV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89CC1F00A05
	for <rcu@vger.kernel.org>; Wed, 11 Nov 2026 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418352;
	bh=ywa8GwVt/KmL5oJA+4U2uk95z2A84lRU6JltZ9dFa1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NGcmfYsVMNK2jIfECKW6t+ogu13Iy6hUN7/rS1lQ+V8MSkXzcuVEYy9UxV08PriOH
	 SfNc851qukWrDdzXQweALyQHN+zDLztgOwD476HRau2sboh1Xqb34XcSxSJk8Q8rLe
	 s9oa+HN1AUS6gEbTRTofZpPjmYN/NWLPgxEL9gxWIICy+UH3S8nYZq8ykFPxk6vkRS
	 aYw9Qu/HBioGO0BDWkkYK91BgzWzbMjNkszfZzJnPzw9X1dfLrthrFo/xjcjKDoKr6
	 pkYj9HJI8lnT3PC5Dc83Vq+jLrYxJt8RNoOnd3UBkfG43dK1hhCCse+0fsv/POTAWp
	 c+6O+wCwiNFrQ==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93cc1ab5f6cso428685285a.0
        for <rcu@vger.kernel.org>; Wed, 11 Nov 2026 09:32:32 -0800 (PST)
X-Gm-Message-State: APuU4Z8HXWxFzjpYpkI4aEuZN1rWhh1tp6AptwE8F99erusOkijOtSIW
	SwYB9oXr0x4A3z0BZ981zqrZfZSMzt4XCB62RJvqBMmUCIOYnx4NLYxhcXP/OAWwnBNbXUqASXY
	duoRi4BZJTgAZi0AmsolcYe/FIaimJJw=
X-Received: by 2002:a05:620a:2a04:b0:947:8018:978e with SMTP id
 af79cd13be357-947afcd6a2dmr491643685a.6.1794418351931; Wed, 11 Nov 2026
 09:32:31 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111053551.3367903-1-song@kernel.org> <20261111155441.GA1829883@joelbox>
In-Reply-To: <20261111155441.GA1829883@joelbox>
From: Song Liu <song@kernel.org>
Date: Wed, 11 Nov 2026 09:32:19 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6_WsuabPQ6unancwouSPZStQQZa8WoDG82-n6Bi5gPhg@mail.gmail.com>
X-Gm-Features: AclHuK_XeHXwre1C2swC-LPtC0Eivggyjbn1-sGfs75SfQVLn2Iu7oIm5rK3Dq0
Message-ID: <CAPhsuW6_WsuabPQ6unancwouSPZStQQZa8WoDG82-n6Bi5gPhg@mail.gmail.com>
Subject: Re: [PATCH] rcu-tasks: Use pr_debug() for callback contend/collapse messages
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org, leitao@debian.org, 
	david.dai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 7:54=E2=80=AFAM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> On Tue, Nov 10, 2026 at 09:35:51PM -0800, Song Liu wrote:
> > Commit 5de907d24919 ("rcu-tasks: Disable callback contend/collapse
> > messages by default") added the rcupdate.rcu_task_collapse_debug module
> > parameter to gate the three pr_info() messages that report RCU Tasks
> > switching between CPU-0 and per-CPU callback queuing.
> >
> > The kernel already has a mechanism for debug-only messages that are off
> > by default: pr_debug().  Use pr_debug() for these messages, and remove
> > the rcu_task_collapse_debug module parameter, its documentation, and
> > its boot-time announcement.
> >
> > The messages stay off by default.  On CONFIG_DYNAMIC_DEBUG=3Dy kernels,
> > they can be enabled at boot with:
> >
> >   dyndbg=3D"file kernel/rcu/tasks.h +p"
> >
> > or at runtime with:
> >
> >   echo 'file kernel/rcu/tasks.h +p' > /proc/dynamic_debug/control
> >
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Song Liu <song@kernel.org>
>
> Makes sense to me,
>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>
> Will apply for 7.5.

How about we queue this for 7.4, say rc3 or rc4.

If we delay until 7.5, 7.4 kernel will be the only one that has
rcupdate.rcu_task_collapse_debug. IOW, if we merge it to 7.4,
no official kernel will have rcupdate.rcu_task_collapse_debug
at all.

WDYT?

Thanks,
Song
