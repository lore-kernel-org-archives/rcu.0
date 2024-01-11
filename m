Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1BD52F74
	for <rcu@vger.kernel.org>; Thu, 11 Jan 2024 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g/VjCZsb"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2a225e9449so614246766b.0
        for <rcu@vger.kernel.org>; Thu, 11 Jan 2024 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704997106; x=1705601906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpKML4qquKpI7PtOF3XTwtUPDiM5bq8kBZAqd4tN7eM=;
        b=g/VjCZsbF0SH4q9x1OiL0ftZlJE33nTDzZdXjFbMU7kuNygr4IQykoABm0cAIIDvjo
         C8U9ljh7VxQXJULCTo1CScpQeMKhWgTlPIk2cdQ3tyKVJbmsGCZOLMG+wEqIyvSxRNjA
         5tXGvl45avxO6vqrOwd0WESs3/a8/iN32h9zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704997106; x=1705601906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpKML4qquKpI7PtOF3XTwtUPDiM5bq8kBZAqd4tN7eM=;
        b=UU8qM6avMVvT7dztlZDuRvcAzGMpDY3qQpKZfDHABaWV1V2EvDRhEMXO5Xq2gkNygG
         MajsnwyqXgo8SpEiE0BZMfdAO4GFbjo0o0pisMEQRbOmvR9f2CffFPEuNrxCsLJi/V9e
         tNbn4IWP1FWbLbNkkI2OaKd19DXfnA+0VBJWXGNLd3esY232/up1xvt2lIvXjxmQYDjy
         BakJtI4KeXpo1Hpm9emX/fsqGVhn+FJ3kZXrEeIUl9RTBrAdepV+WmydmVutisaKww3k
         rG+SRjFM6YmlOonkRcknjfcG9jyXeZU1YL+92aHIjJVOEC5vnObXAq6hxFgo9x4UMnq5
         zRwA==
X-Gm-Message-State: AOJu0Yyi7IegwKZcuRESPZesWPENfeV89PI7WjBnLV4u7xjfqby7Hizg
	Dv+xqzf/FaRj1GVoS2EDhP2bsrpOaWlDodrPP7oqsSbmUxBvRCQw
X-Google-Smtp-Source: AGHT+IHdAtAlA0kU9rREKL1LfZwKXER5npjshIPHefWG94gftpVwYZOxHVDWx4zxlmJD7ttZCSQytg==
X-Received: by 2002:a17:907:970f:b0:a29:fbde:92ec with SMTP id jg15-20020a170907970f00b00a29fbde92ecmr56581ejc.54.1704997106258;
        Thu, 11 Jan 2024 10:18:26 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709062b0b00b00a1fa7e39957sm856427ejg.136.2024.01.11.10.18.24
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 10:18:25 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-557e76e1bd6so4759854a12.1
        for <rcu@vger.kernel.org>; Thu, 11 Jan 2024 10:18:24 -0800 (PST)
X-Received: by 2002:a17:906:f895:b0:a2b:f9f7:2b6e with SMTP id
 lg21-20020a170906f89500b00a2bf9f72b6emr41276ejb.100.1704997104405; Thu, 11
 Jan 2024 10:18:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a6d4007-e783-4dee-9f0d-6a1d2525a766@paulmck-laptop>
 <d9bab0d0-02a4-4220-88b0-3f9a86512bf8@paulmck-laptop> <f54b3cbe-181e-48b1-bd68-3eae64940046@paulmck-laptop>
 <bebc98c1-286c-4196-8f41-50d41b30f031@paulmck-laptop>
In-Reply-To: <bebc98c1-286c-4196-8f41-50d41b30f031@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 10:18:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjVU-r8+QTTy7Hw2KXppnwU-8GNbgzw8YbAwJdsAZPr8Q@mail.gmail.com>
Message-ID: <CAHk-=wjVU-r8+QTTy7Hw2KXppnwU-8GNbgzw8YbAwJdsAZPr8Q@mail.gmail.com>
Subject: Re: Neeraj will be doing RCU PR for v6.8 merge window
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, frederic@kernel.org, neeraj.iitr10@gmail.com, 
	urezki@gmail.com, joel@joelfernandes.org, boqun.feng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jan 2024 at 02:52, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Just following up on Neeraj's RCU pull request from December 23rd:
>
> https://lore.kernel.org/all/20231223021434.GA2714@neeraj.linux/

I do not have that email in my mailbox at all.

I have no idea why - it might have been marked as spam and I missed it
(in which case it got deleted long long ago).

Or I might have fat-fingered something, but none of the contents give
em any d=C3=A9j=C3=A0 vu at all, so I doubt that's it either.

Neeraj, can you please re-send so that I have it in my mailbox, rather
than go by a lore link..

                      Linus
