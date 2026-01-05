Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24DB25A62E
	for <rcu@vger.kernel.org>; Mon,  5 Jan 2026 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767573291; cv=none; b=YKsDjOpCAaPHVhc+Xw9gyoeJlAiomCFSchjxzNUXW9zGEQbG+WVDnbW9aWTJ7u/eta3xEITQCQ1RQv4Mkr68j/ShEz/U1VdP96fnO2LbOfvQOUyRtUBxLp0grMOATR3CUNVevpw9WVcat9SBL/7f5TVvmYKovf3Crpv77PYJB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767573291; c=relaxed/simple;
	bh=K3RIqHgJQT1xGi52w9CHLG4nVH1N4w3wDSR+UgLt7hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=is3Vj7ouxY24iMWuTWFdVWH/LoySv6s7bsZadyEJ7oaf6l5ZnGqvpQD1aLyCu/YNU5anVjEGBUGvCDpD1JRQTNngCgS+LCby+iFzFDk9W5evQRRHbdXGqR/wzeZdbABqTW2qJyB/OfUkt8RhuXxffbPx/AL+qRTb6buQ4juhZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=riTOKJj9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="riTOKJj9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso44156045e9.2
        for <rcu@vger.kernel.org>; Sun, 04 Jan 2026 16:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767573287; x=1768178087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNKNM4sReKEQaK5afRI4aaqhQ67bX9x7T1VNmZfqt6s=;
        b=riTOKJj9588tSCqMzcBpTralosutHFq8vNUxJoE31qDpUR1BOTMQc8xowgM8jwSiLl
         QQQOjd+NilmlmzSj4UoffEPze2PcPqjkNWzmIio255nob0JdO5MYhwzGtKny1DBmQCGy
         ODb1VIFC6FVu/tcQGoe9q3McACnlyzB5TcMAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767573287; x=1768178087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DNKNM4sReKEQaK5afRI4aaqhQ67bX9x7T1VNmZfqt6s=;
        b=MUOdrtDdcZYVlEq/lITDdGNEdeLc4/mzfsc/0x6qMHT5l/7ZQb+p63hicDK0FYM2QS
         q3/puYykMgMllfBozSYHZ1h05pk/5DkKShR4K3Y63zQG8V+01+v0svh9O1m1SBqhKL/v
         qUYbu2lsUDzQaFPQpfAL+kWHPq/sPJ+KDXsQzRrfblHgqijMAgJpGf6nhwCc/WtxCJZd
         r4qUM7KlJOEuJ9/MxEvy/EbE4Dlt6QwRAVeQBzONJnD7UQRfCrpdbVY5qsSpqpg/PKj3
         hGBPBLgRi8KCM/mqWw9s4fxbZ8Rww3Ln+68cJxVcHK8YW/++44+HDX+/+0Z4i75QVLQM
         mnZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4VaT8gDzik3i4RzxnMpge+z+txJRrKjPZ/tfee252ojVomYIpEym4felS3F8Mge1VNc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUVUuG4q3EC9XI4dkBHV8V7aER7kXAnPLnOMxsCDdLFRIGPe7
	qb9VvUo3UE40p1/hwFL4OTc54Su4n0HxYfu59iUcjiQ8R0GJh/rq9TKwh3xEzazHz7RKV+hc40o
	0aH/al4qC7LBq16EEgePEKuhonI8UaoG5HV4fb+RcGw==
X-Gm-Gg: AY/fxX6PnYd/eZgaIZj/Iog0Nd/Z0JNMooYWuKrpNaTc/6pTGO4c8Kt5o3f6VGabuk7
	MFCeO36vI5HAazWiJTmQI5Wx0AhJHu2TIZ7r6749N24/km9l1pJUfdJH9w945rgqzys17x7vkmv
	2UyvRp41qQjIxBboaOtlKJ29pyntkXcGFq4zw/u0lDNmZ7yOSYojm/S0xNNG1LNihNO1pb+5c/f
	8EN4nALei5vFE6ET9a4Lp3cQHM0dScgMYOw6qYAOAfD9ZSMTKSRk0RNXXUD2OeT4lkmhw==
X-Google-Smtp-Source: AGHT+IFDoeswL7nuj50Me0VWVhAO/qPFvQmWaODUfmmFE08RqdsNXGSlzIxloRxgtDaDBQG9r8DoEOPoVmU0KI7sO/Q=
X-Received: by 2002:a05:600c:4e90:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-47d19593896mr586727965e9.28.1767573286818; Sun, 04 Jan 2026
 16:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104081027.189234-1-dolinux.peng@gmail.com>
 <20260104194534.GA2247470@joelbox2> <3188cbf5bcbe5799c77a6cc870ad0ee85b58d255@linux.dev>
In-Reply-To: <3188cbf5bcbe5799c77a6cc870ad0ee85b58d255@linux.dev>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Sun, 4 Jan 2026 19:34:34 -0500
X-Gm-Features: AQt7F2rCSdgkl7PoRhEE5SScyWalYAF4fji0rzQOU5nK8sbEZ3eI7Kfw3uGMla4
Message-ID: <CAEXW_YSxHnUxNXNiwBZRiVF9i5OBv7bV73e_k_RFJ3Osnrr18Q@mail.gmail.com>
Subject: Re: [PATCH] rcu: Align stall warning 'idle=' output with documentation
To: Zqiang <qiang.zhang@linux.dev>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Donglin Peng <dolinux.peng@gmail.com>, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, rostedt@goodmis.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 7:32=E2=80=AFPM Zqiang <qiang.zhang@linux.dev> wrote=
:
>
> >
> > On Sun, Jan 04, 2026 at 04:10:27PM +0800, Donglin Peng wrote:
> >
> > >
> > > From: Donglin Peng <pengdonglin@xiaomi.com>
> > >
> > >  The RCU stall warning message includes an "idle=3D" field to indicat=
e
> > >  the dyntick-idle state of a CPU. According to Documentation/RCU/stal=
lwarn.rst,
> > >  the hexadecimal number before the first '/' represents the low-order=
 16
> > >  bits of the dynticks counter. An even value denotes that the CPU is =
in
> > >  dyntick-idle mode, while an odd value indicates otherwise.
[...]
> > >  kernel/rcu/tree_stall.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >  diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > >  index b67532cb8770..d25cc826d77a 100644
> > >  --- a/kernel/rcu/tree_stall.h
> > >  +++ b/kernel/rcu/tree_stall.h
> > >  @@ -555,7 +555,7 @@ static void print_cpu_stall_info(int cpu)
> > >  rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
> > >  "!."[!delta],
> > >  ticks_value, ticks_title,
> > >  - ct_rcu_watching_cpu(cpu) & 0xffff,
> > >  + (ct_rcu_watching_cpu(cpu) >> ilog2(CT_RCU_WATCHING)) & 0xffff,
>
>
>
> May be also use CT_RCU_WATCHING_START to
> replace ilog2(CT_RCU_WATCHING) operations? (I didn't actually test it)

It should compile down to the same thing, but either is fine with me.

thanks,

 - Joel
