Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5DE336ECF
	for <rcu@vger.kernel.org>; Tue,  6 Jan 2026 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696138; cv=none; b=FqVXxJZv22fkFI4v3dgbbTBSyNlbKnuIHGgYCCsKbWY49OKmiWH9AccSHEDp2XBCP4jccbmFux1y3Qk6XRNoyQJ96Uw1kOLT0tmDsZ5okPkp5kAzQwIpHHouvhnicRkAAniw3XHxxICswIoTgcwviGy33/ww8enqPJUECe6wY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696138; c=relaxed/simple;
	bh=FpmjOprTssmeOm50z49S2q34jiZXmJLBLMFlxmzqyfk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=q6wjBXgPiWSSxsVBAapnZmw6T3ZR78sKecQ849jvo3Yx6nXptIheSfP0XRnLCuXh9bB1RRO4KZdchljj7qf4914ttqtExsxlYCDRb3+T3oydEfvCzCZ6lBj76jgH26Cm9TZOU4dGaNlaSLIbgIc8LkfvdxIvAaTryTwAuNxENdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=dHmEj7wT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dHmEj7wT"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso501284a12.1
        for <rcu@vger.kernel.org>; Tue, 06 Jan 2026 02:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767696135; x=1768300935; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4DHnNlD64p5h6wOoVrrAqDFywUoVYTzLxl5WN2rbRU=;
        b=dHmEj7wTriXidmayV33VEgFwoUvqe4NpA0TwecNdFh4hNJT2cmkGj66SvCQ3N9izvR
         bDgUax64qypkJ1btLIHSp2jpz2lNDbXMOsdEww3dvPCIDvl3OJ4x42Y5Aysr5V0mvX4H
         FR4FV94iYltgNRyUm+aJkTaXYUiZXYmpiPeFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696135; x=1768300935;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m4DHnNlD64p5h6wOoVrrAqDFywUoVYTzLxl5WN2rbRU=;
        b=WpNC8bnjIYv9rZwASAgzfI7E3ftPfGtPKxNaNNBdkoLjJTII1nyKAXgY4TvHcfTnmg
         /XuPr7LDeUAR+gHgUF8iLqUqqoUG2se7glU7MvBpzff8Oy9hiH5R3GdXPumBsru4xjMh
         ZwCRmi44XFx7BqWsVE4WtnPksleGxxDkkMiEkwroGP5QpM3l0ZoPQUOj3ynd1bQHdrno
         RneCsR1f5dGqm3BiFDroHUtcjnvZF/buXO9tvjU9tWfMkh4epAjB3JlCSSvxMsBxpceO
         e+bITgvloTnbniW0+7uZ8jqHJrv5bME2effeo+p3jxjV80AKB2XmH2CYHIqwMdpmCn66
         Q6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXemuwkSoGu8mC7r+5cfeGfjyXHt0X+l6cQPyBc5CKE3WM2A1IXWESuU04FDuK6mr8M+VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCGRLnbQhBtyGCkqzs8ihckDf8X861pIkoiPLyeBWOrTJjUdpi
	I11RCPtb/6Lc19RFC1/U2HcrjBIc8xNRgxsWBRKQoPqaLFewVqOOXZdJeP0r0Gu3VBY=
X-Gm-Gg: AY/fxX7Ipo2Eano0lUPxcfKJw2xBaDDJWaCA/CakAWeVESifNviVOQtZYUjT8DFxiFa
	xCUSDRUp7aiWIUiYckWNwSgcN2ZyD+8kZzH4lluclRHDeNJFFN0JKsE5GOytEeQEApgAQi2FwlY
	Nec7pQCmh5ui1LpojSf8h59XHb9shhr6m+UFNdpXOQLLXsDRaahc2ScBDXJ7ijnN7O5alyJJBU7
	0wdyODRY3HA/Qg0whuKuqurzW3XunRLZwjevmYKfkDGAp81jtXGUUqAm39NUJJahEWBNLp2e7PZ
	QhoeC/k9TAilY8mxPKl9ZIu5K+QFWqmq9Ljjst0UMFKcaxAtDQLDqg4ZnW7plJAdGsolyE3YrHm
	VgWnexCh/UYdlOqlNclhR8Kc7RyoHpZA4zZhZojzEAppGE36QRllHeiWxiBWP1xSDvsfC4QS1ll
	HUO3/SQnCkelemN2bjkEqHAVFr0NCW61pO9A==
X-Google-Smtp-Source: AGHT+IERN4NTuUg9631IoqFFmDFc+SSm8nsSJiPXRRuyNQlJRcMWfJpX1DUlLRv86z28+rD5rpiQ/Q==
X-Received: by 2002:a05:693c:839c:10b0:2a4:7cb9:b7da with SMTP id 5a478bee46e88-2b16f91adfamr1668838eec.25.1767696134508;
        Tue, 06 Jan 2026 02:42:14 -0800 (PST)
Received: from smtpclient.apple ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d57aasm2365350eec.30.2026.01.06.02.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:42:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] MAINTAINERS: Update email address for Joel Fernandes
Date: Tue, 6 Jan 2026 05:42:02 -0500
Message-Id: <8822A0A5-CD4C-403A-A001-F4E7A351D81B@joelfernandes.org>
References: <c5c5c0a4-249f-41b0-b5f1-87a58514b120@nvidia.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 nouveau@lists.freedesktop.org, Boqun Feng <boqun.feng@gmail.com>,
 Paul E McKenney <paulmck@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Steven Rostedt <rostedt@goodmis.org>, rostedt@google.com,
 Yury Norov <yury.norov@gmail.com>
In-Reply-To: <c5c5c0a4-249f-41b0-b5f1-87a58514b120@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
X-Mailer: iPhone Mail (23B85)



> On Jan 5, 2026, at 10:22=E2=80=AFPM, John Hubbard <jhubbard@nvidia.com> wr=
ote:
>=20
> =EF=BB=BFOn 1/4/26 4:30 PM, Joel Fernandes wrote:
>> From: Joel Fernandes (NVIDIA) <joel@joelfernandes.org>
>>=20
>> Update my email address from joelagnelf@nvidia.com to joel@joelfernandes.=
org,
>> which I will be using for community email going forward.
>>=20
>> Signed-off-by: Joel Fernandes (NVIDIA) <joel@joelfernandes.org>
>> ---
>> Boqun, could we take it through the RCU tree for 7.0? Thanks!
>>=20
>> .mailmap    | 1 +
>> MAINTAINERS | 4 ++--
>> 2 files changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/.mailmap b/.mailmap
>> index 84309a39d329..279f8fb223e2 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -389,6 +389,7 @@ Jiri Slaby <jirislaby@kernel.org> <xslaby@fi.muni.cz>=

>> Jisheng Zhang <jszhang@kernel.org> <jszhang@marvell.com>
>> Jisheng Zhang <jszhang@kernel.org> <Jisheng.Zhang@synaptics.com>
>> Jishnu Prakash <quic_jprakash@quicinc.com> <jprakash@codeaurora.org>
>> +Joel Fernandes <joel@joelfernandes.org> <joelagnelf@nvidia.com>
>> Joel Granados <joel.granados@kernel.org> <j.granados@samsung.com>
>> Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
>> Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 12f49de7fe03..43bbf12e2c80 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14558,7 +14558,7 @@ M:    Luc Maranget <luc.maranget@inria.fr>
>> M:    "Paul E. McKenney" <paulmck@kernel.org>
>> R:    Akira Yokosawa <akiyks@gmail.com>
>> R:    Daniel Lustig <dlustig@nvidia.com>
>> -R:    Joel Fernandes <joelagnelf@nvidia.com>
>> +R:    Joel Fernandes (NVIDIA) <joel@joelfernandes.org>
>=20
> Hi Joel,
>=20
> Can you please hold off on doing this for a few more days? We have both
> NVIDIA and Microsoft involved in fixing the email issues, and it looks
> like they may already be solved, in fact.

John,
Ok, thanks. It is common for corporate contributors to use company name in b=
rackets though and I have been using this convention for a long time (as do O=
racle, MS, Google etc and even some at Nvidia). Is there a real benefit to u=
s? Tagging company in the name is in fact better for visibility IMO. Especia=
lly in screaming caps ;-). It is more important that mailing list traffic do=
es not have issues which unfortunately us and other company domains have exp=
erienced. I have been using my domain for a long time without incident. In f=
act I used it at Google for this exact reason (with proper attribution to Go=
ogle).

Boqun, Paul,
Let us hold off on this patch for now while we are trying to resolve long-st=
anding issues with the public mailing list software and policies related to o=
ur mailing list conventions. Sorry for the confusion. thanks!

thanks,

 - Joel



>=20
> thanks,
> --=20
> John Hubbard
>=20
>> L:    linux-kernel@vger.kernel.org
>> L:    linux-arch@vger.kernel.org
>> L:    lkmm@lists.linux.dev
>> @@ -21895,7 +21895,7 @@ READ-COPY UPDATE (RCU)
>> M:    "Paul E. McKenney" <paulmck@kernel.org>
>> M:    Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
>> M:    Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
>> -M:    Joel Fernandes <joelagnelf@nvidia.com>
>> +M:    Joel Fernandes (NVIDIA) <joel@joelfernandes.org>
>> M:    Josh Triplett <josh@joshtriplett.org>
>> M:    Boqun Feng <boqun.feng@gmail.com>
>> M:    Uladzislau Rezki <urezki@gmail.com>
>=20
>=20
