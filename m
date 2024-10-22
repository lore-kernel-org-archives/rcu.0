Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0426B1A726D;
	Tue, 22 Oct 2024 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618168; cv=none; b=UwjpXPyrkWjZjDbg3/Qg1Qlz1F/gIMWk/lsV3CNpT+93Yjt7viAwfLRACJ7VcQdpwavPcgxFhQWpILYt9hEoTCqeuY6QWaA7Artmp408WEpcXqZFFKhNUU2RETHu5osdHGAqEVUNZbm2FZqWcEbwLL78iCIROQqSHVbhQI0dcx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618168; c=relaxed/simple;
	bh=m0Nwo0+i3YnOzZq93vl1VFUzbNQLAnEr6HkebnHRbpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8f8X7YBoSoO16OV3KSfPbufAc2HL8vfIwUey3mDuo6dH3odMk1GU9Yfn1ebbuQ9Frf4W7P80ifYkHdz10QX3eeEEG83Q7n89aneP+wcgqNxVEguBUA9tVprQIAk6AQ3v9OUWKDEYimkpAeYy88R9WzQlQJotrxqYuITvVTcXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGjoowiw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGjoowiw"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso4188870b3a.2;
        Tue, 22 Oct 2024 10:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729618166; x=1730222966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qDFTq1IwR3EAOCiFBH20Hns15lhdahsLn6F0YbvNyY=;
        b=YGjoowiwRpOeSTh0tXqs2g/pQq+I3xIgynjHX6II1zs4/dDEXpbahRxl6yqec22YK9
         4Dj+Slgzj144rWEKHSSC2ozwzLdnDcgXRCzKBMmjvlvaPWGqfFxDHxX4ehuTIO/1JIYr
         DZ2gSgmVkG0+vMTiEPFPfSg6OUYwaN1tqyb6Nb4MXenOKpj7jiI4qZfhfXT9jpozN6NF
         5C+3sglz6JMWODZoN/l0rHONYn+pPHSkXFYT6hBKu5PPTcWIOOmlPajy+lDz/M/vjSJE
         RM8cVju0F2BsCjM7vcE/5f7dPgBpaZTcqMagsOMXnjJgHPuiDPDZqHtix79TCZgX8QMQ
         kaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618166; x=1730222966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qDFTq1IwR3EAOCiFBH20Hns15lhdahsLn6F0YbvNyY=;
        b=eLwURGLlAv3/pbyf4iuCv78PuSEKFe/xsOtEj4lFLw8+tL4JX7xIuLUZMCWk8bMSuZ
         c5af6RVoluSEF5jPi3kWXWLfP9MXAc9KSECC2eWOd34P7QaFq2k8OcMnKoScFS04XU1h
         PfGiLKPlj/9QI293XiGuJsHi5rSO9fW60uQde9XXu63WCt6WpXi9DgfbVjYaFZ/GC8DF
         Gv3UcTFczjqlqQENyV9iwz9sq+hh1rL5ACF0DR6S0TJ9MGQNk3Y9yY74V5cKF17YxpQd
         V7GWjtgMHmk9OeAD7cDMliISM2uLeOz/3pXi9u/Im+lVzAOYCPMCR4xcZcBYbBek2nTv
         8Vlw==
X-Forwarded-Encrypted: i=1; AJvYcCUrbSSJVYDp4Phgf2ex0nOuxF7B5nsgGNOEgCbxb8UHILSEy1z60yCGpnzsGJlf+Jl2Qxt6UT1VsGdVKrE=@vger.kernel.org, AJvYcCWZClFzmdowN378mLDBFtBhA8ZpVC/6s/YJkD0N70utgpK3oeqP16hE317uU6Gt4NPlLtwS@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBeNagVxuYi4T/fq2fffJB/e4BS34hyaulv3vodeVuME+O80t
	9KgYz9ov77qJfYhZMZIlFmGfD8x3bxhs7BLVrjCnhcNmvXjVkeVFJv5HubqDI0Qtt59jY0oduvm
	T8DyVSEX3B0UWDLGzJ6b2QCB/ibU=
X-Google-Smtp-Source: AGHT+IGk5ApWtGrmJSdKF8uzT8Dslo6RcY1GOrRqFYXBm4Tunrey1WFYDqEF5/P0ItYRwDCarpd7vi0nbJgYjJnE+kY=
X-Received: by 2002:a05:6a00:10d2:b0:71e:587d:f268 with SMTP id
 d2e1a72fcca58-72030a070d7mr17997b3a.4.1729618166122; Tue, 22 Oct 2024
 10:29:26 -0700 (PDT)
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
In-Reply-To: <8b2552d8-0453-476a-8606-e8b761934783@paulmck-laptop>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Oct 2024 10:29:13 -0700
Message-ID: <CAEf4BzbyctiXq8L5MQmCtVqGSN8uawUmNXJMm-X8jDcp8QQ86g@mail.gmail.com>
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from srcu_read_lock()
To: paulmck@kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 7:26=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Oct 22, 2024 at 12:13:12AM -0700, Christoph Hellwig wrote:
> > On Tue, Oct 22, 2024 at 09:10:18AM +0200, Peter Zijlstra wrote:
> > > Ah, well, the thing that got us here is that we (Andrii and me) wante=
d
> > > to use -1 as an 'invalid' value to indicate SRCU is not currently in
> > > use.
> > >
> > > So it all being int is really rather convenient :-)
> >
> > Then please document that use.  Maybe even with a symolic name for
> > -1 that clearly describes these uses.
>
> Would this work?
>
> #define SRCU_INVALID_INDEX -1
>

But why? It's a nice property to have an int-returning API where valid
values are only >=3D 0, so callers are free to use the entire negative
range (not just -1) for whatever they need to store in case there is
no srcu_idx value.

Why are we complicating something that's simple and straightforward?
It's similar with any fd- and id- returning API.

Marking it as u16 would be fine, but unusual (and probably suboptimal
due to common u16 to int conversion).

Marking it as unsigned int would be bad, because it implies that all
32 bits can be used for valid value, making it impossible to use <0
for something else.

Just documenting that valid int values are always >=3D is good and
convenient, why not sticking to just that?

> Whatever the name, maybe Peter and Andrii define this under #ifndef
> right now, and we get it into include/linux/srcu.h over time.
>
> Or is there a better way?  Or name, for that matter.
>
>                                                         Thanx, Paul
