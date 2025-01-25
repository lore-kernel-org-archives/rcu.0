Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285143AA9;
	Sat, 25 Jan 2025 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737828482; cv=none; b=oxe+lge6tEdSFu6/nPqVW94M6EAE58W1L8HER7ShZK7/H6wjxYEVmM4ZXH5OPnJly4UGWaakJZ046FULf7YMBYYXeDI8Q9xddCQVejgf1rWsNVkaWy9JnVFEr0Y3LtyC0TQ0ftqteZzHwvdD5yZv6vL1Y6B4+fIZZvUzkwPaeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737828482; c=relaxed/simple;
	bh=sANaFN5qYKpd/u9t7Ye01U+RxpeK8I1iUPpGQfem66A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOobvAWJ2i5Fd8C+bmzzLWgstElQoKJl7IKfMpgibdhcGQ64tGg9S8hbedjwXizqB8LF+FVxWDc14w1ypRN0AZ7yyxQqO2N7I/115/iEi1GV+QRj6JMsMnJHAK3LBStbqdbQVtPKloxDmekDuuF9CY6xYTRh++qTX5ElLupdn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgwSnw46; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgwSnw46"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so6368238a12.2;
        Sat, 25 Jan 2025 10:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737828479; x=1738433279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sANaFN5qYKpd/u9t7Ye01U+RxpeK8I1iUPpGQfem66A=;
        b=FgwSnw46oTDzVaGav5Cbycf0JYljWXHF+0neBOvAm1sq37c3E57YGBdW8tWLsYzy0l
         jmfwdS+7nBqWtwf3Kn6vJxJAjaKVXk3BKYfWLznB9PX/zNIgW2UX/1uF0QeAeOkekCWu
         nnArphpDWf7YDPe3uTcZxHXhomplJeioKX1l+D1zLZmQaku65kYyKJsObo3kSAtiUyOB
         Wt/eTm6lcKAzGSHxaeY6U4kRX6AkLzzbN73eKjOEgTqaNhqq6cZNnS2F6+iteEnzVboy
         cJsuz733iIPCteObexbbYJHXiZ7mRYA8wQSL+/Q9mCYI/q7VUPAR62yfn+/2cLWtvcR2
         ejFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737828479; x=1738433279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sANaFN5qYKpd/u9t7Ye01U+RxpeK8I1iUPpGQfem66A=;
        b=Wg/WazOBzDrFMAj0d4SuMXLqqqvV0MbpBpWcJxcSUYdyzyq9hKR6VyuTl2Aubq3KeS
         B8KVsgcrXsOIkur/8vFnNbcZctTLahAH98a6IxvR65FSPsYVxhXVmUHKRm5JtpdJIfwv
         7AYwwF7E1Fz38KDZrKiw3LNrxuLnyrvImh0ktfAF/F7xYwRqHXFb+6a5QgBFqH0/XGQ4
         82pWb6mrPvAgVv/NUlitnm16+Mq/vqmOklPu7qVD3oiz8nRKy4W0/bNkKLbJeoOiLd8a
         ERGrk33t+RhLP4qIwAJRvVWQ6zkYAx0dg3QxYIvnVN86RJ4xr6qhZ8FRrNXvKzKSblnk
         ZtyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfGWCxFyoVZoWvA9SjbILskkKbZoeajIBRlti3AEOQ91HE/bztOSFxdZVNCq5U4PlPo7TJ7zFBsGjwCQ==@vger.kernel.org, AJvYcCWWHQ6x4IZ1Wst3b6AEK7cqnn/75Ey0iIOkkuTPZ7Kx9cWkdNCKl+TA4+zxp19uwN+x3jhf@vger.kernel.org
X-Gm-Message-State: AOJu0YzowLnqMj7Hf3pl/FR8DugVOONKdBtwRIzytA1LpEy0lxiO7G0h
	Nc5LrVci8wboZkokDeybajrnvzpFlRn6/HLSrmukGdO4n119OFyJbMadM9zWP2dbJZntY78dxP7
	RKz0Bx8cFGEBwSGZJOIaQITysPTQ1mDCV
X-Gm-Gg: ASbGnctQmk0GcC7a11gMSz9aInfmsS5Z9MrF0iOL8cXexOj4zdT/NA/6Mr4k47PjnCM
	8ilR+4f61Su9KBikRsNXrhouEiEceyRavf/k/y/Ls0XiaFFV8hvO7lygz4vO5cbc=
X-Google-Smtp-Source: AGHT+IGXCjHZjDXAq/PK+BXeap6/N6GTlhRz5ueE/WD4sPtyeWCb37vF5PsKs85VUqqhICceGmWf786eJu/WsXAV9Bg=
X-Received: by 2002:aa7:c993:0:b0:5db:f5e9:6749 with SMTP id
 4fb4d7f45d1cf-5dbf5e968d8mr11629021a12.6.1737828478491; Sat, 25 Jan 2025
 10:07:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk>
 <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
 <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk> <Z4-jgMJgbVriLaCr@minute>
 <Z5KMHoA7GlHJyUU_@minute> <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk>
 <Z5NxuIFsMUvqWUtC@minute> <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com>
 <Z5UAFAD6xCSpKJYw@minute>
In-Reply-To: <Z5UAFAD6xCSpKJYw@minute>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 25 Jan 2025 19:07:46 +0100
X-Gm-Features: AWEUYZnFsJ0rqGDvjO8vdfTRNXbW_iHOOW7wgtyNCXkg5YGKcK2JFXChpWb4DgA
Message-ID: <CA+=Fv5Qfiekogdg_Pytf=HvWeJONzqWcQS3rbBvM3DC717hU7A@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: Ivan Kokshaysky <ink@unseen.parts>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Magnus, can you please try this variant?
>

I've built the kernel with this patch applied and I'm running it on
two separate systems right now and so far so good! I'm putting some
load on the systems and letting it run overnight...

/Magnus
