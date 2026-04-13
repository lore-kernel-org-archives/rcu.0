Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD6307AC7
	for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098479; cv=none; b=GWTnP+Aih5yWVALGboa4999YbL2cphjCM1dWDj2MFrhHfy1ckak32fFZIvReogwe3SK2m8kC+E1ZULQu0FUkgv0ultRNJuW4Q9dTd8dyOaEj2PLimZvBe1gpO6GuxfQilWtaJ8n11vGlG9lJ1xec28n61r5Wy5XnmUzxdxkNSac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098479; c=relaxed/simple;
	bh=dJDJ83mfnP274KNek+AFJg66R0VOk2aJaw2xwC3ho8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltO+95oL5H5WdtHjK3Q/CEVOUzWjejfx5y7RDziq1vZ10T1rph7S9ZSmzRuyF9cMdpMfzekE7dMn4Fj7sAf36t5jLY4u/ZDSiuKFq9DLuTKcCtLoeC5zS7vQ+35NDVEAHAJdvZ8btlE3z89TwMzksTaXRb5oVRe3+DJS9CF+gK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vella1yx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vella1yx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b982b0889d8so639594366b.2
        for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776098476; x=1776703276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MlOlMct5Wv2sPzc0AZ2JuPGXsAzW+oOEbrnMJzTagKQ=;
        b=Vella1yxKEoIpMyJ0cWX36T26U6PS5d6YLykT/OcSkFFkG4nNYh7NkoJJx1sl+ylhl
         b21485rxYFgsTKm09FoGSjfHUX/0mYHg+u4kpW9a/AXjcVlx7o+0G/M14k7WvpWld54c
         pWP1PBklMJHAV6WyBGaZ7UoEkDD/9JlhMityM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776098476; x=1776703276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlOlMct5Wv2sPzc0AZ2JuPGXsAzW+oOEbrnMJzTagKQ=;
        b=rYbn8Vlz7A9oUZP01lkMGGmXNvwqadvNlbErsGedj0WWKuqEGZk7+GgUf1Vt//im8i
         /vAyoXgwF8eUqMQDZmO23Cj9eeybmNTNXoEAAO4PyM6Wy0FmcT5sjoOF6M6UQgmDApaY
         Y/uC0g1+77+63InLOOWtXVbR5UkpPoPICBAimYGei8f1/6L6ZqW3VJnJqWl8DDP+Ed9h
         Z9zcutHuYOApVeac6KYvyawv6TWnbBktkflt5kQ/5RCLk/9wMO3zBEcSkkpnup/fJTZa
         IYRhGPCyO1zPABjoE3XDTttncuAO9eg/qVtCH+vAHuXDQ3vDayDBzrqZSNXr5XGA1EtV
         Rtpw==
X-Forwarded-Encrypted: i=1; AFNElJ/9JSVEz9YbKBzhZTDp/AKUhDHYAOz/6K4MI2dIdZVSs6f9HwjpjyMWLR3Bat/Qpz9D/Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEk1+vAcGL9o1/pQ4Pf5/qEG4irGu7dVpILHWufIYqnWfcbhR
	ZBJf3JiAke2DPuJ2jCXQsyyrhcAUczpLTgHIkeTJy5To5gL6TmyzpgDSdYaAV63ZwmVDADpKQbx
	3h/S7oPM=
X-Gm-Gg: AeBDieuj2v+ldU9InZ3go+3VcJJWY5wO5dhvamXseoVag0g2PuxrRl+t9LlFd1SP9M9
	zsd9J43SKkLgxkhbQ/bbvpmh0fS3pLlqd0exA1jZVxu1ifXG7wd9znikA1oyQtXLuxmnz6Eq4Q3
	P4Y8KeanXMXTm2lCt1ihscuS2tQjD8uDjWBpOqpXDwxSTBA8wL7eQpdLDpGZaK5sqmVc18pbiJN
	z7el2pYsKhNI+fcCfzUKpLLLfwX0KWHiMEOGjZkEfnT/Vl/Kkb8rCIMlJcREQR5+fVzOsVHE/OI
	hsqurfHaygLd2Sz+7v+kSS5xIo9YonExgpEqGaNYc47FZZzySBFdEfNGBBPahQjcIEp+AVwG2xV
	Hb+JYmQ2z+KUvF+W7uPSPWr1RKhBErUQrPZhup8Udf0ZsxRV/v0rl3648SwxIEmyNeNla5aBJq9
	v3gCs6oz7qYeL3obpikon9HOqlPcCFanzBLlthBRq0VJnclmjJJ38HqgXaVEX1VSQFzAGd0p2Q
X-Received: by 2002:a17:907:874e:b0:b9e:b78:d6db with SMTP id a640c23a62f3a-b9e0b78d725mr20288466b.30.1776098475910;
        Mon, 13 Apr 2026 09:41:15 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6dffde03sm342913866b.28.2026.04.13.09.41.14
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 09:41:15 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6715006f4f7so2088324a12.2
        for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 09:41:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/MveB7F7rmCxuy2dcVjL7B4eWddGd9ORJCv2EdBQ3Ky8/mFLE6hWAFzOzFYKNkC0KSdUY=@vger.kernel.org
X-Received: by 2002:a05:6402:46db:b0:670:e93f:1269 with SMTP id
 4fb4d7f45d1cf-670e93f339cmr3136699a12.9.1776098474563; Mon, 13 Apr 2026
 09:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1774978730.3972500.27807@nvidia.com>
In-Reply-To: <1774978730.3972500.27807@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 Apr 2026 09:40:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whigg3hvOy7c1j1MXFy6o6CHp0g4Tc3Y-MAk+XDssHU0A@mail.gmail.com>
X-Gm-Features: AQROBzAp_9EdcYirKCGph28b6r734MJmZskPOoI2mfEHDo2QGwbeQQtyIsKKRAg
Message-ID: <CAHk-=whigg3hvOy7c1j1MXFy6o6CHp0g4Tc3Y-MAk+XDssHU0A@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v7.1
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, joel@joelfernandes.org, 
	agnel.joel@gmail.com, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 10:42, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>
> RCU stall:
>
> - Add BOOTPARAM_RCU_STALL_PANIC Kconfig option to allow triggering a kernel
>   panic on RCU stall via kernel boot parameter.

No.

Dammit, stop doing these horrible things.

I've said this a million times by now: the kernel config phase is
probably one of the biggest pain points for random new people trying
to build their own kernels, and we DO NOT ASK PEOPLE STUIPID THINGS.

People who want this can damn well use the sysctl or maybe some kernel
command line option instead, and we DO NOT MAKE LIFE WORSE FOR
EVERYBODY ELSE.

I have removed that disgusting kernel kconfig option, and I want to
make it very clear to people that the kconfig files aren't your
personal playgrounds: they are the most visible interface to NORMAL
USERS that we want to encourage to build their own kernels so that
they can participate in kernel development.

So people: next time you feel the urge to add a Kconfig option, take a
deep breath, and look at that Kconfig file, and go "Maybe I can
instead remove this *other* useless option instead".

Let's *improve* on the kernel instead of making things worse.

                 Linus
