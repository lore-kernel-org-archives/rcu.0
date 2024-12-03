Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F41F429B
	for <rcu@vger.kernel.org>; Tue,  3 Dec 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238040; cv=none; b=kUDKMTS/yco0G6PapIO8zYtwQU2YuxoLtFYAJCzm/K7WiLxAK9r5RWqhjZ7GpJJ7pH0AO0fcYVXyRmKFNIPLIFONoe5ZfRSjeTojkoYjniwQoziZgEp0RBcMF0tplcBt9t1LdzigIwEFqbXiX8P1G9o2qKa27wIdsUOS92gtU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238040; c=relaxed/simple;
	bh=xYdG6YiEKREyfGjp9fPGIDehVO+II6FjrLqDnuvl/CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsQgUAwOOneH/xMlYryHHW9TD2Q1jzn5xZFsPVP8qqV/6MmssyrF9/iOwsNXmTChgduJuBSKXIkOLA7OQF0qlDL/68gLQU7HX09DlRD5O91538AIuYQ4tXFxuSVcCkDaRXm4Md0MxlnpV6YADk6x3HhTHb6DXXSAOF2qtyq1RJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=XXpsw74m; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XXpsw74m"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3971be41d8so4228266276.2
        for <rcu@vger.kernel.org>; Tue, 03 Dec 2024 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1733238037; x=1733842837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYdG6YiEKREyfGjp9fPGIDehVO+II6FjrLqDnuvl/CI=;
        b=XXpsw74mVrFoPVOUXwd5roI023HY29iVTclpql/74YIJXLwUIzPxhxlLSYIf+7C397
         u2hkzXZ262C4X5tZZ24e30BCVvm1huyx7/0Y5Qmj0XnuB9z7/ftfnf9hv9v/n1vY75tW
         RISI92oeAShx3slFVPLyRj/aRQXSkElLMD8bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733238037; x=1733842837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYdG6YiEKREyfGjp9fPGIDehVO+II6FjrLqDnuvl/CI=;
        b=Mg0635gvKd+4BmEypxDIyR9skFAQfZz1RNlONg0vOWBGvgIo7aV7k1N5icBCSY/hmP
         irOxRPCTYocuyLMhAoCxzFqvHnldrcliaIkA3Ae8xuyEpP6sCQ+ziLkIDUCvhlji0qxS
         AgJ+KlhElzHQazyYMjsuBe/80fEdnEWp/Z9J3JKSvi55VNl265n+JsuLBdhr55yFwU/c
         jcYV8eHwKUm15RCaSyaHSEEv97GJ6goTFojVbLi35lqRSol4w7DylzExXIJzEP4ssqWA
         JkSJX4C+tKne0elxqyT6qcuYpFbVdBwV/dE7AkAd2BpE/xZ/scKwbmNhSQYIRZGtX01v
         JvZw==
X-Forwarded-Encrypted: i=1; AJvYcCUuYgzXCZ2UQ7Z/Mc1DiqbLIERpY94ZaI6wNZxmy0IHrO+mmNs+rfIP1JXTcXhd2iWhsTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxzt1Rbyhvrh2YoqploTtCnBXoFQfxZPEeapf+Vtk7z8CkkIgE
	fgF36UhuCYhvboTDm1t9CEldU0Pyt0hHX8tK1wb7sO7o9T3l8aj9C7LLhN3/mPjiJiy5fx+CQDa
	rubAPWEEEjxcoVsC13eF5hUZOWzkOmqY7AFWDOQ==
X-Gm-Gg: ASbGncsA59d0rls7yIimTAQ2xO03arpWPKSXixHbAbvrsUkVwZQwOEjo63WStwV8NM9
	ZKOTyIsdWF+0D7tTc6l5VnqAwu5W3iyj9
X-Google-Smtp-Source: AGHT+IHRBFQmfm+41Q5jBpD1n0GIw3d9h3v9DOtoxp1AQL7jHIgH+IMa5yeDq7jLQOG5SQPiBGSig1+NhW7ZskWGNiw=
X-Received: by 2002:a05:6902:1b12:b0:e38:a550:89c4 with SMTP id
 3f1490d57ef6-e39d3a29589mr2748197276.14.1733238036551; Tue, 03 Dec 2024
 07:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202140735.56368-1-gmonaco@redhat.com> <20241202140735.56368-3-gmonaco@redhat.com>
 <c16481a7-20f1-44b8-981c-fd31cb331cbf@efficios.com>
In-Reply-To: <c16481a7-20f1-44b8-981c-fd31cb331cbf@efficios.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 3 Dec 2024 10:00:25 -0500
Message-ID: <CAEXW_YT1NLU2xsBHwDjbBPg_rZWc4hNGNgmkdxF8C_0Dw60N1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: Move task_mm_cid_work to RCU callback
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	paulmck <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 9:34=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> +=3D CC RCU maintainers, reviewers and list.
> +=3D RSEQ maintainers.
>
> On 2024-12-02 09:07, Gabriele Monaco wrote:
> > Currently, the task_mm_cid_work function is called in a task work
> > triggered by a scheduler tick. This can delay the execution of the
> > task for the entire duration of the function.
> >
> > This patch runs the task_mm_cid_work in the RCU callback thread rather
> > than in the task context before returning to userspace.
> >
> > The main advantage of this change is that the function can be offloaded
> > to a different CPU and even preempted by RT tasks.
> >
> > On a busy system, this may mean the function gets called less often, bu=
t
> > the current behaviour already doesn't provide guarantees.
>
> I've used the same task work pattern as NUMA here. What makes it
> OK for NUMA and not for mm_cid ?
>
> I wonder why we'd want to piggy-back on call_rcu here when
> this has nothing to do with RCU. There is likely a characteristic
> of the call_rcu worker threads that we want to import into
> task_tick_mm_cid(), or change task_work.c to add a new flag
> that says the work can be dispatched to any CPU.

Also there is no guarantee that RCU callback will run within a thread
context (example, some configurations run it in softirq). Further,
call_rcu() usage as shown in this patch can also delay callback runs
by seconds (with RCU_LAZY enabled).

See also #5 in checklist: https://docs.kernel.org/RCU/checklist.html

thanks,

 - Joel
