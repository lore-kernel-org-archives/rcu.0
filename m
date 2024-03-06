Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303F613BAF6
	for <rcu@vger.kernel.org>; Wed,  6 Mar 2024 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709751738; cv=none; b=GrG+Os90sM/WVsA7sXtxiFrAh+JCXmj8X0QOaHVKU9HUhipwYhvI3Tl0J/eCXysizlGbYBgLqrWKY5UOSvqC/t1Q+6NMbJY5KDBAeV3/JyxOTH0Ctg0Fsfr6I1oxvSdU06xBLB6hQGE5aRE3b1N07q5lfoTCzcrhYIKN+tUsQm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709751738; c=relaxed/simple;
	bh=uktpHUkNmhOKTFxoD3U5Oj5kyJgrlheIj53K3uB4Das=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jlzyb5q798NOy8/2ijqHZMSSYeQAD72gxdjlxzXEndvkaaRswI3W+4CNRnD0cWN0AxH7cn/r3zT8ShkJoiYyXFmE/gsBPr5Cq7GYqdrsY7d6TaQb4kTyILOIZd6gEmwPJ/TJj1A/tB7hT9WGBevdDWK90iSGzmSDLmvIji81uR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VgiE0riU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VgiE0riU"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso22486e87.1
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709751734; x=1710356534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nI0SlJxOqKR6hoj2NvT7LNh4O1romH2k1b9PGrSXHg0=;
        b=VgiE0riUh7vM/IXjEx5X2y8szYGhWOlw4hrwQ9S1caoRM0Fp65tjrOnX/z+YoBlUGa
         rKC35hjDNIvaktYfa73wCssEBAViHbYuFMRIj1L9/Sx0vK6XpLGdNmdE0tCQQ8soCMFk
         3BQMZlLdvMZvBqjcb+fTvWlR0BaYY3eAYFSm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709751734; x=1710356534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nI0SlJxOqKR6hoj2NvT7LNh4O1romH2k1b9PGrSXHg0=;
        b=P0rAByJ3yvuX+HLLGam8QVhJTBPDXa1Jkwhm5xN0jHpp8s7Ffyj/4yZ2X7mX63HZmU
         64Be0ewk/DHO6EBZUH2jNEcMmIP1fDm0VzyEJ/kzLq1bWhAQAe2K8CbdB6781GACbmhg
         3qD4btOPiRVH4oq0WYmAvK3GyHrCtbcenKdeWWt02aTaTEA4wMAmzjZWzhzYlKbItrx7
         HcZXF1yEV1OZdBGpMbjtuGhKTy210pnfZchIE3pBBeb4OG+CrhxdCebIEy9OwaO3cD9w
         fnl+nLaSE8hdt3IlMGdLkc76ctludAG3z/fq95uPdTFrdzNgq27yXAP8fY6LNv3nTeGw
         M9xA==
X-Forwarded-Encrypted: i=1; AJvYcCWw6s18YfN8o+sldcPAwGUFM3H++DfdiN+kmfQWiQ0m1TYfcXhVyK9bvJ+z0pWvMgXCIZGTJKf2RVANOga1a0z3FhaU
X-Gm-Message-State: AOJu0Yw7uXPb2WhEG9BYV5n8kqXPZvz9eOQGgAvegjCo+9NtTSXAZjza
	kNrVcJMZ17R5y6xtTkYtf7azb336M6LSzR86Q/s2OAgejoLN+Hr82Z9/0z58qXEGEoq1v4JehVq
	2tI4=
X-Google-Smtp-Source: AGHT+IEJ/g3TuLsBiyvH6/+ZgB9Qtq/pkRP69SYVrh7BNHxxu37wjhpuGQqijqu4aqRpBtZik3hIiQ==
X-Received: by 2002:a2e:b17c:0:b0:2d2:ad40:a7de with SMTP id a28-20020a2eb17c000000b002d2ad40a7demr3577827ljm.20.1709751734135;
        Wed, 06 Mar 2024 11:02:14 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id eo12-20020a056402530c00b0056452477a5esm7194369edb.24.2024.03.06.11.02.12
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 11:02:13 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-568107a9ff2so48205a12.3
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 11:02:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSTOZJY4MbY02PNX/mc50x+FAc2LiR6EqIZ7A2p8G/oMLNh4B4+Jg365xVe5MFuwYAmmob3Z796JGiXhw93vYV0AoM
X-Received: by 2002:a17:906:f355:b0:a3e:c738:afa2 with SMTP id
 hg21-20020a170906f35500b00a3ec738afa2mr11850437ejb.76.1709751731771; Wed, 06
 Mar 2024 11:02:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com> <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop> <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com> <20240306135504.2b3872ef@gandalf.local.home>
In-Reply-To: <20240306135504.2b3872ef@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 11:01:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
Message-ID: <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 10:53, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Now, are you OK with an addition of ADD_ONCE() and/or INC_ONCE()? So that we
> don't have to look at:
>
>         WRITE_ONCE(a, READ_ONCE(a) + 1);
>
> ?

In a generic header file under include/linux/?

Absolutely not. The above is a completely broken operation. There is
no way in hell we should expose it as a general helper.

So there is no way we'd add that kind of sh*t-for-brains operation in
(for example) our <asm/rwonce.h> header file next to the normal
READ/WRITE_ONCE defines.

In some individual tracing C file where it has a comment above it how
it's braindamaged and unsafe and talking about why it's ok in that
particular context? Go wild.

But honestly, I do not see when a ADD_ONCE() would ever be a valid
thing to do, and *if* it's a valid thing to do, why you'd do it with
READ_ONCE and WRITE_ONCE.

If you don't care about races, just do a simple "++" and be done with
it. The end result is random.

Adding a "ADD_ONCE()" macro doesn't make it one whit less random. It
just makes a broken concept even uglier.

So honestly, I think the ADD_ONCE macro not only needs to be in some
tracing-specific C file, the comment needs to be pretty damn big too.
Because as a random number generator, it's not even a very good one.
So you need to explain *why* you want a particularly bad random number
generator in the first place.

                  Linus
