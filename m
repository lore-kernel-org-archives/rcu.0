Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26943A1CA
	for <rcu@vger.kernel.org>; Fri, 15 Mar 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514463; cv=none; b=tum3yMqV/AzcX1XrK9eIPSphG1nwJQk8S4s/o0NxgB4r9mFuyUwGBrRvVAKoWsWQYdyYszy/qpfSUijtqXmInevQmqdB15BDLYEm+LSlU4+NGPSBG0nJmAGDHYQjF5NQrLVjCjTRHY1efx3sAWnlppxhDDoMUCjhIM4gkLPmh+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514463; c=relaxed/simple;
	bh=q0sxlmWZ/FVV1zfz2VpYFEe+xwviTDIZ5JEWihPHwp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjRPGl3edZzxERAyj3jWAdvA6pmoAEDoIb1eqzPfkVLEXY4bBPMIgxWnR7oL7CxZIIdOKR9eDs9U5mTJ5ZHXScvm6nw7T1wO7Sj6+p6h/ZgSZ+r4OS9Rd3lj8kLXqUAyBHBQR3nkhWw6vKADaFiuE5FnXZmLWP5qdq7ApedyhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IgljK7aV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IgljK7aV"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-568a5114881so2087404a12.1
        for <rcu@vger.kernel.org>; Fri, 15 Mar 2024 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710514460; x=1711119260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0sxlmWZ/FVV1zfz2VpYFEe+xwviTDIZ5JEWihPHwp8=;
        b=IgljK7aVz7mWTeCcuJciOzy5qhMHo0og5Gm486qtN0CqfaqiZdxFRnuQIxm1SdsMD1
         NqpjwVbyCCdFeV1w+/Q/BnnJM6lzny6BvB8ib+HeXGUS8fsnLTURXZtcWHb2of2fy9sT
         mUI3Qr2TquspS7KBq1cLk6L6fW8jmCTsjXk3btZ2qFHGnW1KFwq4jq2VLq9pYeq2Kha5
         FQ9X7wufb4zrVI0JebZNTjbZdIhkgqMw9qV5Cgfd/ey43GpHyEB1dcGeuCQOZebRqFWL
         mDKINfC35wpiE1iK9qIRUH2W8CjUz9ySDfoEcw71A9WOWwYdg9EVSDqswajQVQKDUfEB
         bBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710514460; x=1711119260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0sxlmWZ/FVV1zfz2VpYFEe+xwviTDIZ5JEWihPHwp8=;
        b=UoxGwMS7zMoSudGgCvfAshU0fvx7TXyXzsNUxgy6cnnXZlZmsgZSWQugLPQV86oCZN
         iEVsFR/kE16SNbUqy3ZqnGWwI9LdE6YV6cht+0fpWBbC0N+Ty+B/CD3JdEzYgcrk35Lk
         +bKZgb6TufliRrhLk0siAeAZXk9JXP4sOcx0x8uzErB8yyU1C65RNpoY5HtfA4RWENeO
         G5L6iScfyzNsc0mkNSUUOxD5l8t+ERz6ZkKF0ugy6R7aAYEmDET2csz5G2gxPyY4Nc1+
         K50F57z/fIvwHnc2j5GM8bdzYFvk2fMMN40WKak2A0EcHH2leOauQ2kbPl12tFWgYBGJ
         oFmw==
X-Forwarded-Encrypted: i=1; AJvYcCWoEk/K9OG1zxi8sKDO+VasPHPVlYmZOWKdZWrqsnmYQVYOFKfeCarLV5U2imywpYWOTLNnbfvBy+q4Kx6OaUYzQ6WC
X-Gm-Message-State: AOJu0YwJnyW0dpmmESHcoW+JBqXztjCfxdDwEiPR16fFKUJn3hpHj+gb
	SI47R6AaP2ZC6I7Uz3kZwQFwhjvYA62dj+OCTHcdJ3FfaGPibLSLCIw0baLEsHbeN9vT8jljhuW
	NHNklhW4z5JIG7qu7T3ySuHkWS50n/5k6wP6nRA==
X-Google-Smtp-Source: AGHT+IGAXuUW49fzljDaSHnEPf/5724NscYefKAehPQ4X765R6/8qKdPAaZTE8bvj8BPPDkeMk7rsijwG2UmAT6Fg4A=
X-Received: by 2002:a05:6402:913:b0:568:b95e:8012 with SMTP id
 g19-20020a056402091300b00568b95e8012mr259127edz.14.1710514460320; Fri, 15 Mar
 2024 07:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710346410.git.yan@cloudflare.com> <f71214e6221c5c50b32a62a33697473c756e604e.1710346410.git.yan@cloudflare.com>
 <20240314145459.7b3aedf1@kernel.org>
In-Reply-To: <20240314145459.7b3aedf1@kernel.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 15 Mar 2024 09:54:09 -0500
Message-ID: <CAO3-PbqTzsTX9UBgdC2aV4pLdL6ddrSKHTXeYNoD_m5yK6qdrQ@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/3] rcu: add a helper to report consolidated
 flavor QS
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 4:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 13 Mar 2024 09:25:49 -0700 Yan Zhai wrote:
> > +/**
> > + * rcu_softirq_qs_periodic - Periodically report consolidated quiescen=
t states
>
> > +#define rcu_softirq_qs_periodic(old_ts) \
>
> scripts/kernel-doc says:
>
TIL, thanks. Let me send v4 to amend the text.

Yan

> include/linux/rcupdate.h:271: warning: Function parameter or struct membe=
r 'old_ts' not described in 'rcu_softirq_qs_periodic'
> --
> pw-bot: cr
