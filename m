Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60962171;
	Wed, 23 Oct 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702009; cv=none; b=h+FXTRqqEOaLL473hmNh5pa+WOE5Nxjn79W0onWINHfn+KbfOrmSNN1XqiVaagxhyA0jwpco8/olqguAAqOO9hgnOA4uotKtU6guAhGSJ+lMMKBoiA29kbN/T90KJvnxLtVW8lak7JueYb/BTF0GCJ8JSIWgf9M5PKNTb8qQcKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702009; c=relaxed/simple;
	bh=kn5ZGlk7ek0K5Gdps0HnkcelsHkik8tEdXHBw750huY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CqFYSVQkRjU7NPNTm4n45zX1yO1OVU075JnIQYjnmS4/bH9oB5v6M9gD9ajfax0CFjeZzXaZLAt00BghvJQt4Ye/OusIUdabH7487sz/9KuCtUDMk+oLtIDVGMW55v4TPzyKO8s9biMmv8fVOXwuJeTxG+Go9dCoV5ym8pMxdiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QePzkmua; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QePzkmua"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-207115e3056so60416705ad.2;
        Wed, 23 Oct 2024 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729702008; x=1730306808; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu0N00bd78y9tBZZj4xR9kjahnxtIjbsWQjHNz0o880=;
        b=QePzkmual9YofOvZ/ooq50/HTgjQyAIKnHakti2gqoKy3RUcv1i78rIzDy54Abdnxd
         pCaR3jPh6UVP/qyn7rKiilc4qRE/0/8SegJE1CSnG+kHuMS3dihgwMjX5U4lTlA2iSHy
         oqc7tEBqWXZ+AV3upt7cxIff9v/ww/MaQxsnIMwma5xXClz4YeUZHK6ckWSqmBxvxh8H
         Fc3mIsa7cmO22V5Nxx+iCqI7XYCWFBazZNkfWkEs5f/8pSY2N1BuAyKQSMWvppixUJZE
         fP0Lxy4cTnw4GunYxxWhhXio3gPPKJicWRuHAHTGGAPqcSQOJYRhTP3j69kf+W8rTaql
         ZpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702008; x=1730306808;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gu0N00bd78y9tBZZj4xR9kjahnxtIjbsWQjHNz0o880=;
        b=gnOAXYGb9rRkQW6Ll1PyP5IrIluqheTHvClavftlZmb+hmEwPDVzQSaLltRf3vZnQK
         hmQr34BGNUe8/EVZs8R5iD2kIwjEeZ/cvs+kAaTF889nI4DM9xX5BXpJcpgGIeqxRNP/
         7ywYhea98VopunERDavE0f0lJq+eF8TuU/9u7EBHbbqz0FcerNBZIS2QUbIW+tetYIQR
         jDRCcaSwlKpKVuMwa4uPC/jlzQ0nSrtKLUL1LdJVdsOmt5q/HF78yDdoD9tWVeBXbYXu
         QlP44mJfzFuhJb7ysjuXGIlPKRcreEeCAVcArETSHMq//aOW2UzrHB6fmR6DUGLyMpjZ
         yfsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxD7EiDoLQF1VUdU8MQmI9Pmoj+NUx9JrdQQfnWv9BpJsvlZ1gUYzWUoAZo1JbCiShyFUl+uJ7l+fPJ5o=@vger.kernel.org, AJvYcCW+vHJdtfnqgP1LBBDm+wd6qWZZ4/tFqQ6ThsHRBJTJlyp4ixVHAneWmSvcdr9kIHRtpPu/@vger.kernel.org
X-Gm-Message-State: AOJu0YyNr7ghfq0mkefeqDwx22lnzgL1N45RaQr3HAbvv91bKYffQ928
	1judeKoL49S84VxRuiKIAC/ABUqGeSH5fjX5Bi7JWIm3EPybDDj0
X-Google-Smtp-Source: AGHT+IF6kLkgcwRhc+IcJ3YxlaV+iE75CPwrx3HCRv5aGZLtkxjtTWU+h57RUCDyWi8KRWqdQdXZPg==
X-Received: by 2002:a17:902:e054:b0:20c:bb35:dae2 with SMTP id d9443c01a7336-20fa9e5b431mr30251915ad.28.1729702007606;
        Wed, 23 Oct 2024 09:46:47 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0db968sm59229355ad.200.2024.10.23.09.46.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2024 09:46:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <CAEf4BzaqXhq3q5kXSAgH7H3tibC3wFU7R9zr5fcwcddT-r6wUw@mail.gmail.com>
Date: Thu, 24 Oct 2024 00:46:32 +0800
Cc: Christoph Hellwig <hch@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 kernel-team@meta.com,
 Steven Rostedt <rostedt@goodmis.org>,
 andrii@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <09DF4DE0-1694-4B06-84A9-A0E1DA1B3109@gmail.com>
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <ZxdLfLWWrAEfRiXV@infradead.org>
 <20241022070635.GY16066@noisy.programming.kicks-ass.net>
 <ZxdPN6wT1LMyLaNL@infradead.org>
 <20241022071018.GA16066@noisy.programming.kicks-ass.net>
 <ZxdQiLhn16FtkOys@infradead.org>
 <8b2552d8-0453-476a-8606-e8b761934783@paulmck-laptop>
 <CAEf4BzbyctiXq8L5MQmCtVqGSN8uawUmNXJMm-X8jDcp8QQ86g@mail.gmail.com>
 <ZxiacAA9LIWv70Xp@infradead.org>
 <CAEf4BzaqXhq3q5kXSAgH7H3tibC3wFU7R9zr5fcwcddT-r6wUw@mail.gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)

On Oct 24, 2024, at 00:34, Andrii Nakryiko <andrii.nakryiko@gmail.com> =
wrote:
>=20
> On Tue, Oct 22, 2024 at 11:40=E2=80=AFPM Christoph Hellwig =
<hch@infradead.org> wrote:
>>=20
>> On Tue, Oct 22, 2024 at 10:29:13AM -0700, Andrii Nakryiko wrote:
>>>>=20
>>>> Would this work?
>>>>=20
>>>> #define SRCU_INVALID_INDEX -1
>>>>=20
>>>=20
>>> But why?
>>=20
>> Becaue it very clearly documents what is going on.
>=20
> So does saying "returned value is going to be non-negative, always".
> It's not some weird and unusual thing in C by any means.
>=20
>>=20
>>> It's a nice property to have an int-returning API where valid
>>> values are only >=3D 0, so callers are free to use the entire =
negative
>>> range (not just -1) for whatever they need to store in case there is
>>> no srcu_idx value.
>>=20
>> Well, if you have a concrete use case for that we can probably live
>> with it, but I'd rather have that use case extremely well documented,
>> as it will be very puzzling to the reader.
>>=20
>=20
> See [0] for what Peter is proposing. Note hprobe_init() and its use of
> `srcu_idx < 0` as a mark that there is no SRCU "session" associated
> with the uprobe. Now, if we say that SRCU_INVALID_INDEX is the only
> invalid value, it leaves a question: what to do with other negative
> srcu_idx values? Are they valid? Should I now WARN() on "unknown
> invalid" values? Why all these complications? I'd rather just not have
> a unified hprobe_init() at that point, TBH.
>=20
> But anyways, taking a step back. Take idr_alloc()/idr_alloc_cyclic()
> APIs as an example. They return int, but valid IDs are documented to
> be positive. This leaves users of this API free to use int to store ID
> in their data structures, knowing that <=3D 0 is "no ID", and if
> necessary, they can have multiple possible "no ID" situations.
>=20
> Same principle here. Why prescribing a randomly picked -1 as the only
> "valid" invalid value, if anything negative is clearly impossible.
>=20

A IS_INVALID_SRCU_INDEX macro would suffice, you need the condition =
anyway.

>=20
>  [0] =
https://lore.kernel.org/linux-trace-kernel/20241018101647.GA36494@noisy.pr=
ogramming.kicks-ass.net/


