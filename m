Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793780814;
	b=y9FdNyb4id4el8IhXSDYu6ecfPqapAHhfVTNsWYdRwXPFqtYYtBunW8uBeoFJW+JtsRF
	 vFhaKWk8S+gsmyIdL85tKVi6ESlVaVj6X1V3UPle4WgIjGBgRqOHD7sDtHNFIw3Iz7bOE
	 0NlrTX27KLgPJmatl2uaRguT8HlZR3iU4ARUm2W062hNhn8uAPurXFIDcCQUjP/7oLqkT
	 t5mVpo1RN7nbe/nMuFjeXhGavfLr0rhws+50Tu0R3gsQM5TgWUIfh18WGjP37ZjuzKqJ1
	 dSu3MQWLuly5TdQypO1YLWr746QpBzkRimSEZFQHJDvS6ASYCnpKptBLVGHLwJAlTfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=D+vnesPE4t9lKIynjQF/EgK23seabQisbWfdICSw+rI=;
	b=YoB7Gb2J2EFMXg4Gkr7d18nalI7mAkVWVQ4RZzOeBiSwxvRv9k4hzAwlOawaQlWrxUeZ
	 Bd+LkH2X66UmUSNHfKdyDV50MbhK0aKVO8Zxk+nWP1Q/vYTrnYU6bY0odjbPElkhssZvO
	 l1szdwztWQM+8ip4jNFROIQ9+xvWXb4cs9Y/IrxjG4dOzhq5qHFzhyqV42iBm9cnwNtdp
	 evPVjpI2T4kOdBkwzlkcaBpZ4/UfVGkrdG2bWvRj7ZD1RGWQll/5vAXDAgcLPwuzdxuKr
	 39dCRRLah56A3ADLkazzeJDm2sXDfIWjD09Huh80hiv1xh/KoqgS/X8cwtFrm+RlfOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=egv69oqv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81706606A333
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 08:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81706606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=egv69oqv
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c43373ae89aso60885766b.3
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 00:26:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793780812; cv=none;
        d=google.com; s=arc-20260327;
        b=lTWWRUKiTV1RRQ2iy/X4bg2gYgKmTw9qckDMkTnR2vxxSXN598QwMIciaT+FkVU1gI
         yQpuRuIBAdeykNbS1nqCvj0MCzJKJcrAVg4767whax3fztxzI00//ao2M/6nOxJup8P0
         A29a6mqTZpLTZ7ar/+WeSRJr7HlG6IqFDwJpJqbYFhqlp4xuMO7VLmffAMfArf02lA/Q
         xonUfWWhoxift4Y+0cdFvn3ceJoWdgjr71ye5UZRKc0vgsbh4L0YjRDg8fNymIxwiuiO
         nm0vyidn3SvjQMYRhvV8BXn+qsbMlyGmqNbTjT8zNLH4TCqcpOB6xwBIvNMhOG4qvA8x
         2yZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D+vnesPE4t9lKIynjQF/EgK23seabQisbWfdICSw+rI=;
        fh=yPCLocRb6iy2j27Xehr/U+hY41/d6ZthKhMAT48hJTA=;
        b=UMKznaZ4B2OrNBO2DTCNX0Ijb+Qg6+IQWVpdPotFcwThiSLzvnc3awq+z40rmX7G45
         cl/fwY8eEeCsRrhSB58A0iudw/ecW3GxV8Oml/QDrV3dbQ4yim3aIMjUX1gxKEhqtLq3
         jpuGxdUnLXLO7KYX4x291LwOkkt/OBnPGCQ3gE/LnYX2v03Ll/pgBTfuoK8RyHk+Deg+
         tfVAOPmiK78jLJ8HSvgfC2RUfeTOQUGsE4BYDyYl5hIfmQEzqbOUPKrZFghEAHaoTeD/
         Fmir6UWfuggh/AbOLQ1WBYLqwMTMAIiw2YpoRsjcndx5tOhgiq6E16Fn6vswby9kWI62
         s7Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793780812; x=1794385612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D+vnesPE4t9lKIynjQF/EgK23seabQisbWfdICSw+rI=;
        b=egv69oqvcYpneqpYilpQ6uvKgAp9jW4GTNrz7YWaWOHv8GjmtlF5KZPPtwAqnbfw/m
         s08YuDBwW9kGihk/vDJlFSro06K21qE6qojoJUa14UyY2A9K/uE2DZvMsgCirsdCC7jV
         xmjVEeXdTz8Z4bk3ltAh8qWMjgflVD/7Xit8UyMdzN7jsXp4V3Y7aqSE35wMkDK6zL7f
         CIWoaOpQ9S4XzimRwbSthlAgcAVx+zyVl0GkDDzZRFu+4hM0MRE/PW6WAYGfs7JeqsHB
         L9tNxGu839UKsnyirB9eqvmFU8GLfLq48AiahckTSEiYJc8Jcm+wrlzUQc6rhMq2zXmm
         NKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793780812; x=1794385612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D+vnesPE4t9lKIynjQF/EgK23seabQisbWfdICSw+rI=;
        b=hkJX0FYkANBRAWHGHqpyrxP8q34EaWu8O3FNJv0oqYcTfiWhrvb2aPngpQH2qrkEw1
         KOA5aTGTQkJUe51vIss2xNUtP5CY5TIAQAdy4PX27u80V191L/GG5ibww+TCPdKujaIm
         Kaxca1Co/g/tFulAgIDGI9enrJ7p5hvpun87WQuXKqH7ojgjFsVKTO3C1GCKFiSEWOyS
         Zqvjci9yFGunvXmoQ0DIN0IFTmRiIkkLc0L8tDPlcvkbDv0Pw+lriYYjDRqMMcPEpBlf
         LnNS11wP2GsOvEEKrxGqVhdRWvcEME+jxlErGk1EZSwy+yjpMzaxu8Lif9Qj/Z+r9tqH
         Fjsw==
X-Forwarded-Encrypted: i=1; AKwUvBw9XHhFnLzaWHXr4eAnsWrGUukcQpWYH1k0Tl3PS/ts67bcjl94zC2QD6cCSoV27eTZ0Pk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FwS38R7QIR1I5C9p54Sd5sXh9NogyUkYgP76+ugnraj0H7BfJ
	vzS0N7+L+wJ0kmZYSc5iZzQH/ByBLnR41G7JdQz/5c29nE6XYozjHYUrRuNe4be1/i1VxHt5JyH
	yvIqHGFVj2RtJXQU86yfoEffv9u2t/t1IwYzEdFmOVQ==
X-Gm-Gg: AYBFou2NlVjedf1cRt+61GV+D2BckyuSiB94MURHe+W1JPbgRU8tMyhIByRfu0Mi5C3
	kX0RyG2wAAhlXy15bzfJV9IZ/yt+Mq2IQuOm3idOtaBFwfRjPbcCBXy4Rx4zwQ6GhSD99kCBHgw
	Vt+GNvyTknZCb870/DETZ9cmKVdFkPVS1cEN43EUDRDIh9jA8z4nQlb977AeWvLMx8FP/KJ08vH
	311qhxk0UMaaH91Nm8QjCx4ybJANSqZeR3NFYsHQL5RvdE91BZ5iZTgBPhwq+0wPtjI1u0SNaav
	jLE2WzlHmi1zm0fkr7Pptap7T+BY1qwi2p9qELcLK1nRhjbYC66AeF1rVTxtbD3jp/RG4GCnu4M
	9U1mEZhhKVrU9uRRLbP39Z343HE1LQRN3AT4IS3z/zcHWc2EkUf/wORaydZ000FtkUg==
X-Received: by 2002:a17:906:9f8a:b0:c3e:4f41:e2a6 with SMTP id
 a640c23a62f3a-c4ca7974a58mr1321997366b.6.1793780812002; Wed, 04 Nov 2026
 00:26:52 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103113711.1832834-1-max.kellermann@ionos.com>
 <20261103113711.1832834-5-max.kellermann@ionos.com> <CAGsJ_4wpd-e+xjm5KwihVziAeVnQp3XYG=+-BKmx0SVEhmyqqw@mail.gmail.com>
In-Reply-To: <CAGsJ_4wpd-e+xjm5KwihVziAeVnQp3XYG=+-BKmx0SVEhmyqqw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 4 Nov 2026 09:26:41 +0100
X-Gm-Features: AclHuK-KpECaTGoo8CunTP9HlWbpvRsPjMgrhDBxpI0Zzac6pPc7vrwid4sHOVo
Message-ID: <CAKPOu+9textOydxZYng=Bo9Sf91Wq_7rv5r2pBrhXOfiex=qGA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm/mglru: avoid redundant rotations of young memcgs
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 6:18=E2=80=AFAM Barry Song <baohua@kernel.org> wrote=
:
> > In my micro benchmark, this increases the request rate by 36% and
> > reduces the average duration of each write request by 27%.
>
> Could you share your microbenchmark somewhere (or post it here
> if it's not too lengthy), perhaps on GitHub, so others can
> reproduce it? You could then refer to it in your changelog.

Will do.  A note of warning: it's ugly LLM slop, and if I had written
it manually, probably 99% of it could be removed because it's
pointless garbage.  The LLM wrote it for me before I had any clue
where the problem could be.  It helped me find the problem, but
uploading this garbage triggers a bit of shame in me ;-)

> I think this is a correct change. I wonder if we can
> reproduce the issue even without concurrent reclaimers.
> In other words, can a single thread running in a
> memory-limited memcg trigger it as well?

Your question is not really related to this [4/5] patch, is it?
Because this one is just an incremental optimization on top of the
real linked list scalability issue.

A single thread means there is no spinlock contention and the linked
list is only walked once.  I don't think the problem is visible then.

> One thing I noticed is that you may not need to call
> get_random_u32_below(MEMCG_NR_BINS) upfront. Could you
> defer generating the random number until you actually need
> to rotate the memcg? I wonder if this could further improve
> your microbenchmark results.

Good idea, optimization added for the v3 patch.  I don't think it
makes much of a difference, but it really makes sense.

(And I still hate that the Linux coding style requires having all
variable declarations at the top.  Code would be simpler by
declaring+initializing variables where you need them, and additionally
it opens more opportunities for compiler optimizations, but... it's
the way it is.)

> Anyway, the compiler might be able to defer it for you.
> I'm not sure, though. Could you take a look?

The compiler is not allowed to because it is not allowed to make
assumptions on what get_random_u8() does, therefore it must not
reorder the call.

(I wish C had a way to express a promise like "this function call
won't modify global state reachable by the caller's pointers", there's
just GCC's "pure" attribute which is too strong here.)

Minor note: deferring the PRNG call will move it inside spinlock
protection.  I think that's okay, but it can theoretically have a
performance impact, and I'm not expert enough on this part of the
kernel.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
