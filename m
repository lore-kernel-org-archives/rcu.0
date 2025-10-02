Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB96A8D2
	for <rcu@vger.kernel.org>; Thu,  2 Oct 2025 01:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759369068; cv=none; b=Y/qOpsfaPXaFbAet8j1jAn88StzokXYLTWo/cytHsE+2Xh3+2iKjIwIxDk0h8E8ONQQQZTXLB3O61EENDRoglXXoDp4zY2oHwfdTeeFgZu3sdZKhdkD0haAKEQ8n1Hd6joQmhqOdf4whuR8E6dLRc4STYvkVJ01AoJfjxUVVZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759369068; c=relaxed/simple;
	bh=LMkdtzViwyUWMomnf2k71aZvoLTDVva+cK4Gpdmjgsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrIa7ZwbmpFXpI1cRoFpJAs+kOEhJfYpfzW6/46Y1CqFp6H7fL+OVLPJKwm+1NYuMYlWg4cDTFxClu7T5eSEX6GFYMp6LdrllJ5vRoaqV0huLqQYOUNb5dADtt1sazpwQesmgR9HnR23KbEXFA1We08Qn2aL0TDz/+imoSaPLyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuBLd/tD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuBLd/tD"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso308617f8f.1
        for <rcu@vger.kernel.org>; Wed, 01 Oct 2025 18:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759369065; x=1759973865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUsweFKMStD+GhCJN1r57gPem6qJDj51RqfNuzsKQug=;
        b=VuBLd/tDYORyI7Bt8BAx0cGUYieMhOqDJ4Ao7sdwMxlb5dgiqRplbDtIP/9YogEYuA
         569tfsf0vrnU3sDLFgk/8HPcWqhqqaeNLadfhy0Q7KWaJrOGQcdRuGCs6cQMdqe+hUGO
         e3WdCY0hVk9xrPi6L+ukrg9oIN376fWjIaHmf3mrQ/cxZN/iEKkhlIuwOYJPE+S6OC8t
         2J5XMQ5HFb0+pfwiM9rDjClSMHN58m6edChYSPOfo9NjFpSqXIKi2KmOOiHLTAluqBBt
         eWaWibRmOggOLHEXoYZBpu8hqidinmJIEIQM+cXQSm4s8zAQXHy9Pr6X2mbgjWxfMilD
         pPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759369065; x=1759973865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUsweFKMStD+GhCJN1r57gPem6qJDj51RqfNuzsKQug=;
        b=aOoagyhv58fqkVdqmPfx1rpfZwjfyT5Th/05YjNcsfX3LFWbUihljQ5sLIa3zJ13AF
         qbF2XEMwx5BlenUCc92K0F2q1bhx/ObS+LAkMyH89b1pOOKuYw0GqZnmzOWoi/mvU858
         NZAfaS/C3YRGP9v2ur6mW802RTSA6U9EgzqAWr0f3K5ECHUY5AtXKj4E+DYMkF0q1FqS
         W6nuxR/QXS15ADMMKR8SsgAxexJFI8AmaDIIgJ7qREnUMmSedb7+FRrpFLMORHVNjyXj
         bnNNEVYWA8jiVKzcrIlD/56LxHop5ACAuM3y8DxTcJNKdYjpPikEEXRhY2+rPCoqRInn
         xmbA==
X-Gm-Message-State: AOJu0YxorpPx2q8maKQ/pnmKxBzZH+uPG0oTdgaItoOhZddKmIhj/qvY
	mADgkO58p2jSSpsCrC7I+7AmKqaAQJLSRs/JMq2xPr0Vve18r9ANvSkYOVByhL4VtBJJuXgn3ul
	RnHq8yhj9IMtz4A3819ednmtcJkfKA+U=
X-Gm-Gg: ASbGncv0dSS5cxhEODo/74jHW2uDQSu0hotqjTrVqhsrmc2Bb1cwZmF8XQJCvronRVL
	p5wEd0ea9KgwzYMj//QYCGMB0mIt1mjge4mac6efLiVYjIHBv3J2egx98ITAhkusTq/eNFMWZpV
	fP25XWTYEJ3pz/UTW6l9/aM377lkmXs1ccKq+l+/N2hlzrJ0Lvze0G0IAIL3hh6dEw+VTbhdzb0
	hTbxLLU2OSJr2eu8m1/gYN/AJpL7/2RmRt8pxordKAphFOf7zrmkdQ7I1qv
X-Google-Smtp-Source: AGHT+IG/dN6zvZqsW0OdR7QDCo1V90vHvvKNaxbAtuxb51eq9XzcaiuivECud599UAl62Cb3osddY+RXONgelTJz0k4=
X-Received: by 2002:a05:6000:401f:b0:3ea:fb3d:c4cb with SMTP id
 ffacd0b85a97d-4255781ec0cmr4273967f8f.56.1759369064909; Wed, 01 Oct 2025
 18:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop> <20251001144832.631770-8-paulmck@kernel.org>
In-Reply-To: <20251001144832.631770-8-paulmck@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 18:37:33 -0700
X-Gm-Features: AS18NWBgVlCvZ9l0ZgunWqeXdx6ozQ63phiSdeymw8QQUjFb87BpmWz9Dq8KGY4
Message-ID: <CAADnVQLozKuSPMe4qUDxCV6pCSQ=rQNKy524K7R=uM5yTpLV0Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/21] rcu: Add noinstr-fast rcu_read_{,un}lock_tasks_trace()
 APIs
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 7:48=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> +static inline struct srcu_ctr __percpu *rcu_read_lock_tasks_trace(void)
> +{
> +       struct srcu_ctr __percpu *ret =3D __srcu_read_lock_fast(&rcu_task=
s_trace_srcu_struct);
> +
> +       rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> +       if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
> +               smp_mb(); // Provide ordering on noinstr-incomplete archi=
tectures.
> +       return ret;
> +}

...

> @@ -50,14 +97,15 @@ static inline void rcu_read_lock_trace(void)
>  {
>         struct task_struct *t =3D current;
>
> +       rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
>         if (t->trc_reader_nesting++) {
>                 // In case we interrupted a Tasks Trace RCU reader.
> -               rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map=
);
>                 return;
>         }
>         barrier();  // nesting before scp to protect against interrupt ha=
ndler.
> -       t->trc_reader_scp =3D srcu_read_lock_fast(&rcu_tasks_trace_srcu_s=
truct);
> -       smp_mb(); // Placeholder for more selective ordering
> +       t->trc_reader_scp =3D __srcu_read_lock_fast(&rcu_tasks_trace_srcu=
_struct);
> +       if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
> +               smp_mb(); // Placeholder for more selective ordering
>  }

Since srcu_fast() __percpu pointers must be incremented/decremented
within the same task, should we expose "raw" rcu_read_lock_tasks_trace()
at all?
rcu_read_lock_trace() stashes that pointer within a task,
so implementation guarantees that unlock will happen within the same task,
while _tasks_trace() requires the user not to do stupid things.

I guess it's fine to have both versions and the amount of copy paste
seems justified, but I keep wondering.
Especially since _tasks_trace() needs more work on bpf trampoline
side to pass this pointer around from lock to unlock.
We can add extra 8 bytes to struct bpf_tramp_run_ctx and save it there,
but set/reset run_ctx operates on current anyway, so it's not clear
which version will be faster. I suspect _trace() will be good enough.
Especially since trc_reader_nesting is kinda an optimization.
