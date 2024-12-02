Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2620898B
	for <rcu@vger.kernel.org>; Mon,  2 Dec 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152897; cv=none; b=CL3y0CgHL9bqJuN9aC/3VMgrHtLfKBM8E/bnABBIvwNxyV7utKTXcfXh35/8PB/czfNYjuoxA2yK1xng2C/rYh64xoaCe5XQD85K+30JQuI36B1lkP62CwHd3br/HSikwKUw3QqDW87D/3TbP1ysZU8RmOcsPOz2Xk/wddrJh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152897; c=relaxed/simple;
	bh=1fem/pAqlIUnw0gQKE8KwwacxF35hQD/flcACpT6FO8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DgFGuATuDnMjFVkAm/n0+vSQ3NhI+hqk4Syz+GXpa4JjsYsQiQkoXd0dk+fqA4gjJwRAT3KM0F34f5mdV4czEhN6blwlm5GAKKN+OyxpH0egvB8U+x+NlNI6C4TYpMBhw0FJx9w5S8SVJ4j+gBaSyPRVuXyadBI8KxYEvgmYURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVVePnS7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVVePnS7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733152894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1fem/pAqlIUnw0gQKE8KwwacxF35hQD/flcACpT6FO8=;
	b=EVVePnS7GKygekbJWc7IB6daIUt24KW6t+xRsVr3/OKkFYMsEDesb4gJHNEChiGYfePAf9
	axqMLKvgIs2xV4E2gRL693V7eh3L/WzqheejSoi0NMyhiePc5lAkhSYCk5mZSG1NCVon+i
	vdPosSVcm0bRaSez8ygLeak194m4ozQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-PTrci_6WPRuGq9KQOX9EsA-1; Mon, 02 Dec 2024 10:21:33 -0500
X-MC-Unique: PTrci_6WPRuGq9KQOX9EsA-1
X-Mimecast-MFC-AGG-ID: PTrci_6WPRuGq9KQOX9EsA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385dcadffebso1499518f8f.0
        for <rcu@vger.kernel.org>; Mon, 02 Dec 2024 07:21:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152892; x=1733757692;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fem/pAqlIUnw0gQKE8KwwacxF35hQD/flcACpT6FO8=;
        b=KELiut8W+HYo3VFl8PQj8D6ppKyZ/YYDfggwCgaIVzchAOw4KPH/IwXc8mfmb3Qf5g
         hzns0ClFKH7utgdb0ahfvV7RucX6gIujNY0Aa9aZyn96rFRJwPHKR4b+51al1YEOQDsK
         ZbDX89vyqe1kefWTllkVAQVVzTAkP7eWbbOES+lS+Thv4afzQc7mPAJZf0gv0yOVe68h
         uMWrpatN6zD4UXxnh9+A6i0fhAOx99qtJBfH2dikHPWIzMRVgqO4Q0vUls/Ata/o/slw
         xKIT2UX9focvVH3QTbmZKfmlIsoQ8GKdGp03kovmM2K4Ku/06YPyh5DyFJKRCk0nfepk
         Qklw==
X-Forwarded-Encrypted: i=1; AJvYcCXkF1GOREUrQCLcH/mXKaOlbOs2Gw9ugml/RoPZiS2+Mo5QWEmkEmDV6EbL00RorysNMNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTpiZM7KYjL71fLkv4I48jez8yd4WuSHD713ICvRTNDvnEx45t
	G3FnLnCIuNzHVsq8LjXolDMKft4HoRw9yrr+9X0XoXf19Wvobn9nEglE7KkFCxrUvKQl/MFHtzY
	9IDqlWPgnVbSDFvWV5DtIfHKEktPmPBqYwq8hey3wglany0C3XA==
X-Gm-Gg: ASbGncuCUc+68aTvBIQb9MR2HrcQBdKmPaPcwIT4N7XsCXrY8ldLfZvazTbs0eembzr
	BfwR1C33KxvuBJgYF3bVr40rFXbTon/bCza5q2Z7y+FbYuSlGYrW2Y8mu4eVL5l6B32pwFWubvv
	Qru9AMfOynHiBYS5hDlz660VOhHioC8H6wPjyWPRSixwOe/+D8SGLcn8CPndL8X6jiwlodRu/YS
	tCVK2Cr327jxgjXhIiLttUVZHamBtZtThXzKEvSFDbg7tU0dTVz2Ahmwshu5ZWbJkgDdKhTMoY5
X-Received: by 2002:a5d:64cc:0:b0:385:f092:e00 with SMTP id ffacd0b85a97d-385f0a15378mr4069207f8f.50.1733152891893;
        Mon, 02 Dec 2024 07:21:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG937D3RpnGc/LAGI91biGTa9y9+eoHkJjLKa0c2h+zONfzE99nBeAZX56bsUEfuaoD1JafpA==
X-Received: by 2002:a5d:64cc:0:b0:385:f092:e00 with SMTP id ffacd0b85a97d-385f0a15378mr4069172f8f.50.1733152891494;
        Mon, 02 Dec 2024 07:21:31 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd367f9sm12577739f8f.31.2024.12.02.07.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:21:31 -0800 (PST)
Message-ID: <71f31ba8b26d25e3295a2e99803a11eca4e94788.camel@redhat.com>
Subject: Re: [PATCH 2/2] sched: Move task_mm_cid_work to RCU callback
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,  Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: paulmck <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
  Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett	 <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Uladzislau Rezki	 <urezki@gmail.com>, Lai
 Jiangshan <jiangshanlai@gmail.com>, Zqiang	 <qiang.zhang1211@gmail.com>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Date: Mon, 02 Dec 2024 16:21:28 +0100
In-Reply-To: <c16481a7-20f1-44b8-981c-fd31cb331cbf@efficios.com>
References: <20241202140735.56368-1-gmonaco@redhat.com>
	 <20241202140735.56368-3-gmonaco@redhat.com>
	 <c16481a7-20f1-44b8-981c-fd31cb331cbf@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> I've used the same task work pattern as NUMA here. What makes it
> OK for NUMA and not for mm_cid ?
>=20

I didn't investigate the behaviour with the NUMA work, but my rough
guess is that this wouldn't even be visible in an isolated environment
(i.e. no migrations).
Also it doesn't seem to scale linearly with the number of cores.

Your approach (or the NUMA's) isn't wrong, in my opinion, it just
doesn't necessarily require to run in that context.

In an environment with isolated CPUs, we want the lowest latency
possible, that kind of work before switching to userspace imposes a
latency that could simply be elsewhere, even on another core since we
are doing remote accesses.
We are talking about 35us on a rather big system, not many applications
are sensitive to that kind of latency.

> I wonder why we'd want to piggy-back on call_rcu here when
> this has nothing to do with RCU. There is likely a characteristic
> of the call_rcu worker threads that we want to import into
> task_tick_mm_cid(), or change task_work.c to add a new flag
> that says the work can be dispatched to any CPU.
>=20

Alright, taking the RCU path was probably a bit lazy, another thought I
had was to run it in a workqueue, perhaps tied to the mm rather than to
the task struct itself. I'm also not entirely sure running it with the
scheduler tick is the best approach, since it doesn't seem quite
predictable, but I didn't really get the full requirements, so a
discussion on this can surely help.
=20
> > =C2=A0 void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
> > =C2=A0 {
> > - struct callback_head *work =3D &curr->cid_work;
> > + struct rcu_head *rhp =3D &curr->rcu;
>=20
> Why is it OK to re-use the task struct rcu field ? Where else is it
> used, and is there a risk of being inserted twice ?
>=20

The same approach is used in
https://elixir.bootlin.com/linux/v6.12/source/include/linux/sched/task.h#L1=
69
also there it was probably chosen for its simplicity and it isn't the
absolute best approach.
There may be a risk of messing things up, again this was the lazy path
and probably a more robust approach would work better.

Thanks for your comments.
Gabriele

