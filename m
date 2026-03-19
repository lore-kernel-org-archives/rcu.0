Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C73EF0DC
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939621; cv=pass; b=ZhBnDsJ9oQ6wZbzLlPlY9V+aYobFJB2Ay+VQU/jPFJb94jATsSB8XtxpehZDnkfGeAgLWhGie3xMukPAQifuIH4v01Mo6IplG5WUp14IJ2iACIHiumt7lY7M8NQ0ysbrkY+cDBQgrdSqFxNZaASlQFk5fefRotdMzFB9VpRd7vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939621; c=relaxed/simple;
	bh=lEu0ZdZk+7V+A9EsVEIVTY8OPXiuqCJAQfImiRMh+Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzk89S/VSexOvohWpBq5sUgvZgoUUHzBBjke3gN13r3+NtJ2l3DzAw4s/RASseXrPpDhy9SBR7/Z4sFEps7nNmXhFljZDO2ZRWEbCMgXB/dNUDwwhLG0/UZzS5Jh39SNjsfAlSNI4qIb1doYYUOmG9a29XcK9lW6uY5a1QtAHU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWzFia0/; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWzFia0/"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-486b9675d36so7890395e9.0
        for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 10:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773939617; cv=none;
        d=google.com; s=arc-20240605;
        b=cMMIcCUs5Yj4abYNxpJfd8C+qo5Sntmb5XbYQEskNzd+LCXCDaxAxjF5rg6OmWugjV
         BOFm0z+//Sg7hx1vZNE/7OSk8uVc/w55jYvh7Ev9q7j64wycg+HbeQ1OpgnoC7jKc8Zy
         MGSBTJ+RDu3/1+sn8ZYbD7iaOXa2p8XddsZgOb/2KlxYVQXIj/9sZSP3j2qoPZ5V0fpD
         kwQaEakUuWxfq5S6pnmNsmtrpNTkDuzAOEVFKCnnkVttoXRM8In+l1Oz6ubmnVN3Z4XW
         jzMgHgCSNgiN5LpPXxolzKQKEVj2U6BEfL7LH1hgCjbCaOlEf0ajYea1G79R5cf+85AS
         /b+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lEu0ZdZk+7V+A9EsVEIVTY8OPXiuqCJAQfImiRMh+Gs=;
        fh=+7TfpdTqZI583YR32VNuiaeB2q/Arh8NPSNGbzDjoGY=;
        b=k2OWztMguLOAAsmk5fsInk85/aAyZefpylznVOLWpxH9QXuRBikT4wI3qvZ2q0bvt+
         UKlmXTEScEtR7UjI9/kwkwdYE1obKf+HC6g4R8WbC9n25LCoZr1Jklf2LdAYd+wHwIZT
         fu+UoRvOjbtQuoYHuplTZRUkaqMtcr39MI3UGqwVaXPGf03r7DDLAkz0SL8Se82Nbatr
         NJp6/3I6l9C5Ax7jVSrQfESdauzVNkX7U7o0hI+QbBuRNEO0RqA7AxxoIa74roKzwIoe
         UsClHzvXteYdYeinaPOPosm9Phpt6BWrvBtQVmALAjiT8cNrG14zsSyrKcTJ26ZAG07y
         dtcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773939617; x=1774544417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lEu0ZdZk+7V+A9EsVEIVTY8OPXiuqCJAQfImiRMh+Gs=;
        b=AWzFia0/drdkBWEEn0BE9nWZTbaJ3TPJ+CZCrBM/lFUUp15ek9EsZOXCvCZb/GDUuu
         Yz9H25jz986oGfu83kG3rw1bBy2DYu3ppcensHZ0vCdKpLZAhGBykQ9GBU/AM5rqb9Tp
         wBLiwX4MzGw1aHWrmxnYqKlpqj/C6lKgWw1yusKF2JNG4OOdo3gZS6lvV+ZJJ4ok2RDQ
         YQ++gS16wxyowdK9ZeKj1jQouKaGP2HFRsRWcDoSBv4TdPchpT5UKG0mPhHr7YXp1wUc
         nqDyVTsAttdOsTEZkVkVJF+NYfuZ41jUGlamOimDqzSesjLzCO+xLKYJ64waJGrMJHES
         uYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773939617; x=1774544417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEu0ZdZk+7V+A9EsVEIVTY8OPXiuqCJAQfImiRMh+Gs=;
        b=aW8eO8TnoOpE/GdVkcWQeNwVe6hUgtVC0gM7DDC+DUfqDM4kXAmh1ZR31zTumY9p4l
         P2UzRJu/avRJUAp8Zjoalw+IGTA4nS9F4uXpZ7ww1x3q8eAdt1Zsq7fqF8Ixb6h4Iiy2
         JABREAaaK791+h85BZYMb80G6OstPr38wU28GLsELiGxhGA7gDisKKcByM/Fo/fllBKG
         k7ZP70FjAbSXEtZWfR17MwEFK3n/M2+5SvAafSzshg09DwLmRH7pK3gZCdlVud6tTw1v
         9dXu54TYloLtCEfrhpcplZycbja1TTWnRUugg0v7Enu/x9FhOn8H2sChenw6eATM7zXW
         6Dtw==
X-Forwarded-Encrypted: i=1; AJvYcCXx5vQ1QqzokRbGzNeziswrHHOk+jzf8SKxE4dnjpT5OaCcAKkpzRqslRp2m6Gq/MILfg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQb9htg51HEU4Snd8cD60xdU7kehAXGTX7aVupw53LmFLoVDks
	zM01l16Y45Nsn+iaZLSfcsAt8NeBDFWhZMofGS9K03LhZApGTD42eutYYeW1byeznkvdweVyGqk
	xrLtHftsEBVlF7LTbqfgWnrHv7Qzqu5DVXLQAOrwWoQ==
X-Gm-Gg: ATEYQzzi2luM73G6OqqcE7erSQ8l1gbh53szR3gXjQ88jGP4wGXzY7NQwzG09S3p3Zc
	1bmczyW5NT0RJzqhgawHKXUMg2mKrk+J7wQo5AiuvV8WZG1Isp5aeHalqc9Tug4X8U9eIoCYdvv
	JeAay7w7PyHRzwV3+ApdpJu4ENF7gi+uRIgIpGdBriIoUWm5Ejx8hZXaaqvPEr8ht6WKeDYl7ir
	5gEqmOrd/tSBLlSAj953sWgY7hNxWgvMNObbZNfs7TLeMKqcHEWswkJgkw0KMxFSHC61Iyf2dEp
	vDnPXuMz7TOZmeeR1Nj7f9449zqnb/qaH5Qbwp59LLenvnRn/y3T0+XvDmF3+Z/7kovSEeHK71g
	/TdXJkA==
X-Received: by 2002:a05:600c:1d10:b0:485:3d3e:167b with SMTP id
 5b1f17b1804b1-486f441fc5bmr135256825e9.5.1773939616711; Thu, 19 Mar 2026
 10:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local> <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local> <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local> <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de> <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de> <abwo0I_mu94t5Ews@tardis.local>
In-Reply-To: <abwo0I_mu94t5Ews@tardis.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 19 Mar 2026 17:59:40 +0100
X-Gm-Features: AaiRm52CqAzq_bYhDhK7AY8TG1ghElKl_vIl3ULwU0Boa56a8p9f0V8QgusnIKo
Message-ID: <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace + PREEMPT_RT
To: Boqun Feng <boqun@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com, 
	boqun.feng@gmail.com, rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Mar 2026 at 17:48, Boqun Feng <boqun@kernel.org> wrote:
>
> On Thu, Mar 19, 2026 at 05:33:50PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-03-19 09:27:59 [-0700], Boqun Feng wrote:
> > > On Thu, Mar 19, 2026 at 10:03:15AM +0100, Sebastian Andrzej Siewior wrote:
> > > > Please just use the queue_delayed_work() with a delay >0.
> > > >
> > >
> > > That doesn't work since queue_delayed_work() with a positive delay will
> > > still acquire timer base lock, and we can have BPF instrument with timer
> > > base lock held i.e. calling call_srcu() with timer base lock.
> > >
> > > irq_work on the other hand doesn't use any locking.
> >
> > Could we please restrict BPF somehow so it does roam free? It is
> > absolutely awful to have irq_work() in call_srcu() just because it
> > might acquire locks.
> >
>
> I agree it's not RCU's fault ;-)
>
> I guess it'll be difficult to restrict BPF, however maybe BPF can call
> call_srcu() in irq_work instead? Or a more systematic defer mechanism
> that allows BPF to defer any lock holding functions to a different
> context. (We have a similar issue that BPF cannot call kfree_rcu() in
> some cases IIRC).
>
> But we need to fix this in v7.0, so this short-term fix is still needed.
>

I don't think this is an option, even longer term. We already do it
when it's incorrect to invoke call_rcu() or any other API in a
specific context (e.g., NMI, where we punt it using irq_work).
However, the case reported in this thread is different. It was an
existing user which worked fine before but got broken now. We were
using call_rcu_tasks_trace() just fine in scx callbacks where rq->lock
is held before, so the conversion underneath to call_srcu() should
continue to remain transparent in this respect.

> Regars,
> Boqun
>
> > > Regards,
> > > Boqun
> > >
> > Sebastian
