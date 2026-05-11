Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B5743E9C8
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519348; cv=pass; b=HaBjC2qcbpC1NKA9bJ+6dVt8f6qX+rWsH9x/GWYZ5geaE6kuy7TwZsvUYXNldzP7vSCRAnbRp36mZBziAHSVO+cajmWx4/8g7UjFz1I6dgnIiKhzpGgPwXfrg7k3HSQLgs4gQa8U9nLzrS8l+cLhQZQ6JuVQkl1qqJr+PQ3dIqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519348; c=relaxed/simple;
	bh=k6Rze9LwEFXfHw1VGiqDsPRrjPr6OfKR+FgTRdqqxZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXiCKdpqUwW8y8F9w8P9I+m8ZFYroUuVNyEpiFi8Q80CROxpFFvAQvI2CoViFm6o43qcTbZ1mTyb53hDDbJhgn2J3jKgmiaXRMCOkwW11ve5MPf1uZLR6/xulszuxct8leV1urfNuEJxfN5irde8x6c67t+EUq5gD7Q3VKYD/lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sc2y5UAD; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sc2y5UAD"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4826c92b14cso39059b6e.2
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778519345; cv=none;
        d=google.com; s=arc-20240605;
        b=B/7jXB9Hykotb3dlryaTQupY9WRFM4hYnbNnoFONVesFQERC6Mk3LHgv/t5PJHpZDZ
         viV0MGdnbjOX0awZjqrp8Jz2iTR8zoFuUwlmrJ7LSKjSynnjrd/UlifvpdjnLhnFiSdc
         N7SJFlCqGHd9trbHSBiCElq0UG1/s+clEVirnl0uTbSuzAJ4pcyVrD11PeW6b9u87ELv
         U57VsOwHgEorlR+U3Iy4/k468QTbjYQMvI7I36l20rxbxeAk3NMgXzLvcj4pLh+aEITa
         lvZC1DELVRItHZdIXH+lAhCJSjDYgrnRQjauQibndOpeFwn3l/dJYxWX65E/d4A6aO1f
         Mllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PoTJTh8yH+dfHf/ffCLrWvd3b1lXNOkP34ZrY3+mswY=;
        fh=qbuHc+VZEU98Ep7NZSovDraRyv11rCeMjiRjbsTNE6Q=;
        b=d8eFuRBAOpLlgpomo1s/jnUiWnO21H3ISudIUB8pmC8RBD+p8b6fw/oYGV8znfg1Pd
         0dJyh2ktJCjg8668ppx8gmwKMUGZ8I8+11Z3gCqnoEdBO4OitzooFTHPVSxtXtUiKOHx
         mJK6BKTk+mtslD7Eiw+C6rg39xuZZ7XjfUeTO7Uap67hRkRNsfjMyZABU+eJ8IbaGDBx
         TRg6jBKaNRz4BCm/cwwkaRjMtvlkX8DC5iFRiqJWAaHmttaXfkqDHo2z3JTH4ZT7vHsq
         tzquu0+jqG2HC3DGbWOgtvjri7o0sr1p5GIbbf1QKngKlITWlyS4QsuZWAzNJYgvuszf
         xyRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519345; x=1779124145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoTJTh8yH+dfHf/ffCLrWvd3b1lXNOkP34ZrY3+mswY=;
        b=sc2y5UADvDqAsJdT4VQ1OfrRvNP+go0IfReNkoPC2xUW9yCjcvz/2HNEveWYFQevB7
         K3fhjr9NwSqmuS7exfByYlLbDiznBvfpLxICchfYB5tVh9Yj1mYTOylRws2zxHJjHv4F
         j9LXnCbZDWdfNpCaLPcWzK3Q54R4qkGMrGSTzy5IVaq5nvCNg5TWYongiBg93vyYbldy
         vbFSUocxrRd0e9j2p8J1GIXtMnb/sBjbXjk9i/LpK4Geq7EKhdOvvUPaCqxCAqwMnLz/
         W3sJHsW+VguzwYSDBQHwjm/V6Dr02//4i9pLpeyVGK5l/bActwjOKm1Yt42wunKqq4Y+
         bXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519345; x=1779124145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PoTJTh8yH+dfHf/ffCLrWvd3b1lXNOkP34ZrY3+mswY=;
        b=WlDvY6tVMskSpRy3NATizDXh6iaBFHkhwyVe4KutCOcreAhBZS2YFNkq87IM9Qpkcp
         2g3HjU+LZyZ8h62eMWBxqN5Fn4aZrMQlWPIKuDtkKoVPHrv5ngjjch+6MN+ToXADQzCC
         n0gxmxbqyQNM74XaJLJpZWZWyXdKWLH+3pFzQHHCDEO/qyYfLeccKTRQoBjEJb6KdER1
         VShBK7tVloAniJojaJjmz1oEdMFn29pWz9uGbG+SElEBK+M0x8ELaYTUtOvYCF5g7Hx4
         BqFP5nUFwPlBhB5ioykwFUGQ42JcQNVx2lcgNZenmaryW32r2am8CAsLgiRLT17bLh6d
         eYCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0Xj4dSSWMaazk6LOccwPN7MU8DNxiH9oICVXKpbhaab6botZbPRqDtD/uqq7SBnEDPSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bCmUh/uovc5Jp/rd4RJQZgZxGzivvwcOGCghSFnunNgieEW0
	fUOQPjdIyYWCE+UIc6lH7p9qiFBB9jOPi3e9Yn0bBjDhtEHA/Ek8t+9RVJ863Adm6M9pP+fm2Ll
	c+S7Dxcbrkl+zDUE60mPu88aFGXRCvRo=
X-Gm-Gg: Acq92OFqHjS4zlq4zao1ZBgY4xdROHF2gFoXU88nu2uc8p+SNOFTz55pfDHK7Z5iT2q
	sCJyHNAPgeHY3Pj+Qsx0wZKeXCjd1OEyvU9Rjg5Yle5iFUpEPbaAEFmgzTERLSr34M0WkPyNDhm
	LZkLlin9XMh9tnoGkob4FxjK7Mc10CJ3NWg4oNg3cLGb6jtKujiRwWLBTQOuPsnwoXlK4VZRUBF
	ZBWsh1wFAsj4xxkhvjXWUmapG7pyeWGoyXao9/3rUP1q517U99Qq6PRQlgVdYMZcIzf4iKBQvVK
	QV+Un/ARld+R/CMvJ/6Z9MShRx5XO45mQg==
X-Received: by 2002:a05:6808:1827:b0:467:53b0:b44d with SMTP id
 5614622812f47-4804518afd3mr9603396b6e.5.1778519345047; Mon, 11 May 2026
 10:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-rcu-pending-cbs-stats-v1-0-8f4eb3553bc9@gmail.com> <fd8b4470-930b-4688-b423-2e349f8c883f@nvidia.com>
In-Reply-To: <fd8b4470-930b-4688-b423-2e349f8c883f@nvidia.com>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 11 May 2026 18:08:53 +0100
X-Gm-Features: AVHnY4J02EM-STLCD2MP6FVV-JQ0lvc4nk-VTjvEiKhgUyD-3ZL7OQ5Tc9N05vM
Message-ID: <CAGSyskW6T4cbX53gSRZSGeiTct9zHLBo9vsE9OH3Yw_sB1Frfg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] rcu: Add debugfs interface for pending callback monitoring
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Breno Leitao <leitao@debian.org>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Thu, May 7, 2026 at 7:59=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.co=
m> wrote:
>
>
>
> On 5/7/2026 1:37 PM, Gustavo Luiz Duarte wrote:
> > There is currently no easy way to monitor how many RCU callbacks are
> > pending system-wide. The existing trace points provide per-event data
> > but require active tracing, which makes them awkward for fleet-wide
> > monitoring. Knowing the depth and stage of pending callbacks helps
> > admins reason about RCU health, gives an indirect signal of memory
> > held back by RCU, and is useful when tuning RCU parameters.
> >
> > This series adds a debugfs file at:
> >
> >   /sys/kernel/debug/rcu/pending_cbs
> >
> > that reports per-CPU pending callback counts with a "total" row.
> >
> > Patch 1 introduces the file with per-CPU columns for each segcblist
> > segment (done, wait, next_ready, next) plus a "lazy" column.
> >
> > Patch 2 extends the file with a "kfree_rcu" column reporting objects
> > queued in the batched kfree_rcu()/kvfree_rcu() path
> > (CONFIG_KVFREE_RCU_BATCHED), which has its own per-CPU queues outside
> > the main segmented callback list.
> >
> > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
>
> You actually don't need debugfs for this. You can just use bpftrace and
> instrument trace_rcu_ (with other RCU tracing Kconfig options enabled?). =
I had
> something like that working sometime ago.

My initial attempt to do this using tracepoints was probing
trace_rcu_segcb_stats, but this would add significant overhead to
every callback enqueue/dequeue event which is too expensive for a
production environment. I played a bit more with bpftrace and managed
to get this working with an interval probe plus some __per_cpu_offset
pointer arithmetic (see below). It is not the most maintainable code
and has some race issues, but probably acceptable for us if you
believe having this information easily available doesn't add value for
other use cases.

If anyone is interested, here is what I came up with:

interval:s:5 {
    printf("=3D=3D=3D=3D=3D %s =3D=3D=3D=3D=3D\n", strftime("%H:%M:%S", nse=
cs));
    $rdp_base =3D kaddr("rcu_data");
    $krc_base =3D kaddr("krc");
    $offsets  =3D (uint64 *)kaddr("__per_cpu_offset");

    for ($cpu : 0..ncpus) {
        $rdp  =3D (struct rcu_data *)($rdp_base + $offsets[$cpu]);
        $krcp =3D (struct kfree_rcu_cpu *)($krc_base + $offsets[$cpu]);

        $kfree =3D $krcp->head_count.counter
               + $krcp->bulk_count[0].counter
               + $krcp->bulk_count[1].counter;

        printf("cpu: %d done: %ld wait: %ld nr: %ld next: %ld lazy:
%ld kfree: %d\n",
               $cpu,
               $rdp->cblist.seglen[0],
               $rdp->cblist.seglen[1],
               $rdp->cblist.seglen[2],
               $rdp->cblist.seglen[3],
               $rdp->lazy_len,
               $kfree);
    }
}

>
> Generally RCU doesn't add userspace interfaces randomly like that. I reme=
mber
> Paul ripped similar things out some time ago.

Debugfs is intentionally not a stable ABI, so the bar for adding
things useful for debugging and tuning seems lower than /proc or /sys
-- which is why I went with debugfs here.
