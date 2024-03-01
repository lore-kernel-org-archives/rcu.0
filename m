Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9C224D0
	for <rcu@vger.kernel.org>; Fri,  1 Mar 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314243; cv=none; b=HyOsUJq4Rixe4lsg2F1A+RKVyUJ+K7D/z4MtoBaG1/tnv4vTQI2TAf7mI2dExLkUUjUU65HiP7lZzL7IhuLONNh366BQ08+vLMnARIAEcFXz79shwTRRGjzmd66Ic8wYp+03bh9cSzwL9x+3WN/YVXuJQKbqUsU5L11uB5svE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314243; c=relaxed/simple;
	bh=ylK+D7JueGqF19SPnHZNe+5mxcvVGQNvmcj6EMAxZD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6lNvRDxXtSmxYhoKebE+wyOejIb/6c4+8JS5Xk977UgvRJH1wybNaEk9gRnkSWDN8eA/9DkIAn5Qa2jvw0pFHTv7Yg7PmyD/UijjQPF1bDt1+7HEsG1+TmLZPAicdLyElxy44y1StkQarwwusC3OdzCV1mbzpng8t6SuJKWqGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=d6DDV6/E; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d6DDV6/E"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-566adfeced4so2520338a12.1
        for <rcu@vger.kernel.org>; Fri, 01 Mar 2024 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709314240; x=1709919040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Im9Umr2T85hMOmj0bpnRxcaABawqPpPhu4ZR7NKNsVY=;
        b=d6DDV6/Eiarm0bJq1DNTlh7R5wtoJ1ISKdiLl35Ys/jOwOfcieS/bmafgVOQVrkXeY
         ESnDnJkis662XNZsXul5BOhCtq55yO9ZIiVPwAB2TuZVEYRZm/SIxvqDJA6V9M9iJQZl
         9T+b9NmKN2s6RgXn4cDFSevOL2kfTYkO4/z+ceLX8eEzOlWcfDb9UICjw6K+kjB/i3Eh
         E+tW80Zd9ALMirEfyGDsOdlREIDyG4cV484rrH/5CT64fkpaKiq4ZEsgLt2K84pI7WjT
         GPOKDPvrhcN7rlmx7VPKSPm/UFdw4pEyJHc8EtNQeYnh+GiWdg8VU9bNhU8/zxZUWvSs
         q7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709314240; x=1709919040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Im9Umr2T85hMOmj0bpnRxcaABawqPpPhu4ZR7NKNsVY=;
        b=iChDi/KgYdCQWXm9P+YhH9IIXMl128reXF6xqp5jSyZkDEyqmPw9xUaVWwyuyuRsWu
         eefMz0b7ZeR6PdwXMSrO9YJqLGcHmofjuPHMDH1uGVH9PRDIrtaWXKnsSBaPyfjOr6nF
         lVu/yE5VGNyOiu53XFyJuH1NNePe32PcJRiZS0N+3l4cI9MU3iO/rIhhRWPnzLI27YT5
         DCcSfLjauolXa/PlSmXTQybN5TYXan2xAYkmYF+A44vsd2TqyFgqrKfX13GOY2k8PQJI
         wmaRz3nRG/Aziup180X9WnC4p1JRBq/m+sFKRiQOgPL8gv/bmIkX+7pF34b0LflCPEYu
         cS2w==
X-Forwarded-Encrypted: i=1; AJvYcCW/Lu2ylfXCUSl5IywaF++qX+Xvin2jVkPh++6lC7Z3yK0v5bQrexVuHL8Gz0kF7mdQyCDH5bGw5M5QBI9L2O3SYl+R
X-Gm-Message-State: AOJu0YzCX2XS96J5l47FFnL1G6dfQ47EObTxpGDpP1TvDcPjpaOgCA/x
	SABvvz8v6Yy+De6aiaLUcm8XXXIWxl2NpqBOYkOFxFRzPBANs5vkPH8S83ku3vF9S/Tl41wL5aU
	Lha7MPhxJDubXh9eq6JKUBOu7lojaqj3mFrmMYQ==
X-Google-Smtp-Source: AGHT+IGYLJyhVjmMRjbUCITVxHrHFq3SYd6tnAK4qRR5cHKptQ5mXdPAN6On8sZlA3S5Bv7Ldr+4yWiPY5SAqyrDMao=
X-Received: by 2002:a05:6402:35cc:b0:566:f851:f53b with SMTP id
 z12-20020a05640235cc00b00566f851f53bmr334043edc.35.1709314240646; Fri, 01 Mar
 2024 09:30:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeFPz4D121TgvCje@debian.debian> <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
 <CANn89iLCv0f3vBYt8W+_ZDuNeOY1jDLDBfMbOj7Hzi8s0xQCZA@mail.gmail.com>
In-Reply-To: <CANn89iLCv0f3vBYt8W+_ZDuNeOY1jDLDBfMbOj7Hzi8s0xQCZA@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 1 Mar 2024 11:30:29 -0600
Message-ID: <CAO3-PboZwTiSmVxVFFfAm94o+LgK=rnm1vbJvMhzSGep+RYzaQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: raise RCU qs after each threaded NAPI poll
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Fri, Mar 1, 2024 at 2:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> I could not see the reason for 1sec (HZ) delays.
>
> Would calling rcu_softirq_qs() every ~10ms instead be a serious issue ?
>
The trouble scenarios are often when we need to detach an ad-hoc BPF
tracing program, or restart a monitoring service. It is fine as long
as they do not block for 10+ seconds or even completely stall under
heavy traffic. Raising a QS every few ms or HZ both work in such
cases.

> In anycase, if this all about rcu_tasks, I would prefer using a macro
> defined in kernel/rcu/tasks.h
> instead of having a hidden constant in a networking core function.

Paul E. McKenney was suggesting either current form or

         local_bh_enable();
         if (!IS_ENABLED(CONFIG_PREEMPT_RT))
                 rcu_softirq_qs_enable(local_bh_enable());
         else
                 local_bh_enable();

With an interval it might have to be
"rcu_softirq_qs_enable(local_bh_enable(), &next_qs);" to avoid an
unnecessary extern/static var. Will it make more sense to you?

thanks

>
> Thanks.
