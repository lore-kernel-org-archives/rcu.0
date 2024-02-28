Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE55E073
	for <rcu@vger.kernel.org>; Wed, 28 Feb 2024 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151291; cv=none; b=H3W7skB1+SkTAI+YwsxNnT9V4pFFdwYVINxqoggiHfwhqe8dG0oDQSNYeH2ewi5SL4WKo2BThDBYA/1wea9Ld3bnD+uwOuK62xdmv5oweRXssunODOKoVmNNpMxb0Hz4UFuz3rRoJQQs72hCgBDU8rugVoWBsY8Oq2X3XXYjKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151291; c=relaxed/simple;
	bh=0nrml+WBxBMSjB6gKdozgb5uGnndn0Y89KcuAcb5ymw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jn0S6jVNaoflmIw5dkNXcqKxCuiJ9pL5+D1cV1NN9T+MSYbYu4OrGo4cfu0pW3D1ymNWDfi/Hl8IKOWs99ANsZ94nTbsUhPkecPNWnNk9Fe51XmhIxlRAJH36++9K6LreoHaSFU0ARteItBah0nVQ8Cr68eUdz0gMu+E4+x0xW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=W5O7VKgi; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="W5O7VKgi"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so1499881fa.3
        for <rcu@vger.kernel.org>; Wed, 28 Feb 2024 12:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709151288; x=1709756088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ADqDxZgPwlPHrnolYYX16DFA+qGQXF/8Cktxf1H8u4=;
        b=W5O7VKgi0RbREj9bK4Jj5Fb/FthztsNedxht03WloYlKep64hw9KOTCl1792qGxaBQ
         xcQKzawXUgJcl+IXmoQ9/1Yp1GVfNaxOvmPklwosEmZ2Jj1obRlTpB0GXJDQ9tktvLW5
         2P/lviMm1/25OJAZNOdBD2hxALxvlydcFp5Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709151288; x=1709756088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ADqDxZgPwlPHrnolYYX16DFA+qGQXF/8Cktxf1H8u4=;
        b=GW8QmRLmdb7ilVF8odgjCeeQ0ZsoGe6UEOzJggiDG71doqDnNyZOM0DVa6noskqJVn
         gyMF1kwYFMoYP5cfvwQv6jZybQ5Jz8N7kWj1DunZ1My1OiilQZDw7u/zSfPwW5sPme4s
         ploIN4IjLcl2RKRINXL7Ios/YP7rEV97YfVcWtGH3Tk9wvDnWm+gaSaKqOjoWJMYB8pH
         sbDjdUKX2Pqti8lqIMgPzRy5tF6IwMCJjMzoekBWHM66N5X8ZeR+Ebcwn8K7Rje1g3wH
         tTvaRII6MOQT3BWIUFBzmTWxNraZomL6T6JJYjesxhDIpNBICvzv6kSyPeUudV5FiziZ
         yuxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5RPDfmTgxGfLSCMpLkOV/sfE5mrdIAv3TP7uE/PEjBT8yH5D85H2N1M/CHh71Q6wwOYiu8fDNO4/4RcUpDTlTUk0r
X-Gm-Message-State: AOJu0YxWzPGMBTBJ9VL0o+nJBQ3owfgGfnCfy1nS1y+6xQrC0p9QdTqi
	vaPTJV12IIaibZswtc31nhp3NYFSNPgHuSJYhCdsh+aS98ve0kHQCn5UqWmH+q3mbdSXx6A6E/S
	pmxms/SJV4azrHl4+4/PdLq7cVLmZetNbsb08cw==
X-Google-Smtp-Source: AGHT+IG7XxH4AwZOInEocXRNgWrMaGpJwprc/M5hmyKfGaWgosyEiwVI681eukxW0okBE54/dKecrCUQtR2maiJPvrI=
X-Received: by 2002:a2e:be28:0:b0:2d2:64c8:49a6 with SMTP id
 z40-20020a2ebe28000000b002d264c849a6mr11611642ljq.21.1709151287525; Wed, 28
 Feb 2024 12:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian> <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop> <f1d1e0fb-2870-4b8f-8936-881ac29a24f1@joelfernandes.org>
 <CAO3-Pboo32iQBBUHUELUkvvpSa=jZwUqefrwC-NBjDYx4yxYJQ@mail.gmail.com> <e592faa3-db99-4074-9492-3f9021b4350c@paulmck-laptop>
In-Reply-To: <e592faa3-db99-4074-9492-3f9021b4350c@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 28 Feb 2024 15:14:34 -0500
Message-ID: <CAEXW_YRfjhBjsMpBEdCoLd2S+=5YdFSs2AS07xwN72bgtW4sDQ@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: paulmck@kernel.org
Cc: Yan Zhai <yan@cloudflare.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, rostedt@goodmis.org, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:18=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Feb 28, 2024 at 10:37:51AM -0600, Yan Zhai wrote:
> > On Wed, Feb 28, 2024 at 9:37=E2=80=AFAM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > > Also optionally, I wonder if calling rcu_tasks_qs() directly is bette=
r
> > > (for documentation if anything) since the issue is Tasks RCU specific=
. Also
> > > code comment above the rcu_softirq_qs() call about cond_resched() not=
 taking
> > > care of Tasks RCU would be great!
> > >
> > Yes it's quite surprising to me that cond_resched does not help here,
>
> In theory, it would be possible to make cond_resched() take care of
> Tasks RCU.  In practice, the lazy-preemption work is looking to get rid
> of cond_resched().  But if for some reason cond_resched() needs to stay
> around, doing that work might make sense.

In my opinion, cond_resched() doing Tasks-RCU QS does not make sense
(to me), because cond_resched() is to inform the scheduler to run
something else possibly of higher priority while the current task is
still runnable. On the other hand, what's not permitted in a Tasks RCU
reader is a voluntary sleep. So IMO even though cond_resched() is a
voluntary call, it is still not a sleep but rather a preemption point.

So a Tasks RCU reader should perfectly be able to be scheduled out in
the middle of a read-side critical section (in current code) by
calling cond_resched(). It is just like involuntary preemption in the
middle of a RCU reader, in disguise, Right?

thanks,

 - Joel
