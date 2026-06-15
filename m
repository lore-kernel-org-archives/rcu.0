Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228323B42F4
	for <rcu@vger.kernel.org>; Mon, 15 Jun 2026 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553889; cv=none; b=QZYuM6ukXBUE5b/fHEuIfd3ze2ba2QNCbTmA3i6lSYEuUJMi03BJmGJ7Ui2ourXvsqhj/RMbjm06PbixlsErhIbztTH+StxKalq/Kl2fkbYqry2Gxzyh/7qHr3PyRGuEZq36pooe8w3/0bwdXDzSRESCj/0LuGi8B4tCRCVWq5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553889; c=relaxed/simple;
	bh=O7AK+avBtUq66QCHc+PycHss3yeDRao/n+7K4bdeeNo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PQ8RvQZQqdGRQIFT1RbN/vXB/Ofg1p7SectBqu49/5k6yUkqJJ3i98c0H0MVXca6DN/J6olw7pD+Oqy0cjmcLFHhIzwdPYeWKScNNp6x/+Jd6Qwm2YJ6y3EWiVuRLRHY1Pvd6kC+gGg3/2PYxj+7qHbrPApAV9If2O+VlJJhRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdsx/2IE; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdsx/2IE"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6b5c374e5so3835176a34.0
        for <rcu@vger.kernel.org>; Mon, 15 Jun 2026 13:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553887; x=1782158687; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXCGDsnXgpty84dJ1mO0u39WICRv28gHhnNvC/hudJQ=;
        b=bdsx/2IECURggyX46rSg85ssblHsIbf3wiikLYY7CpGJjRhs2Qg71wEnsYuMLwFkUe
         OAUNfm/VZro6iDhiaL1rtyY4LsHtQC0p4FqepsveNZ6hLgUSfN73B+Xr5kpkfO66DheY
         YQMH/kKklL1XgPj+KvixXZIL2QCGf8XGNmfxfjl7SzmPT7Xq/2gsQIke2YOXPfbLQI+N
         caacBJ4fLwR5TPhXGg9jJqGDPlHXcMTFWtL2GXJi77N7qd4KRBt8RY9TD6b/tDPmQwRJ
         Pap1+tilJRmbdnP66PCUC6R3la9eBjxjH5WDLER43MDRKKcDUTG404yirMRlUGyCQjIS
         y+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553887; x=1782158687;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXCGDsnXgpty84dJ1mO0u39WICRv28gHhnNvC/hudJQ=;
        b=PXDejvEUqhpOgimVXPbXPh5V4CW8bhZsYOrSKiML4VNQziYvLnAlHqa1n5p9UYAtzb
         57RDW2J7xGOSeNtE5TfCclte3VvN45yTJUsmsH76+sbUxI5m1HRXcZBgXR4OFsqqo3fJ
         GYoEoETU6WmhBPq97fhRVhcWLZTUYfC20mwn6AQ0FIKKQY0dcY0PcnPZ9ZriaDnI9c4q
         5icJtM9q0qh13KgDQ4sz+Zc32GTbpmySm7cx6e9v8kyNSbrJcT1yM/ZtEgJkQp8zKfGj
         DHhQRS+Gk1+g8lkelf520+A55U2tXdNgU58O8ihMc8Mcaw82EOyBPdVHgxJrGC3ERpud
         vu7g==
X-Forwarded-Encrypted: i=1; AFNElJ9XfNGN6c4g23ZR8zcFGXGaOjwC0WNjJwk3ViMNB3onX5C6IQAbbBl7p1sGFv+3N3ZzWNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf6JtJ4ehQUjVhHsfcSwLmasJedxdBzpSPF4H454I6sknFiWxk
	pY8WavSDMxtbuxR7AfOTUOzq8rAFR979BIZsQebv/n9rtr5zZCJpwotL
X-Gm-Gg: Acq92OGcfwP1ypCWC76Jf2fTvFfqQcbC8by5/7/p8/s8B9jHa+HBJ+Zgr7rnxY6mXH7
	oXEW43k1HN+v1wPYvWz515xYYIL6cY4Di2DHupFxV1x7X4bfvMtjOSmO+/Nhpy58Qgio6iF3fvx
	n69cUfH7+3yrZgh4cuFfcincUpYyks7bVA2oqWoFRhlfR88Ai1pSq9FDaY20FBL0lhOyAFJN7UB
	ZsOGNlYv16DPjn7jQcVb27UQ8UilvNuFNrWix3lqY9WJeM2GBFxPApOkE+F3dqJcAVdp3tW0ieJ
	jHghj3t8PMw1Sc6V6j5bu45DavB4hhbhALdswhkSFHwabstTtCWa6vgNFGXrgQSzuLDTaP6+Klo
	fRTMtjy8ZLSyUYtNP7n9NmY5ANZu7k5hqII2ZfW5uZ5fUPCb5RqRTetJjC6xPF8wOpfoFx3m0gF
	Volh9+bLiAp+Shzz85JiXjido/oKqgRjWzAXo9pJB59FV1jH1FrJyhkZ4HSUDbt9Ba0wHjCGxHb
	qioimNOJep/QKQnkC184zre9Ijn
X-Received: by 2002:a9d:7f08:0:b0:7e7:4a94:bace with SMTP id 46e09a7af769-7e8fc9ac8dbmr393027a34.13.1781553887063;
        Mon, 15 Jun 2026 13:04:47 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6dfde9sm4892917a34.24.2026.06.15.13.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 13:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 13:04:44 -0700
Message-Id: <DJ9W57VQJQ0A.XOCAQZWY51HR@gmail.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH for-next v3 2/9] mm/slab, slub_kunit: register kprobe to
 trigger _nolock APIs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li"
 <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Amery Hung" <ameryhung@gmail.com>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Pedro Falcato" <pfalcato@suse.de>,
 "Suren Baghdasaryan" <surenb@google.com>
X-Mailer: aerc
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>

On Mon Jun 15, 2026 at 4:05 AM PDT, Harry Yoo (Oracle) wrote:
> =20
> +/*
> + * A no-op function used to attach kprobe handlers in slub_kunit tests.
> + * The barrier is needed to prevent the compiler from optimizing out cal=
lsites.
> + */
> +#if defined(CONFIG_DEBUG_VM) || defined(CONFIG_PROVE_LOCKING)
> +static noinline void slab_attach_kprobe_locked(void)
> +{
> +	barrier();
> +}
> +#else
> +static inline void slab_attach_kprobe_locked(void) { }
> +#endif
> +
> +#define slab_lockdep_assert_held(lock) do {	\
> +	lockdep_assert_held(lock);		\
> +	slab_attach_kprobe_locked();	\
> +} while (0)

Great idea. That should cover all kinds of cases.
