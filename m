Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3518AE2
	for <rcu@vger.kernel.org>; Tue, 21 Jan 2025 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737499899; cv=none; b=UC868ghoF7fOqPl/3bsZoYgOW6Z5BvI0KF/dgZltRBeH2gICLQqOIxZ1D2YtikoQ+TAPhriMVrAjTVFH3E8Cda5Dd3pDu45PWnMLpYuxwszw5Mw5MZ3bkb8tju/nfAk9wMFkgclqYiwZvFlEzf5tIn73JZyMurRN9w6YhYZOwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737499899; c=relaxed/simple;
	bh=7xg/L5vBJhda/yowLURqlGku/tFBInB78Tt6VZP1eBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4KUpVrn4s0w+FC+X6rQtQz4Si2ltyu+UFKkobw5PXBH58iHCFPxBWYn7v4AKCMgOfMthSwprvuDxzf8YUbOWJgcInZDJtEM1X5K4jdn62m4Qpvwb/K2PG048UKAhYpDXK1cSvIp7j8oH/oEa3E/SpKI2IpnJW7eE1r0PjjQMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DdwYVAIe; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DdwYVAIe"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso11967028a12.0
        for <rcu@vger.kernel.org>; Tue, 21 Jan 2025 14:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737499894; x=1738104694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nJow/q1BduEybWb1MrlEpj+rWBkAGTqsp7vbp2qgJ3g=;
        b=DdwYVAIeLQRcxkjjgJNOz/ryVQ6StDoj5DkZMZwdWlsr7I7VkQ+7iTf/apzWffnoGA
         Q/hSYJwq5qVGcG6/Y0kmqFLQnwy73kA10YUTwCFkMIUjZEObESp/g2PYTUS7KOkx8Fd0
         8u1RMJ7opCLMOs5bZlNGbCb+849g05vxKG5N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737499894; x=1738104694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJow/q1BduEybWb1MrlEpj+rWBkAGTqsp7vbp2qgJ3g=;
        b=I2wgxPCnD0DceBJKSI6AW5pGAUkHezHkZaA95uzUVg9dNdATeiew9IGgguYB+3Disb
         WfPvovg0Vdc/O3LWKQz9Bl3swg0NODuqnheS0rcda9C2vTo4b45cFth6f/AOyuufhx1I
         NE6XMx7Ebr87fGbwvUyLUXj0chaczLS7sGNYoPQlPUVk7EMBJkvpZ7fI3WggM5ukP+2g
         /2LVDOdmxDUzOrOySHKU7V+fWj/g9yxeRZMUitaHYmUOhKAszOLV/H4ZehuMFXMm5GxF
         0VEc9tE5iGVsVR/aTZzrR3Zc1e8d1i1SLUOfAqISkzc+yy1Ehb1DIRPpcwa1/VKfmeyM
         +1NQ==
X-Gm-Message-State: AOJu0YygkDjCJi2We3rePqcM+8Rqn0Yx3FiyY+XE4/IAhcHLj2Sis+GM
	84zyxdvCJGu6r1he1YrGQKaz1bVAf7KxZBozxV815gTaxIdGJBT7gA6WEsxDOu9lpc064B83JM4
	Jgr8=
X-Gm-Gg: ASbGncu5khaO8kS7NrfkZjk4/7xil5OhCYf+Yv2VX5xTDO2Q5PdohfZ8k8f0D/strkb
	FKwyFBmgiNTdNRuvdy5iuYlrc5mtt8XZIYSKVXARVgflcxhBDep3nPnIg3PhnG8IXd79ZgCaESg
	VqeJ5QmJa7eZ2qLrLyjfaZEjcMxAoviuJ9wNC7engf4pbqhZc2fQ7AAVxpweDaV8oke7Tcn9Kol
	yjSunb3LF68RUyyzo90c4jW8EHsrvVpKHu9mNe3C0LeRfGbPEzmUIiS2izgRHYNJxiOpFSUSuy4
	YQLW5vAeGsYvBM62uIXACGFSudn9brvVyU2ycYuDXGwE
X-Google-Smtp-Source: AGHT+IFspsgE5fboDcjUWHtyct+7qFA92Ovt/H/or5EeayFgRP+bkjkus2FLUUSvMQ6uEEE+CRM9Kw==
X-Received: by 2002:a17:907:3f90:b0:aa6:6f92:74b1 with SMTP id a640c23a62f3a-ab38b231a83mr1887405166b.13.1737499893745;
        Tue, 21 Jan 2025 14:51:33 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f22fd2sm811218366b.110.2025.01.21.14.51.31
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 14:51:33 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab651f1dd36so66262166b.0
        for <rcu@vger.kernel.org>; Tue, 21 Jan 2025 14:51:31 -0800 (PST)
X-Received: by 2002:a17:907:7ba8:b0:aa6:7c8e:8087 with SMTP id
 a640c23a62f3a-ab38b1b4669mr1756816366b.12.1737499891535; Tue, 21 Jan 2025
 14:51:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117172440.49319-1-urezki@gmail.com>
In-Reply-To: <20250117172440.49319-1-urezki@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Jan 2025 14:51:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgGjEgK3V6XtGckJ5gdPsoj5Zn4O+ipN6Kvv83AKE2h9Q@mail.gmail.com>
X-Gm-Features: AbW1kvZHm_iXCJKw-K0RK7vbINzn8rS4U6J2O9ggVVfDmmNSzmZjXDAyjJsVETY
Message-ID: <CAHk-=wgGjEgK3V6XtGckJ5gdPsoj5Zn4O+ipN6Kvv83AKE2h9Q@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.14
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Feng Lee <379943137@qq.com>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jan 2025 at 09:24, Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
>
> Please pull the latest RCU git tree from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.14

Hmm. I have pulled this, and the resulting shortlog matches what you
say I should have gotten.

But your diffstat is odd and looks very wrong.

Things like this:

>  tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c |  395 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

were already in my tree from before, and aren't new (and your shortlog
doesn't mention them).

Also, look at that line. It's long. It's not supposed to be that long.
You've presumably generated this (incorrect) diffstat in a very wide
terminal, and then cut-and-pasted that very wide output into the
email.

Please don't do that. Yes, git will default to wide output if the
output is a wide terminal, but if you either pipe it into something
else (may I suggest "xsel", so that it goes directly into your X
clipboard).

Or use "--stat=80" to limit the width manually to 80 columns.

But the strange formatting is the less worrisome issue. The diffstat
just being plain wrong is the more alarming thing.

             Linus
