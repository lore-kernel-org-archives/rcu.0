Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9124A31
	for <rcu@vger.kernel.org>; Sat, 23 Mar 2024 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711159337; cv=none; b=nM1XHy6xoqSPS3mGj0O14h2D1GctVYQ55JOSFzO6sT+bhXD3RaDwZlXj797MWTVKtvB+JLRyvT6kIeBRvmrIqmcGRqu7jg0rq5LgNU4u5mm+XPey3n7+4H7kGZydOUnejzauxkqXw0wMSfzv/qeLJbxVmczY1e8zXhavtTRT5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711159337; c=relaxed/simple;
	bh=kjQK/ZXJeuufuWKUqTmtrVb3RiT09PzKuAhVluGT+go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIJDiLrLQVtIDrKN2W5DdQujjwDABYxv4RqaH3fGglE3ledR5Fg1eYWo09SYXQscQX4hR39uAoMm+b0tXAWYuPmc2QwI0FgV5HC/AWaq9SqTOc8GyzAo0PLNgevCq+KUQsQairMdG0j+0Pqk8e15Sn7Q6dvcjHNRbRnDiZ6LML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Th2/ZZP5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Th2/ZZP5"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4702457ccbso366532566b.3
        for <rcu@vger.kernel.org>; Fri, 22 Mar 2024 19:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1711159334; x=1711764134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDrtS3kmmAHBfczwt+9v+j8bPsXytsIEzAPUfRDLktk=;
        b=Th2/ZZP5sfW7yYwdEB9kKPKe2ZEgP8l3WruK+7IkwBzFdPxlX/g+SVdYemdVtDjFyC
         2zZEePDIChlyKqGtSPF3yvm3NEEPdmvB48Z/IvmClr4xwUYaV/XZpPe/h0VebglO1oJj
         ZycMb+zFvakcYLLGYpuKKRitAOBIUz72AqkDIow9zt1L6rkIT+VKxmo/9GaUoPB6brsR
         CYdcZHZV8T8v5yOPHJjeKKSYZCtx0UuMh4rC5MZUAFcAHh8JWBs1aOyNPNX6fy6xDJbS
         wWKBtzZVeClTa0PduraQBpY40SqZlMIPsygl48/86za6Gd7btjQC9xmtXoLv2nMivwUc
         U4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711159334; x=1711764134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDrtS3kmmAHBfczwt+9v+j8bPsXytsIEzAPUfRDLktk=;
        b=lceQ5UAfMZaztjOxhYAG0S+5zTYw92t5qeSMf/1rEU3pSFjknToRGbclXnfzn6N8+v
         1j5VgtJ2XtmBK2EuOE9aDTTBY5xGPWjFdCEQdjITqEjL8A0EclPO8SRwBU4voQxFHgct
         M7SU5kNnqiG6a+bHhZFJg6427mXoXNZNFgML3vph9/UfrDcXOFsOcHxi2X6b9Qt/WI/c
         EmSSBgfCFReT//yCAmQlvY3JHScN/PD2kuPAhXcYnGCJHvO0MC6Q/7hrSvi0b4Gnk3f7
         iq3URjWD5NtylNJrpwDrnQRqhrlnlKQfg5ZXOXAJYdbLmAhaeEap6C71R6RnuU5OT+RO
         lunA==
X-Forwarded-Encrypted: i=1; AJvYcCV/IdWitn+GwPrmJ/6dkLQpKeKa6WDe6MZFGUYroDqo7ZcghrP1gtkzksH7g2TIwJQ4tg/iRzddLK8mQYgThVfzs6zh
X-Gm-Message-State: AOJu0Yxl7OjAatTd+7BjUq7BIgPxYR0UbijDyG4NRsL0ESfBSW6v+tyZ
	5aq/bSIvSle6SGt+sAvSLnP1bAx7ZkPaf4dS9CH4WFHCeeq0Jc6AjydUMKjrGmGOUFXrbMyr7v+
	c4UvYpPLmrH2MAOinH+6EmjX3M4vx5zaBOPGGWg==
X-Google-Smtp-Source: AGHT+IFilYtLpWhQMZrvvCHnCL+cWrm27JI38D0QFqame+iNQqNKz8aOz9QXGy0lw2uDZ/Nj6Ill05uOw4ImUyjck/s=
X-Received: by 2002:a17:906:81c8:b0:a46:a712:3972 with SMTP id
 e8-20020a17090681c800b00a46a7123972mr797745ejx.11.1711159334004; Fri, 22 Mar
 2024 19:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710877680.git.yan@cloudflare.com> <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>
 <20240322112413.1UZFdBq5@linutronix.de> <123ca494-dc8c-47cc-a6d5-3c529bc7f549@paulmck-laptop>
In-Reply-To: <123ca494-dc8c-47cc-a6d5-3c529bc7f549@paulmck-laptop>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 22 Mar 2024 21:02:02 -0500
Message-ID: <CAO3-PbqRztEC1JFg3SrgUi9a404Xpou_Xx9_mxXoZVY-KVkyGg@mail.gmail.com>
Subject: Re: [PATCH v5 net 1/3] rcu: add a helper to report consolidated
 flavor QS
To: paulmck@kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	Joel Fernandes <joel@joelfernandes.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 4:31=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Mar 22, 2024 at 12:24:13PM +0100, Sebastian Andrzej Siewior wrote=
:
> > On 2024-03-19 13:44:34 [-0700], Yan Zhai wrote:
> > > + * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT ker=
nels would
> > > + * have more chance to invoke schedule() calls and provide necessary=
 quiescent
> > > + * states. As a contrast, calling cond_resched() only won't achieve =
the same
> > > + * effect because cond_resched() does not provide RCU-Tasks quiescen=
t states.
> > > + */
> >
> > Paul, so CONFIG_PREEMPTION is affected but CONFIG_PREEMPT_RT is not.
> > Why does RT have more scheduling points?
>
> In RT, isn't BH-disabled code preemptible?  But yes, this would not help
> RCU Tasks.
>
By "more chance to invoke schedule()", my thought was that
cond_resched becomes no op on RT or PREEMPT kernel. So it will not
call __schedule(SM_PEREEMPT), which clears the NEED_RESCHED flag. On a
normal irq exit like timer, when NEED_RESCHED is on,
schedule()/__schedule(0) can be called time by time then.
__schedule(0) is good for RCU tasks, __schedule(SM_PREEMPT) is not.

But I think this code comment does not take into account frequent
preempt_schedule and irqentry_exit_cond_resched on a PREEMPT kernel.
When returning to these busy kthreads, irqentry_exit_cond_resched is
in fact called now, not schedule(). So likely __schedule(PREEMPT) is
still called frequently, or even more frequently. So the code comment
looks incorrect on the RT argument part. We probably should remove the
"IS_ENABLED" condition really. Paul and Sebastian, does this sound
reasonable to you?

Yan
