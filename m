Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4C3F0AB1
	for <rcu@vger.kernel.org>; Thu, 23 Apr 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776950718; cv=pass; b=m1COkUVNv7idS0Pvz0U2d9+UKu5t/ldqeuhCsM/RPDctxmnw37OR1nUpVSy3YSfmt0muO953be+dcj4O2itGuvH4FyBavDvKragKBhtswRtFacam8rkdahGuvNSbAsSmnUW5m5tM4IG9oSKNhe5o5J5jPKduy0ruWiKYjFXz6ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776950718; c=relaxed/simple;
	bh=9b8754IDEm0TQDjQSnxDEexYNuYd2dC6tmyRCw03JwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fx2wMedGQxDEqSABrh1vefzdfhqdTAiwZo5KmtdL9plOHhrMFCw9HusIHBtOUpJKnfhalo1MBKdD5Z7DRDDsPdpHhCmMWC4igTiHG8gSTfEaPXxGnb96NP3gPwEfci1X8upYSQM1tETnrbJ4GcYK6Fkxtb1/z7xLGMENqPr09ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=GYkEUMFj; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="GYkEUMFj"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64e87a81639so6077502d50.0
        for <rcu@vger.kernel.org>; Thu, 23 Apr 2026 06:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776950715; cv=none;
        d=google.com; s=arc-20240605;
        b=eG2G3jD4W6j6v85a+6Pt5NBwWxUsE4fn1DxptAqSaZMXjo+tb+JZvE45LhdwCnRYsY
         f2rWnW1e7hcn44ZC40T3MZJ6V+wBqd5Nr4L4brWTEO4GQgV33w+dbJkVR+dTOiZyHCE9
         fsMaC5fCgf+hhZak2KzNHbLt+opE2aKS5zybKIWT80DlX2usritbEzzUVsJOiGTkgLWe
         ifd/LsoKrMUL8HXu0ACv5tphwW7DmEG+UyRiCO1JRVGWmIXlVFuJywGOn2UWbGIH31bf
         TCtl9q6sq0ZKKJBp0ccOM07AVwTgzP3RFpznJpj+6eb61SNxee+IjOx6Gxx+SpSZiUux
         8X7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lhNHO9jAUIx/0udLGeS5tagccSSFrBTO/SZbGN9q6H8=;
        fh=2mB9mkPa1Pd124NoHVrvJ5lB4ANvpnPILcptHbckhRo=;
        b=DTsGNHqFBPzr1ZhGDI83sCHQBdBm0ASGF0sY84WMxzBl7aqDZyaNxYLYgFIt9NlD2D
         n9/1LlKoWh5HY8jiylcMD8mxLToa6pi+Glj6w17Oo8W/2wvXC6rlWutUMIeFqei/TFQU
         HSAJq4xJvNPbcK/IUbPo1V7R7RUqZyQpyc+5tCNcuAVRdUgErsVP69E7KtI5JxSgtSTy
         ICd59NJPjh0eTUlWVEppsruHVW1K19wH24mRswqypEgGu0mMkaXvfsJfDtnPgulo+Gs7
         eYuORWpehPFA0k3agbI6gY9GMHUZAB5rJfljVJ+BI4v4h//slTidTO9+KiXdOHMCj4/a
         hqJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1776950715; x=1777555515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhNHO9jAUIx/0udLGeS5tagccSSFrBTO/SZbGN9q6H8=;
        b=GYkEUMFjmceiNCtpVlZJN/CS/8bgBuEXGSA70ElbG0qbEzUFDWFrHaYJaoBY7t0OjU
         ATEj8yutKcRnCCKXAVFWh4G1BQtH6jTviOaUue9dC7vOtmkAM28+qSrS5Wix6cRk76kE
         +e0hJ4xxpfIllirCrxMm2ShkgcRakNWK/kKAfZKgne+3vZ1P9Qk3hEtvfiC+QLSdpoRa
         ktzq0v8+sQ0LLT9A5BpgqI6qS3xyKxfCAjktMFtxA3UV1UOCmvEkyXIID9JJGN89XbMY
         Xb54Vt8ZFs8dke3Gr/oAiZTEgO9JpXrMtN/3c+Hg5h0mwQX+owCPXn/2yUFJwYOSOZmt
         Wisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776950715; x=1777555515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhNHO9jAUIx/0udLGeS5tagccSSFrBTO/SZbGN9q6H8=;
        b=iEzjfe/ppGZwiN6baTFEI+Khx94R0OUzG0xdOIgdH1IVT2UdXdrlQivDgTYxNOYdbk
         k4Xv2BzqKDRrKgHYypxvYEUKLMr/bUuXLEdSWoAh+9nQGBAvnFso4DVpP4iE5jV6/XwM
         jEYJQbIbw1Zc5IeHMDRDXenMr1Ei5HeSRhWZHf7ExLIWRVOWZBrJ0iwmnV9YaAWuAceP
         /K68zadkGMM/Y7HxGCC+D3EhgU8ZcO0EODFSEdToLnpwfZD8BCG4kWovgZQ0DVeBXkJw
         XWuDdwHvW3sEAnhzIQgaHEqT3eUgPNf7dkX0iLStZ4rfksLEypBCsQLer0KKfg9Hwirm
         2u3w==
X-Forwarded-Encrypted: i=1; AFNElJ+m2A7GTYdCCSMbkRm06QSRacTQTGTT7UK5Y99vuqS9J6UQzOpvcKiQVzb8L6/1rY4GLPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+33PEQ9PcYGrtO9H+tfMGmUPN37h5/4Zw8Os4fvTBynOBgDDt
	CuJm7jH3v2skaBdID6lcnVTpRYFZX370EXW0k1rVqHt+o3aHESFjniYYlJZW/TgHK9MskAqZupj
	Vl9mg7SBnmj+s4GjbCV/lhGK+Cujg2FTfQ77bU+NO/Q==
X-Gm-Gg: AeBDievog9IFSsWXXat711AWM/tagQu+/FpzfVObzlSGOG0U5s+AMaw7EPlyul0TufQ
	wcoCWhzupVA/oOCs6pINnQPQy7Z1ccAOP/r/IQFfUHFFfaxxH34hvi9prUPK7DI/PBXgvRNHiK7
	XGR0a+eMgPUAnguYo2KtJGNvYkTrLsSohBtshcixo8wZQV534B6bu8xRH2cimz59pqzO0dogcNd
	sEMsxi4hFhK2W5XUO8tGaV3bBb2OOTs9fdZjwv3/6EDZcm/k05156smTE8TVZREsWsD9jlgfgW9
	gXUgZC/dNSBBmDJEPIf3j+UOSCx/Nm70vpJP7YB6OZt4C4zf
X-Received: by 2002:a05:690e:1913:b0:64f:fa9a:9017 with SMTP id
 956f58d0204a3-653108846afmr26025810d50.28.1776950715337; Thu, 23 Apr 2026
 06:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aefAWGcAQHeRYbs8@slm.duckdns.org> <20260423090100.3231633-1-sonam.sanju@intel.com>
In-Reply-To: <20260423090100.3231633-1-sonam.sanju@intel.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Thu, 23 Apr 2026 09:25:04 -0400
X-Gm-Features: AQROBzDuqnoAWQ0x4UMQxhwITFSDzgrxL0fOr-O37WxBma-Xso9IsfXUvAQZ01s
Message-ID: <CAO7JXPgf-PQah9XCq-KD+FimQATkxy4HpvWy6r6LDT52Jv0sdA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu
 out of resampler_lock
To: Sonam Sanju <sonam.sanju@intel.com>
Cc: tj@kernel.org, dmaluka@chromium.org, kunwu.chan@linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org, 
	pbonzini@redhat.com, rcu@vger.kernel.org, seanjc@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 5:05=E2=80=AFAM Sonam Sanju <sonam.sanju@intel.com>=
 wrote:
>
> Hello Tejun,
>
> Thank you for the detailed analysis.
>
> On Wed, Apr 23, 2026, Tejun Heo wrote:
> > The problem with this theory is that this kworker, while preempted, is =
still
> > runnable and should be dispatched to its CPU once it becomes available
> > again. Workqueue doesn't care whether the task gets preempted or when i=
t
> > gets the CPU back. It only cares about whether the task enters blocking
> > state (!runnable). A task which is preempted, even on the way to blocki=
ng,
> > still is runnable and should get put back on the CPU by the scheduler.
> >
> > If you can take a crashdump of the deadlocked state, can you see whethe=
r the
> > task is still on the scheduler's runqueue?
>
> I instrumented show_one_worker_pool() to dump scheduler state for each bu=
sy worker
> when the pool has been hung for >30 seconds.
>
> All workers show on_rq=3D0.
>
> =3D=3D Pool state =3D=3D
>
>   pool 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 hung=3D47s
>   workers=3D13 nr_running=3D1 nr_idle=3D7
>
> =3D=3D Per-worker scheduler state (first dump at t=3D62.5s) =3D=3D
>
>   PID  | state | on_rq | se.on_rq | sched_delayed | sleeping | blocked_on
>   -----|-------|-------|----------|---------------|----------|-----------=
--------
>   4819 | 0x2   | 0     | 0        | 0             | 1        | ffff953608=
205210 type=3D1
>   4823 | 0x2   | 0     | 0        | 0             | 1        | ffff953608=
205210 type=3D1
>   4818 | 0x2   | 0     | 0        | 0             | 0        | ffff953608=
205210 type=3D1
>   11   | 0x2   | 0     | 0        | 0             | 1        | ffff953608=
205210 type=3D1
>   9    | 0x2   | 0     | 0        | 0             | 1        | ffff953608=
205210 type=3D1
>   4814 | 0x2   | 0     | 0        | 0             | 1        | (mutex hol=
der)
>
>
> All 6 workers are in kvm-irqfd-cleanup, calling irqfd_shutdown =E2=86=92
> irqfd_resampler_shutdown. They contend on the same resampler->lock
> mutex (ffff953608205210).
>

Sorry for the late disclosure; I was running the 6.18 Android kernel
and missed this relevant detail because the bug discussion initially
started with KVM and I had verified the irqfd related code was the
same as the vanilla kernel. Now, after going through Tejun's response
and reviewing the __schedule() code regarding SM_PREEMPT, I realized
the Android kernel has extra logic related to proxy execution that
might be triggering this issue. I tested on vanilla 6.18.23 kernel and
was not able to reproduce this.

Sonam, just checking if you are able to reproduce this issue with the
vanilla 6.18 kernel?

Thanks,
Vineeth
