Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AD3A7F6B
	for <rcu@vger.kernel.org>; Wed,  7 Jan 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807499; cv=none; b=PqKTZ9KxN7E9nz7PeTH0tyGlBmgcpYlC5e2sS2kmNvhUvxu6JOodKmtWPfdiSJTNv/QbLQd9Cxv5qPMG+CG/40g7Y+qsoc6BL427o/ZIUazB9DRjreNH+lBUsNQ3jO2kK/MdsGDHSf5y7ht8KMTXs792cZTmnycDdao3TEmVNUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807499; c=relaxed/simple;
	bh=dai0JxbhtkNUSVHfzCrnopP3eftyTSKVJDkB5Ag+2gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQeU9LPk+BkM/61rHndlmzHLN2abJftETrJrc+Sc11htP+Ien8q/8jBBhD60h+ejjcPmXtYglWMWpbTLrY5zB8JuxArsK17G5U5wqX/NF5ry4XNqppJml4W/66exvUE8sxRhZNPILCMrtDYOhIhEODjAT7P1ep1pAnglKGNRr9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOd8qmqW; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOd8qmqW"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-121b14d00a5so158049c88.0
        for <rcu@vger.kernel.org>; Wed, 07 Jan 2026 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767807493; x=1768412293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dai0JxbhtkNUSVHfzCrnopP3eftyTSKVJDkB5Ag+2gU=;
        b=IOd8qmqWGx5Q5yg9L7B/wPzaoP34s68EhQ+45uAbOK/naASmQD283WG0pK8ThQ0KKT
         aw/hPWjvPc5tYEj4Kc4Rw27yOdtMb3d2sOlqQd/vsxr2EbCVlCtXXwNwL/yd9mLjYZGb
         cPmhV3PuiLjOVmLGkoCtsrFMkg9VZVk1HwXk4lKA553bwxneezZ7sdjdTBQ/d34ED9GT
         Io0hFashX2J2ig5M6VYzGW2brk2GDDFokso7huQ0q0X7133QkxcInsglvO45GkWvDtG8
         m2LVfCPeCwa6FRlQd+5ml2KcFux++W9mcG8/Id+o6Z2eXp8Oo8/cZfkvJ9ucG5DT8Gk8
         ZwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767807493; x=1768412293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dai0JxbhtkNUSVHfzCrnopP3eftyTSKVJDkB5Ag+2gU=;
        b=HLl5/ckiwXMmatTHzwWoTMNLHBJK2C3VFUfuGgaN1SalCiHAPkD5QTngBIhgTj1+O/
         gRLtq73qKSSAbenkklWlFUmnJ8dbcph0HIM5ZyxPEx2l2L7C6QZPw/yindKfZUi6RoFU
         a6ZbvhW4RthL6oh4nSkfI1cypEUSAbUTpyxzfxLsaXlk/ss0hqc5F7sTqW15ZuDb1xCV
         yWZnKDRoKF/vitRbjyekOYoqa8WSUaonTWq3DD5mu3v/a0oTx0krcZIOXLX1WXvsXmBb
         r1Nk9dz6UgdmdFvGneeVywQSGGQgRQbRdxHe2+rvUfrYFfcOGvFfNmim1kLzjpq8TTbo
         CRAA==
X-Forwarded-Encrypted: i=1; AJvYcCWVdhGdHnzqz69ULLVU9de3D15SRzcv8g1r0cBp4AsV5DFBSYPmo4J20MME7h7mEcs8t9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9BfZ5dmh41IfwqD8j013F7xI8DUpWkmizBIaC2bwgABn4/Eu3
	+nM0KIxQ5s2uNWJ+imhwJlMm2pCn3RltR0oR/aUca/vPx77aHXfNP90NJwb95XTc7CUi8cH+F6a
	aP154Ykowx/Pw+878uwScb6f2YGyW7IM=
X-Gm-Gg: AY/fxX69naYEJAjNiN7Qpv3D+O8eUYUnTokS2mHq/OLC73RSjnCCccRZgLBLp7D2MDd
	vrOkyz9WcSmzkbg9hlTRKJBxVpLfKZgTDetAQT9IWTL84XcQi+qkBsa091hkLZf0Cp5E/LzV2zR
	yPwGBJSNwP2+k4xi0BMBd55ZcLZdIj6O3QfZdT4js39YEXSw/k9+GjaiJ1VlBE3Mvgi/sGsrqwq
	BOCwR6n60lKQgHoEb4eSMX4Zsz2DZoZd8aqg+ROXJazaGz2cH8/7Dvsc4txISF8aroiosHRC44/
	ul662P1mF9FE0AzE7qYaXrBzX+8lQ8p1fHnimSxzATG5fVnRuzE/RbYDBHDrlAUqKN7w6BAJwsz
	23JyRC6tm6MWW
X-Google-Smtp-Source: AGHT+IGM3CJ6rtoXkbS1gqw0JneRH0rWCzxshK8igUVhgyP37LCW23SucegWV0VjMr/tA1v0YCguyHEB3GP0478A79I=
X-Received: by 2002:a05:7300:dd0c:b0:2ae:598e:abea with SMTP id
 5a478bee46e88-2b17d30fd2fmr968807eec.5.1767807493047; Wed, 07 Jan 2026
 09:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5c5c0a4-249f-41b0-b5f1-87a58514b120@nvidia.com>
 <8822A0A5-CD4C-403A-A001-F4E7A351D81B@joelfernandes.org> <CANiq72mUCGL3f=GAYSZfMV1=NXpOjz4vsV7B3Pd-=EG8tmWC_A@mail.gmail.com>
 <39e74621-aba6-47eb-9935-0d2321c56d6d@nvidia.com> <20260107123159.7ac61d69@gandalf.local.home>
In-Reply-To: <20260107123159.7ac61d69@gandalf.local.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 7 Jan 2026 18:38:00 +0100
X-Gm-Features: AQt7F2rwFEKJSdRzkzLSCri3PhwRCqQPNRRr6ZPmL34vxqGv6L7SqzXqvqSjVP8
Message-ID: <CANiq72k6xengESGrJSELV8OtOwaO2d-DO0_to=WCu8PtfhH3mQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update email address for Joel Fernandes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, nouveau@lists.freedesktop.org, 
	Boqun Feng <boqun.feng@gmail.com>, Paul E McKenney <paulmck@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, rostedt@google.com, Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:31=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> This is why I prefer the "(company)" in the email name and not the addres=
s.
> It allows developers to maintain the same email while they move companies=
.
> I did this for Red Hat, VMware and now Google, and all with the same emai=
l
> address.

Yeah, it is simpler for everyone else, indeed.

> Although I may need to switch to my kernel.org address because my
> goodmis.org is being blocked by gmail :-p

I saw your post in LinkedIn about the pain... :)

But yeah, so far kernel.org is smooth (knocking on wood).

Cheers,
Miguel
