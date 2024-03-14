Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB808BEC
	for <rcu@vger.kernel.org>; Thu, 14 Mar 2024 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710378941; cv=none; b=up8ZJ2ZnQeFqj1uK8dFHd2nNJZZvWZM6OHi1KcwocW3egPck6/Xt2+sVLH2wdC7gMY+vefdoBedNILLH8fsmX7xZ6HVZBUoYhjmuVLjvjR2BKDTGXUzPQMn9l77K15bQkxMu1PC8z4P1XhBK4JHZW0itqB7wpoyPeqDN4hiSl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710378941; c=relaxed/simple;
	bh=KrPxTNGdpWETrK+T9KbNRK7Qi4h2PE7esLmJ2xH0loE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haZk3JZAjoJGfD5FumkM3XeirMnhiqbNHCwP0jt3rmltcAamZif6YKcsxlQYPTYmvCYpB/3wIdHU2n11vOMYeXUH+O6OuW7vzfHbnBV4R38DAVCSp+7gJ3wz6OO6o7FvMOYdToKvvK4qEx1M7XlGyvCpzyJmoNAyxVygZYYI8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FibtgZx0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FibtgZx0"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a466f89560eso20065666b.3
        for <rcu@vger.kernel.org>; Wed, 13 Mar 2024 18:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710378938; x=1710983738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi5Og+CbxdS4GgMBXpSqcHe7hFHRWvxTE989cCTSHJI=;
        b=FibtgZx0eu4OATOCoGdH3BsRJaI31u8VOrexLqKTWcCNhPC2dcQ3dFnhfZNjmRFqNN
         6KvB5zFdfQ4Jw6LlXJZSRtAselIKGjn9+QkS9zc+AYwmI+Zl5KJfjhWHxJ6X+geHbYgu
         /ZNvBAd/RVGYpILlq7xF8yfPpC5VcbSof9mQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710378938; x=1710983738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xi5Og+CbxdS4GgMBXpSqcHe7hFHRWvxTE989cCTSHJI=;
        b=ISbjxEm3YEqkDriY9ypbTdo7kGucwAzRDXpt1cvOyV/QPzHxHJBd37ns8Qoj2LD/Bn
         r8hc+c9a2oYiAHhEDZjlrLeagpyL7aqeVaMrEKtDn783tF8svLsXaUXUsqDjiYQHBAEk
         EErK91LkYLTs+epZ/zlyH1Gg1GBY27NY1bFzlEtyg6dqlvCet+kzFEPeZFoa1LUFGDW6
         0nLOk9ZZYfgF5Dc5hxdzsffYeQV9ctSRzZXSOnz357mKafOQrnLI406dyD1CowBwsWC0
         VKHKJA8gWB8FcfDNQzrDAIbisfeXw5AtxPY5lJM7+6qsCFvX8kFwmxWrorPwPAi2HWkt
         xQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6dscBkQQrYjFGLQ2TrIuaUomxvFK8GRwK2SXwf0uVQKwshQvAXeKZLHyzIElgHnMtED1CZfeDGjouinFgboIv8PFo
X-Gm-Message-State: AOJu0YwgY0XlwLiChJay8JbsIkUnwmMrqE2IOFuFl2vRiADCIc+1vNnd
	fS3RC4PulKKw9F8r2DGJZgFllAXpa+DkA+Ww/QNHAjLgASNWj6OMwuWhXj1+/WYz0OOm/Pa7vBA
	mQ0w6pg==
X-Google-Smtp-Source: AGHT+IEhFbyzY8QTzf38fNl8Ghd/pdr1g3qwyGyC3hRTPpR8A1/MpC9jhgP/94BWvTLF65SCyx2UmQ==
X-Received: by 2002:a17:906:bfe6:b0:a46:4c8e:1afd with SMTP id vr6-20020a170906bfe600b00a464c8e1afdmr122044ejb.6.1710378938085;
        Wed, 13 Mar 2024 18:15:38 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id h11-20020a1709062dcb00b00a466b8c2c72sm163190eji.162.2024.03.13.18.15.35
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 18:15:35 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a467322d52eso1267166b.2
        for <rcu@vger.kernel.org>; Wed, 13 Mar 2024 18:15:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzfC3/614G8jJNbgsLdQy3YnAl8Qq33j718XTj6Mo8GQ+G4XOUYVBC2S2IFN3tv+b2ShWNFf6iCjbEC/Ow8jLw3ktG
X-Received: by 2002:a17:906:48d2:b0:a3f:1cb6:fb00 with SMTP id
 d18-20020a17090648d200b00a3f1cb6fb00mr107160ejt.69.1710378935472; Wed, 13 Mar
 2024 18:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZetHwrCb0KXE0xFI@tardis> <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux> <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux> <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com> <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com> <ZfItZs756Bps2pFa@shell.armlinux.org.uk>
 <337ad5f0-bd1b-4dbf-a94b-681a21f0df45@gmail.com>
In-Reply-To: <337ad5f0-bd1b-4dbf-a94b-681a21f0df45@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Mar 2024 18:15:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=widRkpp1NqpDWoOv7stHcjcDOwZ8monxu6f8VOWPDDdag@mail.gmail.com>
Message-ID: <CAHk-=widRkpp1NqpDWoOv7stHcjcDOwZ8monxu6f8VOWPDDdag@mail.gmail.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for v6.9]
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Joel Fernandes <joel@joelfernandes.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org, 
	mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org, 
	neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com, 
	frederic@kernel.org, bigeasy@linutronix.de, chenzhongjin@huawei.com, 
	yangjihong1@huawei.com, rostedt@goodmis.org, 
	Justin Chen <justin.chen@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 16:29, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On this specific commit 7ee988770326fca440472200c3eb58935fe712f6, there
> is a 100% failure for at least 3 devices out of the 16 that are running
> the test.

Hmm.  I have no idea what is going on, and the unimac-mdio probe
function (one of the things that seem to take forever on your setup)
looks fairly simple.

There doesn't even seem to be any timers involved.

That said - one of the things it does is

  unimac_mdio_probe ->
    unimac_mdio_clk_set ->
      clk_prepare_enable

and maybe that's a pattern, because you report that
brcm_pcie_resume_noirq is another problem spot (on resume).

And guess what brcm_pcie_resume_noirq() does?

Yup. clk_prepare_enable().

So I'm wondering if there's some interaction with some clock driver?
That might explain why it shows up on some arm platforms but not
elsewhere.

I may be barking *entirely* up the wrong tree, though. I was just
looking at that unimac probe and going "there's absolutely _nothing_
timer-related here" and that clk thing looked like it might at least
have _some_ relevance.

            Linus
