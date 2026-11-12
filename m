Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501203;
	b=1TmsiXWCYRWmqy9EW+X+R9b/tRS11N4HdTf85I8FGyyojh8my/jtMBVx/mSwiOBzRjlM
	 2KqS+0F05mmYJKzTvXoAwL/HHB8FPgPJGPSCX/hasW3+WXxadkDw6FZywkTrqggRKvz4K
	 fGI3i/ee9xmhHLTrU2Gu2xQAz4wSoI2F7AvggYjMQyQXB02UhIwCEWv5TXi4d67iGgA8l
	 /J1AUjI5zVO3ZikUY62wKuzbz+vAPdJBjVN3uElL8XbFAxJQWo3fPcmfZCe4zkDUww63y
	 iYngNb9zsYAzbH4gJwdBaYfqxc7jtRXcmCCsQY05TBnYFFMyhS7UYU/0wpFpAoVVejQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=dmjuPZ8BQZpeLS5NHfXu6uyM92RYmwsffX2PFFxEaPU=;
	b=VZevWHo8InbwGqcEe6QeMcguu8FSPun7UjkqVFRUpfHf68yK59csHg0ywVfPJqp06iwv
	 nKj7AtOS3SnV8UCZMVwhIqvJzY8FKTQ5MAXw9vvi14ZMzOjnfbUDq5iCKHUHSJRHazPnW
	 PtxMDOrzHKVGOcpQYfqGH9cweffxJ6eTxIqybuziVZ3/COInh3DH1eKo7UnilDQ2BBi0e
	 XFWxY1dhxl7k8gIth/9myG2O13BHB/BZPPlVGFyNArZJ9SnyOb42Ji1orS4E0vfS4qT9U
	 oF8ClqWgRp6kln8GRerNJfALRNFAZCYDvWSbECvx3cy0ZE8SjWe4QilcMVED5xkbIzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wJdEDNt8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B6606A8BA
	for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 16:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 097B6606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wJdEDNt8
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67a5c8ffa1dso263286d50.3
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 08:33:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794501202; cv=none;
        d=google.com; s=arc-20260327;
        b=OkH/UbQqrj3elxRpqbNKxwnup+qcCc1p9IqlqdJ7wNhEYBC1f18wor7JAQTM6gFMG0
         0ERlcgyoocNuROBEBzv1ldb82oRNkSiNW/m6ZX24+81uK0a0QvRa827aYPGfiP7qG0ac
         EVoZcUMH6wKNCHyIXCzJEzTLFqMsV3OHP6+gx/qEdij2Ovz7UMvz3HSJ055Kv0zc5Rzj
         Vu8Y7wPfe3Xd0MvP0lGpPBVQlPz7QXZj+vcazj0TvFbvpy+lehQSIJBBRCkD8Yx3jUyr
         1g7vRv4yU6LpLYX7RMqtLHadJ24DqjK+KAUC2uvWfaJFqToWfJ54+Qni1PmVlwbu4nvv
         zlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=dmjuPZ8BQZpeLS5NHfXu6uyM92RYmwsffX2PFFxEaPU=;
        fh=59wYOk5D7MQNnaZQqZoMx6qgVEihndxnKa4JMoJFXZA=;
        b=KtpNfwVIy1GYMSBO9DoTZ/3YVzbuaSK43mwHYGNLnNp5ZgttqpmwlwY7Vps9+ZyhBy
         AFgP5GP9sqF8t5VJQpaBbuwd8m97RItApWYK6cA9pvHVxO3eNBREWIiawQn914liOwIt
         YZGm6BaAe3KF/gYJ5SWf233NA8Y9meuDRKdh7R4Tq8vZw4TtWL0xvlc6kxz03Toq6X3K
         ZIc9IkroJXy54GUWFMrC4xpnYJGdYt/UYelSddNT/v51Nc4WLS4wWuLsITcJ4cku3Poo
         uWqo+fEMBCSmBY8B9vkZSff1scpbc2DWpGScf12zdbdHZsdujMy+ZKK7I6shVRMJMcMn
         rFEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501202; x=1795106002; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dmjuPZ8BQZpeLS5NHfXu6uyM92RYmwsffX2PFFxEaPU=;
        b=wJdEDNt8Hsp1p1oDqKGXQ/xWBS4RmuVhcH8IwWKBGYwfstVbCmaEHw/gUhTjlUcS1z
         QfNGsvv4wl9Mj00diukU5WNnS8XMEwuNRvknOeZC+EUZ+j8bsQ+C7QHOvyNTRv7/tGzU
         vFyx6qQczBYdmwuZ1Dycs7S4ReKVW/aO+9uXl7GYjhXDTQcNF5JAwAiQzm9d4e8vFCQ1
         /Bs9DKK1LyHrBy7LAoXtLwPdT3CKwTkCVZRJ+kAWdDY/u0w3ZRFIoNfokKwf/z9v5EEa
         TH6posaVTGPD0cAd5H+cXmpBkbqvf2IK4iMMT9mvTFiKiReycR8MpH3u5A7cRI7UMkgc
         7KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501202; x=1795106002;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dmjuPZ8BQZpeLS5NHfXu6uyM92RYmwsffX2PFFxEaPU=;
        b=Tg97ojyqTo5xkwRhFY5TzPhu5/Aamwi4dc/hXxM2gVpkrx26w4i2ClBQeYo2SmWFIB
         q5l5xwNYAPN4Q0YLjapuM1UZXWuIe+lNK+7evMbCArGnarRiWCF7nKjYI0uF629eBZnG
         hHQyLDRIwW2u4F1A7H/KJA7AX18HmcsnvOVF0ZO8vylipxVTLon8OkCmz7M7tZRY1C78
         9qpeve4ueMxiQV+eK0AZBcLVnGcW/PTsvBAMXY175AUrNOM7AnHPej6UaaPh9kbG+ivb
         +oMFoIcq3GlX1PjKbofGipz1fWTTgLd3DYVPDTIzlQuSq1Lnb2AB5J/zH3KARiUitWqX
         lCZw==
X-Gm-Message-State: APuU4Z9PyPtia6IV75M71Cr2ZgO2BjvXA1awdQGGkaGRVDWpHLPn37Zb
	guwEnxyj/vOq0xiB9nWMXLpJp89o5E2+7ylijWsoUCf+6pasqs9jc+w8q1OYyzIaaYBniZwwvbR
	PE1G++ezG2ELDNAvyVg/9PMvK8tF8smw=
X-Gm-Gg: AYBFou0BvjMUw4UiQE0yQGKRrL1gxwYFrF7ligle426cAv+msgrX1X24yRJr8tR6eGL
	aRju7Emss8z3+UK2AmgfmhPfIuXEwbLNygweOrDhD9+RdtIs8MOr4TFZ7qRYFx5zeu84QGHh7WK
	FhrYjuR4OclHyetZluAW8usj3mWB0z5G6dl+/60Zj6Q8XoD2hstVg9BLAytrFBaECY1SBM97nLv
	n1I17yerPwM5u8woOkOZAiJGzcHlp9XXLu108jvznu0bbg2NFMFymZ5HUibXy2aEQPBUrTQn7D8
	PugFWY7AGln5Gi+OYwkMYt1/ckwp7SemEFiBJGXHLJxjQwVblZFrD3hmzNqRZhGvwCzTLUhZuSy
	gZy6eE+D+bEa3GYPr7MUdLk9k0XEoBf74erE=
X-Received: by 2002:a05:690e:4002:b0:67c:f0d:82e1 with SMTP id
 956f58d0204a3-67d893bd8bdmr525d50.2.1794501201888; Thu, 12 Nov 2026 08:33:21
 -0800 (PST)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 12 Nov 2026 08:33:20 -0800
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261109000243.3936824-5-joelagnelf@nvidia.com>
References: <20261109000243.3936824-1-joelagnelf@nvidia.com> <20261109000243.3936824-5-joelagnelf@nvidia.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 08:33:20 -0800
X-Gm-Features: AclHuK_FGWOWv4UbRIgbbmYPPnmJDJ_Hf17GfXM7QfUltDyC3SKn9TnbpoYkG1w
Message-ID: <CAPAsAGxPCJ87akRFmcKWLW9qQ=zMYim+F6wnLeYmSP7CuEgMLw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kasan: Avoid an unrelated RCU warning in the
 callback test
To: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: rcu@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Joel Fernandes <joelagnelf@nvidia.com> writes:

> rcu_uaf() passes a false protection condition to
> rcu_dereference_protected(), which produces a suspicious-RCU-usage
> warning before the intended KASAN failure occurs.
>
> The pointer refers to a fresh allocation that has not been published to
> readers. State that protection condition explicitly, leaving the intended
> tests intact.
>
> Test:
> Built with CONFIG_KASAN_KUNIT_TEST=m
> Booted Qemu guest (8 CPUs), ran modprobe kasan_test filtered to kasan.*rcu_uaf*
>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
