Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423B1B85E2;
	Wed, 23 Oct 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701280; cv=none; b=dCTgu1MIoam9Y1rH4LC3vb3PsNHvr4V7WNuFVZqsSYAN88h6upyaC+VCrv/KkfNBA2qCZ+q2usPG4dE7wrfOYUArod8uhUWImvFrHdkaMuGVg3tNiRG/OUq6fRou+4ytuZbhg2s/ur6QpR2NpL4IlISKb3wFMVjNNBOnM1O5AIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701280; c=relaxed/simple;
	bh=DQnLT0cqsI10tAQuGYshiGpPshKjWjBAqW+Vp0oACn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwM0wo7elEvD+Mgnmkyimfds1cMbEW1Twb1ECppdyHmTiqxKwTIOmUOmSgZoUAhZ9Nyj96KWRO8S60g87Ajn+Sa4wJZ7skDKS1xb/BmNyXjURyzaWseb9udhDmx2Zqvy1ASUsG9GIzwj8H+YcHAl8JJ09LfhuVFTlgoc+tUkPCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDnNXzZ/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDnNXzZ/"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e93d551a3so14047b3a.1;
        Wed, 23 Oct 2024 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729701278; x=1730306078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsRZDl7FXLxYMasnabpJGQaZwP5jw5alDM0gxUScWa0=;
        b=cDnNXzZ/z7pQGl4AYyJGTMZZharxWzcbG0yzWCJN3IX7zDJM1AbVa1sD9L/X7vlWmW
         7knWCe+WcDPG53OIr9D1PHypX1HBLnkY6bdcHAR0Hlz0NvU3sVqs5qZsTgqdAW9k+vsq
         LeC+jZjqlSLLDYe1gdMIzrjhlsB8nJN1diyYy1y+xV/FWSJQm/J0TJu6sGaUcQOvuNaA
         NDLCy+2y3iJHbeXGnwXwSCTZGIP9ak749RhO/1jFbPZ7PY82c0OzlAfHOQiTLCB3IwpC
         vAakgzzvn+YaC/nsyWKV+VFwGUxJGyzuekme6akqmeIF6bMHUVe0zbSxawB85bUaz+UC
         gKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729701278; x=1730306078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsRZDl7FXLxYMasnabpJGQaZwP5jw5alDM0gxUScWa0=;
        b=A10MpEIZ4SHla4ePZTHD+Wc+2VACKkWQ1OTQYyYBcJawuIk2gQU5/G8Ti1tZUIRa5T
         ujY+QIIMawkpIFCI9CnNZQeQdbaR1ihsrhQnJ1hIwDPWoaww66Rj5RbEOlc9tXj9cKOO
         f2tmhCHCDE66QDwhHR4RVZi0fUllBgJDjZByJ+vBOlMw0IpLo5QRCVmNTI3CFyFmoki+
         wUZDSSN38hbG//ZefysGf8lbUd6PICLdgWkSrbROnEn4B00VR3U19KKiJeorjJ09ja8J
         wXu1+wdi/QYbZFHiMv7zVbTpAcPaWwOlDrZ+dadmI8VBxPSDZG0VtNFYKFrAwdnbn+ur
         reWg==
X-Forwarded-Encrypted: i=1; AJvYcCV/G/UT1/sX1Efjk1s0sp149Fv1syjMM43pTWtzzWM3iupWunmqP9eeiEnC6VGCj5c6fH+gS6n0eWsqppo=@vger.kernel.org, AJvYcCVG+RuPHlGvz96nej2FT+PK4JrSUA9wVSseYr/5tnokBbEeLrcMQ0Poo82/wuQ3d30XtIG1@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlENWMGcvobQvzmYcLTw9hGzXiUVR577X4vBGyOuNKRWGGp2h
	ij80QNa67AeBGmpf6d8F7KXSfTGIqgLUMX/pBRk/e2IpODvGYOYPYUloULO28n+kIt7ig1unzbi
	lwl+s9fU8vWLCr7yhw/Fem/DfTfUd4w13
X-Google-Smtp-Source: AGHT+IHGywkJMc+BTpjs1ZSHLelIEAgkuJb5pUjrJorVH2MAh9RIMlCFzVJB6t5SXmtSpKyWAPNvoaJ9VwDv84ShLz8=
X-Received: by 2002:a05:6a00:3c94:b0:71d:f4ef:6b57 with SMTP id
 d2e1a72fcca58-72030c9d618mr4186710b3a.18.1729701278308; Wed, 23 Oct 2024
 09:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <ZxdLfLWWrAEfRiXV@infradead.org> <20241022070635.GY16066@noisy.programming.kicks-ass.net>
 <ZxdPN6wT1LMyLaNL@infradead.org> <20241022071018.GA16066@noisy.programming.kicks-ass.net>
 <ZxdQiLhn16FtkOys@infradead.org> <8b2552d8-0453-476a-8606-e8b761934783@paulmck-laptop>
 <CAEf4BzbyctiXq8L5MQmCtVqGSN8uawUmNXJMm-X8jDcp8QQ86g@mail.gmail.com> <ZxiacAA9LIWv70Xp@infradead.org>
In-Reply-To: <ZxiacAA9LIWv70Xp@infradead.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 09:34:26 -0700
Message-ID: <CAEf4BzaqXhq3q5kXSAgH7H3tibC3wFU7R9zr5fcwcddT-r6wUw@mail.gmail.com>
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from srcu_read_lock()
To: Christoph Hellwig <hch@infradead.org>
Cc: paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:40=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Tue, Oct 22, 2024 at 10:29:13AM -0700, Andrii Nakryiko wrote:
> > >
> > > Would this work?
> > >
> > > #define SRCU_INVALID_INDEX -1
> > >
> >
> > But why?
>
> Becaue it very clearly documents what is going on.

So does saying "returned value is going to be non-negative, always".
It's not some weird and unusual thing in C by any means.

>
> >It's a nice property to have an int-returning API where valid
> > values are only >=3D 0, so callers are free to use the entire negative
> > range (not just -1) for whatever they need to store in case there is
> > no srcu_idx value.
>
> Well, if you have a concrete use case for that we can probably live
> with it, but I'd rather have that use case extremely well documented,
> as it will be very puzzling to the reader.
>

See [0] for what Peter is proposing. Note hprobe_init() and its use of
`srcu_idx < 0` as a mark that there is no SRCU "session" associated
with the uprobe. Now, if we say that SRCU_INVALID_INDEX is the only
invalid value, it leaves a question: what to do with other negative
srcu_idx values? Are they valid? Should I now WARN() on "unknown
invalid" values? Why all these complications? I'd rather just not have
a unified hprobe_init() at that point, TBH.

But anyways, taking a step back. Take idr_alloc()/idr_alloc_cyclic()
APIs as an example. They return int, but valid IDs are documented to
be positive. This leaves users of this API free to use int to store ID
in their data structures, knowing that <=3D 0 is "no ID", and if
necessary, they can have multiple possible "no ID" situations.

Same principle here. Why prescribing a randomly picked -1 as the only
"valid" invalid value, if anything negative is clearly impossible.


  [0] https://lore.kernel.org/linux-trace-kernel/20241018101647.GA36494@noi=
sy.programming.kicks-ass.net/
