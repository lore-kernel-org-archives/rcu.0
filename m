Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27591CCB31;
	Wed, 23 Oct 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702811; cv=none; b=XRhjuRlbCfPfR6jFYBpIk96Nj+he+Nq3QJsq9UXeG07yJ0J2ng0fVyQjroqXjT/YnXxCicNn8zUxpVrGbqxBvTpMay8NeLo8JwyGPieoW7KAviYkERkKhIhHAzUmJ2NvxlHskGx/DgNHjxfNzsFdL5/mNqbjXQRyu4XbkBZC7RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702811; c=relaxed/simple;
	bh=ZcUukSfOP2zGyc+sDHWa0FnktAOjEH0xo3lALvE8A/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+eyXXfRUDD4GZSIxoUXDb172DmT6wTDEAOp03Yv9DzkDvfyUNaDLk+29w/DCfgwxnEFZyEf4X0bF9eoNsXbhKxKQs5h8wREsHUzJm6+k3wiGO3uazDUA4Vk4+j8SFZwFHqGveOCVew5EWH7197Ei6oyoMEz/zPTLZ1J3MdFPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/aqoTAB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/aqoTAB"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71ec1216156so23469b3a.2;
        Wed, 23 Oct 2024 10:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729702809; x=1730307609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrJQNm6L7RIme3BQ48SdCaSWKhjOQNUdndKBm9Hgn1I=;
        b=C/aqoTAB69u+6qgI7DLEPARdPWuFusrtrDzrktaDzHFQu3BR4Sf55M/CoKQ88IjVTm
         mIbw8ab+NUiKc9AWLpk6aXk5z+pHKB0y+AAu/i6ZhJP2Hgju7vCIutdwhRx2E37qgLvC
         YWMIlxgx/VevBNcKMyEZtW3y9sDwWdzgDIi0d8ONFVm/9Ya2dq4CdpjdVvwscxhHsaCV
         pc+KifNFu/EY+m1nn9qht1kSLv6eRmo5y2NZulqS1IbStg3Nt6Q4H9VxIml3rR5WaCWf
         i6F1rrKnRYwHTt12wSCYM1iZSqhmP4Lm8Ss66KMjAriGC3b6hI0zLg57udERt4dPGtys
         PJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702809; x=1730307609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrJQNm6L7RIme3BQ48SdCaSWKhjOQNUdndKBm9Hgn1I=;
        b=sgbocGcqebNOLHZeSafev/aH5hSFr6jDV2r05yeEMqVYHsFTe1nu+KIPEfi0KfGh9n
         1VnlAfAmKHv6fO0vXxYnFXB9afocD5YXEyp2YDkyyfE70apBgEnR5pBdZYvg9FvLiZDJ
         lkDNYF8o3fk7pWxtgRmTfYdJczHdNFGYjSBjQapDZ7XB5IAjUyml+058I54Yj+QtSskC
         /g28SSgk7H3wIMhQeppS4XmrFLnbMgRdxIRbXKmDAT47HA7/sq+ycWODLV78R//ohhvu
         nauYRgbP9Oo+wJbO6qRyBQ8KB9orMcAuYdU2zvqyfz7fxu/TpScJkDL74XBXUbzNDAOc
         eZQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYp+mQ4kdW9Un0O6jdcf3zFnyGvEw3gzRfbneb+KyrSwJW1g74k9SFHFm7NCRjHoPnejDF@vger.kernel.org, AJvYcCUZdQdD6nKw2RWUhMf6+6x6rYUc2MPaEtEmfiD90kaCl0nW2mF4EQd0+NimPVN6bR7IdBhAcE8HPwl1J1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8Ws1qSrbKSWIqbtFmNbn9wmTE7MMCO7YnwyVxpBsdxNL04Rb
	zRA2g9yKb4iG8j+8XlL9q8uGKzL/xlgSyRDWqcXrsIp0ssLpN1CMkiKQIOjWjMe3K9k5zef9LSj
	SK0O87E1bZJcLM06doOKXr+8QbGojJA==
X-Google-Smtp-Source: AGHT+IG2w3ZJFgeGEvqStk6dAoXbYpVMtGJw4IdNZcpVc8CIoANXDtAtfgmspOInzNqg5rBDYXqapwwyiyR92Sk+PP4=
X-Received: by 2002:a05:6a00:14c8:b0:71e:c0c:5996 with SMTP id
 d2e1a72fcca58-72030b96faamr5073401b3a.7.1729702808467; Wed, 23 Oct 2024
 10:00:08 -0700 (PDT)
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
 <CAEf4BzbyctiXq8L5MQmCtVqGSN8uawUmNXJMm-X8jDcp8QQ86g@mail.gmail.com>
 <ZxiacAA9LIWv70Xp@infradead.org> <CAEf4BzaqXhq3q5kXSAgH7H3tibC3wFU7R9zr5fcwcddT-r6wUw@mail.gmail.com>
 <09DF4DE0-1694-4B06-84A9-A0E1DA1B3109@gmail.com>
In-Reply-To: <09DF4DE0-1694-4B06-84A9-A0E1DA1B3109@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 09:59:56 -0700
Message-ID: <CAEf4BzZDWy9=WPV4Xb4CjPuNzEokqR2Md1HjAARQjFmXzMhYJA@mail.gmail.com>
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from srcu_read_lock()
To: Alan Huang <mmpgouride@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, RCU <rcu@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com, 
	Steven Rostedt <rostedt@goodmis.org>, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 9:46=E2=80=AFAM Alan Huang <mmpgouride@gmail.com> w=
rote:
>
> On Oct 24, 2024, at 00:34, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
> >
> > On Tue, Oct 22, 2024 at 11:40=E2=80=AFPM Christoph Hellwig <hch@infrade=
ad.org> wrote:
> >>
> >> On Tue, Oct 22, 2024 at 10:29:13AM -0700, Andrii Nakryiko wrote:
> >>>>
> >>>> Would this work?
> >>>>
> >>>> #define SRCU_INVALID_INDEX -1
> >>>>
> >>>
> >>> But why?
> >>
> >> Becaue it very clearly documents what is going on.
> >
> > So does saying "returned value is going to be non-negative, always".
> > It's not some weird and unusual thing in C by any means.
> >
> >>
> >>> It's a nice property to have an int-returning API where valid
> >>> values are only >=3D 0, so callers are free to use the entire negativ=
e
> >>> range (not just -1) for whatever they need to store in case there is
> >>> no srcu_idx value.
> >>
> >> Well, if you have a concrete use case for that we can probably live
> >> with it, but I'd rather have that use case extremely well documented,
> >> as it will be very puzzling to the reader.
> >>
> >
> > See [0] for what Peter is proposing. Note hprobe_init() and its use of
> > `srcu_idx < 0` as a mark that there is no SRCU "session" associated
> > with the uprobe. Now, if we say that SRCU_INVALID_INDEX is the only
> > invalid value, it leaves a question: what to do with other negative
> > srcu_idx values? Are they valid? Should I now WARN() on "unknown
> > invalid" values? Why all these complications? I'd rather just not have
> > a unified hprobe_init() at that point, TBH.
> >
> > But anyways, taking a step back. Take idr_alloc()/idr_alloc_cyclic()
> > APIs as an example. They return int, but valid IDs are documented to
> > be positive. This leaves users of this API free to use int to store ID
> > in their data structures, knowing that <=3D 0 is "no ID", and if
> > necessary, they can have multiple possible "no ID" situations.
> >
> > Same principle here. Why prescribing a randomly picked -1 as the only
> > "valid" invalid value, if anything negative is clearly impossible.
> >
>
> A IS_INVALID_SRCU_INDEX macro would suffice, you need the condition anywa=
y.

That condition is `if (srcu_idx < 0)`, no need for ugly macros that
obscure things unnecessarily.

>
> >
> >  [0] https://lore.kernel.org/linux-trace-kernel/20241018101647.GA36494@=
noisy.programming.kicks-ass.net/
>
>
